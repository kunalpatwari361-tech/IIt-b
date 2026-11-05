"""Inputs for the anomaly detector, built from the L&T Indian loan data.

The detector never sees a label. It learns what normal applications look like
and flags ones that are hard to explain: extreme amounts, or details that
contradict each other in ways a genuine application rarely does.

Two steps:
* ``build_base`` turns raw L&T columns into application fields, the same fields
  the decision engine sends when it scores a new application.
* ``derive`` turns application fields into model inputs, including consistency
  checks such as "does the stated LTV match loan / asset cost?".
"""
from __future__ import annotations

import numpy as np
import pandas as pd

from ..credit_scorecard.features import LT, LT_NOT_SCORED_BELOW, _lt_dates, _years, age_band

# Application fields (what the engine sends)
BASE_FIELDS = [
    "loan_amount", "asset_cost", "ltv", "bureau_score", "total_accounts", "active_accounts",
    "overdue_accounts", "outstanding_balance", "sanctioned_total", "disbursed_total", "existing_emi",
    "new_accounts_6m", "recent_delinquencies", "enquiries", "credit_history_years",
    "avg_account_age_years", "age_years", "employment_type",
]

# Integrity rules: details that cannot all be true together. An IsolationForest
# cannot catch these well (a combination never seen in training is a constant 0
# to it), so they are checked directly. Limits are set by what is impossible or
# never seen in real L&T data, not tuned on the planted test cases.
RULES = {
    "ltv_mismatch": "Stated LTV differs from loan / asset cost by more than 10 points",
    "score_without_loans": "Bureau score present but no loans of any kind on record",
    "history_before_16": "Credit history would have started before age 16",
    "count_contradiction": "More active, overdue or defaulted loans than loans on record",
    "over_disbursed_2x": "Past loans disbursed at more than 2x the amount sanctioned",
}
LTV_GAP_LIMIT, START_AGE_LIMIT, OVER_DISBURSED_LIMIT = 10.0, 16.0, 2.0

# Model inputs for the IsolationForest, with plain labels for the reasons officers see.
INPUTS_ALL = {
    "log_loan_amount": {"label": "Loan amount", "field": "loan_amount", "unit": "₹"},
    "log_asset_cost": {"label": "Asset cost", "field": "asset_cost", "unit": "₹"},
    "ltv": {"label": "Loan-to-value", "field": "ltv", "unit": "%"},
    "ltv_gap": {"label": "Stated LTV vs loan ÷ asset cost (gap)", "field": None, "unit": "points"},
    "bureau_score_or_0": {"label": "Bureau score", "field": "bureau_score", "unit": ""},
    "log_total_accounts": {"label": "Loans in bureau report", "field": "total_accounts", "unit": ""},
    "log_active_accounts": {"label": "Active loans", "field": "active_accounts", "unit": ""},
    "log_overdue_accounts": {"label": "Overdue loans", "field": "overdue_accounts", "unit": ""},
    "slog_outstanding": {"label": "Outstanding balance", "field": "outstanding_balance", "unit": "₹"},
    "log_sanctioned_total": {"label": "Total sanctioned on past loans", "field": "sanctioned_total", "unit": "₹"},
    "log_disbursed_total": {"label": "Total disbursed on past loans", "field": "disbursed_total", "unit": "₹"},
    "over_disbursed": {"label": "Disbursed more than sanctioned", "field": None, "unit": "ratio"},
    "log_existing_emi": {"label": "Existing EMIs", "field": "existing_emi", "unit": "₹/month"},
    "log_new_accounts_6m": {"label": "New loans in last 6 months", "field": "new_accounts_6m", "unit": ""},
    "log_recent_delinquencies": {"label": "Loans defaulted in last 6 months", "field": "recent_delinquencies", "unit": ""},
    "log_enquiries": {"label": "Recent loan enquiries", "field": "enquiries", "unit": ""},
    "credit_history_years": {"label": "Years since first loan", "field": "credit_history_years", "unit": "years"},
    "avg_account_age_years": {"label": "Average loan age", "field": "avg_account_age_years", "unit": "years"},
    "history_gap": {"label": "Average loan age longer than credit history", "field": None, "unit": "years"},
    "history_before_18": {"label": "Credit history starting before age 18", "field": None, "unit": "years"},
    "count_mismatch": {"label": "Bureau counts that contradict each other", "field": None, "unit": ""},
    "score_without_loans": {"label": "Bureau score with no loans on record", "field": None, "unit": ""},
    "employment_salaried": {"label": "Salaried", "field": "employment_type", "unit": ""},
    "employment_self_employed": {"label": "Self-employed", "field": "employment_type", "unit": ""},
}
# Kept for the forest after testing on planted cases: fewer, sharper inputs isolate odd
# applications better. Dropped: inputs that never vary in real data (handled by RULES),
# near-duplicates (asset cost, active loans, disbursed total, average loan age) and the
# 0/1 employment flags.
FOREST_INPUTS = [
    "log_loan_amount", "ltv", "ltv_gap", "bureau_score_or_0", "log_total_accounts", "log_overdue_accounts",
    "slog_outstanding", "log_sanctioned_total", "over_disbursed", "log_existing_emi", "log_new_accounts_6m",
    "log_recent_delinquencies", "log_enquiries", "credit_history_years", "history_before_18",
]  # history_gap was dropped too: it is 0 for every real L&T application, so the forest never used it
INPUTS = {k: INPUTS_ALL[k] for k in FOREST_INPUTS}

LEFT_OUT = {
    "State_ID, Current_pincode_ID, branch_id": "Where someone lives. A rare location must not make an application 'odd'.",
    "supplier_id, manufacturer_id, Employee_code_ID": "IDs with no order; they describe the dealer or staff, not the applicant.",
    "Aadhar_flag, PAN_flag and other ID flags": "Aadhaar is voluntary; choosing a different ID must not look suspicious.",
    "age_years on its own": "A very young or old applicant is rare but not suspicious. Age is used only to spot a credit "
                            "history that starts before 18.",
}


def build_base(raw: pd.DataFrame) -> pd.DataFrame:
    """Raw L&T columns -> application fields."""
    out = pd.DataFrame(index=raw.index)
    score = raw["PERFORM_CNS.SCORE"]
    out["loan_amount"] = raw["disbursed_amount"]
    out["asset_cost"] = raw["asset_cost"]
    out["ltv"] = raw["ltv"]
    out["bureau_score"] = score.where(score >= LT_NOT_SCORED_BELOW)
    out["total_accounts"] = raw["PRI.NO.OF.ACCTS"] + raw["SEC.NO.OF.ACCTS"]
    out["active_accounts"] = raw["PRI.ACTIVE.ACCTS"] + raw["SEC.ACTIVE.ACCTS"]
    out["overdue_accounts"] = raw["PRI.OVERDUE.ACCTS"] + raw["SEC.OVERDUE.ACCTS"]
    out["outstanding_balance"] = raw["PRI.CURRENT.BALANCE"] + raw["SEC.CURRENT.BALANCE"]
    out["sanctioned_total"] = raw["PRI.SANCTIONED.AMOUNT"] + raw["SEC.SANCTIONED.AMOUNT"]
    out["disbursed_total"] = raw["PRI.DISBURSED.AMOUNT"] + raw["SEC.DISBURSED.AMOUNT"]
    out["existing_emi"] = raw["PRIMARY.INSTAL.AMT"] + raw["SEC.INSTAL.AMT"]
    out["new_accounts_6m"] = raw["NEW.ACCTS.IN.LAST.SIX.MONTHS"]
    out["recent_delinquencies"] = raw["DELINQUENT.ACCTS.IN.LAST.SIX.MONTHS"]
    out["enquiries"] = raw["NO.OF_INQUIRIES"]
    out["credit_history_years"] = _years(raw["CREDIT.HISTORY.LENGTH"])
    out["avg_account_age_years"] = _years(raw["AVERAGE.ACCT.AGE"])
    born, disbursed = _lt_dates(raw)
    out["age_years"] = (disbursed - born).dt.days / 365.25
    out["employment_type"] = raw["Employment.Type"].map({"Salaried": "salaried", "Self employed": "self_employed"})
    return out


def _num(base: pd.DataFrame, name: str) -> pd.Series:
    col = base[name] if name in base else pd.Series(np.nan, index=base.index)
    return pd.to_numeric(col, errors="coerce").astype(float)


def derive(base: pd.DataFrame) -> pd.DataFrame:
    """Application fields -> model inputs. Missing amounts and counts count as 0."""
    f = {name: _num(base, name) for name in BASE_FIELDS if name != "employment_type"}
    z = {k: v.fillna(0) for k, v in f.items()}
    score = f["bureau_score"].where(f["bureau_score"] >= LT_NOT_SCORED_BELOW)
    out = pd.DataFrame(index=base.index)
    out["log_loan_amount"] = np.log1p(z["loan_amount"].clip(lower=0))
    out["log_asset_cost"] = np.log1p(z["asset_cost"].clip(lower=0))
    out["ltv"] = z["ltv"]
    implied = 100 * z["loan_amount"] / z["asset_cost"].where(z["asset_cost"] > 0)
    out["ltv_gap"] = (z["ltv"] - implied).abs().fillna(0)
    out["bureau_score_or_0"] = score.fillna(0)
    for name in ("total_accounts", "active_accounts", "overdue_accounts", "sanctioned_total", "disbursed_total",
                 "existing_emi", "new_accounts_6m", "recent_delinquencies", "enquiries"):
        out[f"log_{name}"] = np.log1p(z[name].clip(lower=0))
    out["slog_outstanding"] = np.sign(z["outstanding_balance"]) * np.log1p(z["outstanding_balance"].abs())
    out["over_disbursed"] = np.log1p((z["disbursed_total"] - z["sanctioned_total"]).clip(lower=0)
                                     / (z["sanctioned_total"].clip(lower=0) + 1))
    out["credit_history_years"] = z["credit_history_years"]
    out["avg_account_age_years"] = z["avg_account_age_years"]
    out["history_gap"] = (z["avg_account_age_years"] - z["credit_history_years"]).clip(lower=0)
    started_at = f["age_years"] - z["credit_history_years"]
    out["history_before_18"] = (18 - started_at).clip(lower=0).where(f["age_years"].notna(), 0)
    out["count_mismatch"] = ((z["active_accounts"] - z["total_accounts"]).clip(lower=0)
                             + (z["overdue_accounts"] - z["total_accounts"]).clip(lower=0)
                             + (z["recent_delinquencies"] - z["total_accounts"]).clip(lower=0))
    out["score_without_loans"] = (score.notna() & (z["total_accounts"] == 0)).astype(float)
    employment = base["employment_type"] if "employment_type" in base else pd.Series(None, index=base.index)
    out["employment_salaried"] = (employment == "salaried").astype(float)
    out["employment_self_employed"] = (employment == "self_employed").astype(float)
    return out[list(INPUTS_ALL)].astype(float)


def integrity_flags(base: pd.DataFrame) -> pd.DataFrame:
    """One True/False column per rule in RULES."""
    d = derive(base)
    f = {name: _num(base, name).fillna(0) for name in ("sanctioned_total", "disbursed_total", "age_years")}
    started_at = _num(base, "age_years") - d["credit_history_years"]
    return pd.DataFrame({
        "ltv_mismatch": d["ltv_gap"] > LTV_GAP_LIMIT,
        "score_without_loans": d["score_without_loans"] > 0,
        "history_before_16": (started_at < START_AGE_LIMIT) & (d["credit_history_years"] > 0),
        "count_contradiction": d["count_mismatch"] > 0,
        "over_disbursed_2x": (f["sanctioned_total"] > 0) & (f["disbursed_total"] > OVER_DISBURSED_LIMIT * f["sanctioned_total"]),
    }, index=base.index)


def months(raw: pd.DataFrame) -> pd.Series:
    _, disbursed = _lt_dates(raw)
    return disbursed.dt.to_period("M")


def fairness_groups(raw: pd.DataFrame, base: pd.DataFrame) -> dict[str, pd.Series]:
    return {"age_band": age_band(base["age_years"]),
            "state": "state " + raw["State_ID"].astype(str),
            "employment": base["employment_type"].fillna("missing")}


__all__ = ["BASE_FIELDS", "INPUTS", "INPUTS_ALL", "FOREST_INPUTS", "RULES", "LEFT_OUT", "LT", "build_base",
           "derive", "integrity_flags", "months", "fairness_groups"]
