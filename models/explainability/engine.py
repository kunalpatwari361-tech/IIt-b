from typing import Dict, Any


def explain_decision(result: Dict[str, Any]) -> Dict[str, Any]:

    credit = result.get("credit_assessment", {})
    eligibility = result.get("eligibility_assessment", {})
    fraud = result.get("fraud_assessment", {})
    documents = result.get("document_verification", {})

    decision = result.get("final_decision", "REFER")

    explanations = []
    risk_factors = []
    triggered_rules = []

    # 1. Credit score explanation
    for item in credit.get("points", []):
        points = item.get("points", 0)

        risk_factors.append({
            "factor": item.get("label"),
            "group": item.get("group"),
            "value": item.get("value"),
            "points": points,
            "impact": (
                "Positive" if points > 0
                else "Negative" if points < 0
                else "Neutral"
            )
        })

    # 2. Eligibility explanation
    for rule in eligibility.get("failed_rules", []):
        triggered_rules.append({
            "module": "Eligibility",
            "rule": rule
        })

    for rule in eligibility.get("review_rules", []):
        triggered_rules.append({
            "module": "Eligibility",
            "rule": rule
        })

    # 3. Document verification explanation
    if documents:
        verification = documents.get("verification", documents)

        for mismatch in verification.get("mismatches", []):
            triggered_rules.append({
                "module": "Document Verification",
                "rule": mismatch.get("reason", "Document mismatch"),
                "field": mismatch.get("field")
            })

    # 4. Fraud explanation (flags are strings like "F-04: description")
    severity = fraud.get("risk_level")
    for flag in fraud.get("fraud_flags", []):
        if isinstance(flag, dict):
            code, description = flag.get("code"), flag.get("description")
        else:
            code, _, description = str(flag).partition(": ")
        triggered_rules.append({
            "module": "Fraud Detection",
            "rule_code": code,
            "rule": description or str(flag),
            "severity": severity
        })

    # 5. Final decision explanation
    reasons = result.get("decision_reasons", {})

    explanations.extend(reasons.get("rejection_reasons", []))
    explanations.extend(reasons.get("review_reasons", []))

    if decision == "APPROVE":
        summary = "Application passed all configured demo underwriting checks."
    elif decision == "REJECT":
        summary = "Application failed one or more configured demo policy rules."
    else:
        summary = "Application requires manual review before a final lending decision."

    return {
        "application_id": result.get("application_id"),
        "final_decision": decision,
        "decision_summary": summary,
        "credit_score": credit.get("score"),
        "credit_grade": credit.get("grade"),
        "probability_of_default": credit.get("probability_of_default"),
        "fraud_risk_level": fraud.get("risk_level"),
        "fraud_risk_score": fraud.get("risk_score"),
        "risk_factors": risk_factors,
        "triggered_rules": triggered_rules,
        "decision_reasons": explanations,
        "explanation_type": "RULE_AND_SCORECARD_BASED"
    }
