"""Train the Nirnay fraud classifier (model 3) on the Bank Account Fraud (BAF) data.

Run from the repo root:
    .venv/Scripts/python -m models.fraud_classifier.train
    .venv/Scripts/python -m models.fraud_classifier.train --data path/to/Base.csv

Time split, as in the BAF paper: learn on months 0-4, choose the number of trees
and the alert thresholds on month 5, test once on months 6-7.

It writes:
    artifacts/model.txt          the LightGBM model
    artifacts/fraud.json         inputs, categories, constraints and alert thresholds
    reports/metrics.json         fraud caught at 5% and 1% false alarms, AUC, fairness
    reports/alerts.csv           what each alert threshold catches on the test months
    reports/by_month.csv         the same, month by month
    reports/fairness.csv         false-alarm rate by age group, income and employment
    reports/shap_importance.csv  how much each input moves the fraud score on average
    reports/shap_summary.png     SHAP chart: what pushes fraud risk up or down
"""
from __future__ import annotations

import argparse
import json
from datetime import date
from pathlib import Path

import lightgbm as lgb
import numpy as np
import pandas as pd
from sklearn.metrics import roc_auc_score

from ..credit_challenger.train import monotone_violations, shap_chart
from .features import (CATEGORICAL, EXCLUDED, FEATURES, MISSING_IF_NEGATIVE, MONOTONE, MONTH, SOURCE_URL, TARGET,
                       age_group, build, income_band, load_raw)
from .fraud import FraudModel

HERE = Path(__file__).resolve().parent
VERSION = "fraud-v1"

TRAIN_MONTHS, VALID_MONTH, TEST_MONTHS = [0, 1, 2, 3, 4], 5, [6, 7]
TARGET_FPR = {"review": 0.05, "high": 0.01}  # false-alarm rate each alert level is set for
MIN_FAIRNESS_GROUP = 1000

PARAMS = {
    "objective": "binary",
    "metric": "auc",
    "learning_rate": 0.05,
    "num_leaves": 63,
    "min_data_in_leaf": 500,
    "feature_fraction": 0.8,
    "bagging_fraction": 0.8,
    "bagging_freq": 1,
    "lambda_l2": 1.0,
    "monotone_constraints_method": "basic",  # the only method that never leaked on the credit models
    "verbose": -1,
    "seed": 42,
}
MAX_ROUNDS, EARLY_STOP = 3000, 100

# Inputs left out even though BAF has them. Fraud in BAF rises sharply with age
# (0.5% in the 20s, 3.3% in the 60s), and using age flags far more honest older
# applicants. See README for the with/without comparison.
LEFT_OUT = {"customer_age": "Age. With it, 13.6% of honest applicants aged 50+ were flagged (vs 10.2% without) "
                            "for only 0.8 points more fraud caught at 5% false alarms."}


def threshold_for_fpr(y: np.ndarray, p: np.ndarray, fpr: float) -> float:
    """Score above which `fpr` of honest applications fall."""
    return float(np.quantile(p[y == 0], 1 - fpr))


def caught(y: np.ndarray, p: np.ndarray, t: float) -> dict:
    flagged = p >= t
    fraud, honest = y == 1, y == 0
    return {
        "threshold": round(t, 6),
        "flagged_share": round(float(flagged.mean()), 4),
        "fraud_caught": round(float(flagged[fraud].mean()), 4),          # recall
        "false_alarm_rate": round(float(flagged[honest].mean()), 4),     # FPR
        "fraud_share_of_flagged": round(float(y[flagged].mean()), 4) if flagged.any() else None,  # precision
        "frauds": int(fraud.sum()), "frauds_caught": int(flagged[fraud].sum()),
        "honest_flagged": int(flagged[honest].sum()),
    }


def fairness_table(y: np.ndarray, p: np.ndarray, t: float, groups: dict[str, np.ndarray]) -> pd.DataFrame:
    """False-alarm rate (honest applicants flagged) per group, and its ratio to the worst group."""
    rows = []
    for attribute, labels in groups.items():
        part = []
        for g in sorted(pd.unique(labels)):
            m = labels == g
            if m.sum() < MIN_FAIRNESS_GROUP or g in ("nan", None):
                continue
            honest, fraud = m & (y == 0), m & (y == 1)
            part.append({"attribute": attribute, "group": g, "applicants": int(m.sum()),
                         "fraud_rate": round(float(y[m].mean()), 4),
                         "false_alarm_rate": round(float((p[honest] >= t).mean()), 4),
                         "fraud_caught": round(float((p[fraud] >= t).mean()), 4) if fraud.any() else None})
        worst = max((r["false_alarm_rate"] for r in part), default=0)
        for r in part:
            ratio = r["false_alarm_rate"] / worst if worst else None
            r["ratio_to_worst"] = None if ratio is None else round(ratio, 3)
        lo = min((r["false_alarm_rate"] for r in part), default=0)
        for r in part:  # BAF's "predictive equality": lowest FPR / highest FPR within the attribute
            r["attribute_fpr_ratio"] = round(lo / worst, 3) if worst else None
            r["fpr_parity"] = "ok" if worst and lo / worst >= 0.8 else "check"
        rows += part
    return pd.DataFrame(rows)


def model_frame(X: pd.DataFrame, features: list[str], categories: dict[str, list[str]]) -> pd.DataFrame:
    out = X[features].copy()
    for name in features:
        if name in categories:
            out[name] = pd.Categorical(out[name].astype("object"), categories=categories[name])
    return out


def train(raw: pd.DataFrame, out_dir: Path = HERE, seed: int = 42, left_out: dict | None = None,
          make_chart: bool = True) -> dict:
    left_out = LEFT_OUT if left_out is None else left_out
    features = [f for f in FEATURES if f not in left_out]
    raw = raw.reset_index(drop=True)
    y = raw[TARGET].astype(int).to_numpy()
    X = build(raw)
    month = raw[MONTH].to_numpy()
    tr, va, te = np.isin(month, TRAIN_MONTHS), month == VALID_MONTH, np.isin(month, TEST_MONTHS)

    categories = {n: sorted(X.loc[tr, n].dropna().astype(str).unique().tolist()) for n in features if n in CATEGORICAL}
    M = model_frame(X, features, categories)
    params = {**PARAMS, "seed": seed, "monotone_constraints": [MONOTONE.get(n, 0) for n in features]}

    booster = lgb.train(params, lgb.Dataset(M[tr], y[tr]), MAX_ROUNDS,
                        valid_sets=[lgb.Dataset(M[va], y[va])],
                        callbacks=[lgb.early_stopping(EARLY_STOP, verbose=False)])
    rounds = max(1, booster.best_iteration)

    # Alert thresholds come from the validation month, never from the test months.
    p_va = booster.predict(M[va], num_iteration=rounds)
    thresholds = {level: threshold_for_fpr(y[va], p_va, fpr) for level, fpr in TARGET_FPR.items()}

    meta = {
        "model": "fraud_classifier",
        "version": VERSION,
        "dataset": "baf",
        "trained_on": f"Bank Account Fraud (BAF) Base, months {TRAIN_MONTHS[0]}-{TRAIN_MONTHS[-1]} "
                      f"({int(tr.sum()):,} applications)",
        "trained_at": date.today().isoformat(),
        "trees": rounds,
        "thresholds": thresholds,
        "target_false_alarm_rate": TARGET_FPR,
        "params": {k: v for k, v in params.items() if k != "monotone_constraints"},
        "features": features,
        "inputs": {
            n: {**FEATURES[n],
                "type": "categorical" if n in CATEGORICAL else "numerical",
                **({"categories": categories[n]} if n in CATEGORICAL else {}),
                **({"missing_if_negative": True} if n in MISSING_IF_NEGATIVE else {}),
                "monotone": MONOTONE.get(n, 0)}
            for n in features
        },
    }
    (out_dir / "artifacts").mkdir(parents=True, exist_ok=True)
    (out_dir / "reports").mkdir(parents=True, exist_ok=True)
    # LightGBM cannot read its model file with Windows line endings, so always write plain "\n".
    (out_dir / "artifacts" / "model.txt").write_text(
        booster.model_to_string(num_iteration=rounds).replace("\r\n", "\n"), encoding="utf-8", newline="\n")
    (out_dir / "artifacts" / "fraud.json").write_text(json.dumps(meta, indent=2, ensure_ascii=False),
                                                      encoding="utf-8")
    model = FraudModel.load(out_dir / "artifacts")

    # The saved model must give exactly what the trained model gives.
    raw_te = raw.loc[te]
    p_te = model.score_frame(raw_te)["fraud_probability"].to_numpy()
    gap = float(np.max(np.abs(p_te - booster.predict(M[te], num_iteration=rounds))))
    if gap > 1e-9:
        raise RuntimeError(f"Saved fraud model differs from the trained model by {gap:.2e}.")
    violations = monotone_violations(model, X.loc[te], {k: v for k, v in MONOTONE.items() if k in features},
                                     seed=seed, column="fraud_probability")
    if any(violations.values()):
        raise RuntimeError(f"Monotonic constraints broken: {violations}")

    y_te = y[te]
    alerts = pd.DataFrame([{"alert": lvl, "set_for_false_alarms": TARGET_FPR[lvl], **caught(y_te, p_te, t)}
                           for lvl, t in thresholds.items()])
    by_month = pd.DataFrame([{"month": int(m), "alert": lvl, **caught(y[month == m], p_te[month[te] == m], t)}
                             for m in TEST_MONTHS for lvl, t in thresholds.items()])
    benchmark = {f"fraud_caught_at_{int(f * 100)}pct_false_alarms":
                 round(float((p_te[y_te == 1] >= threshold_for_fpr(y_te, p_te, f)).mean()), 4)
                 for f in (0.05, 0.01)}
    groups = {"age_group": np.asarray(age_group(raw_te)), "income": income_band(raw_te).to_numpy(),
              "employment_status": raw_te["employment_status"].astype(str).to_numpy()}
    fairness = fairness_table(y_te, p_te, thresholds["review"], groups)

    rng = np.random.default_rng(seed)
    sample = raw_te.iloc[rng.choice(len(raw_te), min(50000, len(raw_te)), replace=False)]
    shap_values, _ = model._explain(model.frame(sample))
    importance = pd.DataFrame({
        "input": features, "label": [FEATURES[n]["label"] for n in features],
        "india_check": [FEATURES[n]["india"] for n in features],
        "mean_abs_shap": np.abs(shap_values).mean(axis=0).round(5),
        "monotone": [MONOTONE.get(n, 0) for n in features],
    }).sort_values("mean_abs_shap", ascending=False)

    review = alerts.set_index("alert").loc["review"]
    metrics = {
        "model": "fraud_classifier",
        "version": VERSION,
        "dataset": "Bank Account Fraud (BAF) Base, NeurIPS 2022",
        "source": SOURCE_URL,
        "trained_at": meta["trained_at"],
        "split": f"train months {TRAIN_MONTHS}, thresholds and trees on month {VALID_MONTH}, test months {TEST_MONTHS}",
        "rows": {"train": int(tr.sum()), "valid": int(va.sum()), "test": int(te.sum()),
                 "fraud_rate_test": round(float(y_te.mean()), 4)},
        "trees": rounds,
        "auc_test": round(float(roc_auc_score(y_te, p_te)), 4),
        "auc_train": round(float(roc_auc_score(y[tr], booster.predict(M[tr], num_iteration=rounds))), 4),
        "benchmark_on_test": benchmark,
        "review_alert_on_test": review.to_dict(),
        "thresholds": thresholds,
        "monotone_violations": violations,
        "left_out_on_purpose": {**EXCLUDED, **left_out},
        "fairness_checks_flagged": sorted({r["attribute"] for r in fairness.to_dict("records") if r["fpr_parity"] == "check"}),
        "export_matches_model": True,
    }
    (out_dir / "reports" / "metrics.json").write_text(json.dumps(metrics, indent=2, ensure_ascii=False, default=float),
                                                      encoding="utf-8")
    alerts.to_csv(out_dir / "reports" / "alerts.csv", index=False)
    by_month.to_csv(out_dir / "reports" / "by_month.csv", index=False)
    fairness.to_csv(out_dir / "reports" / "fairness.csv", index=False)
    importance.to_csv(out_dir / "reports" / "shap_importance.csv", index=False)
    if make_chart:
        shap_chart(model, model.frame(sample), out_dir / "reports" / "shap_summary.png", seed=seed,
                   title="What pushes fraud risk up (right) or down (left)",
                   xlabel="SHAP value (change in log-odds of fraud)", max_display=15)
    return {"metrics": metrics, "alerts": alerts, "by_month": by_month, "fairness": fairness,
            "importance": importance}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--data", type=Path, default=None, help="path to BAF Base.csv")
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()
    r = train(load_raw(args.data), seed=args.seed)
    m = r["metrics"]
    b = m["benchmark_on_test"]
    print(f"Trained {m['version']} ({m['split']}), {m['trees']} trees.")
    print(f"Test AUC {m['auc_test']} (train {m['auc_train']})")
    print(f"Fraud caught at 5% false alarms: {b['fraud_caught_at_5pct_false_alarms']:.1%}   "
          f"at 1%: {b['fraud_caught_at_1pct_false_alarms']:.1%}")
    for title, table in (("Alerts on test months", r["alerts"]), ("By month", r["by_month"]),
                         ("Fairness (review threshold)", r["fairness"]), ("SHAP importance", r["importance"])):
        print(f"\n{title}:")
        print(table.to_string(index=False))


if __name__ == "__main__":
    main()
