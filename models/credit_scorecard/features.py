"""Turn raw Home Credit columns into the scorecard's inputs.

The scorecard learns from the Home Credit Default Risk dataset. Each input
below stands for data Nirnay collects in India. The README maps every input
to its Indian equivalent.
"""
from __future__ import annotations

import numpy as np
import pandas as pd

# Columns read from application_train.csv. CODE_GENDER is read only for the
# fairness check. It is never an input to the score.
RAW_COLUMNS = [
    "SK_ID_CURR", "TARGET", "CODE_GENDER",
    "EXT_SOURCE_1", "EXT_SOURCE_2", "EXT_SOURCE_3",
    "AMT_INCOME_TOTAL", "AMT_CREDIT", "AMT_ANNUITY", "AMT_GOODS_PRICE",
    "DAYS_BIRTH", "DAYS_EMPLOYED", "NAME_INCOME_TYPE", "FLAG_OWN_REALTY",
]

# The inputs the scorecard may use. Groups follow the report: repayment
# history, affordability, collateral and stability.
FEATURES = {
    "bureau_score_1": {"group": "Repayment history", "label": "Bureau score 1"},
    "bureau_score_2": {"group": "Repayment history", "label": "Bureau score 2"},
    "bureau_score_3": {"group": "Repayment history", "label": "Bureau score 3"},
    "payment_to_income": {"group": "Affordability", "label": "Loan payment as a share of income"},
    "loan_to_income": {"group": "Affordability", "label": "Loan amount compared with yearly income"},
    "loan_to_price": {"group": "Collateral", "label": "Loan amount compared with the price paid"},
    "owns_property": {"group": "Collateral", "label": "Already owns property"},
    "years_employed": {"group": "Stability", "label": "Years in current job"},
    "age_years": {"group": "Stability", "label": "Age"},
    "employment_type": {"group": "Stability", "label": "Employment type"},
}
CATEGORICAL = ["owns_property", "employment_type"]
NUMERICAL = [name for name in FEATURES if name not in CATEGORICAL]

# Columns we deliberately leave out, and why. The fairness check in train.py
# makes sure leaving them out actually keeps approval rates even.
EXCLUDED = {
    "CODE_GENDER": "Gender. Lending decisions must not depend on it.",
    "NAME_FAMILY_STATUS": "Marital status. Can stand in for gender and is not about ability to repay.",
    "CNT_CHILDREN / CNT_FAM_MEMBERS": "Family size. Can stand in for gender and marital status.",
    "NAME_EDUCATION_TYPE": "Education. Can stand in for social background.",
    "REGION_* / *_CITY flags": "Where someone lives. Can stand in for community or caste.",
    "Raw income and loan amounts": "Home Credit amounts are not in rupees, so we use ratios that carry over.",
}

# NAME_INCOME_TYPE mapped onto Nirnay's own employment types. Maternity leave
# counts as salaried so the score never penalises pregnancy.
EMPLOYMENT_TYPE = {
    "Working": "salaried",
    "State servant": "salaried",
    "Maternity leave": "salaried",
    "Commercial associate": "self_employed",
    "Businessman": "self_employed",
    "Pensioner": "pensioner",
    "Unemployed": "other",
    "Student": "other",
}

DAYS_EMPLOYED_NOT_WORKING = 365243  # Home Credit's code for "not currently employed"


def _ratio(top: pd.Series, bottom: pd.Series) -> pd.Series:
    bottom = bottom.where(bottom > 0)
    return top / bottom


def build_features(raw: pd.DataFrame) -> pd.DataFrame:
    """Return one row of scorecard inputs per application."""
    out = pd.DataFrame(index=raw.index)
    out["bureau_score_1"] = raw["EXT_SOURCE_1"]
    out["bureau_score_2"] = raw["EXT_SOURCE_2"]
    out["bureau_score_3"] = raw["EXT_SOURCE_3"]
    out["payment_to_income"] = _ratio(raw["AMT_ANNUITY"], raw["AMT_INCOME_TOTAL"])
    out["loan_to_income"] = _ratio(raw["AMT_CREDIT"], raw["AMT_INCOME_TOTAL"])
    out["loan_to_price"] = _ratio(raw["AMT_CREDIT"], raw["AMT_GOODS_PRICE"])
    out["owns_property"] = raw["FLAG_OWN_REALTY"].map({"Y": "yes", "N": "no"})
    days_employed = raw["DAYS_EMPLOYED"].where(raw["DAYS_EMPLOYED"] != DAYS_EMPLOYED_NOT_WORKING)
    out["years_employed"] = (-days_employed / 365.25).clip(lower=0)
    out["age_years"] = -raw["DAYS_BIRTH"] / 365.25
    out["employment_type"] = raw["NAME_INCOME_TYPE"].map(EMPLOYMENT_TYPE).fillna("other")
    return out.replace([np.inf, -np.inf], np.nan)
