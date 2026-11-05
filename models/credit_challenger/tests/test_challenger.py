import numpy as np
import pandas as pd
import pytest

from models.credit_challenger.challenger import Challenger
from models.credit_challenger.train import MONOTONE, train
from models.credit_scorecard.features import DATASETS
from models.credit_scorecard.tests.synthetic import make_lt_applications
from models.credit_scorecard.train import train as train_scorecard

GOOD = {"bureau_score": 820, "bureau_status": "scored", "overdue_accounts": 0, "recent_delinquencies": 0,
        "credit_history_years": 8, "enquiries": 0, "new_accounts_6m": 0, "active_accounts": 2,
        "existing_emi": 2000, "loan_amount": 50000, "ltv": 60, "age_years": 42, "employment_type": "salaried"}


@pytest.fixture(scope="module")
def trained(tmp_path_factory):
    raw = make_lt_applications(n=12000)
    sc_dir = tmp_path_factory.mktemp("scorecard")
    train_scorecard(raw, dataset=DATASETS["lt"], out_dir=sc_dir)
    out = tmp_path_factory.mktemp("challenger")
    result = train(raw, dataset=DATASETS["lt"], out_dir=out,
                   scorecard_path=sc_dir / "artifacts" / "scorecard.json")
    return result, Challenger.load(out / "artifacts"), out


def test_training_writes_every_output(trained):
    *_, out = trained
    for path in ["artifacts/model.txt", "artifacts/challenger.json", "reports/metrics.json",
                 "reports/comparison.csv", "reports/grades.csv", "reports/decision_swap.csv",
                 "reports/fairness.csv", "reports/shap_importance.csv", "reports/shap_summary.png"]:
        assert (out / path).exists(), path


def test_learns_and_is_compared_with_the_scorecard(trained):
    result, _, _ = trained
    m = result["metrics"]
    assert m["test"]["auc"] > 0.65
    assert {"auc_gap", "low_95", "high_95"} <= set(m["auc_gap_vs_scorecard"])
    assert m["auc_gap_vs_scorecard"]["low_95"] <= m["auc_gap_vs_scorecard"]["auc_gap"] <= m["auc_gap_vs_scorecard"]["high_95"]


def test_runs_in_shadow_mode(trained):
    _, ch, _ = trained
    out = ch.score(GOOD)
    assert out["mode"] == "shadow"
    for k in ["model", "model_version", "trained_on", "score", "grade", "flag", "reason_code",
              "probability_of_default", "points", "top_reasons"]:
        assert k in out


def test_shap_points_add_up_to_the_score(trained):
    _, ch, _ = trained
    out = ch.score({**GOOD, "ltv": 92, "bureau_score": 400})
    assert out["score"] == min(900, max(300, out["base_score"] + sum(p["points"] for p in out["points"])))


def test_shap_values_match_the_prediction(trained):
    _, ch, _ = trained
    out = ch.score(GOOD)
    log_odds = ch.reference + sum(p["shap"] for p in out["points"])
    assert abs(1 / (1 + np.exp(-log_odds)) - out["probability_of_default"]) < 1e-3


def test_shap_library_agrees_with_lightgbm(trained):
    shap = pytest.importorskip("shap")
    _, ch, _ = trained
    X = ch.frame(pd.DataFrame([GOOD, {**GOOD, "bureau_score": 350, "ltv": 90}]))
    ours, _ = ch._explain(X)
    theirs = shap.TreeExplainer(ch.booster).shap_values(X)
    theirs = theirs[1] if isinstance(theirs, list) else theirs
    assert np.allclose(ours, theirs, atol=1e-6)


@pytest.mark.parametrize("name, direction", sorted(MONOTONE["lt"].items()))
def test_monotone_inputs_never_move_risk_the_wrong_way(trained, name, direction):
    _, ch, _ = trained
    grid = {"bureau_score": range(300, 900, 25), "credit_history_years": np.linspace(0, 15, 25),
            "overdue_accounts": range(0, 8), "recent_delinquencies": range(0, 6), "enquiries": range(0, 10),
            "ltv": np.linspace(20, 95, 25), "loan_amount": np.linspace(15000, 100000, 25)}[name]
    rows = pd.DataFrame([{**GOOD, name: v} for v in grid])
    pd_ = ch.score_frame(rows)["probability_of_default"].to_numpy()
    steps = np.diff(pd_) * direction
    assert (steps >= -1e-12).all(), f"{name} moved risk the wrong way"


def test_bureau_score_zero_means_no_score(trained):
    _, ch, _ = trained
    base = {**GOOD, "bureau_status": "no_history"}
    assert ch.score({**base, "bureau_score": 0})["score"] == ch.score({**base, "bureau_score": None})["score"]


def test_missing_and_unknown_inputs_still_score(trained):
    _, ch, _ = trained
    out = ch.score({"employment_type": "astronaut"})
    assert 300 <= out["score"] <= 900


def test_single_and_batch_scoring_agree(trained):
    _, ch, _ = trained
    batch = ch.score_frame(pd.DataFrame([GOOD]))
    assert int(batch["score"].iloc[0]) == ch.score(GOOD)["score"]


def test_never_uses_protected_or_location_inputs(trained):
    _, ch, _ = trained
    assert not {"State_ID", "state", "Current_pincode_ID", "branch_id", "CODE_GENDER", "age_years"} & set(ch.features)


def test_metrics_record_monotone_check_and_age_fairness(trained):
    result, _, _ = trained
    m = result["metrics"]
    assert sum(m["monotone_violations"].values()) == 0
    assert "age_years" in m["left_out_on_purpose"]
    assert "age_band" in set(result["fairness"]["attribute"])
