"""Plant fake odd applications among real ones, to measure what the detector catches.

Each type copies real applications and changes them the way a fabricated or
manipulated application might look. Nothing here is real customer data: the
copies are altered, used only for testing, and never saved to disk.

Two kinds, reported separately so the result is not flattered:
* Extreme values: still internally consistent, just far outside normal
  (an inflated loan, a burst of new loans).
* Contradictions: details that cannot all be true together. The detector has
  consistency inputs for these, so they are easier to catch.
"""
from __future__ import annotations

import numpy as np
import pandas as pd

KIND = {
    "inflated_loan": "extreme",
    "loan_stacking": "extreme",
    "tampered_ltv": "contradiction",
    "borrowed_score": "contradiction",
    "impossible_history": "contradiction",
    "over_disbursed": "contradiction",
}

DESCRIPTION = {
    "inflated_loan": "Loan and asset cost both 4-8x a normal application (LTV still consistent)",
    "loan_stacking": "6-12 new loans and 8-20 enquiries in the last 6 months, with matching extra EMIs",
    "tampered_ltv": "Stated LTV cut by 30-50 points below what loan / asset cost implies",
    "borrowed_score": "Bureau score of 780-890 but no loans of any kind on record",
    "impossible_history": "Credit history that would have started at age 2-8",
    "over_disbursed": "Past loans disbursed at 2-4x the amount sanctioned",
}


def plant_odd_cases(base: pd.DataFrame, n_per_type: int = 500, seed: int = 7) -> pd.DataFrame:
    """Return altered copies of real applications, with a `plant_type` column."""
    rng = np.random.default_rng(seed)
    out = []
    for kind in KIND:
        rows = base.sample(n_per_type, random_state=int(rng.integers(1 << 31)), replace=len(base) < n_per_type)
        rows = rows.copy().reset_index(drop=True)
        n = len(rows)
        u = lambda lo, hi: rng.uniform(lo, hi, n)
        if kind == "inflated_loan":
            f = u(4, 8)
            rows["loan_amount"] *= f
            rows["asset_cost"] *= f
        elif kind == "loan_stacking":
            new = rng.integers(6, 13, n)
            rows["new_accounts_6m"] = new
            rows["enquiries"] = rng.integers(8, 21, n)
            rows["total_accounts"] = rows["total_accounts"].fillna(0) + new
            rows["active_accounts"] = rows["active_accounts"].fillna(0) + new
            rows["existing_emi"] = rows["existing_emi"].fillna(0) + new * u(1500, 4000)
        elif kind == "tampered_ltv":
            rows["ltv"] = np.clip(rows["ltv"] - u(30, 50), 10, 95)
        elif kind == "borrowed_score":
            rows["bureau_score"] = rng.integers(780, 891, n)
            for c in ("total_accounts", "active_accounts", "overdue_accounts", "recent_delinquencies",
                      "outstanding_balance", "sanctioned_total", "disbursed_total", "existing_emi",
                      "new_accounts_6m"):
                rows[c] = 0
            rows["credit_history_years"] = 0
            rows["avg_account_age_years"] = 0
        elif kind == "impossible_history":
            rows["credit_history_years"] = (rows["age_years"] - u(2, 8)).clip(lower=10)
            rows["avg_account_age_years"] = rows["credit_history_years"] * u(0.3, 0.7)
            rows["total_accounts"] = rows["total_accounts"].fillna(0).clip(lower=1)
        elif kind == "over_disbursed":
            sanctioned = u(20000, 100000)
            rows["total_accounts"] = rows["total_accounts"].fillna(0).clip(lower=1)
            rows["sanctioned_total"] = sanctioned
            rows["disbursed_total"] = sanctioned * u(2, 4)
        rows["plant_type"] = kind
        out.append(rows)
    return pd.concat(out, ignore_index=True)
