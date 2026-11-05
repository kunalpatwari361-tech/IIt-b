"""Train the Nirnay credit scorecard (model 1) on Home Credit Default Risk data.

Run from the repo root:
    .venv/Scripts/python -m models.credit_scorecard.train
    .venv/Scripts/python -m models.credit_scorecard.train --data path/to/application_train.csv

It writes:
    artifacts/scorecard.json   the trained scorecard: bins and points for every input
    reports/metrics.json       accuracy, grade and fairness results
    reports/points_table.csv   every bin of every input and its points
    reports/grades.csv         applicants and default rate in each grade
    reports/fairness.csv       approval rates by gender and by age band
"""
from __future__ import annotations

import argparse
import json
import math
from datetime import date
from pathlib import Path

import numpy as np
import pandas as pd
from optbinning import BinningProcess
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_auc_score, roc_curve
from sklearn.model_selection import train_test_split

from .features import CATEGORICAL, EXCLUDED, FEATURES, NUMERICAL, RAW_COLUMNS, build_features
from .scorecard import GRADES, Scorecard, grade_for

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
DEFAULT_DATA = ROOT / "data" / "raw" / "application_train.csv"

VERSION = "scorecard-v1"
BASE_SCORE = 650  # the score of an applicant who is average on every input
PDO = 50          # every 50 extra points doubles the odds of repaying
MIN_IV = 0.02     # inputs below this information value barely predict default
APPROVE_GRADES = {"A", "B"}


def load_raw(path: Path) -> pd.DataFrame:
    zipped = path.with_name(path.name + ".zip")
    if not path.exists() and zipped.exists():
        path = zipped  # Kaggle downloads come zipped; pandas reads the zip directly
    if not path.exists():
        raise SystemExit(
            f"Data file not found: {path}\n"
            "Download application_train.csv from "
            "https://www.kaggle.com/competitions/home-credit-default-risk/data "
            "and put it in data/raw/."
        )
    return pd.read_csv(path, usecols=RAW_COLUMNS)


def fit_binning(X: pd.DataFrame, y: pd.Series) -> BinningProcess:
    """Group each input into bins whose default rate only rises or only falls."""
    bp = BinningProcess(
        variable_names=list(FEATURES),
        categorical_variables=CATEGORICAL,
        selection_criteria={"iv": {"min": MIN_IV}},
        binning_fit_params={name: {"monotonic_trend": "auto_asc_desc"} for name in NUMERICAL},
    )
    bp.fit(X, y)
    return bp


def to_woe(bp: BinningProcess, X: pd.DataFrame) -> pd.DataFrame:
    return bp.transform(X, metric="woe", metric_missing="empirical")


def fit_logistic(W: pd.DataFrame, y: pd.Series, names: list[str]):
    """Fit the logistic regression, dropping any input whose sign comes out flipped.

    With weight-of-evidence inputs every coefficient should have the same sign.
    A flipped sign means the input overlaps another one and its points would
    run the wrong way, which would make the scorecard impossible to explain.
    """
    names = list(names)
    expected = np.sign(LogisticRegression(max_iter=1000).fit(W[[names[0]]], y).coef_[0][0])
    dropped = []
    while True:
        lr = LogisticRegression(C=1.0, max_iter=2000).fit(W[names], y)
        coefs = dict(zip(names, lr.coef_[0]))
        wrong = [n for n in names if np.sign(coefs[n]) != expected]
        if not wrong:
            return lr, names, dropped
        worst = max(wrong, key=lambda n: abs(coefs[n]))
        names.remove(worst)
        dropped.append(worst)


def _fmt(x: float) -> str:
    return f"{x:.3g}"


def _numeric_labels(splits: list[float]) -> list[str]:
    if not splits:
        return ["any value"]
    labels = [f"below {_fmt(splits[0])}"]
    labels += [f"{_fmt(a)} to {_fmt(b)}" for a, b in zip(splits[:-1], splits[1:])]
    labels.append(f"{_fmt(splits[-1])} or more")
    return labels


def export_spec(bp: BinningProcess, lr: LogisticRegression, names: list[str], n_train: int) -> dict:
    factor = PDO / math.log(2)
    coefs = dict(zip(names, lr.coef_[0]))
    inputs = {}
    for name in names:
        optb = bp.get_binned_variable(name)
        table = optb.binning_table.build()
        bins = table[~table["Bin"].astype(str).isin(["Special", "Missing"]) & (table.index != "Totals")]
        missing = table[table["Bin"].astype(str) == "Missing"]
        coef = float(coefs[name])
        woe = [float(w) for w in bins["WoE"]]
        missing_woe = float(missing["WoE"].iloc[0]) if len(missing) and missing["Count"].iloc[0] > 0 else 0.0
        spec = {
            "group": FEATURES[name]["group"],
            "coef": coef,
            "woe": woe,
            "points": [int(round(-factor * coef * w)) for w in woe],
            "missing_woe": missing_woe,
            "missing_points": int(round(-factor * coef * missing_woe)),
            "event_rate": [float(r) for r in bins["Event rate"]],
            "missing_event_rate": float(missing["Event rate"].iloc[0])
            if len(missing) and missing["Count"].iloc[0] > 0 else None,
        }
        if name in CATEGORICAL:
            cats = [[str(c) for c in group] for group in optb.splits]
            spec.update(type="categorical", categories=cats, bins=[" / ".join(c) for c in cats])
        else:
            splits = [float(s) for s in optb.splits]
            spec.update(type="numerical", splits=splits, bins=_numeric_labels(splits))
        inputs[name] = spec
    return {
        "model": "credit_scorecard",
        "version": VERSION,
        "trained_on": f"Home Credit Default Risk, application_train.csv ({n_train:,} training rows)",
        "trained_at": date.today().isoformat(),
        "base_score": BASE_SCORE,
        "pdo": PDO,
        "intercept": float(lr.intercept_[0]),
        "min_score": 300,
        "max_score": 900,
        "grades": [{"grade": g, "from": f, "flag": fl, "reason_code": c} for g, f, fl, c in GRADES],
        "inputs": inputs,
    }


def ks(y, p) -> float:
    fpr, tpr, _ = roc_curve(y, p)
    return float(np.max(tpr - fpr))


def accuracy(y, p) -> dict:
    auc = float(roc_auc_score(y, p))
    return {"auc": round(auc, 4), "gini": round(2 * auc - 1, 4), "ks": round(ks(y, p), 4)}


def grade_table(scored: pd.DataFrame, y: pd.Series) -> pd.DataFrame:
    df = scored.assign(defaulted=y.to_numpy(), grade=[grade_for(s)[0] for s in scored["score"]])
    rows = []
    for grade, floor, flag, _ in GRADES:
        g = df[df["grade"] == grade]
        rows.append({
            "grade": grade,
            "score_from": floor,
            "flag": flag,
            "applicants": len(g),
            "share": round(len(g) / len(df), 4),
            "default_rate": round(g["defaulted"].mean(), 4) if len(g) else None,
            "predicted_default_rate": round(g["probability_of_default"].mean(), 4) if len(g) else None,
        })
    return pd.DataFrame(rows)


def fairness_table(grades: pd.Series, y: pd.Series, gender: pd.Series, age: pd.Series) -> pd.DataFrame:
    df = pd.DataFrame({
        "grade": grades.to_numpy(), "defaulted": y.to_numpy(),
        "gender": gender.to_numpy(),
        "age_band": pd.cut(age, [0, 30, 45, 60, 200], right=False,
                           labels=["under 30", "30-44", "45-59", "60+"]).astype(str).to_numpy(),
    })
    df["approved"] = df["grade"].isin(APPROVE_GRADES)
    df["referred"] = df["grade"] == "C"
    rows = []
    for attribute, groups in (("gender", ["F", "M"]), ("age_band", ["under 30", "30-44", "45-59", "60+"])):
        part = []
        for group in groups:
            g = df[df[attribute] == group]
            if not len(g):
                continue
            approved = g[g["approved"]]
            part.append({
                "attribute": attribute, "group": group, "applicants": len(g),
                "approval_rate": round(g["approved"].mean(), 4),
                "refer_rate": round(g["referred"].mean(), 4),
                "default_rate": round(g["defaulted"].mean(), 4),
                "default_rate_if_approved": round(approved["defaulted"].mean(), 4) if len(approved) else None,
            })
        best = max(r["approval_rate"] for r in part) if part else 0
        for r in part:
            r["ratio_to_best"] = round(r["approval_rate"] / best, 3) if best else None
            r["four_fifths_rule"] = "ok" if best and r["approval_rate"] / best >= 0.8 else "check"
        rows += part
    return pd.DataFrame(rows)


def train(raw: pd.DataFrame, out_dir: Path = HERE, seed: int = 42, test_size: float = 0.2) -> dict:
    raw = raw.reset_index(drop=True)
    y = raw["TARGET"].astype(int)
    X = build_features(raw)
    X_tr, X_te, y_tr, y_te = train_test_split(X, y, test_size=test_size, stratify=y, random_state=seed)

    bp = fit_binning(X_tr, y_tr)
    selected = [str(name) for name in bp.get_support(names=True)]
    if not selected:
        raise RuntimeError("No input passed the information-value check, so there is nothing to score.")
    W_tr, W_te = to_woe(bp, X_tr), to_woe(bp, X_te)
    lr, names, dropped_for_sign = fit_logistic(W_tr, y_tr, selected)

    spec = export_spec(bp, lr, names, len(X_tr))
    card = Scorecard(spec)
    s_tr, s_te = card.score_frame(X_tr), card.score_frame(X_te)

    # The JSON scorecard must give exactly what the fitted model gives.
    gap = float(np.max(np.abs(s_te["log_odds_bad"].to_numpy() - lr.decision_function(W_te[names]))))
    if gap > 1e-6:
        raise RuntimeError(f"Exported scorecard differs from the fitted model by {gap:.2e} in log-odds.")

    grades = grade_table(s_te, y_te)
    rates = grades.dropna(subset=["default_rate"]).query("applicants >= 30")["default_rate"].tolist()
    test_grades = pd.Series([grade_for(s)[0] for s in s_te["score"]], index=s_te.index)
    fairness = fairness_table(test_grades, y_te, raw.loc[X_te.index, "CODE_GENDER"], X_te["age_years"])

    iv = {row["name"]: round(float(row["iv"]), 4) for _, row in bp.summary().iterrows()}
    metrics = {
        "model": "credit_scorecard",
        "version": VERSION,
        "trained_at": spec["trained_at"],
        "rows": {"train": len(X_tr), "test": len(X_te), "default_rate": round(float(y.mean()), 4)},
        "train": accuracy(y_tr, s_tr["probability_of_default"]),
        "test": accuracy(y_te, s_te["probability_of_default"]),
        "test_using_rounded_score": accuracy(y_te, -s_te["score"]),
        "inputs_used": names,
        "information_value": iv,
        "dropped_low_iv": [n for n in FEATURES if n not in selected],
        "dropped_flipped_sign": dropped_for_sign,
        "excluded_on_purpose": EXCLUDED,
        "grades_monotonic": all(a < b for a, b in zip(rates, rates[1:])),
        "approval_rate_test": round(float(test_grades.isin(APPROVE_GRADES).mean()), 4),
        "export_matches_model": True,
    }

    (out_dir / "artifacts").mkdir(parents=True, exist_ok=True)
    (out_dir / "reports").mkdir(parents=True, exist_ok=True)
    (out_dir / "artifacts" / "scorecard.json").write_text(json.dumps(spec, indent=2), encoding="utf-8")
    (out_dir / "reports" / "metrics.json").write_text(json.dumps(metrics, indent=2), encoding="utf-8")
    grades.to_csv(out_dir / "reports" / "grades.csv", index=False)
    fairness.to_csv(out_dir / "reports" / "fairness.csv", index=False)
    points_rows = []
    for name, s in spec["inputs"].items():
        for label, pts, rate in zip(s["bins"], s["points"], s["event_rate"]):
            points_rows.append({"input": name, "group": s["group"], "bin": label, "points": pts,
                                "default_rate": round(rate, 4)})
        rate = s["missing_event_rate"]
        points_rows.append({"input": name, "group": s["group"], "bin": "missing",
                            "points": s["missing_points"],
                            "default_rate": None if rate is None else round(rate, 4)})
    pd.DataFrame(points_rows).to_csv(out_dir / "reports" / "points_table.csv", index=False)
    return {"metrics": metrics, "grades": grades, "fairness": fairness, "spec": spec}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--data", type=Path, default=DEFAULT_DATA, help="path to application_train.csv")
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()

    result = train(load_raw(args.data))
    m = result["metrics"]
    print(f"Trained {m['version']} on {m['rows']['train']:,} rows, tested on {m['rows']['test']:,}.")
    print(f"Inputs used: {', '.join(m['inputs_used'])}")
    print(f"Test  AUC {m['test']['auc']}  Gini {m['test']['gini']}  KS {m['test']['ks']}")
    print(f"Train AUC {m['train']['auc']}  Gini {m['train']['gini']}  KS {m['train']['ks']}")
    print("\nGrades on the test set:")
    print(result["grades"].to_string(index=False))
    print("\nFairness on the test set (approve = grade A or B):")
    print(result["fairness"].to_string(index=False))


if __name__ == "__main__":
    main()
