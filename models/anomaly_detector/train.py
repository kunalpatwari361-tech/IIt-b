"""Train the Nirnay anomaly detector (model 4) on the L&T Indian loan data, without labels.

Run from the repo root:
    .venv/Scripts/python -m models.anomaly_detector.train
    .venv/Scripts/python -m models.anomaly_detector.train --data path/to/train.csv

It learns on Aug-Sep 2018 applications and is tested on Oct 2018 applications,
plus fake odd applications planted among them (see plants.py).

It writes:
    artifacts/model.joblib       the IsolationForest
    artifacts/anomaly.json       inputs, thresholds and percentile tables
    reports/metrics.json         planted cases caught, flag rate, default-rate check, fairness
    reports/planted.csv          planted cases caught, by type, at each alert level
    reports/fairness.csv         share of real applications flagged, by age band, state and employment
    reports/shap_importance.csv  which inputs most often make an application look odd
    reports/shap_summary.png     SHAP chart
"""
from __future__ import annotations

import argparse
import json
from datetime import date
from pathlib import Path

import joblib
import numpy as np
import pandas as pd
import sklearn
from sklearn.ensemble import IsolationForest

from ..credit_challenger.train import shap_chart
from ..credit_scorecard.train import load_raw
from .detector import AnomalyDetector, average_path_length
from .features import (FOREST_INPUTS, INPUTS, LEFT_OUT, LT, RULES, build_base, derive, fairness_groups,
                       integrity_flags)
from .plants import DESCRIPTION, KIND, plant_odd_cases

HERE = Path(__file__).resolve().parent
VERSION = "anomaly-v1"
FLAG_SHARE = {"unusual": 0.01, "very_unusual": 0.001}  # share of normal applications each alert is set to flag
# Larger samples per tree let each tree look at more inputs; on planted cases this lifted catches
# from 19% (256 samples, 24 inputs) to 52% (8,192 samples, 15 inputs) with the same 1% flag rate.
PARAMS = {"n_estimators": 500, "max_samples": 8192, "random_state": 42, "n_jobs": -1}
LEVELS = np.r_[np.arange(0, 0.99, 0.01), np.arange(0.99, 0.999, 0.001), [0.999, 0.9995, 0.9999, 1.0]]
MIN_FAIRNESS_GROUP = 1000
PLANTS_PER_TYPE = 500


def flag_table(groups: dict[str, pd.Series], flagged: np.ndarray) -> pd.DataFrame:
    """Share of real applications flagged per group, and each group's rate next to the lowest."""
    rows = []
    for attribute, labels in groups.items():
        labels = labels.astype(str).to_numpy()
        part = [{"attribute": attribute, "group": g, "applicants": int((labels == g).sum()),
                 "flagged_share": round(float(flagged[labels == g].mean()), 4)}
                for g in sorted(set(labels)) if (labels == g).sum() >= MIN_FAIRNESS_GROUP and g != "nan"]
        low = min((r["flagged_share"] for r in part), default=0)
        high = max((r["flagged_share"] for r in part), default=0)
        for r in part:
            r["times_lowest_group"] = round(r["flagged_share"] / low, 2) if low else None
            r["attribute_ratio"] = round(low / high, 3) if high else None  # lowest / highest flag rate
        rows += part
    return pd.DataFrame(rows)


def train(raw: pd.DataFrame, out_dir: Path = HERE, seed: int = 42, make_chart: bool = True,
          plants_per_type: int = PLANTS_PER_TYPE, params: dict | None = None) -> dict:
    params = {**(params or PARAMS), "random_state": seed}
    raw = raw.reset_index(drop=True)
    base = build_base(raw)
    X = derive(base)[FOREST_INPUTS]
    test = LT.test_mask(raw).to_numpy()  # the latest month (Oct 2018 for L&T)
    X_tr, X_te = X[~test], X[test]

    # 1. Learn what normal looks like, from training months only. No labels are used.
    model = IsolationForest(**params).fit(X_tr.to_numpy())
    s_tr = -model.score_samples(X_tr.to_numpy())
    thresholds = {k: float(np.quantile(s_tr, 1 - share)) for k, share in FLAG_SHARE.items()}

    meta = {
        "model": "anomaly_detector",
        "version": VERSION,
        "dataset": "lt",
        "trained_on": f"L&T Vehicle Loan Default (India), Aug-Sep 2018 ({len(X_tr):,} applications, labels not used)",
        "trained_at": date.today().isoformat(),
        "sklearn_version": sklearn.__version__,
        "params": params,
        "thresholds": thresholds,
        "flag_share": FLAG_SHARE,
        "features": FOREST_INPUTS,
        "inputs": INPUTS,
        "rules": RULES,
        "quantile_levels": LEVELS.tolist(),
        "score_quantiles": np.quantile(s_tr, LEVELS).tolist(),
        "quantiles": {name: np.quantile(X_tr[name], LEVELS).round(6).tolist() for name in X.columns},
    }
    (out_dir / "artifacts").mkdir(parents=True, exist_ok=True)
    (out_dir / "reports").mkdir(parents=True, exist_ok=True)
    joblib.dump(model, out_dir / "artifacts" / "model.joblib", compress=3)
    (out_dir / "artifacts" / "anomaly.json").write_text(json.dumps(meta, indent=2, ensure_ascii=False),
                                                        encoding="utf-8")
    det = AnomalyDetector.load(out_dir / "artifacts")

    # 2. The saved detector must give exactly what the trained one gives,
    #    and SHAP must add up to the score (via the average path length).
    s_te = det.score_frame(base[test])["anomaly_score"].to_numpy()
    if not np.allclose(s_te, -model.score_samples(X_te.to_numpy()), atol=1e-12):
        raise RuntimeError("Saved detector differs from the trained model.")
    sample = X_te.sample(min(100, len(X_te)), random_state=seed)
    sv, expected = det._explain(sample)
    rebuilt = 2 ** (-(expected + sv.sum(axis=1)) / average_path_length(model.max_samples_))
    shap_gap = float(np.max(np.abs(rebuilt - det.anomaly_score(sample))))
    if shap_gap > 1e-6:
        raise RuntimeError(f"SHAP values do not add up to the anomaly score (gap {shap_gap:.2e}).")

    # 3. Real October applications: how many get flagged, and do flagged ones default more?
    y_te = raw.loc[test, LT.target].to_numpy() if LT.target in raw else None
    real_frame = det.score_frame(base[test])
    flagged = (real_frame["alert"] != "normal").to_numpy()
    forest_flagged = (real_frame["forest_alert"] != "normal").to_numpy()
    real = {"applications": int(test.sum()),
            "flagged_total": round(float(flagged.mean()), 4),
            "flagged_by_forest": round(float(forest_flagged.mean()), 4),
            "flagged_by_rules": round(float((real_frame["rules_broken"] > 0).mean()), 4),
            "rule_hits": {r: int(real_frame[r].sum()) for r in RULES},
            "flagged_very_unusual": round(float((real_frame["alert"] == "very_unusual").mean()), 4)}
    if y_te is not None:
        real["default_rate_flagged"] = round(float(y_te[flagged].mean()), 4) if flagged.any() else None
        real["default_rate_not_flagged"] = round(float(y_te[~flagged].mean()), 4)

    # 4. Planted odd applications: altered copies of real October applications.
    plants = plant_odd_cases(base[test], n_per_type=plants_per_type, seed=seed)
    pf = det.score_frame(plants)
    plants = plants.assign(alert=pf["alert"].to_numpy(), forest_alert=pf["forest_alert"].to_numpy(),
                           rules_broken=pf["rules_broken"].to_numpy())
    caught = lambda col, want=None: (lambda a: round(float((a != "normal").mean() if want is None
                                                           else (a == want).mean()), 4))
    planted = (plants.groupby("plant_type")
               .agg(planted=("alert", "size"),
                    caught_by_forest=("forest_alert", caught("forest_alert")),
                    caught_by_rules=("rules_broken", lambda r: round(float((r > 0).mean()), 4)),
                    caught_total=("alert", caught("alert")),
                    caught_very_unusual=("alert", caught("alert", "very_unusual")))
               .reset_index())
    planted["kind"] = planted["plant_type"].map(KIND)
    planted["what_was_changed"] = planted["plant_type"].map(DESCRIPTION)
    planted = planted.sort_values(["kind", "caught_total"], ascending=[False, False])
    kind = plants.plant_type.map(KIND)
    by_kind = {k: {"forest": round(float((plants.loc[kind == k, "forest_alert"] != "normal").mean()), 4),
                   "total": round(float((plants.loc[kind == k, "alert"] != "normal").mean()), 4)}
               for k in ("extreme", "contradiction")}

    # 5. Fairness: share of real (unaltered) applications flagged, by group.
    groups = {k: v[test].reset_index(drop=True) for k, v in fairness_groups(raw, base).items()}
    fairness = flag_table(groups, flagged)
    fairness_forest = flag_table(groups, forest_flagged)
    fairness["flagged_share_forest_only"] = fairness_forest["flagged_share"].to_numpy()

    # 6. What makes applications look odd, on average (real flagged + planted).
    explain_rows = pd.concat([X_te[forest_flagged].sample(min(400, int(forest_flagged.sum())), random_state=seed),
                              derive(plants)[FOREST_INPUTS].sample(min(400, len(plants)), random_state=seed)])
    sv_all, _ = det._explain(explain_rows)
    importance = pd.DataFrame({"input": list(X.columns), "label": [INPUTS[n]["label"] for n in X.columns],
                               "mean_abs_shap": np.abs(sv_all).mean(axis=0).round(5),
                               "share_of_rows_where_top_reason": [
                                   round(float((np.argmin(sv_all, axis=1) == j).mean()), 4)
                                   for j in range(len(X.columns))]}
                              ).sort_values("mean_abs_shap", ascending=False)

    metrics = {
        "model": "anomaly_detector",
        "version": VERSION,
        "dataset": "L&T Vehicle Loan Default (India), labels not used for training",
        "source": LT.source_url,
        "trained_at": meta["trained_at"],
        "split": "learn on Aug-Sep 2018, test on Oct 2018 plus planted odd applications",
        "rows": {"train": len(X_tr), "test": int(test.sum()), "planted": len(plants)},
        "thresholds": thresholds,
        "planted_caught_total": round(float((plants["alert"] != "normal").mean()), 4),
        "planted_caught_by_forest": round(float((plants["forest_alert"] != "normal").mean()), 4),
        "planted_caught_by_rules": round(float((plants["rules_broken"] > 0).mean()), 4),
        "planted_caught_very_unusual": round(float((plants["alert"] == "very_unusual").mean()), 4),
        "planted_caught_by_kind": by_kind,
        "real_october": real,
        "shap_adds_up": True,
        "left_out_on_purpose": LEFT_OUT,
        "export_matches_model": True,
    }
    (out_dir / "reports" / "metrics.json").write_text(json.dumps(metrics, indent=2, ensure_ascii=False),
                                                      encoding="utf-8")
    planted.to_csv(out_dir / "reports" / "planted.csv", index=False)
    fairness.to_csv(out_dir / "reports" / "fairness.csv", index=False)
    importance.to_csv(out_dir / "reports" / "shap_importance.csv", index=False)
    if make_chart:
        shap_chart(det, explain_rows, out_dir / "reports" / "shap_summary.png", seed=seed,
                   title="What makes an application look unusual (left = odder)",
                   xlabel="SHAP value (change in average isolation depth)", max_display=15)
    return {"metrics": metrics, "planted": planted, "fairness": fairness, "importance": importance}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--data", type=Path, default=None, help="path to the L&T train.csv")
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()
    r = train(load_raw(LT, args.data), seed=args.seed)
    m = r["metrics"]
    print(f"Trained {m['version']} on {m['rows']['train']:,} L&T applications ({m['split']}).")
    print(f"Planted odd cases caught: {m['planted_caught_total']:.1%} in total "
          f"(forest {m['planted_caught_by_forest']:.1%}, rules {m['planted_caught_by_rules']:.1%})  "
          f"by kind: {m['planted_caught_by_kind']}")
    print(f"Real October applications: {m['real_october']}")
    for title, table in (("Planted cases", r["planted"]), ("Fairness (real applications flagged)", r["fairness"]),
                         ("SHAP importance", r["importance"])):
        print(f"\n{title}:")
        print(table.to_string(index=False))


if __name__ == "__main__":
    main()
