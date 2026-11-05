"""Make fake applications in the Home Credit column format, for tests only.

Risk is driven by a hidden factor, so the scorecard has a real pattern to learn.
None of this is real customer data.
"""
import numpy as np
import pandas as pd


def make_applications(n: int = 8000, seed: int = 7) -> pd.DataFrame:
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
