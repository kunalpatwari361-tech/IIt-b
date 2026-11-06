"""Tests for the eligibility, fraud, underwriting, audit and API layers (no Kaggle data needed)."""
import json
from pathlib import Path

import pytest
from fastapi.testclient import TestClient

from api.main import app
from models.audit import logger
from models.eligibility.engine import evaluate_eligibility
from models.fraud_detection.engine import detect_fraud

LT_GOOD = json.loads((Path(__file__).resolve().parents[2] / "credit_scorecard" / "example_input.json").read_text())
GOOD_ELIG = dict(age=35, monthly_income=120000, years_employed=8, requested_loan_amount=4_000_000,
                 property_value=6_000_000, existing_monthly_emi=8000, tenure_years=20)
DOC_OK = {"verification": {"verification_status": "matched", "mismatches": []},
          "extracted_fields": {"name": "Ravi Kumar"}}


@pytest.fixture()
def client(tmp_path, monkeypatch):
    monkeypatch.setattr(logger, "AUDIT_FILE", tmp_path / "audit.jsonl")
    return TestClient(app)


def run(client, elig=None, credit=None, doc=DOC_OK, name="Ravi Kumar", model_type="lt", app_id="T-1"):
    body = dict(application_id=app_id, model_type=model_type, credit_data=credit or LT_GOOD,
                eligibility_data={**GOOD_ELIG, **(elig or {})}, document_verification=doc, declared_name=name)
    r = client.post("/api/v1/underwriting/evaluate", json=body)
    assert r.status_code == 200, r.text
    return r.json()


# ---------- eligibility ----------
def test_eligibility_approves_clean_case():
    r = evaluate_eligibility(GOOD_ELIG)
    assert r["decision"] == "APPROVE" and r["failed_rules"] == []


@pytest.mark.parametrize("change,rule", [
    (dict(requested_loan_amount=5_200_000), "R-LTV-01"),
    (dict(monthly_income=40000), "R-DTI-01"),
    (dict(age=50, tenure_years=20), "R-AGE-02"),
    (dict(age=19), "R-AGE-01"),
    (dict(monthly_income=20000, requested_loan_amount=500_000), "R-INC-01"),
])
def test_eligibility_rejects_policy_breaches(change, rule):
    r = evaluate_eligibility({**GOOD_ELIG, **change})
    assert r["decision"] == "REJECT" and rule in r["failed_rules"]


def test_short_employment_is_referred_not_rejected():
    r = evaluate_eligibility({**GOOD_ELIG, "years_employed": 0.5})
    assert r["decision"] == "REFER" and r["review_rules"] == ["R-EMP-01"]


# ---------- fraud rules ----------
def test_fraud_clean_and_flags():
    clean = detect_fraud(dict(monthly_income=100000, requested_loan_amount=3e6, property_value=5e6,
                              years_employed=5, declared_name="a b", extracted_name="A B", document_status="matched"))
    assert clean["risk_level"] == "LOW" and not clean["requires_manual_review"]
    bad = detect_fraud(dict(monthly_income=100000, requested_loan_amount=6e6, property_value=5e6, years_employed=5,
                            declared_name="a b", extracted_name="c d", document_status="matched"))
    assert any(f.startswith("F-02") for f in bad["fraud_flags"]) and any(f.startswith("F-04") for f in bad["fraud_flags"])
    assert bad["risk_level"] == "HIGH"


# ---------- API and credit schemas ----------
def test_api_lists_models_and_scores_lt(client):
    assert {m["model_type"] for m in client.get("/api/v1/models").json()["models"]} == {"lt", "home_credit"}
    r = client.post("/api/v1/credit-score?model_type=lt", json=LT_GOOD).json()
    assert r["grade"] in "AB" and r["flag"] == "pass"


def test_api_rejects_fields_of_the_wrong_scorecard(client):
    r = client.post("/api/v1/credit-score?model_type=lt", json={"bureau_score_1": 0.6})
    assert r.status_code == 422


def test_home_credit_scorecard_works(client):
    hc = json.loads((Path(__file__).resolve().parents[2] / "credit_scorecard" / "home_credit_example.json").read_text())
    r = client.post("/api/v1/credit-score?model_type=home_credit", json=hc)
    assert r.status_code == 200 and r.json()["flag"] == "pass"


# ---------- end to end decisions ----------
def test_end_to_end_approve(client):
    r = run(client)["underwriting_result"]
    assert r["final_decision"] == "APPROVE", r["decision_reasons"]


def test_missing_document_is_referred(client):
    r = run(client, doc=None)["underwriting_result"]
    assert r["final_decision"] == "REFER"
    assert "Document verification is missing" in r["decision_reasons"]["review_reasons"]


def test_name_mismatch_is_referred(client):
    doc = {"verification": {"verification_status": "matched", "mismatches": []}, "extracted_fields": {"name": "Other Person"}}
    r = run(client, doc=doc)["underwriting_result"]
    assert r["final_decision"] == "REFER" and any("F-04" in f for f in r["fraud_flags"])


def test_policy_breach_is_rejected(client):
    r = run(client, elig=dict(requested_loan_amount=5_500_000))["underwriting_result"]
    assert r["final_decision"] == "REJECT"


def test_weak_credit_profile_is_rejected(client):
    r = run(client, credit={**LT_GOOD, "bureau_score": 560, "credit_history_years": 0.5, "ltv": 95, "loan_amount": 900000})["underwriting_result"]
    assert r["final_decision"] == "REJECT"


# ---------- audit ----------
def test_audit_records_fraud_fields_and_detects_tampering(client):
    run(client, app_id="A-1"); run(client, app_id="A-2", doc=None)
    logs = client.get("/api/v1/audit").json()["audit_logs"]
    assert logs[-1]["fraud_risk_level"] is not None and logs[-1]["fraud_risk_score"] is not None
    assert client.get("/api/v1/audit/verify").json()["intact"] is True
    lines = logger.AUDIT_FILE.read_text().splitlines()
    first = json.loads(lines[0]); first["final_decision"] = "APPROVE" if first["final_decision"] != "APPROVE" else "REJECT"
    logger.AUDIT_FILE.write_text("\n".join([json.dumps(first)] + lines[1:]) + "\n")
    v = client.get("/api/v1/audit/verify").json()
    assert v["intact"] is False and v["first_bad_record"] == 0
