import numpy as np
import pandas as pd
import pytest

from models.anomaly_detector.detector import AnomalyDetector, average_path_length
from models.anomaly_detector.features import BASE_FIELDS, build_base, derive
from models.anomaly_detector.plants import KIND, plant_odd_cases
from models.anomaly_detector.train import FLAG_SHARE, train
from models.credit_scorecard.tests.synthetic import make_lt_applications

NORMAL = {"loan_amount": 52000, "asset_cost": 70000, "ltv": 74.29, "bureau_score": 700, "total_accounts": 2,
          "active_accounts": 1, "overdue_accounts": 0, "outstanding_balance": 30000, "sanctioned_total": 80000,
          "disbursed_total": 78000, "existing_emi": 2500, "new_accounts_6m": 0, "recent_delinquencies": 0,
          "enquiries": 0, "credit_history_years": 4, "avg_account_age_years": 2, "age_years": 34,
          "employment_type": "salaried"}


@pytest.fixture(scope="module")
def trained(tmp_path_factory):
    out = tmp_path_factory.mktemp("anomaly")
    small = {"n_estimators": 150, "max_samples": 2048, "random_state": 42, "n_jobs": -1}  # keeps tests quick
    result = train(make_lt_applications(n=12000), out_dir=out, plants_per_type=150, params=small)
    return result, AnomalyDetector.load(out / "artifacts"), out


def test_training_writes_every_output(trained):
    *_, out = trained
    for path in ["artifacts/model.joblib", "artifacts/anomaly.json", "reports/metrics.json",
                 "reports/planted.csv", "reports/fairness.csv", "reports/shap_importance.csv",
                 "reports/shap_summary.png"]:
        assert (out / path).exists(), path


def test_flags_about_the_planned_share_of_real_applications(trained):
    result, _, _ = trained
    share = result["metrics"]["real_october"]["flagged_by_forest"]
    assert 0.003 < share < 0.03  # the forest is set to flag 1% of training months


def test_catches_most_planted_odd_cases(trained):
    result, _, _ = trained
    m = result["metrics"]
    assert m["planted_caught_total"] > 0.5
    assert m["planted_caught_total"] >= max(m["planted_caught_by_forest"], m["planted_caught_by_rules"])
    assert set(result["planted"]["plant_type"]) == set(KIND)


def test_contradictions_score_higher_than_the_original(trained):
    _, det, _ = trained
    normal = det.score(NORMAL)["anomaly_score"]
    odd = det.score({**NORMAL, "ltv": 20})["anomaly_score"]  # stated LTV far below 52000 / 70000
    assert odd > normal


def test_alerts_only_refer_never_reject(trained):
    _, det, _ = trained
    weird = {**NORMAL, "bureau_score": 880, "total_accounts": 0, "active_accounts": 0, "sanctioned_total": 0,
             "disbursed_total": 0, "credit_history_years": 30, "age_years": 31, "ltv": 15, "loan_amount": 900000}
    out = det.score(weird)
    assert out["alert"] in {"unusual", "very_unusual"}
    assert out["flag"] == "refer" and out["reason_code"] == "R-FRD-04"
    assert out["top_reasons"]
    clear = det.score(NORMAL)
    assert clear["flag"] in {"pass", "refer"} and (clear["flag"] == "pass") == (clear["alert"] == "normal")


def test_shap_adds_up_to_the_anomaly_score(trained):
    _, det, _ = trained
    X = det.frame(pd.DataFrame([NORMAL, {**NORMAL, "ltv": 20}]))
    sv, expected = det._explain(X)
    rebuilt = 2 ** (-(expected + sv.sum(axis=1)) / average_path_length(det.model.max_samples_))
    assert np.allclose(rebuilt, det.anomaly_score(X), atol=1e-6)


def test_age_alone_does_not_make_an_application_odd(trained):
    _, det, _ = trained
    assert "age_years" not in det.inputs
    young, old = det.score({**NORMAL, "age_years": 22}), det.score({**NORMAL, "age_years": 64})
    assert young["anomaly_score"] == old["anomaly_score"]  # history starts after 18 in both


def test_history_before_18_is_caught_as_a_contradiction():
    X = derive(pd.DataFrame([{**NORMAL, "age_years": 30, "credit_history_years": 25}]))
    assert X["history_before_18"].iloc[0] == pytest.approx(13)


def test_never_uses_location_or_id_flags():
    raw = make_lt_applications(n=50)
    X = derive(build_base(raw))
    assert not {c for c in X.columns if "state" in c.lower() or "pincode" in c.lower() or "aadhar" in c.lower()}


def test_missing_fields_still_score(trained):
    _, det, _ = trained
    out = det.score({"loan_amount": 50000})
    assert 0 < out["anomaly_score"] < 1


def test_single_and_batch_scoring_agree(trained):
    _, det, _ = trained
    batch = det.score_frame(pd.DataFrame([NORMAL]))["anomaly_score"].iloc[0]
    assert abs(batch - det.score(NORMAL)["anomaly_score"]) <= 5e-6


def test_plants_change_what_they_say():
    base = build_base(make_lt_applications(n=400))
    plants = plant_odd_cases(base, n_per_type=20, seed=1)
    stacked = plants[plants.plant_type == "loan_stacking"]
    assert (stacked["new_accounts_6m"] >= 6).all() and (stacked["enquiries"] >= 8).all()
    borrowed = plants[plants.plant_type == "borrowed_score"]
    assert (borrowed["bureau_score"] >= 780).all() and (borrowed["total_accounts"] == 0).all()
    assert set(BASE_FIELDS) <= set(plants.columns)


def test_thresholds_match_flag_share(trained):
    _, det, _ = trained
    assert set(det.thresholds) == set(FLAG_SHARE)
    assert det.thresholds["very_unusual"] > det.thresholds["unusual"]


def test_impossible_details_break_integrity_rules(trained):
    _, det, _ = trained
    out = det.score({**NORMAL, "bureau_score": 820, "total_accounts": 0, "active_accounts": 0,
                     "overdue_accounts": 0, "sanctioned_total": 0, "disbursed_total": 0})
    assert "score_without_loans" in out["rules_broken"]
    assert out["alert"] == "very_unusual" and out["flag"] == "refer"
    assert out["top_reasons"][0].startswith("Integrity check failed")
    assert det.score(NORMAL)["rules_broken"] == []
