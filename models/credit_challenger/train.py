"""Train the Nirnay credit challenger (model 2) and compare it with the scorecard.

Run from the repo root, after training the scorecard:
    .venv/Scripts/python -m models.credit_challenger.train                       # L&T Indian data (default)
    .venv/Scripts/python -m models.credit_challenger.train --dataset home_credit

It writes:
    artifacts/model.txt          the LightGBM model
    artifacts/challenger.json    inputs, categories, constraints and score scaling
    reports/metrics.json         accuracy of both models, the AUC gap and its 95% range
    reports/comparison.csv       the same comparison as a table
    reports/grades.csv           applicants and default rate in each challenger grade
    reports/decision_swap.csv    where the two models' decisions differ
    reports/fairness.csv         approval rates by group
    reports/shap_importance.csv  how much each input moves the score on average
    reports/shap_summary.png     SHAP chart: which inputs push risk up or down
"""
from __future__ import annotations

import argparse
import dataclasses
import json
import math
from datetime import date
from pathlib import Path

import lightgbm as lgb
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split

from ..credit_scorecard.features import DATASETS, LT, Dataset
from ..credit_scorecard.scorecard import DEFAULT_PATH as SCORECARD_PATH
from ..credit_scorecard.scorecard import Scorecard, grade_for
from ..credit_scorecard.train import (APPROVE_GRADES, BASE_SCORE, PDO, accuracy, fairness_table,
                                      grade_table, load_raw, split)
from .challenger import Challenger

HERE = Path(__file__).resolve().parent
VERSION = "challenger-v1"

PARAMS = {
    "objective": "binary",
    "learning_rate": 0.03,
    "num_leaves": 31,
    "min_data_in_leaf": 200,      # every leaf must hold enough loans to be trusted
    "feature_fraction": 0.8,
    "bagging_fraction": 0.8,
    "bagging_freq": 1,
    "lambda_l2": 1.0,
    # "advanced" and "intermediate" both let small wrong-way steps through on L&T data;
    # "basic" never did and was just as accurate (test AUC within 0.001).
    "monotone_constraints_method": "basic",
    "verbose": -1,
    "seed": 42,
}
MAX_ROUNDS = 3000
EARLY_STOP = 100

# Which way each input may move the risk of default: -1 = more of it can only
# lower risk, +1 = can only raise it, 0 = left free. Only inputs with an obvious
# direction are constrained, so the model can never give a reason that makes no sense.
MONOTONE = {
    "lt": {"bureau_score": -1, "credit_history_years": -1, "overdue_accounts": 1,
           "recent_delinquencies": 1, "enquiries": 1, "ltv": 1, "loan_amount": 1},
    "home_credit": {"bureau_score_1": -1, "bureau_score_2": -1, "bureau_score_3": -1,
                    "payment_to_income": 1, "loan_to_price": 1},
}

DECISION = {"A": "approve", "B": "approve", "C": "refer", "D": "reject", "E": "reject"}

# Inputs the challenger leaves out even though the data has them. On L&T data,
# using age directly cut the under-30 approval ratio from 0.45 to 0.19 for a
# gain of only 0.002 AUC. Age is still used for the fairness check.
LEFT_OUT = {"age_years": "Age. Widened the approval gap for younger applicants for almost no accuracy gain."}


def without_left_out(dataset: Dataset) -> Dataset:
    return dataclasses.replace(
        dataset,
        features={k: v for k, v in dataset.features.items() if k not in LEFT_OUT},
        categorical=[c for c in dataset.categorical if c not in LEFT_OUT],
    )


def to_model_frame(X: pd.DataFrame, dataset: Dataset, categories: dict[str, list[str]]) -> pd.DataFrame:
    out = X[list(dataset.features)].copy()
    for name in dataset.categorical:
        out[name] = pd.Categorical(out[name].astype("object"), categories=categories[name])
    return out


def validation_split(raw_tr: pd.DataFrame, X_tr, y_tr, dataset: Dataset, seed: int):
    """Hold back the latest training month (or 20% at random) to choose the number of trees."""
    if dataset.test_mask is not None:
        is_val = dataset.test_mask(raw_tr).to_numpy()
        return X_tr[~is_val], X_tr[is_val], y_tr[~is_val], y_tr[is_val]
    return train_test_split(X_tr, y_tr, test_size=0.2, stratify=y_tr, random_state=seed)


def paired_auc_gap(y, p_new, p_old, rounds: int = 200, seed: int = 0) -> dict:
    """AUC(challenger) - AUC(scorecard), with a 95% range from resampling the test loans."""
    from sklearn.metrics import roc_auc_score
    y, p_new, p_old = map(np.asarray, (y, p_new, p_old))
    rng = np.random.default_rng(seed)
    gaps = []
    for _ in range(rounds):
        i = rng.integers(0, len(y), len(y))
        gaps.append(roc_auc_score(y[i], p_new[i]) - roc_auc_score(y[i], p_old[i]))
    gap = roc_auc_score(y, p_new) - roc_auc_score(y, p_old)
    low, high = np.percentile(gaps, [2.5, 97.5])
    return {"auc_gap": round(float(gap), 4), "low_95": round(float(low), 4), "high_95": round(float(high), 4),
            "challenger_better": bool(low > 0)}


def monotone_violations(challenger: Challenger, X: pd.DataFrame, constraints: dict[str, int],
                        profiles: int = 50, steps: int = 30, seed: int = 0) -> dict[str, int]:
    """Sweep each constrained input across real applicant profiles; count wrong-way moves in risk."""
    rng = np.random.default_rng(seed)
    base = X.iloc[rng.integers(0, len(X), profiles)]
    found = {}
    for name, direction in constraints.items():
        lo, hi = np.nanpercentile(X[name].astype(float), [1, 99])
        grid = np.linspace(lo, hi, steps)
        rows = pd.DataFrame([{**b, name: v} for b in base.to_dict("records") for v in grid])
        pd_ = challenger.score_frame(rows)["probability_of_default"].to_numpy().reshape(profiles, steps)
        found[name] = int(((np.diff(pd_, axis=1) * direction) < -1e-12).sum())
    return found


def shap_chart(challenger: Challenger, X: pd.DataFrame, path: Path, sample: int = 5000, seed: int = 0) -> None:
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    import shap

    Xs = X.sample(min(sample, len(X)), random_state=seed)
    values, _ = challenger._explain(Xs)  # LightGBM's TreeSHAP, the same values shap.TreeExplainer returns
    display = Xs.copy()
    for name in display.columns:
        if isinstance(display[name].dtype, pd.CategoricalDtype):
            display[name] = display[name].cat.codes.replace(-1, np.nan)
    labels = [challenger.inputs[n]["label"] for n in Xs.columns]
    shap.summary_plot(values, display, feature_names=labels, show=False, max_display=len(labels))
    plt.title("What pushes default risk up (right) or down (left)", fontsize=12)
    plt.xlabel("SHAP value (change in log-odds of default)")
    plt.tight_layout()
    plt.savefig(path, dpi=120)
    plt.close()


def train(raw: pd.DataFrame, dataset: Dataset = LT, out_dir: Path = HERE,
          scorecard_path: Path = SCORECARD_PATH, seed: int = 42, test_size: float = 0.2,
          make_chart: bool = True) -> dict:
    raw = raw.reset_index(drop=True)
    y = raw[dataset.target].astype(int)
    X = dataset.build(raw)  # still holds every input, so fairness can be checked by age
    X_tr, X_te, y_tr, y_te = split(raw, X, y, dataset, seed, test_size)
    dataset = without_left_out(dataset)
    categories ={name: sorted(X_tr[name].dropna().astype(str).unique().tolist()) for name in dataset.categorical}
    M_tr, M_te = (to_model_frame(d, dataset, categories) for d in (X_tr, X_te))

    constraints = MONOTONE.get(dataset.key, {})
    params = {**PARAMS, "seed": seed,
              "monotone_constraints": [constraints.get(n, 0) for n in dataset.features]}

    # 1. Choose the number of trees on the latest training month, never on the test month.
    F_fit, F_val, y_fit, y_val = validation_split(raw.loc[X_tr.index], M_tr, y_tr, dataset, seed)
    probe = lgb.train(params, lgb.Dataset(F_fit, y_fit), MAX_ROUNDS,
                      valid_sets=[lgb.Dataset(F_val, y_val)],
                      callbacks=[lgb.early_stopping(EARLY_STOP, verbose=False)])
    rounds = max(1, probe.best_iteration)

    # 2. Retrain on every training month with that number of trees.
    booster = lgb.train(params, lgb.Dataset(M_tr, y_tr), rounds)
    reference = float(booster.predict(M_tr.iloc[:1], pred_contrib=True)[0, -1])

    meta = {
        "model": "credit_challenger",
        "version": VERSION,
        "mode": "shadow",
        "dataset": dataset.key,
        "trained_on": f"{dataset.title} ({len(X_tr):,} training rows)",
        "trained_at": date.today().isoformat(),
        "base_score": BASE_SCORE,
        "pdo": PDO,
        "reference_log_odds": reference,
        "trees": rounds,
        "params": {k: v for k, v in params.items() if k != "monotone_constraints"},
        "features": list(dataset.features),
        "inputs": {
            name: {**dataset.features[name],
                   "type": "categorical" if name in dataset.categorical else "numerical",
                   **({"categories": categories[name]} if name in dataset.categorical else {}),
                   "monotone": constraints.get(name, 0)}
            for name in dataset.features
        },
    }
    (out_dir / "artifacts").mkdir(parents=True, exist_ok=True)
    (out_dir / "reports").mkdir(parents=True, exist_ok=True)
    # LightGBM cannot read its model file with Windows line endings, so always write plain "\n".
    (out_dir / "artifacts" / "model.txt").write_text(booster.model_to_string().replace("\r\n", "\n"),
                                                     encoding="utf-8", newline="\n")
    (out_dir / "artifacts" / "challenger.json").write_text(json.dumps(meta, indent=2, ensure_ascii=False),
                                                           encoding="utf-8")
    challenger = Challenger.load(out_dir / "artifacts")

    # 3. The saved model must give exactly what the trained model gives.
    c_te = challenger.score_frame(X_te)
    gap = float(np.max(np.abs(c_te["probability_of_default"].to_numpy() - booster.predict(M_te))))
    if gap > 1e-9:
        raise RuntimeError(f"Saved challenger differs from the trained model by {gap:.2e}.")
    c_tr = challenger.score_frame(X_tr)
    violations = monotone_violations(challenger, X_te, constraints, seed=seed)
    if any(violations.values()):
        raise RuntimeError(f"Monotonic constraints broken: {violations}")

    # 4. Compare with the scorecard on the same test loans.
    card = Scorecard.load(scorecard_path)
    if card.spec.get("dataset") != dataset.key:
        raise RuntimeError(f"The scorecard at {scorecard_path} was trained on {card.spec.get('dataset')!r}, "
                           f"not {dataset.key!r}. Train the scorecard on the same data first.")
    s_te = card.score_frame(X_te)
    ch_acc, sc_acc = accuracy(y_te, c_te["probability_of_default"]), accuracy(y_te, s_te["probability_of_default"])
    auc_gap = paired_auc_gap(y_te, c_te["probability_of_default"], s_te["probability_of_default"], seed=seed)

    grades = grade_table(c_te, y_te)
    rates = grades.query("applicants >= 30")["default_rate"].tolist()
    ch_grade = pd.Series([grade_for(s)[0] for s in c_te["score"]], index=X_te.index)
    sc_grade = pd.Series([grade_for(s)[0] for s in s_te["score"]], index=X_te.index)
    groups = {k: v.loc[X_te.index] for k, v in dataset.fairness_groups(raw, X).items()}
    fairness = fairness_table(ch_grade, y_te, groups)

    swap = (pd.DataFrame({"scorecard": sc_grade.map(DECISION), "challenger": ch_grade.map(DECISION),
                          "defaulted": y_te})
            .groupby(["scorecard", "challenger"]).agg(applicants=("defaulted", "size"),
                                                      default_rate=("defaulted", "mean"))
            .round(4).reset_index())
    same = float((sc_grade.map(DECISION) == ch_grade.map(DECISION)).mean())

    shap_values, _ = challenger._explain(M_te)
    importance = (pd.DataFrame({
        "input": list(dataset.features),
        "label": [dataset.features[n]["label"] for n in dataset.features],
        "mean_abs_shap": np.abs(shap_values).mean(axis=0).round(5),
        "mean_abs_points": (np.abs(shap_values).mean(axis=0) * PDO / math.log(2)).round(2),
        "monotone": [constraints.get(n, 0) for n in dataset.features],
    }).sort_values("mean_abs_shap", ascending=False))

    comparison = pd.DataFrame([
        {"measure": k.upper(), "scorecard": sc_acc[k], "challenger": ch_acc[k],
         "difference": round(ch_acc[k] - sc_acc[k], 4)} for k in ("auc", "gini", "ks")
    ] + [{"measure": "Approval rate (A/B)", "scorecard": round(float(sc_grade.isin(APPROVE_GRADES).mean()), 4),
          "challenger": round(float(ch_grade.isin(APPROVE_GRADES).mean()), 4),
          "difference": round(float(ch_grade.isin(APPROVE_GRADES).mean() - sc_grade.isin(APPROVE_GRADES).mean()), 4)}])

    metrics = {
        "model": "credit_challenger",
        "version": VERSION,
        "mode": "shadow",
        "dataset": dataset.key,
        "dataset_title": dataset.title,
        "trained_at": meta["trained_at"],
        "split": dataset.split_note,
        "trees": rounds,
        "rows": {"train": len(X_tr), "test": len(X_te)},
        "train": accuracy(y_tr, c_tr["probability_of_default"]),
        "test": ch_acc,
        "scorecard_test": sc_acc,
        "auc_gap_vs_scorecard": auc_gap,
        "same_decision_as_scorecard": round(same, 4),
        "grades_monotonic": all(a < b for a, b in zip(rates, rates[1:])),
        "approval_rate_test": round(float(ch_grade.isin(APPROVE_GRADES).mean()), 4),
        "monotone_constraints": constraints,
        "monotone_violations": violations,
        "left_out_on_purpose": {**dataset.excluded, **LEFT_OUT},
        "fairness_checks_flagged": [f"{r['attribute']} {r['group']}" for r in fairness.to_dict("records")
                                    if r["four_fifths_rule"] == "check"],
        "export_matches_model": True,
    }
    (out_dir / "reports" / "metrics.json").write_text(json.dumps(metrics, indent=2, ensure_ascii=False),
                                                      encoding="utf-8")
    comparison.to_csv(out_dir / "reports" / "comparison.csv", index=False)
    grades.to_csv(out_dir / "reports" / "grades.csv", index=False)
    swap.to_csv(out_dir / "reports" / "decision_swap.csv", index=False)
    fairness.to_csv(out_dir / "reports" / "fairness.csv", index=False)
    importance.to_csv(out_dir / "reports" / "shap_importance.csv", index=False)
    if make_chart:
        shap_chart(challenger, M_te, out_dir / "reports" / "shap_summary.png", seed=seed)
    return {"metrics": metrics, "comparison": comparison, "grades": grades, "swap": swap,
            "fairness": fairness, "importance": importance}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--dataset", choices=sorted(DATASETS), default=LT.key)
    parser.add_argument("--data", type=Path, default=None, help="path to the training CSV")
    parser.add_argument("--scorecard", type=Path, default=SCORECARD_PATH, help="trained scorecard.json to compare with")
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()

    dataset = DATASETS[args.dataset]
    r = train(load_raw(dataset, args.data), dataset=dataset, scorecard_path=args.scorecard, seed=args.seed)
    m = r["metrics"]
    g = m["auc_gap_vs_scorecard"]
    print(f"Trained {m['version']} on {m['dataset_title']} ({m['split']}), {m['trees']} trees.")
    print(f"Test  AUC {m['test']['auc']}  Gini {m['test']['gini']}  KS {m['test']['ks']}")
    print(f"Train AUC {m['train']['auc']}  Gini {m['train']['gini']}  KS {m['train']['ks']}")
    print(f"AUC gap vs scorecard: {g['auc_gap']:+.4f} (95% range {g['low_95']:+.4f} to {g['high_95']:+.4f})")
    print(f"Same decision as the scorecard: {m['same_decision_as_scorecard']:.1%}   "
          f"Grades monotonic: {m['grades_monotonic']}")
    for title, table in (("Comparison", r["comparison"]), ("Grades", r["grades"]),
                         ("Decision swap", r["swap"]), ("SHAP importance", r["importance"]),
                         ("Fairness", r["fairness"])):
        print(f"\n{title}:")
        print(table.to_string(index=False))


if __name__ == "__main__":
    main()
