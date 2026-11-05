"""Turn each training dataset's raw columns into the scorecard's inputs.

Two datasets are supported:

* ``lt`` (default): L&T Vehicle Loan Default. Real Indian loans with a
  bureau score, published on Kaggle from an L&T Financial Services hackathon.
* ``home_credit``: Home Credit Default Risk. Consumer loans from outside India,
  published by Home Credit as a Kaggle competition.

Each input stands for data Nirnay collects in India. The README maps every
input to its Indian equivalent.
"""
from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Callable

import numpy as np
import pandas as pd

ROOT = Path(__file__).resolve().parents[2]

REPAYMENT, AFFORDABILITY, COLLATERAL, STABILITY = (
    "Repayment history", "Affordability", "Collateral", "Stability")


@dataclass(frozen=True)
class Dataset:
    key: str
    title: str
    source_url: str
    default_path: Path
    target: str
    columns: list[str] | None
    features: dict[str, dict[str, str]]
    categorical: list[str]
    excluded: dict[str, str]
    build: Callable[[pd.DataFrame], pd.DataFrame]
    fairness_groups: Callable[[pd.DataFrame, pd.DataFrame], dict[str, pd.Series]]
    test_mask: Callable[[pd.DataFrame], pd.Series] | None = None  # out-of-time split, if the data has dates
    split_note: str = "random 20% of applications, kept aside"

    @property
    def numerical(self) -> list[str]:
        return [name for name in self.features if name not in self.categorical]


def _ratio(top: pd.Series, bottom: pd.Series) -> pd.Series:
    return top / bottom.where(bottom > 0)


def age_band(age: pd.Series) -> pd.Series:
    return pd.cut(age, [0, 30, 45, 60, 200], right=False,
                  labels=["under 30", "30-44", "45-59", "60+"]).astype(str)


# --- L&T Vehicle Loan Default (India) ---------------------------------------

LT_NOT_SCORED_BELOW = 300  # scores under 300 are codes: 0 = no history, 11-18 = "not scored"


def _years(text: pd.Series) -> pd.Series:
    """'1yrs 11mon' -> 1.92"""
    parts = text.astype(str).str.extract(r"(\d+)yrs\s+(\d+)mon").astype(float)
    return parts[0] + parts[1] / 12


def _lt_dates(raw: pd.DataFrame) -> tuple[pd.Series, pd.Series]:
    disbursed = pd.to_datetime(raw["DisbursalDate"], format="%d-%m-%y", errors="coerce")
    born = pd.to_datetime(raw["Date.of.Birth"], format="%d-%m-%y", errors="coerce")
    # Two-digit years: '01-01-68' parses as 2068, so move any birth date after the loan back a century.
    born = born.where(~(born > disbursed), born - pd.DateOffset(years=100))
    return born, disbursed


def build_lt(raw: pd.DataFrame) -> pd.DataFrame:
    out = pd.DataFrame(index=raw.index)
    score = raw["PERFORM_CNS.SCORE"]
    out["bureau_score"] = score.where(score >= LT_NOT_SCORED_BELOW)
    out["bureau_status"] = np.select(
        [score >= LT_NOT_SCORED_BELOW, score == 0], ["scored", "no_history"], default="not_scored")
    out["overdue_accounts"] = raw["PRI.OVERDUE.ACCTS"] + raw["SEC.OVERDUE.ACCTS"]
    out["recent_delinquencies"] = raw["DELINQUENT.ACCTS.IN.LAST.SIX.MONTHS"]
    out["credit_history_years"] = _years(raw["CREDIT.HISTORY.LENGTH"])
    out["enquiries"] = raw["NO.OF_INQUIRIES"]
    out["new_accounts_6m"] = raw["NEW.ACCTS.IN.LAST.SIX.MONTHS"]
    out["active_accounts"] = raw["PRI.ACTIVE.ACCTS"] + raw["SEC.ACTIVE.ACCTS"]
    out["existing_emi"] = raw["PRIMARY.INSTAL.AMT"] + raw["SEC.INSTAL.AMT"]
    out["loan_amount"] = raw["disbursed_amount"]
    out["ltv"] = raw["ltv"]
    born, disbursed = _lt_dates(raw)
    out["age_years"] = (disbursed - born).dt.days / 365.25
    out["employment_type"] = raw["Employment.Type"].map({"Salaried": "salaried", "Self employed": "self_employed"})
    return out.replace([np.inf, -np.inf], np.nan)


def lt_fairness(raw: pd.DataFrame, X: pd.DataFrame) -> dict[str, pd.Series]:
    return {"age_band": age_band(X["age_years"]), "state": "state " + raw["State_ID"].astype(str)}


def lt_test_mask(raw: pd.DataFrame) -> pd.Series:
    _, disbursed = _lt_dates(raw)
    month = disbursed.dt.to_period("M")
    return month == month.max()


LT = Dataset(
    key="lt",
    title="L&T Vehicle Loan Default (India)",
    source_url="https://www.kaggle.com/datasets/mamtadhaker/lt-vehicle-loan-default-prediction",
    default_path=ROOT / "data" / "raw" / "lt_vehicle_loan" / "train.csv",
    target="loan_default",
    columns=None,
    features={
        # Bureaus send 0 or a code under 300 when there is no score; treat those as missing.
        "bureau_score": {"group": REPAYMENT, "label": "Bureau score", "missing_below": LT_NOT_SCORED_BELOW},
        "bureau_status": {"group": REPAYMENT, "label": "Bureau record"},
        "overdue_accounts": {"group": REPAYMENT, "label": "Loans currently overdue"},
        "recent_delinquencies": {"group": REPAYMENT, "label": "Loans defaulted in the last 6 months"},
        "credit_history_years": {"group": REPAYMENT, "label": "Years since first loan"},
        "enquiries": {"group": REPAYMENT, "label": "Recent loan enquiries"},
        "new_accounts_6m": {"group": REPAYMENT, "label": "New loans in the last 6 months"},
        "active_accounts": {"group": REPAYMENT, "label": "Active loans"},
        "existing_emi": {"group": AFFORDABILITY, "label": "Existing EMIs (₹ per month)"},
        "loan_amount": {"group": AFFORDABILITY, "label": "Loan amount (₹)"},
        "ltv": {"group": COLLATERAL, "label": "Loan-to-value (%)"},
        "age_years": {"group": STABILITY, "label": "Age"},
        "employment_type": {"group": STABILITY, "label": "Employment type"},
    },
    categorical=["bureau_status", "employment_type"],
    excluded={
        "State_ID, Current_pincode_ID, branch_id": "Where someone lives. Can stand in for community or caste.",
        "supplier_id, manufacturer_id, Employee_code_ID": "Which dealer, brand or staff member handled the loan, not the borrower.",
        "Aadhar_flag, PAN_flag and other ID flags": "Belong to the Identity gate. Aadhaar is voluntary, so not giving it must not cost points.",
        "PERFORM_CNS.SCORE.DESCRIPTION": "Repeats the bureau score as a band.",
        "asset_cost": "Already inside loan-to-value.",
    },
    build=build_lt,
    fairness_groups=lt_fairness,
    test_mask=lt_test_mask,
    split_note="out of time: trained on Aug-Sep 2018 loans, tested on Oct 2018 loans",
)


# --- Home Credit Default Risk -------------------------------------------------

DAYS_EMPLOYED_NOT_WORKING = 365243  # Home Credit's code for "not currently employed"

# NAME_INCOME_TYPE mapped onto Nirnay's employment types. Maternity leave counts
# as salaried so the score never penalises pregnancy.
HC_EMPLOYMENT_TYPE = {
    "Working": "salaried", "State servant": "salaried", "Maternity leave": "salaried",
    "Commercial associate": "self_employed", "Businessman": "self_employed",
    "Pensioner": "pensioner", "Unemployed": "other", "Student": "other",
}


def build_home_credit(raw: pd.DataFrame) -> pd.DataFrame:
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
    out["employment_type"] = raw["NAME_INCOME_TYPE"].map(HC_EMPLOYMENT_TYPE).fillna("other")
    return out.replace([np.inf, -np.inf], np.nan)


def home_credit_fairness(raw: pd.DataFrame, X: pd.DataFrame) -> dict[str, pd.Series]:
    return {"gender": raw["CODE_GENDER"].where(raw["CODE_GENDER"].isin(["F", "M"])),
            "age_band": age_band(X["age_years"])}


HOME_CREDIT = Dataset(
    key="home_credit",
    title="Home Credit Default Risk",
    source_url="https://www.kaggle.com/competitions/home-credit-default-risk/data",
    default_path=ROOT / "data" / "raw" / "application_train.csv",
    target="TARGET",
    columns=[
        "SK_ID_CURR", "TARGET", "CODE_GENDER",
        "EXT_SOURCE_1", "EXT_SOURCE_2", "EXT_SOURCE_3",
        "AMT_INCOME_TOTAL", "AMT_CREDIT", "AMT_ANNUITY", "AMT_GOODS_PRICE",
        "DAYS_BIRTH", "DAYS_EMPLOYED", "NAME_INCOME_TYPE", "FLAG_OWN_REALTY",
    ],
    features={
        "bureau_score_1": {"group": REPAYMENT, "label": "Bureau score 1"},
        "bureau_score_2": {"group": REPAYMENT, "label": "Bureau score 2"},
        "bureau_score_3": {"group": REPAYMENT, "label": "Bureau score 3"},
        "payment_to_income": {"group": AFFORDABILITY, "label": "Loan payment as a share of income"},
        "loan_to_income": {"group": AFFORDABILITY, "label": "Loan amount compared with yearly income"},
        "loan_to_price": {"group": COLLATERAL, "label": "Loan amount compared with the price paid"},
        "owns_property": {"group": COLLATERAL, "label": "Already owns property"},
        "years_employed": {"group": STABILITY, "label": "Years in current job"},
        "age_years": {"group": STABILITY, "label": "Age"},
        "employment_type": {"group": STABILITY, "label": "Employment type"},
    },
    categorical=["owns_property", "employment_type"],
    excluded={
        "CODE_GENDER": "Gender. Lending decisions must not depend on it. Used only for the fairness check.",
        "NAME_FAMILY_STATUS, CNT_CHILDREN, CNT_FAM_MEMBERS": "Marital status and family size. Can stand in for gender.",
        "NAME_EDUCATION_TYPE": "Education. Can stand in for social background.",
        "REGION_* and *_CITY flags": "Where someone lives. Can stand in for community or caste.",
        "Raw income and loan amounts": "Not in rupees, so we use ratios that carry over.",
    },
    build=build_home_credit,
    fairness_groups=home_credit_fairness,
)

DATASETS = {d.key: d for d in (LT, HOME_CREDIT)}
