from typing import Dict, Any


def detect_fraud(data: Dict[str, Any]) -> Dict[str, Any]:
    """Rule-based fraud risk indicators for prototype testing."""

    risk_score = 0
    fraud_flags = []

    monthly_income = float(data.get("monthly_income", 0) or 0)
    loan_amount = float(data.get("requested_loan_amount", 0) or 0)
    property_value = float(data.get("property_value", 0) or 0)
    years_employed = float(data.get("years_employed", 0) or 0)

    declared_name = str(data.get("declared_name", "")).strip().lower()
    extracted_name = str(data.get("extracted_name", "")).strip().lower()
    document_status = data.get("document_status", "missing")

    if monthly_income > 0 and loan_amount / (monthly_income * 12) > 15:
        risk_score += 25
        fraud_flags.append("F-01: High loan-to-annual-income ratio")

    if property_value > 0 and loan_amount > property_value:
        risk_score += 40
        fraud_flags.append("F-02: Loan amount exceeds property value")

    if years_employed > 50:
        risk_score += 20
        fraud_flags.append("F-03: Unusual employment duration")

    if declared_name and extracted_name and declared_name != extracted_name:
        risk_score += 40
        fraud_flags.append("F-04: Declared and extracted name mismatch")

    if document_status != "matched":
        risk_score += 25
        fraud_flags.append("F-05: Document verification requires review")

    risk_score = min(risk_score, 100)

    if risk_score >= 60:
        risk_level = "HIGH"
    elif risk_score >= 25:
        risk_level = "MEDIUM"
    else:
        risk_level = "LOW"

    return {
        "risk_score": risk_score,
        "risk_level": risk_level,
        "fraud_flags": fraud_flags,
        "requires_manual_review": risk_level in ("MEDIUM", "HIGH")
    }
