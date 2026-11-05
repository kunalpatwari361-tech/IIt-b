"""Train the Nirnay bank transaction tagger (model 5).

Run from the repo root:
    .venv/Scripts/python -m models.transaction_tagger.train

Data:
* Our generator: about 2,100 labelled narrations across 15 categories, in the
  formats of 6 Indian banks (generator.py).
* The Karthik-Eswar Hugging Face set: 970 narrations from a different
  generator, mapped onto our categories (sources.py).

Three checks, from hardest to easiest:
1. Unseen formats: hold out whole templates of our generator (5-fold GroupKFold).
2. Cross-source: train on our data only, test on the Hugging Face set.
3. Combined: 5-fold cross-validation on both sources together.
The shipped model is trained on both sources.

It writes:
    artifacts/model.joblib        TF-IDF + logistic regression pipeline
    artifacts/tagger.json         version, categories and data counts
    reports/metrics.json          accuracy and macro F1 for each check
    reports/per_category.csv      precision, recall and F1 per category, for each check
    reports/cross_source_mistakes.csv  the commonest confusions on the Hugging Face set
    reports/training_data.csv     how many examples per category and source
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
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, f1_score, precision_recall_fscore_support
from sklearn.model_selection import GroupKFold, StratifiedKFold
from sklearn.pipeline import FeatureUnion, Pipeline

from .generator import CATEGORIES, generate
from .sources import HF_PATH, HF_URL, load_hf
from .tagger import TransactionTagger, document

HERE = Path(__file__).resolve().parent
VERSION = "tagger-v1"
PER_CATEGORY = 140
DIRECTION_DROP = 0.3  # hide the direction on 30% of training rows, so the model copes when it is missing
BANK_CODE = r"(?:UPI|NEFT|IMPS|RTGS|POS|ACH|NACH|ECS|ATM|Ref#|\d{6,})"  # looks like a real statement line


def make_pipeline(C: float = 10.0) -> Pipeline:
    features = FeatureUnion([
        ("word", TfidfVectorizer(ngram_range=(1, 2), token_pattern=r"(?u)\b[\w#]+\b", sublinear_tf=True)),
        ("char", TfidfVectorizer(analyzer="char_wb", ngram_range=(2, 5), sublinear_tf=True, min_df=2)),
    ])
    return Pipeline([("features", features),
                     ("model", LogisticRegression(C=C, max_iter=3000, class_weight="balanced"))])


def docs(df: pd.DataFrame, rng: np.random.Generator | None = None) -> list[str]:
    directions = df["direction"].to_numpy(dtype=object).copy()
    if rng is not None:
        directions[rng.random(len(df)) < DIRECTION_DROP] = "unknown"
    return [document(t, d) for t, d in zip(df["text"], directions)]


def per_category(y_true, y_pred, labels: list[str], check: str) -> pd.DataFrame:
    p, r, f, s = precision_recall_fscore_support(y_true, y_pred, labels=labels, zero_division=0)
    return pd.DataFrame({"check": check, "category": labels, "precision": p.round(3), "recall": r.round(3),
                         "f1": f.round(3), "examples": s})


def summary(y_true, y_pred, labels) -> dict:
    return {"accuracy": round(float(accuracy_score(y_true, y_pred)), 4),
            "macro_f1": round(float(f1_score(y_true, y_pred, labels=labels, average="macro", zero_division=0)), 4),
            "examples": int(len(y_true))}


def train(gen: pd.DataFrame | None = None, hf: pd.DataFrame | None = None, out_dir: Path = HERE,
          seed: int = 42) -> dict:
    rng = np.random.default_rng(seed)
    gen = generate(PER_CATEGORY, seed=seed) if gen is None else gen
    labels = sorted(CATEGORIES)
    tables, metrics = [], {}

    # 1. Unseen formats: every template of our generator is held out once.
    pred = np.empty(len(gen), dtype=object)
    for tr, te in GroupKFold(n_splits=5).split(gen, gen["category"], groups=gen["template"]):
        model = make_pipeline().fit(docs(gen.iloc[tr], rng), gen["category"].iloc[tr])
        pred[te] = model.predict(docs(gen.iloc[te]))
    tables.append(per_category(gen["category"], pred, labels, "unseen_formats"))
    metrics["unseen_formats"] = summary(gen["category"], pred, labels)

    mistakes = pd.DataFrame()
    if hf is not None:
        # 2. Cross-source: our data only -> the Hugging Face set (no direction there).
        hf_labels = sorted(hf["category"].unique())
        model = make_pipeline().fit(docs(gen, rng), gen["category"])
        hf_pred = model.predict(docs(hf))
        tables.append(per_category(hf["category"], hf_pred, hf_labels, "cross_source"))
        metrics["cross_source"] = summary(hf["category"], hf_pred, hf_labels)
        # About a third of the Hugging Face rows are plain sentences ("bought vegetables at
        # BigBasket") that real statements never contain, so report bank-code rows separately.
        code = hf["text"].str.contains(BANK_CODE, regex=True).to_numpy()
        for name, mask in (("cross_source_bank_code", code), ("cross_source_plain_language", ~code)):
            metrics[name] = summary(hf["category"][mask], hf_pred[mask], hf_labels)
        tables.append(per_category(hf["category"][code], hf_pred[code], hf_labels, "cross_source_bank_code"))
        wrong = hf.assign(predicted=hf_pred)[hf["category"] != hf_pred]
        mistakes = (wrong.groupby(["category", "predicted"])
                    .agg(count=("text", "size"), example=("text", "first"),
                         original_category=("original_category", "first"))
                    .reset_index().sort_values("count", ascending=False).head(15))

        # 3. Combined: 5-fold cross-validation on both sources.
        both = pd.concat([gen, hf], ignore_index=True)
        pred = np.empty(len(both), dtype=object)
        for tr, te in StratifiedKFold(5, shuffle=True, random_state=seed).split(both, both["category"]):
            model = make_pipeline().fit(docs(both.iloc[tr], rng), both["category"].iloc[tr])
            pred[te] = model.predict(docs(both.iloc[te]))
        tables.append(per_category(both["category"], pred, labels, "combined"))
        metrics["combined"] = summary(both["category"], pred, labels)
        final_data = both
    else:
        final_data = gen

    final = make_pipeline().fit(docs(final_data, rng), final_data["category"])
    counts = final_data.groupby(["category", "source"]).size().unstack(fill_value=0)
    meta = {
        "model": "transaction_tagger", "version": VERSION, "trained_at": date.today().isoformat(),
        "sklearn_version": sklearn.__version__, "categories": labels, "category_direction": CATEGORIES,
        "training_rows": {s: int(n) for s, n in final_data["source"].value_counts().items()},
        "sources": {"nirnay_generator": "models/transaction_tagger/generator.py", "hf_karthik_eswar": HF_URL},
    }
    (out_dir / "artifacts").mkdir(parents=True, exist_ok=True)
    (out_dir / "reports").mkdir(parents=True, exist_ok=True)
    joblib.dump(final, out_dir / "artifacts" / "model.joblib", compress=3)
    (out_dir / "artifacts" / "tagger.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")

    # The saved tagger must give exactly what the trained pipeline gives.
    tagger = TransactionTagger.load(out_dir / "artifacts")
    sample = final_data.sample(min(200, len(final_data)), random_state=seed)
    got = [t["category"] for t in tagger.tag_many(sample[["text", "direction"]].to_dict("records"))]
    if got != list(final.predict(docs(sample))):
        raise RuntimeError("Saved tagger differs from the trained pipeline.")

    table = pd.concat(tables, ignore_index=True)
    metrics = {"model": "transaction_tagger", "version": VERSION, "trained_at": meta["trained_at"],
               "training_rows": meta["training_rows"], "checks": metrics, "export_matches_model": True}
    (out_dir / "reports" / "metrics.json").write_text(json.dumps(metrics, indent=2), encoding="utf-8")
    table.to_csv(out_dir / "reports" / "per_category.csv", index=False)
    mistakes.to_csv(out_dir / "reports" / "cross_source_mistakes.csv", index=False)
    counts.to_csv(out_dir / "reports" / "training_data.csv")
    return {"metrics": metrics, "per_category": table, "mistakes": mistakes, "counts": counts}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--hf", type=Path, default=HF_PATH, help="path to the Hugging Face CSV")
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()
    r = train(hf=load_hf(args.hf), seed=args.seed)
    for check, m in r["metrics"]["checks"].items():
        print(f"{check:15s} accuracy {m['accuracy']:.3f}  macro F1 {m['macro_f1']:.3f}  ({m['examples']} examples)")
    wide = r["per_category"].pivot(index="category", columns="check", values="f1")
    print("\nF1 per category:\n" + wide.to_string())
    print("\nCommonest cross-source mistakes:\n" + r["mistakes"].to_string(index=False))


if __name__ == "__main__":
    main()
