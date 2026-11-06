"""Gate rules, tested on Ravi's real recorded evidence with one fact changed at a time."""
import copy

import pytest

from backend import pipeline


@pytest.fixture
def ev(ravi):
    rec = next(r for r in ravi["records"] if r["stage"] == "in_principle")
    return copy.deepcopy(rec["evidence"])


def run(ev):
    d = pipeline.decide(ev)
    return d, {r["code"] for g in d["gates"] for r in g["reasons"]}, [r["code"] for r in d["customer_reasons"]]


def test_baseline_is_approve_and_deterministic(ev):
    a, b = pipeline.decide(ev), pipeline.decide(copy.deepcopy(ev))
    assert a == b and a["outcome"] == "approve"


def test_spoofed_selfie_refers_to_video_kyc(ev):
    ev["identity"]["selfie"] = {**(ev["identity"]["selfie"] or {"face_found": True}), "face_found": True, "live": False,
                                "liveness": {"score": 0.1}}
    d, internal, shown = run(ev)
    assert d["outcome"] == "refer" and "R-KYC-01" in internal and shown == ["R-KYC-01"]


def test_face_mismatch_refers(ev):
    ev["identity"]["face_match"] = {"match": False, "similarity": 0.12, "model_version": "x"}
    assert "R-KYC-01" in run(ev)[1]


def test_aml_hit_refers_without_tipping_off(ev):
    ev["aml"] = {**ev["aml"], "hits": [{"ref": "QDi.1"}], "flag": "refer", "reason_code": "R-AML-01"}
    d, internal, shown = run(ev)
    assert d["outcome"] == "refer" and "R-AML-01" in internal
    assert shown == ["R-RSK-01"]           # the customer sees a general review, never the screening hit


def test_fraud_model_alert_refers(ev):
    ev["models"]["fraud"] = {**ev["models"]["fraud"], "flag": "refer", "fraud_probability": 0.2}
    assert "R-FRD-01" in run(ev)[1]


def test_low_bureau_score_rejects(ev):
    ev["profile"]["bureau"]["score"] = 640
    d, internal, shown = run(ev)
    assert d["outcome"] == "reject" and "R-BUR-01" in internal and shown[0] == "R-BUR-01"


def test_no_credit_history_refers(ev):
    ev["profile"]["bureau"]["score"] = None
    assert "R-BUR-04" in run(ev)[1]


def test_under_21_rejects(ev):
    ev["profile"]["dob"] = "2007-01-01"
    assert "R-POL-01" in run(ev)[1]


def test_loan_past_retirement_age_refers(ev):
    ev["profile"]["dob"] = "1975-01-01"
    assert "R-POL-02" in run(ev)[1]


def test_bounces_refer(ev):
    ev["bank"]["bounces"] = 3
    assert "R-AFF-02" in run(ev)[1]


def test_emis_already_at_the_limit_reject(ev):
    ev["income"]["existing_emi"] = 60000
    d, internal, _ = run(ev)
    assert d["outcome"] == "reject" and "R-AFF-01" in internal


def test_large_loans_go_to_a_senior_officer(ev):
    ev["request"].update(amount=15_000_000, property_value=25_000_000)
    ev["income"]["income_used"] = 1_000_000
    d, internal, _ = run(ev)
    assert "R-AUT-01" in internal and d["offer"]["amount"] > 1e7


def test_income_limits_the_offer(ev):
    ev["income"]["income_used"] = 60000
    d, _, _ = run(ev)
    assert d["offer"]["limited_by"] == "income" and d["offer"]["amount"] < 4500000


def test_missing_document_refers(ev):
    ev["documents"].pop("salarySlip", None)
    ev["income"]["slip_net_pay"] = None
    assert "R-DOC-04" in run(ev)[1]


def test_edited_pdf_refers(ev):
    ev["documents"]["salarySlip"]["tamper_signals"] = ["made with an editing tool (Sejda)"]
    assert "R-DOC-03" in run(ev)[1]


def test_withdrawn_consent_holds_the_decision(ev):
    ev["consents"]["given"]["bureau"] = False
    d, internal, shown = run(ev)
    assert d["outcome"] == "refer" and "R-CMP-01" in internal
    rules = next(g for g in d["gates"] if g["gate"] == "compliance")["facts"]["rules"]
    assert not next(r for r in rules if r["rule"].startswith("CMP-01"))["ok"]


def test_challenger_never_changes_the_outcome(ev):
    ev["models"]["challenger"] = {**ev["models"]["challenger"], "score": 420, "grade": "E"}
    assert pipeline.decide(ev)["outcome"] == "approve"
