"""Make fake applications in each dataset's column format, for tests only.

Risk is driven by a hidden factor, so the scorecard has a real pattern to learn.
None of this is real customer data.
"""
import numpy as np
import pandas as pd


def make_lt_applications(n: int = 8000, seed: int = 11) -> pd.DataFrame:
    rng = np.random.default_rng(seed)
    risk = rng.normal(size=n)
    has_history = rng.random(n) < 0.5
    score = np.where(has_history, np.clip(650 - 90 * risk + rng.normal(0, 60, n), 300, 890).round(), 0)
    not_scored = has_history & (rng.random(n) < 0.06)
    score = np.where(not_scored, rng.integers(14, 19, n), score)
    accounts = np.where(has_history, rng.poisson(2, n), 0)
    overdue = np.where(has_history, rng.binomial(accounts, np.clip(0.1 + 0.08 * risk, 0, 1)), 0)
    delinquent = np.minimum(overdue, rng.poisson(np.clip(0.2 + 0.3 * risk, 0, None)) * has_history)
    years = np.where(has_history, rng.integers(0, 12, n), 0)
    months = np.where(has_history, rng.integers(0, 12, n), 0)
    age = rng.uniform(19, 66, n)
    ltv = np.clip(rng.normal(75 + 4 * risk, 10), 10, 95).round(2)
    loan = rng.normal(55000, 12000, n).clip(15000).round()
    log_odds = -1.5 + 0.9 * risk + 0.03 * (ltv - 75) - 0.02 * (age - 35) + 0.4 * (overdue > 0)
    target = (rng.random(n) < 1 / (1 + np.exp(-log_odds))).astype(int)
    disbursal = pd.Timestamp("2018-08-01") + pd.to_timedelta(rng.integers(0, 92, n), unit="D")
    birth = disbursal - pd.to_timedelta((age * 365.25).astype(int), unit="D")
    total = accounts + np.where(has_history, rng.poisson(1.5, n), 0)
    sanctioned = np.where(total > 0, total * rng.uniform(20000, 80000, n), 0).round()
    avg_years = np.where(has_history, np.minimum(years, rng.integers(0, 6, n)), 0)
    return pd.DataFrame({
        "UniqueID": np.arange(400000, 400000 + n),
        "PRI.NO.OF.ACCTS": total, "SEC.NO.OF.ACCTS": 0,
        "PRI.CURRENT.BALANCE": (sanctioned * rng.uniform(0, 0.8, n)).round(), "SEC.CURRENT.BALANCE": 0,
        "PRI.SANCTIONED.AMOUNT": sanctioned, "SEC.SANCTIONED.AMOUNT": 0,
        "PRI.DISBURSED.AMOUNT": (sanctioned * rng.uniform(0.9, 1.0, n)).round(), "SEC.DISBURSED.AMOUNT": 0,
        "AVERAGE.ACCT.AGE": [f"{y}yrs {m}mon" for y, m in zip(avg_years, rng.integers(0, 12, n))],
        "disbursed_amount": loan, "asset_cost": (loan / (ltv / 100)).round(), "ltv": ltv,
        "Date.of.Birth": birth.strftime("%d-%m-%y"), "DisbursalDate": disbursal.strftime("%d-%m-%y"),
        "Employment.Type": rng.choice(["Salaried", "Self employed", None], n, p=[0.42, 0.55, 0.03]),
        "State_ID": rng.integers(1, 8, n),
        "PERFORM_CNS.SCORE": score,
        "PRI.ACTIVE.ACCTS": accounts, "SEC.ACTIVE.ACCTS": 0,
        "PRI.OVERDUE.ACCTS": overdue, "SEC.OVERDUE.ACCTS": 0,
        "PRIMARY.INSTAL.AMT": accounts * rng.integers(0, 3000, n), "SEC.INSTAL.AMT": 0,
        "NEW.ACCTS.IN.LAST.SIX.MONTHS": np.minimum(accounts, rng.poisson(0.4, n)),
        "DELINQUENT.ACCTS.IN.LAST.SIX.MONTHS": delinquent,
        "CREDIT.HISTORY.LENGTH": [f"{y}yrs {m}mon" for y, m in zip(years, months)],
        "NO.OF_INQUIRIES": rng.poisson(np.clip(0.2 + 0.15 * risk, 0.01, None)),
        "loan_default": target,
    })


def make_applications(n: int = 8000, seed: int = 7) -> pd.DataFrame:
    """Home Credit format."""
    rng = np.random.default_rng(seed)
    risk = rng.normal(size=n)  # hidden: higher means more likely to default

    def bureau(noise: float, missing_share: float) -> np.ndarray:
        score = 1 / (1 + np.exp(1.3 * risk + rng.normal(scale=noise, size=n)))
        return np.where(rng.random(n) < missing_share, np.nan, score)

    age = rng.uniform(21, 68, size=n)
    years_employed = np.minimum(rng.exponential(6, size=n), age - 20)
    pensioner = age > 60
    income = rng.lognormal(mean=12, sigma=0.5, size=n)
    credit = income * rng.uniform(1, 6, size=n)
    goods = credit / rng.uniform(1.0, 1.25, size=n)
    annuity = credit * rng.uniform(0.04, 0.09, size=n)
    payment_to_income = annuity / income

    log_odds = -2.7 + 1.1 * risk + 2.5 * (payment_to_income - 0.2) - 0.02 * (age - 40)
    target = (rng.random(n) < 1 / (1 + np.exp(-log_odds))).astype(int)

    return pd.DataFrame({
        "SK_ID_CURR": np.arange(100000, 100000 + n),
        "TARGET": target,
        "CODE_GENDER": rng.choice(["F", "M"], size=n, p=[0.65, 0.35]),
        "EXT_SOURCE_1": bureau(0.8, 0.5),
        "EXT_SOURCE_2": bureau(0.6, 0.01),
        "EXT_SOURCE_3": bureau(0.7, 0.2),
        "AMT_INCOME_TOTAL": income,
        "AMT_CREDIT": credit,
        "AMT_ANNUITY": annuity,
        "AMT_GOODS_PRICE": goods,
        "DAYS_BIRTH": -(age * 365.25).astype(int),
        "DAYS_EMPLOYED": np.where(pensioner, 365243, -(years_employed * 365.25).astype(int)),
        "NAME_INCOME_TYPE": np.where(pensioner, "Pensioner",
                                     rng.choice(["Working", "Commercial associate", "State servant"],
                                                size=n, p=[0.6, 0.25, 0.15])),
        "FLAG_OWN_REALTY": rng.choice(["Y", "N"], size=n, p=[0.7, 0.3]),
    })
