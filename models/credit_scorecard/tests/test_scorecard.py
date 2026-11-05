import math

import pandas as pd
import pytest

from models.credit_scorecard.features import DATASETS
from models.credit_scorecard.scorecard import Scorecard, grade_for
from models.credit_scorecard.train import train

from .synthetic import make_applications, make_lt_applications

PROFILES = {
    "lt": {
        "make": make_lt_applications,
        "good": {"bureau_score": 820, "bureau_status": "scored", "overdue_accounts": 0,
                 "recent_delinquencies": 0, "credit_history_years": 8, "enquiries": 0,
                 "new_accounts_6m": 0, "active_accounts": 2, "existing_emi": 2000, "loan_amount": 50000,
                 "ltv": 60, "age_years": 42, "employment_type": "salaried"},
        "weak": {"bureau_score": 320, "bureau_status": "scored", "overdue_accounts": 3,
                 "recent_delinquencies": 2, "ltv": 92, "age_years": 21},
        "bureau": ("bureau_score", 350, 850),
    },
    "home_credit": {
        "make": make_applications,
        "good": {"bureau_score_1": 0.8, "bureau_score_2": 0.75, "bureau_score_3": 0.8, "payment_to_income": 0.1,
                 "loan_to_income": 2.0, "loan_to_price": 1.0, "owns_property": "yes", "years_employed": 10,
                 "age_years": 42, "employment_type": "salaried"},
        "weak": {"bureau_score_1": 0.1, "bureau_score_2": 0.1, "bureau_score_3": 0.1, "payment_to_income": 0.4},
        "bureau": ("bureau_score_2", 0.15, 0.85),
    },
}


@pytest.fixture(scope="module", params=sorted(PROFILES))
def trained(request, tmp_path_factory):
    key = request.param
    out = tmp_path_factory.mktemp(f"scorecard-{key}")
    result = train(PROFILES[key]["make"](), dataset=DATASETS[key], out_dir=out)
    return key, result, Scorecard.load(out / "artifacts" / "scorecard.json"), out


def test_training_writes_every_output(trained):
    *_, out = trained
    for path in ["artifacts/scorecard.json", "reports/metrics.json", "reports/grades.csv",
                 "reports/fairness.csv", "reports/points_table.csv"]:
        assert (out / path).exists(), path


def test_learns_the_pattern(trained):
    _, result, _, _ = trained
    assert result["metrics"]["test"]["auc"] > 0.65
    assert result["metrics"]["export_matches_model"]


def test_never_uses_protected_or_location_inputs(trained):
    _, _, card, _ = trained
    banned = {"CODE_GENDER", "gender", "State_ID", "state", "Current_pincode_ID", "branch_id"}
    assert not banned & set(card.inputs)


def test_lt_tests_on_a_later_month(trained):
    key, result, _, _ = trained
    if key == "lt":
        assert "out of time" in result["metrics"]["split"]


@pytest.mark.parametrize("score, grade, flag", [
    (900, "A", "pass"), (760, "A", "pass"), (759, "B", "pass"), (700, "B", "pass"),
    (699, "C", "refer"), (650, "C", "refer"), (649, "D", "reject"), (600, "D", "reject"),
    (599, "E", "reject"), (300, "E", "reject"),
])
def test_grade_bands_match_the_report(score, grade, flag):
    assert grade_for(score)[:2] == (grade, flag)


def test_output_follows_the_shared_contract(trained):
    key, _, card, _ = trained
    out = card.score(PROFILES[key]["good"])
    for k in ["model", "model_version", "trained_on", "score", "grade", "flag", "reason_code",
              "probability_of_default", "points", "top_reasons"]:
        assert k in out
    assert 300 <= out["score"] <= 900
    assert out["flag"] in {"pass", "refer", "reject"}
    assert 0 < out["probability_of_default"] < 1


def test_points_add_up_to_the_score(trained):
    key, _, card, _ = trained
    out = card.score(PROFILES[key]["good"])
    total = out["base_score"] + sum(p["points"] for p in out["points"])
    assert out["score"] == min(900, max(300, total))


def test_better_bureau_score_never_lowers_the_score(trained):
    key, _, card, _ = trained
    name, low, high = PROFILES[key]["bureau"]
    good = PROFILES[key]["good"]
    assert card.score({**good, name: high})["score"] >= card.score({**good, name: low})["score"]


def test_weak_profile_scores_below_good_and_gets_reasons(trained):
    key, _, card, _ = trained
    good = card.score(PROFILES[key]["good"])
    weak = card.score({**PROFILES[key]["good"], **PROFILES[key]["weak"]})
    assert weak["score"] < good["score"]
    assert weak["top_reasons"]


def test_missing_and_unknown_inputs_still_score(trained):
    _, _, card, _ = trained
    out = card.score({"employment_type": "astronaut"})
    assert 300 <= out["score"] <= 900
    assert not math.isnan(out["probability_of_default"])


def test_single_and_batch_scoring_agree(trained):
    key, _, card, _ = trained
    good = PROFILES[key]["good"]
    batch = card.score_frame(pd.DataFrame([good]))
    assert int(batch["score"].iloc[0]) == card.score(good)["score"]


def test_lt_bureau_score_zero_means_no_score(trained):
    key, _, card, _ = trained
    if key != "lt":
        pytest.skip("only the L&T data uses score codes")
    base = {**PROFILES["lt"]["good"], "bureau_status": "no_history"}
    as_zero = card.score({**base, "bureau_score": 0})
    as_none = card.score({**base, "bureau_score": None})
    assert as_zero["score"] == as_none["score"]
    batch = card.score_frame(pd.DataFrame([{**base, "bureau_score": 0}]))
    assert int(batch["score"].iloc[0]) == as_none["score"]


def test_lt_reads_two_digit_birth_years():
    raw = make_lt_applications(n=50)
    raw.loc[0, "Date.of.Birth"] = "01-01-60"  # parses as 2060 unless corrected
    raw.loc[0, "DisbursalDate"] = "15-08-18"
    age = DATASETS["lt"].build(raw).loc[0, "age_years"]
    assert 58 < age < 59
