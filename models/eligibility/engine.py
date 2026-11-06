
from typing import Dict, Any


# DEMO POLICY CONFIGURATION
POLICY = {
    "minimum_age": 21,
    "maximum_age_at_maturity": 65,
    "minimum_monthly_income": 25000,
    "minimum_employment_years": 1,
    "maximum_ltv": 80,
    "maximum_dti": 50
}


def evaluate_eligibility(applicant: Dict[str, Any]) -> Dict[str, Any]:

    reasons = []
    failed_rules = []
    review_rules = []

    age = applicant.get("age")
    income = applicant.get("monthly_income")
    employment_years = applicant.get("years_employed")
    loan_amount = applicant.get("requested_loan_amount")
    property_value = applicant.get("property_value")
    existing_emi = applicant.get("existing_monthly_emi")
    tenure = applicant.get("tenure_years")

    # Check missing information
    required_fields = {
        "age": age,
        "monthly_income": income,
        "years_employed": employment_years,
        "requested_loan_amount": loan_amount,
        "property_value": property_value,
        "existing_monthly_emi": existing_emi,
        "tenure_years": tenure
    }

    missing = [key for key, value in required_fields.items() if value is None]

    if missing:
        return {
            "decision": "REFER",
            "status": "manual_review",
            "reasons": ["Missing required applicant information"],
            "missing_fields": missing,
            "policy_type": "DEMO_POLICY"
        }

    # Check invalid values
    if (
        age <= 0 or income <= 0 or employment_years < 0
        or loan_amount <= 0 or property_value <= 0
        or existing_emi < 0 or tenure <= 0
    ):
        return {
            "decision": "REFER",
            "status": "manual_review",
            "reasons": ["Invalid applicant financial or demographic values"],
            "missing_fields": [],
            "policy_type": "DEMO_POLICY"
        }

    # 1. Minimum age
    if age < POLICY["minimum_age"]:
        failed_rules.append("R-AGE-01")
        reasons.append("Applicant does not meet minimum age requirement")

    # 2. Maximum age at loan maturity
    if age + tenure > POLICY["maximum_age_at_maturity"]:
        failed_rules.append("R-AGE-02")
        reasons.append("Age exceeds maximum permitted age at loan maturity")

    # 3. Minimum income
    if income < POLICY["minimum_monthly_income"]:
        failed_rules.append("R-INC-01")
        reasons.append("Monthly income is below demo policy threshold")

    # 4. Employment stability
    if employment_years < POLICY["minimum_employment_years"]:
        review_rules.append("R-EMP-01")
        reasons.append("Employment history requires manual review")

    # 5. Loan-to-Value ratio
    ltv = (loan_amount / property_value) * 100

    if ltv > POLICY["maximum_ltv"]:
        failed_rules.append("R-LTV-01")
        reasons.append("Loan amount exceeds permitted property value ratio")

    # 6. Debt-to-Income ratio
    # Illustrative EMI estimate using a fixed 9% annual interest rate.
    monthly_rate = 0.09 / 12
    total_months = int(tenure * 12)

    estimated_emi = (
        loan_amount * monthly_rate *
        (1 + monthly_rate) ** total_months
        / ((1 + monthly_rate) ** total_months - 1)
    )

    dti = ((existing_emi + estimated_emi) / income) * 100

    if dti > POLICY["maximum_dti"]:
        failed_rules.append("R-DTI-01")
        reasons.append("Debt-to-income ratio exceeds demo policy threshold")

    # Final decision
    if failed_rules:
        decision = "REJECT"
        status = "policy_failed"
    elif review_rules:
        decision = "REFER"
        status = "manual_review"
    else:
        decision = "APPROVE"
        status = "eligible_under_demo_rules"

    return {
        "decision": decision,
        "status": status,
        "policy_type": "DEMO_POLICY",
        "metrics": {
            "ltv_percent": round(ltv, 2),
            "dti_percent": round(dti, 2),
            "estimated_monthly_emi": round(estimated_emi, 2)
        },
        "failed_rules": failed_rules,
        "review_rules": review_rules,
        "reasons": reasons
    }
