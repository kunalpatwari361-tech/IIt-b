"""Credit policy as a versioned table, and the eligibility maths.

Only the Home Loan LTV tiers come from regulation (RBI). Every other value is
illustrative, as in the report. The customer app's quick check (app/lib/policy.dart)
uses the same numbers; the engine's answer is the one that counts.
"""
from __future__ import annotations

import math
from dataclasses import asdict, dataclass

POLICY = {
    "version": "policy-v1",
    "effective_from": "2026-11-01",
    "min_age": 21,
    "max_age_at_end": {"salaried": 65, "selfEmployed": 70},
    "max_tenure_years": {"homeLoan": 30, "lap": 15},
    "rate_pct": {"homeLoan": 8.75, "lap": 10.50},
    "auto_sanction_limit": 1e7,               # Rs 1 crore; above this a senior officer sanctions
    "foir_caps": [[50000, 0.45], [150000, 0.50], [None, 0.60]],   # net monthly income up to -> cap
    "ltv_home_loan": [[30e5, 0.90], [75e5, 0.80], [None, 0.75]],  # RBI tiers by loan amount
    "ltv_lap": 0.60,
    "bureau_reject_below": 650,
    "bureau_refer_below": 700,
    "bounces_refer_at": 2,                    # EMI/cheque bounces in the statement period
    "slip_over_bank_tolerance": 0.15,         # slip net pay may exceed bank salary credits by this much
    "business_credits_min_share": 0.8,        # bank credits must cover this share of declared business income
    "in_principle_valid_days": 30,
    "cooling_off_days": 3,                    # RBI Digital Lending: at least 1 day; ours is 3 (illustrative)
    # Bank statements come through the Account Aggregator, so they are not uploads (same list as the app).
    "required_documents": {"salaried": ["pan", "aadhaar", "salarySlip", "form16"],
                           "selfEmployed": ["pan", "aadhaar", "itr", "gst"]},
}


def foir_cap(income: float) -> float:
    for upto, cap in POLICY["foir_caps"]:
        if upto is None or income <= upto:
            return cap
    return POLICY["foir_caps"][-1][1]


def ltv_cap(product: str, loan: float) -> float:
    if product == "lap":
        return POLICY["ltv_lap"]
    for upto, cap in POLICY["ltv_home_loan"]:
        if upto is None or loan <= upto:
            return cap
    return POLICY["ltv_home_loan"][-1][1]


def loan_by_property(product: str, value: float) -> float:
    """The largest loan the property supports, keeping the loan inside the tier whose cap it uses."""
    if product == "lap":
        return POLICY["ltv_lap"] * value
    best, lower = 0.0, 0.0
    for upto, cap in POLICY["ltv_home_loan"]:
        top = math.inf if upto is None else upto
        loan = min(cap * value, top)
        if loan > lower:
            best = max(best, loan)
        lower = top
    return best


def emi(principal: float, rate_pct: float, months: int) -> float:
    r = rate_pct / 12 / 100
    if r == 0:
        return principal / months
    f = (1 + r) ** months
    return principal * r * f / (f - 1)


def loan_for_emi(monthly: float, rate_pct: float, months: int) -> float:
    r = rate_pct / 12 / 100
    return monthly * (1 - (1 + r) ** -months) / r


@dataclass
class Eligibility:
    max_emi: float
    loan_by_income: float
    loan_by_property: float
    eligible: float
    emi: float
    foir_after: float
    ltv: float
    ltv_cap: float
    foir_cap: float
    rate_pct: float
    limited_by: str

    def to_dict(self) -> dict:
        return {k: round(v, 4) if isinstance(v, float) else v for k, v in asdict(self).items()}


def eligibility(product: str, income: float, existing_emi: float, property_value: float, asked: float, years: int) -> Eligibility:
    """Eligible loan = the lowest of: loan by income, loan by property, amount asked (rounded down to Rs 1,000)."""
    rate = POLICY["rate_pct"][product]
    months = years * 12
    cap = foir_cap(income)
    max_emi = max(0.0, income * cap - existing_emi)
    by_income = loan_for_emi(max_emi, rate, months)
    by_property = loan_by_property(product, property_value)
    limits = {"asked": asked, "income": by_income, "property": by_property}
    limited_by = min(limits, key=lambda k: (limits[k], ["asked", "income", "property"].index(k)))
    eligible = math.floor(limits[limited_by] / 1000) * 1000
    e = emi(eligible, rate, months) if eligible > 0 else 0.0
    return Eligibility(max_emi=max_emi, loan_by_income=by_income, loan_by_property=by_property, eligible=float(eligible),
                       emi=e, foir_after=(e + existing_emi) / income if income > 0 else 0.0,
                       ltv=eligible / property_value if property_value > 0 else 0.0, ltv_cap=ltv_cap(product, eligible),
                       foir_cap=cap, rate_pct=rate, limited_by=limited_by)
