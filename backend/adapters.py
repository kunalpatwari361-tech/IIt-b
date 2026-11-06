"""Turn an application into the inputs each trained model expects.

Models 1, 2 and 4 were trained on L&T *vehicle* loans, and model 3 on BAF, a synthetic
bank-account fraud set. Nirnay underwrites home loans, so each adapter writes down
how it bridges the gap. None of it is tuned to the demo cases.

- Credit (models 1, 2): bureau inputs mean the same thing for any Indian retail loan and
  go in as they are. Loan amount does not: a Rs 45 lakh home loan is off the vehicle
  scale, so it goes in as missing (0 points). Affordability is judged by FOIR instead.
- Anomaly (model 4): it looks at *combinations*, such as LTV against loan / asset cost.
  The home loan and property value are rescaled to the size of a typical L&T loan
  (AMOUNT_SCALE), which keeps every ratio; the bureau history goes in unchanged.
- Fraud (model 3): inputs we can measure in India are measured (name vs email, OTP-verified
  phone, address and bank-account age, emails on this device, time spent applying).
  The rest take the median of genuine BAF applications (backend/data/fraud_neutral.json),
  so they push the score neither way.
"""
from __future__ import annotations

import json
from datetime import date
from functools import lru_cache
from pathlib import Path

DATA = Path(__file__).resolve().parent / "data"
TYPICAL_LT_LOAN = 54_000          # median L&T vehicle loan, Rs
TYPICAL_HOME_LOAN = 2_700_000     # typical Indian home-loan ticket, Rs
AMOUNT_SCALE = TYPICAL_LT_LOAN / TYPICAL_HOME_LOAN
FREE_EMAIL = {"gmail.com", "yahoo.com", "yahoo.co.in", "outlook.com", "hotmail.com", "rediffmail.com", "ymail.com",
              "icloud.com", "proton.me", "protonmail.com"}


def age_on(dob: date, day: date) -> float:
    return (day - dob).days / 365.25


def credit_inputs(profile: dict, loan: float, property_value: float, today: date) -> dict:
    b = profile["bureau"]
    return {
        "bureau_score": b.get("score") or 0,
        "bureau_status": b.get("status", "scored"),
        "credit_history_years": b.get("history_years"),
        "loan_amount": None,           # vehicle-loan scale only; see the module notes
        "ltv": round(100 * loan / property_value, 2) if property_value else None,
        "overdue_accounts": b.get("overdue_accounts", 0),
        "recent_delinquencies": b.get("recent_delinquencies", 0),
        "enquiries": b.get("enquiries_6m", 0),
        "new_accounts_6m": b.get("new_accounts_6m", 0),
        "active_accounts": b.get("active_accounts", 0),
        "existing_emi": profile.get("existing_emi", 0),
        "age_years": round(age_on(date.fromisoformat(profile["dob"]), today), 1),
        "employment_type": "salaried" if profile["employment"] == "salaried" else "self_employed",
    }


def anomaly_inputs(profile: dict, loan: float, property_value: float, today: date) -> dict:
    b = profile["bureau"]
    return {
        "loan_amount": round(loan * AMOUNT_SCALE),
        "asset_cost": round(property_value * AMOUNT_SCALE),
        "ltv": round(100 * loan / property_value, 2) if property_value else 0,
        "bureau_score": b.get("score") or 0,
        "total_accounts": b.get("total_accounts", 0),
        "active_accounts": b.get("active_accounts", 0),
        "overdue_accounts": b.get("overdue_accounts", 0),
        "outstanding_balance": b.get("outstanding", 0),
        "sanctioned_total": b.get("sanctioned_total", 0),
        "disbursed_total": b.get("disbursed_total", 0),
        "existing_emi": profile.get("existing_emi", 0),
        "new_accounts_6m": b.get("new_accounts_6m", 0),
        "recent_delinquencies": b.get("recent_delinquencies", 0),
        "enquiries": b.get("enquiries_6m", 0),
        "credit_history_years": b.get("history_years", 0),
        "avg_account_age_years": b.get("avg_account_age_years", 0),
        "age_years": round(age_on(date.fromisoformat(profile["dob"]), today), 1),
        "employment_type": "salaried" if profile["employment"] == "salaried" else "self_employed",
    }


@lru_cache(maxsize=1)
def fraud_neutral() -> dict:
    return json.loads((DATA / "fraud_neutral.json").read_text(encoding="utf-8"))["values"]


def fraud_inputs(profile: dict, bank: dict | None, signals: dict) -> tuple[dict, dict]:
    """BAF-style inputs, and which of them were measured (the rest are neutral medians)."""
    from rapidfuzz import fuzz
    x = dict(fraud_neutral())
    measured = {}
    email = profile.get("email") or ""
    local, _, domain = email.lower().partition("@")
    if email:
        name = profile["name"].lower().replace(" ", "")
        measured["name_email_similarity"] = round(fuzz.partial_ratio(name, local.replace(".", "").replace("_", "")) / 100, 3)
        measured["email_is_free"] = 1.0 if domain in FREE_EMAIL else 0.0
    measured["phone_mobile_valid"] = 1.0                       # the mobile number passed OTP
    if profile.get("address_months") is not None:
        measured["current_address_months_count"] = float(profile["address_months"])
    if bank and bank.get("account_months") is not None:
        measured["bank_months_count"] = float(bank["account_months"])
    if signals.get("emails_on_device") is not None:
        measured["device_distinct_emails_8w"] = float(max(1, signals["emails_on_device"]))
    if signals.get("emails_for_dob", 1) > 1:                    # bursts we see on our own platform
        measured["date_of_birth_distinct_emails_4w"] = x["date_of_birth_distinct_emails_4w"] + 10 * (signals["emails_for_dob"] - 1)
    if signals.get("session_minutes") is not None:
        measured["session_length_in_minutes"] = round(float(signals["session_minutes"]), 2)
    measured["has_other_cards"] = 1.0 if profile["bureau"].get("has_credit_card") else 0.0
    measured["foreign_request"] = 0.0
    x.update(measured)
    return x, measured


def avm_input(prop: dict) -> dict:
    return {"city": prop["city"].strip().lower().replace(" ", "-"), "locality": prop["locality"].strip(),
            "society": (prop.get("society") or "").strip() or None, "area_sqft": prop["areaSqft"], "bhk": prop["bhk"],
            "is_new": 1 if prop.get("isNew") else 0, "declared_price": prop["declaredPrice"]}
