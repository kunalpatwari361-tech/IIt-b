
from typing import Dict, Any

from models.credit_scorecard.scorecard import predict
from models.eligibility.engine import evaluate_eligibility
from models.fraud_detection.engine import detect_fraud


def evaluate_underwriting(application: Dict[str, Any]) -> Dict[str, Any]:

    # 1. Credit risk assessment
    credit_data = application.get("credit_data", {})
    model_type = application.get("model_type", "lt")
    credit_result = predict(credit_data, model_type=model_type)

    # 2. Mortgage eligibility assessment
    eligibility_data = application.get("eligibility_data", {})
    eligibility_result = evaluate_eligibility(eligibility_data)

    # 3. Document verification
    document_result = application.get("document_verification") or {}

    # Support both direct verification data and complete OCR response
    verification_data = document_result.get(
        "verification", document_result
    )

    extracted_fields = document_result.get("extracted_fields", {})

    # 4. Automatic fraud detection
    fraud_data = {
        "monthly_income": eligibility_data.get("monthly_income", 0),
        "requested_loan_amount": eligibility_data.get(
            "requested_loan_amount", 0
        ),
        "property_value": eligibility_data.get("property_value", 0),
        "years_employed": eligibility_data.get("years_employed", 0),
        "declared_name": application.get("declared_name", ""),
        "extracted_name": extracted_fields.get("name", ""),
        "document_status": verification_data.get(
            "verification_status", "missing"
        )
    }

    fraud_result = detect_fraud(fraud_data)

    # Preserve any additional flags supplied by the caller
    additional_fraud_flags = application.get("fraud_flags", [])
    all_fraud_flags = (
        fraud_result["fraud_flags"] + additional_fraud_flags
    )

    review_reasons = []
    rejection_reasons = []

    # 5. Credit decision
    credit_flag = str(credit_result.get("flag", "")).lower()

    if credit_flag == "reject":
        rejection_reasons.append(
            "Credit scorecard rejected the application"
        )
    elif credit_flag != "pass":
        review_reasons.append(
            "Credit scorecard requires manual review"
        )

    # 6. Eligibility decision
    eligibility_decision = eligibility_result.get("decision")

    if eligibility_decision == "REJECT":
        rejection_reasons.extend(
            eligibility_result.get("reasons", [])
        )
    elif eligibility_decision == "REFER":
        review_reasons.extend(
            eligibility_result.get("reasons", [])
        )

    # 7. Document verification
    if not document_result:
        review_reasons.append(
            "Document verification is missing"
        )
    else:
        verification_status = verification_data.get(
            "verification_status", ""
        )

        if verification_status != "matched":
            review_reasons.append(
                "Document verification requires manual review"
            )

        if verification_data.get("mismatches"):
            review_reasons.append(
                "Applicant document details do not match declared details"
            )

    # 8. Fraud risk assessment
    if fraud_result["requires_manual_review"]:
        review_reasons.append(
            "Potential fraud indicators require manual investigation"
        )

    # Additional externally supplied risk flags
    if additional_fraud_flags:
        review_reasons.append(
            "Additional risk indicators require investigation"
        )

    # 9. Final decision
    if rejection_reasons:
        final_decision = "REJECT"
        final_status = "policy_failed"

    elif review_reasons:
        final_decision = "REFER"
        final_status = "manual_review"

    else:
        final_decision = "APPROVE"
        final_status = "eligible_under_demo_rules"

    return {
        "application_id": application.get("application_id"),
        "final_decision": final_decision,
        "final_status": final_status,

        "credit_assessment": credit_result,
        "eligibility_assessment": eligibility_result,

        "document_verification": document_result,

        "fraud_assessment": fraud_result,
        "fraud_flags": all_fraud_flags,

        "decision_reasons": {
            "rejection_reasons": rejection_reasons,
            "review_reasons": review_reasons
        },

        "policy_type": "DEMO_UNDERWRITING_POLICY"
    }
