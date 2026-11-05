"""Fake applications in the BAF column format, for tests only. Not real data."""
import numpy as np
import pandas as pd


def make_baf_applications(n: int = 30000, seed: int = 5) -> pd.DataFrame:
    rng = np.random.default_rng(seed)
    risk = rng.normal(size=n)
    age = rng.choice([20, 30, 40, 50, 60, 70], n, p=[0.25, 0.31, 0.24, 0.14, 0.04, 0.02])
    log_odds = (-5.2 + 1.3 * risk + 0.02 * (age - 35))
    fraud = (rng.random(n) < 1 / (1 + np.exp(-log_odds))).astype(int)
    lean = risk + 2.0 * fraud  # fraud cases look riskier on every signal
    clip = lambda a, lo, hi: np.clip(a, lo, hi)
    return pd.DataFrame({
        "fraud_bool": fraud,
        "income": rng.choice(np.round(np.arange(0.1, 1.0, 0.1), 1), n),
        "name_email_similarity": clip(0.55 - 0.15 * lean + rng.normal(0, 0.2, n), 0, 1),
        "prev_address_months_count": np.where(rng.random(n) < 0.7, -1, rng.integers(0, 300, n)),
        "current_address_months_count": clip(rng.integers(-1, 400, n) - (20 * lean).astype(int), -1, 428),
        "customer_age": age,
        "days_since_request": rng.exponential(1, n),
        "intended_balcon_amount": np.where(rng.random(n) < 0.7, -rng.random(n), rng.uniform(0, 100, n)),
        "payment_type": rng.choice(["AA", "AB", "AC", "AD"], n),
        "zip_count_4w": rng.integers(1, 5000, n),
        "velocity_6h": rng.uniform(0, 15000, n),
        "velocity_24h": rng.uniform(1300, 9500, n),
        "velocity_4w": rng.uniform(2800, 7000, n),
        "bank_branch_count_8w": rng.integers(0, 2000, n),
        "date_of_birth_distinct_emails_4w": clip(rng.poisson(9, n) - (2 * lean).astype(int), 0, 39),
        "employment_status": rng.choice(["CA", "CB", "CC", "CD"], n, p=[0.7, 0.15, 0.1, 0.05]),
        "credit_risk_score": (130 + 40 * lean + rng.normal(0, 50, n)).astype(int),
        "email_is_free": (rng.random(n) < 0.5 + 0.1 * np.tanh(lean)).astype(int),
        "housing_status": rng.choice(["BA", "BB", "BC", "BE"], n),
        "phone_home_valid": (rng.random(n) < 0.45 - 0.1 * np.tanh(lean)).astype(int),
        "phone_mobile_valid": (rng.random(n) < 0.9 - 0.1 * np.tanh(lean)).astype(int),
        "bank_months_count": np.where(rng.random(n) < 0.25, -1, rng.integers(1, 32, n)),
        "has_other_cards": (rng.random(n) < 0.2).astype(int),
        "proposed_credit_limit": rng.choice([200, 500, 1000, 1500, 2000], n),
        "foreign_request": (rng.random(n) < 0.02 + 0.03 * (lean > 2)).astype(int),
        "source": rng.choice(["INTERNET", "TELEAPP"], n, p=[0.99, 0.01]),
        "session_length_in_minutes": rng.exponential(7, n),
        "device_os": np.where(lean > 1.5, rng.choice(["windows", "other"], n), rng.choice(["linux", "other", "macintosh"], n)),
        "keep_alive_session": (rng.random(n) < 0.6).astype(int),
        "device_distinct_emails_8w": np.where(rng.random(n) < 0.01, -1, clip(1 + (lean > 2.2).astype(int), 0, 2)),
        "device_fraud_count": 0,
        "month": rng.integers(0, 8, n),
    })
