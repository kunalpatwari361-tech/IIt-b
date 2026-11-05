"""Train the Nirnay property valuation model (model 7).

Run from the repo root (after downloading the listings, see features.py):
    .venv/Scripts/python -m models.property_avm.train

Checks:
1. Random split: 20% of listings held out (stratified by city). This is the normal AVM
   case: other flats in the same locality are known.
2. Unseen localities: 20% of localities held out entirely. This is the case of a
   property where we have no listings nearby.
3. Outside source: a model trained on the 2023 listings values the 2020 CC0 metro scrape.
4. Circle rates: how listing prices compare with Delhi and Gurugram circle values, and
   what the circle rate adds for unseen localities there.
"Typical % error" is the median absolute percentage error (MdAPE). We also report the share
of estimates within 10% and 20% of the listed price, and how often the price falls inside
the P10-P90 range (the target is 80%).

It writes:
    artifacts/model_p10.txt, model_p50.txt, model_p90.txt   LightGBM boosters (LF line endings)
    artifacts/avm.json                  encoder, categories, conformal widening, version
    reports/metrics.json                every check
    reports/by_city.csv, by_price_band.csv, by_locality_data.csv
    reports/feature_importance.csv
    reports/circle_rates.csv            listing price versus circle value, Delhi and Gurugram
"""
from __future__ import annotations

import argparse
import json
from datetime import date
from pathlib import Path

import lightgbm as lgb
import numpy as np
import pandas as pd
from sklearn.model_selection import KFold, train_test_split

from .avm import CATEGORICAL, FEATURES, Encoder, PropertyAVM, frame
from .circle_rates import add_circle_rates
from .features import load_houseprice, load_metros

HERE = Path(__file__).resolve().parent
VERSION = "avm-v1"
COVERAGE = 0.8
BASE = dict(learning_rate=0.1, num_leaves=63, min_data_in_leaf=20, feature_fraction=0.8, bagging_fraction=0.8,
            bagging_freq=1, lambda_l2=1.0, verbose=-1, num_threads=0)
PRICE_BANDS = [(0, 30e5, "up to 30 lakh"), (30e5, 75e5, "30 to 75 lakh"), (75e5, np.inf, "above 75 lakh")]


def categories(df: pd.DataFrame) -> dict:
    return {c: sorted(df[c].dropna().astype(str).unique().tolist()) for c in CATEGORICAL}


def oof_frame(train: pd.DataFrame, cats: dict, seed: int) -> pd.DataFrame:
    """Features for training rows, with each row's locality levels worked out without its own price."""
    parts = []
    for fit_idx, enc_idx in KFold(5, shuffle=True, random_state=seed).split(train):
        enc = Encoder.fit(train.iloc[fit_idx])
        parts.append(frame(train.iloc[enc_idx], enc, cats))
    return pd.concat(parts).loc[train.index]


def _booster(params, X, y, Xv, yv):
    ds = lgb.Dataset(X, y, categorical_feature=CATEGORICAL, free_raw_data=False)
    dv = lgb.Dataset(Xv, yv, reference=ds, categorical_feature=CATEGORICAL)
    return lgb.train(params, ds, num_boost_round=2000, valid_sets=[dv],
                     callbacks=[lgb.early_stopping(50, verbose=False)])


def fit(train: pd.DataFrame, seed: int = 42, drop: tuple = ()) -> tuple[PropertyAVM, dict]:
    """Fit P10, P50 and P90 boosters on 85% of the rows; the other 15% stop the training
    and set the conformal widening (split conformal, so the 80% coverage holds on new data).
    `drop` blanks inputs, for comparisons."""
    train = train.copy()
    for col in drop:
        train[col] = np.nan
    cats = categories(train)
    X, y = oof_frame(train, cats, seed), train["log_ppsf"].to_numpy()
    fit_i, cal_i = train_test_split(np.arange(len(train)), test_size=0.15, random_state=seed,
                                    stratify=train["city"].where(train["city"].map(train["city"].value_counts()) >= 20, "rare"))
    specs = {"p50": dict(BASE, objective="regression", seed=seed),
             "p10": dict(BASE, objective="quantile", alpha=0.1, seed=seed),
             "p90": dict(BASE, objective="quantile", alpha=0.9, seed=seed)}
    boosters = {q: _booster(p, X.iloc[fit_i], y[fit_i], X.iloc[cal_i], y[cal_i]) for q, p in specs.items()}
    # Conformal calibration: widen the range until 80% of the calibration prices fall inside.
    lo, hi = boosters["p10"].predict(X.iloc[cal_i]), boosters["p90"].predict(X.iloc[cal_i])
    scores = np.maximum(lo - y[cal_i], y[cal_i] - hi)
    n = len(scores)
    widen = float(np.quantile(scores, min(1.0, np.ceil((n + 1) * COVERAGE) / n)))
    rounds = {q: b.best_iteration or b.current_iteration() for q, b in boosters.items()}
    meta = {"version": VERSION, "categories": cats, "conformal_widen_log": widen, "rounds": rounds,
            "dropped_inputs": list(drop)}
    return PropertyAVM(boosters, Encoder.fit(train), meta), meta


def score(model: PropertyAVM, test: pd.DataFrame, drop: tuple = ()) -> pd.DataFrame:
    test = test.copy()
    for col in drop:
        test[col] = np.nan
    X = frame(test, model.encoder, model.meta["categories"])
    q = model.predict_log(X)
    out = test[["city", "price", "area_sqft", "log_ppsf"]].copy()
    out["estimate"] = np.exp(q["mid"]) * test["area_sqft"]
    out["low"], out["high"] = np.exp(q["low"]) * test["area_sqft"], np.exp(q["high"]) * test["area_sqft"]
    out["ape"] = (out["estimate"] - out["price"]).abs() / out["price"]
    out["inside"] = out["price"].between(out["low"], out["high"])
    out["half_width"] = (out["high"] - out["low"]) / 2 / out["estimate"]
    out["locality_listings"] = X["locality_listings"].to_numpy()
    return out


def summary(s: pd.DataFrame) -> dict:
    return {"typical_pct_error": round(100 * float(s["ape"].median()), 1),
            "within_10pct": round(float((s["ape"] <= 0.10).mean()), 3),
            "within_20pct": round(float((s["ape"] <= 0.20).mean()), 3),
            "range_coverage": round(float(s["inside"].mean()), 3),
            "range_plus_minus_pct": round(100 * float(s["half_width"].median()), 1),
            "median_estimate_to_price": round(float((s["estimate"] / s["price"]).median()), 3),
            "listings": int(len(s))}


def table(s: pd.DataFrame, by: pd.Series, min_n: int = 1) -> pd.DataFrame:
    rows = [{"group": k, **summary(g)} for k, g in s.groupby(by, sort=False) if len(g) >= min_n]
    return pd.DataFrame(rows).sort_values("listings", ascending=False)


def band(price: pd.Series) -> pd.Series:
    return pd.cut(price, [b[0] for b in PRICE_BANDS] + [np.inf], labels=[b[2] for b in PRICE_BANDS], right=False).astype(str)


def baseline(train_df: pd.DataFrame, test_df: pd.DataFrame) -> float:
    """The simple benchmark: the locality's median price per sq ft (else the city's). Typical % error."""
    loc = train_df.groupby("city_locality")["log_ppsf"].median()
    city = train_df.groupby("city")["log_ppsf"].median()
    p = test_df["city_locality"].map(loc).fillna(test_df["city"].map(city)).fillna(train_df["log_ppsf"].median())
    return round(100 * float((np.abs(np.exp(p) * test_df["area_sqft"] - test_df["price"]) / test_df["price"]).median()), 1)


def self_baseline(df: pd.DataFrame, seed: int = 42) -> float:
    """How predictable a dataset is from its own locality medians (5-fold)."""
    df = df.reset_index(drop=True)
    errs = []
    for tr, te in KFold(5, shuffle=True, random_state=seed).split(df):
        t = df.iloc[te]
        loc = df.iloc[tr].groupby("city_locality")["log_ppsf"].median()
        city = df.iloc[tr].groupby("city")["log_ppsf"].median()
        p = t["city_locality"].map(loc).fillna(t["city"].map(city))
        errs.append(np.abs(np.exp(p) * t["area_sqft"] - t["price"]) / t["price"])
    return round(100 * float(pd.concat(errs).median()), 1)


def outside_checks(s3: pd.DataFrame, metrics: dict, reports: dict) -> None:
    """The 2020 scrape differs in two known ways, so it is also scored without them:
    * its "Mumbai" includes Thane, Navi Mumbai and Mira Road, which our data lists as separate, cheaper cities;
    * prices rose from 2020 to 2023. Scaling each city's estimates by its median estimate-to-price ratio
      removes the city-wide level and leaves how well the model ranks flats *within* a city.
      This uses the test prices themselves, so it is a diagnostic, not an accuracy claim."""
    metrics["outside_source_metros_2020_without_mumbai"] = summary(s3[s3["city"] != "mumbai"])
    adj = s3.copy()
    ratio = (adj["estimate"] / adj["price"]).groupby(adj["city"]).transform("median")
    for col in ("estimate", "low", "high"):
        adj[col] = adj[col] / ratio
    adj["ape"] = (adj["estimate"] - adj["price"]).abs() / adj["price"]
    adj["inside"] = adj["price"].between(adj["low"], adj["high"])
    metrics["outside_source_metros_2020_city_level_removed"] = summary(adj)
    by = table(s3, s3["city"])
    by["typical_pct_error_city_level_removed"] = by["group"].map(
        {c: round(100 * float(g["ape"].median()), 1) for c, g in adj.groupby("city")})
    reports["outside_by_city"] = by


def log(name, m):
    print(f"[{name}] {json.dumps(m)}", flush=True)


def train(df: pd.DataFrame | None = None, metros: pd.DataFrame | None = None, out_dir: Path = HERE, seed: int = 42,
          quick: bool = False) -> dict:
    df = add_circle_rates(load_houseprice() if df is None else df)
    metrics, reports = {}, {}

    # 1. Random split
    strat = df["city"].where(df["city"].map(df["city"].value_counts()) >= 20, "rare")
    tr, te = train_test_split(df.index, test_size=0.2, random_state=seed, stratify=strat)
    model, _ = fit(df.loc[tr], seed)
    s = score(model, df.loc[te])
    metrics["random_split"] = summary(s)
    metrics["random_split"]["locality_median_baseline_pct_error"] = baseline(df.loc[tr], df.loc[te])
    log("random_split", metrics["random_split"])
    reports["by_city"] = table(s, s["city"], min_n=50)
    reports["by_price_band"] = table(s, band(s["price"]))
    data = pd.cut(s["locality_listings"], [-1, 0, 9, np.inf], labels=["none", "1 to 9", "10 or more"]).astype(str)
    reports["by_locality_data"] = table(s, data)

    # 2. Unseen localities
    keys = df["city_locality"].replace("", "unknown")
    loc = pd.Series(keys.unique())
    held = set(loc.sample(frac=0.2, random_state=seed))
    te2 = keys.isin(held)
    model2, _ = fit(df[~te2], seed)
    s2 = score(model2, df[te2])
    metrics["unseen_localities"] = summary(s2)
    metrics["unseen_localities"]["locality_median_baseline_pct_error"] = baseline(df[~te2], df[te2])
    log("unseen_localities", metrics["unseen_localities"])

    # 4. Circle rates: listing prices versus circle values, and what the circle rate adds.
    cr = df[df["circle_rate_sqft"].notna()]
    rows = []
    for city, g in cr.groupby("city"):
        ratio = g["price"] / g["circle_value"]
        rows.append({"city": city, "listings_with_circle_rate": int(len(g)),
                     "share_of_city_listings": round(len(g) / int((df["city"] == city).sum()), 3),
                     "median_price_to_circle_value": round(float(ratio.median()), 2),
                     "share_listed_below_circle_value": round(float((ratio < 1).mean()), 3)})
    reports["circle_rates"] = pd.DataFrame(rows)
    in_cr = te2 & df["circle_rate_sqft"].notna()
    if not quick and in_cr.sum() >= 30:
        model3, _ = fit(df[~te2], seed, drop=("circle_rate_sqft",))
        without = score(model3, df[in_cr], drop=("circle_rate_sqft",))
        metrics["circle_rate_effect_unseen_localities"] = {
            "with_circle_rate": summary(score(model2, df[in_cr])), "without_circle_rate": summary(without)}
        log("circle_rate_effect", metrics["circle_rate_effect_unseen_localities"])

    # Final model on every listing.
    final, meta = fit(df, seed)

    # 3. Outside source
    if metros is not None and len(metros):
        s3 = score(final, add_circle_rates(metros))
        metrics["outside_source_metros_2020"] = summary(s3)
        metrics["outside_source_metros_2020"]["metros_predicting_itself_pct_error"] = self_baseline(metros)
        log("outside_source_metros_2020", metrics["outside_source_metros_2020"])
        outside_checks(s3, metrics, reports)

    out_dir = Path(out_dir)
    (out_dir / "artifacts").mkdir(parents=True, exist_ok=True)
    (out_dir / "reports").mkdir(parents=True, exist_ok=True)
    for q, b in final.boosters.items():
        text = b.model_to_string()
        with open(out_dir / "artifacts" / f"model_{q}.txt", "w", encoding="utf-8", newline="\n") as f:
            f.write(text)
    meta.update({"model": "property_avm", "trained_at": date.today().isoformat(), "lightgbm_version": lgb.__version__,
                 "training_listings": int(len(df)), "cities": int(df["city"].nunique()),
                 "sources": {"listings": "https://www.kaggle.com/datasets/juhibhojani/house-price (CDLA-Sharing-1.0)",
                             "outside_check": "https://www.kaggle.com/datasets/ruchi798/housing-prices-in-metropolitan-areas-of-india (CC0)",
                             "circle_rates": "models/property_avm/circle_rates.py"},
                 "encoder": final.encoder.to_json()})
    (out_dir / "artifacts" / "avm.json").write_text(json.dumps(meta), encoding="utf-8")

    # The saved model must give exactly what the trained one gives.
    loaded = PropertyAVM.load(out_dir / "artifacts")
    sample = df.sample(min(200, len(df)), random_state=seed)
    a = loaded.predict_log(frame(sample, loaded.encoder, loaded.meta["categories"]))["mid"]
    b = final.predict_log(frame(sample, final.encoder, final.meta["categories"]))["mid"]
    if not np.allclose(a, b):
        raise RuntimeError("Saved model differs from the trained one.")

    imp = pd.DataFrame({"feature": FEATURES, "gain": final.boosters["p50"].feature_importance("gain")})
    imp["share"] = (imp["gain"] / imp["gain"].sum()).round(4)
    reports["feature_importance"] = imp.sort_values("share", ascending=False)[["feature", "share"]]
    metrics = {"model": "property_avm", "version": VERSION, "trained_at": meta["trained_at"],
               "training_listings": meta["training_listings"], "target_range_coverage": COVERAGE,
               "conformal_widen_log": round(meta["conformal_widen_log"], 4), "checks": metrics,
               "export_matches_model": True}
    (out_dir / "reports" / "metrics.json").write_text(json.dumps(metrics, indent=2), encoding="utf-8")
    for name, t in reports.items():
        t.to_csv(out_dir / "reports" / f"{name}.csv", index=False)
    return {"metrics": metrics, **reports}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()
    r = train(metros=load_metros(), seed=args.seed)
    for check, m in r["metrics"]["checks"].items():
        print(check, json.dumps(m))
    for name in ("by_city", "by_price_band", "by_locality_data", "outside_by_city", "circle_rates", "feature_importance"):
        if name in r:
            print(f"\n{name}:\n" + r[name].head(20).to_string(index=False))


if __name__ == "__main__":
    main()
