"""Second labelled source: the Karthik-Eswar Indian transaction set (Hugging Face, MIT).

970 synthetic narrations from a different generator than ours, about 65% in
real bank-code styles (UPI/NEFT/IMPS). Its 21 spending categories are mapped
onto our 15. It has no debit/credit direction, and no bounce, cash-deposit,
refund or tax rows, so those four categories are tested on our data only.
"""
from __future__ import annotations

from pathlib import Path

import pandas as pd

ROOT = Path(__file__).resolve().parents[2]
HF_PATH = ROOT / "data" / "raw" / "hf_indian_txn" / "synthetic_indian_transactions.csv"
HF_URL = "https://huggingface.co/datasets/Karthik-Eswar/indian-transaction-categorization-synthetic"

HF_TO_NIRNAY = {
    "Salary": "salary",
    "Income & Deposits": "other_income",   # interest credits, rental income, claims, reimbursements
    "Loan Payment": "emi",
    "Rent & Mortgage": "rent",
    "ATM & Cash": "cash_withdrawal",
    "Fees & Interest": "bank_charges",     # SMS charges, GST on charges, overdraft interest
    "Utilities": "bills",
    "Insurance": "insurance",
    "Investments & Savings Transfer": "investment",
    "Internal Transfer": "transfer",
    **{c: "spend" for c in ["Groceries", "Eating Out", "Kids Activities", "Shopping & Clothing",
                            "Medicine & Pharmacy", "Hospital & Medical", "Transportation & Gas",
                            "Entertainment & Subscriptions", "Travel", "Personal Care", "Education"]},
}


def load_hf(path: Path = HF_PATH) -> pd.DataFrame:
    if not Path(path).exists():
        raise SystemExit(f"Missing {path}\nDownload synthetic_indian_transactions.csv from {HF_URL}")
    df = pd.read_csv(path)
    out = pd.DataFrame({
        "text": df["text"].astype(str),
        "category": df["category"].map(HF_TO_NIRNAY),
        "original_category": df["category"],
        "direction": "unknown",
        "template": "hf:" + df["category"],
        "source": "hf_karthik_eswar",
    })
    unmapped = out["category"].isna()
    if unmapped.any():
        raise ValueError(f"Unmapped categories: {sorted(df.loc[unmapped, 'category'].unique())}")
    return out
