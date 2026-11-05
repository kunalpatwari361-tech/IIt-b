import numpy as np
import pandas as pd
import pytest

from models.fraud_classifier.features import MONOTONE
from models.fraud_classifier.fraud import FraudModel
from models.fraud_classifier.train import TARGET_FPR, threshold_for_fpr, train

from .synthetic import make_baf_applications

HONEST = {"income": 0.6, "name_email_similarity": 0.9, "prev_address_months_count": -1,
          "current_address_months_count": 120, "customer_age": 40, "days_since_request": 0.01,
          "intended_balcon_amount": 20, "payment_type": "AB", "zip_count_4w": 1500, "velocity_6h": 5000,
          "velocity_24h": 4800, "velocity_4w": 4900, "bank_branch_count_8w": 100,
          "date_of_birth_distinct_emails_4w": 10, "employment_status": "CA", "credit_risk_score": 100,
          "email_is_free": 0, "housing_status": "BC", "phone_home_valid": 1, "phone_mobile_valid": 1,
          "bank_months_count": 20, "has_other_cards": 1, "proposed_credit_limit": 500, "foreign_request": 0,
          "source": "INTERNET", "session_length_in_minutes": 6, "device_os": "linux", "keep_alive_session": 1,
          "device_distinct_emails_8w": 1}
SUSPICIOUS = {**HONEST, "name_email_similarity": 0.02, "phone_mobile_valid": 0, "phone_home_valid": 0,
              "device_distinct_emails_8w": 2, "foreign_request": 1, "credit_risk_score": 300,
              "device_os": "windows", "email_is_free": 1, "current_address_months_count": 2}


@pytest.fixture(scope="module")
def trained(tmp_path_factory):
    out = tmp_path_factory.mktemp("fraud")
    result = train(make_baf_applications(), out_dir=out)
    return result, FraudModel.load(out / "artifacts"), out


def test_training_writes_every_output(trained):
    *_, out = trained
    for path in ["artifacts/model.txt", "artifacts/fraud.json", "reports/metrics.json", "reports/alerts.csv",
                 "reports/by_month.csv", "reports/fairness.csv", "reports/shap_importance.csv",
                 "reports/shap_summary.png"]:
        assert (out / path).exists(), path


def test_model_file_has_no_windows_line_endings(trained):
    *_, out = trained
    assert b"\r" not in (out / "artifacts" / "model.txt").read_bytes()


def test_catches_fraud(trained):
    result, _, _ = trained
    assert result["metrics"]["auc_test"] > 0.8
    assert result["metrics"]["benchmark_on_test"]["fraud_caught_at_5pct_false_alarms"] > 0.3


def test_thresholds_come_from_the_validation_month(trained):
    result, model, _ = trained
    assert model.thresholds["high"] > model.thresholds["review"]
    assert set(model.thresholds) == set(TARGET_FPR)
    assert "month 5" in result["metrics"]["split"]


def test_never_declares_fraud_only_refers(trained):
    _, model, _ = trained
    out = model.score(SUSPICIOUS)
    assert out["alert"] in {"review", "high"}
    assert out["flag"] == "refer" and out["reason_code"] == "R-FRD-01"
    assert out["top_reasons"]
    clear = model.score(HONEST)
    assert clear["alert"] == "clear" and clear["flag"] == "pass" and clear["reason_code"] is None


def test_shap_values_match_the_prediction(trained):
    _, model, _ = trained
    out = model.score(SUSPICIOUS)
    X = model.frame(pd.DataFrame([SUSPICIOUS]))
    _, bias = model._explain(X)
    log_odds = bias[0] + sum(c["shap"] for c in out["contributions"])
    assert abs(1 / (1 + np.exp(-log_odds)) - out["fraud_probability"]) < 1e-3


def test_age_is_never_an_input(trained):
    _, model, _ = trained
    assert "customer_age" not in model.features
    assert "device_fraud_count" not in model.features


def test_negative_codes_count_as_missing(trained):
    _, model, _ = trained
    a = model.score({**HONEST, "bank_months_count": -1})["fraud_probability"]
    b = model.score({**HONEST, "bank_months_count": None})["fraud_probability"]
    assert a == b


@pytest.mark.parametrize("name, direction", sorted(MONOTONE.items()))
def test_monotone_inputs_never_move_risk_the_wrong_way(trained, name, direction):
    _, model, _ = trained
    grid = {"name_email_similarity": np.linspace(0, 1, 21), "phone_mobile_valid": [0, 1],
            "phone_home_valid": [0, 1], "date_of_birth_distinct_emails_4w": range(0, 40, 2),
            "device_distinct_emails_8w": [0, 1, 2], "foreign_request": [0, 1]}[name]
    for base in (HONEST, SUSPICIOUS):
        p = model.score_frame(pd.DataFrame([{**base, name: v} for v in grid]))["fraud_probability"].to_numpy()
        assert (np.diff(p) * direction >= -1e-12).all(), f"{name} moved fraud risk the wrong way"


def test_single_and_batch_scoring_agree(trained):
    _, model, _ = trained
    batch = model.score_frame(pd.DataFrame([SUSPICIOUS]))["fraud_probability"].iloc[0]
    assert abs(batch - model.score(SUSPICIOUS)["fraud_probability"]) <= 5e-6  # score() rounds to 5 places


def test_unknown_categories_and_missing_inputs_still_score(trained):
    _, model, _ = trained
    out = model.score({"device_os": "symbian"})
    assert 0 <= out["fraud_probability"] <= 1


def test_threshold_for_fpr_flags_the_right_share():
    rng = np.random.default_rng(0)
    y = (rng.random(20000) < 0.01).astype(int)
    p = rng.random(20000)
    t = threshold_for_fpr(y, p, 0.05)
    assert abs((p[y == 0] >= t).mean() - 0.05) < 0.002


def test_fairness_is_reported_by_age_income_and_employment(trained):
    result, _, _ = trained
    assert {"age_group", "income", "employment_status"} <= set(result["fairness"]["attribute"])
