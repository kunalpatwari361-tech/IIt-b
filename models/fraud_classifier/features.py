"""Inputs for the fraud classifier, built from the Bank Account Fraud (BAF) data.

BAF (Feedzai, NeurIPS 2022) is 10 lakh synthetic account-opening applications
generated from a real bank's data, with about 1.1% fraud. No Indian dataset of
applications with fraud labels is public, so we train on BAF and map each input
to the matching check Nirnay runs in India (see README).
"""
from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_PATH = ROOT / "data" / "raw" / "baf" / "Base.csv"
SOURCE_URL = "https://www.kaggle.com/datasets/sgpjesus/bank-account-fraud-dataset-neurips-2022"
TARGET = "fraud_bool"
MONTH = "month"

IDENTITY, VELOCITY, DEVICE, PROFILE = "Identity and contact", "Application bursts", "Device and session", "Applicant profile"

# label: what officers see; india: the matching Nirnay check in India
FEATURES = {
    "name_email_similarity": {"group": IDENTITY, "label": "Name matches email", "india": "PAN name vs email ID"},
    "email_is_free": {"group": IDENTITY, "label": "Free email address", "india": "Gmail/Yahoo etc. vs company email"},
    "phone_mobile_valid": {"group": IDENTITY, "label": "Mobile number valid", "india": "Mobile OTP verified"},
    "phone_home_valid": {"group": IDENTITY, "label": "Home phone valid", "india": "Alternate number verified"},
    "current_address_months_count": {"group": IDENTITY, "label": "Months at current address", "india": "Address tenure (Aadhaar / utility bill)"},
    "prev_address_months_count": {"group": IDENTITY, "label": "Months at previous address", "india": "Previous address tenure"},
    "bank_months_count": {"group": IDENTITY, "label": "Months with previous bank", "india": "Age of salary account (Account Aggregator)"},
    "date_of_birth_distinct_emails_4w": {"group": VELOCITY, "label": "Emails used with same date of birth (4 weeks)", "india": "Same DOB + PAN seen with other emails"},
    "zip_count_4w": {"group": VELOCITY, "label": "Applications from same pincode (4 weeks)", "india": "Pincode application burst"},
    "velocity_6h": {"group": VELOCITY, "label": "Applications per hour, last 6 hours", "india": "Platform-wide application rate"},
    "velocity_24h": {"group": VELOCITY, "label": "Applications per hour, last 24 hours", "india": "Platform-wide application rate"},
    "velocity_4w": {"group": VELOCITY, "label": "Applications per hour, last 4 weeks", "india": "Platform-wide application rate"},
    "bank_branch_count_8w": {"group": VELOCITY, "label": "Applications at same branch (8 weeks)", "india": "Branch / DSA application burst"},
    "device_distinct_emails_8w": {"group": DEVICE, "label": "Emails used on same device (8 weeks)", "india": "Device shared across applicants"},
    "device_os": {"group": DEVICE, "label": "Device operating system", "india": "App / browser device"},
    "session_length_in_minutes": {"group": DEVICE, "label": "Session length (minutes)", "india": "Time spent filling the application"},
    "keep_alive_session": {"group": DEVICE, "label": "Stayed logged in", "india": "Session kept alive"},
    "foreign_request": {"group": DEVICE, "label": "Request from abroad", "india": "Non-Indian IP address"},
    "source": {"group": DEVICE, "label": "Channel", "india": "App/portal vs telecaller/DSA"},
    "income": {"group": PROFILE, "label": "Income (percentile)", "india": "Declared income"},
    "employment_status": {"group": PROFILE, "label": "Employment status", "india": "Salaried / self-employed etc."},
    "housing_status": {"group": PROFILE, "label": "Housing status", "india": "Owned / rented / family home"},
    "credit_risk_score": {"group": PROFILE, "label": "Internal risk score", "india": "Bureau-based risk score"},
    "has_other_cards": {"group": PROFILE, "label": "Has other cards", "india": "Other cards in bureau report"},
    "proposed_credit_limit": {"group": PROFILE, "label": "Amount applied for", "india": "Loan amount asked"},
    "intended_balcon_amount": {"group": PROFILE, "label": "Initial amount transferred", "india": "Own contribution / processing fee paid"},
    "payment_type": {"group": PROFILE, "label": "Payment plan", "india": "EMI plan chosen"},
    "days_since_request": {"group": PROFILE, "label": "Days since request", "india": "Days since the application started"},
    "customer_age": {"group": PROFILE, "label": "Age (decade)", "india": "Age"},
}
CATEGORICAL = ["device_os", "source", "employment_status", "housing_status", "payment_type"]

# BAF codes missing values as -1 (and as any negative amount for intended_balcon_amount).
MISSING_IF_NEGATIVE = ["prev_address_months_count", "current_address_months_count", "bank_months_count",
                       "session_length_in_minutes", "device_distinct_emails_8w", "intended_balcon_amount"]

# Which way each input may move the risk of fraud (-1: more of it can only lower
# risk, +1: can only raise it). Only inputs with an obvious direction.
MONOTONE = {
    "name_email_similarity": -1,
    "phone_mobile_valid": -1,
    "phone_home_valid": -1,
    "date_of_birth_distinct_emails_4w": 1,
    "device_distinct_emails_8w": 1,
    "foreign_request": 1,
}

EXCLUDED = {
    "device_fraud_count": "Always 0 in BAF, so it carries no information.",
    "month": "Used only to split the data by time.",
}


def load_raw(path: Path | None = None) -> pd.DataFrame:
    path = Path(path or DEFAULT_PATH)
    zipped = path.with_name(path.name + ".zip")
    if not path.exists() and zipped.exists():
        path = zipped
    if not path.exists():
        raise SystemExit(f"Data file not found: {path}\nDownload Base.csv from {SOURCE_URL}")
    return pd.read_csv(path)


def build(raw: pd.DataFrame, features: list[str] | None = None) -> pd.DataFrame:
    """Clean the raw columns: negative 'missing' codes become real missing values."""
    names = features or list(FEATURES)
    out = raw[names].copy()
    for name in MISSING_IF_NEGATIVE:
        if name in out:
            out[name] = out[name].where(out[name] >= 0)
    return out.replace([np.inf, -np.inf], np.nan)


def age_group(raw: pd.DataFrame) -> pd.Series:
    """BAF's fairness split: under 50 vs 50 and over."""
    return np.where(raw["customer_age"] >= 50, "50 and over", "under 50")


def income_band(raw: pd.DataFrame) -> pd.Series:
    return pd.cut(raw["income"], [0, 0.35, 0.65, 1.01], labels=["low", "middle", "high"]).astype(str)
