"""Train the Nirnay document classifier (model 6).

Run from the repo root (after build_data.py has made data/generated_ocr.csv):
    .venv/Scripts/python -m models.document_classifier.train

Training text for each fake document:
* the OCR text of its photo or scan (the main set)
* the OCR text of a bad photo of it, for 130 of them (the hard set)
* its clean text, as a text PDF or a better OCR engine would give it

Checks, from most to least realistic:
1. Unseen layouts: every layout is held out once (5 folds). This measures the model
   on formats it has never seen, such as a payroll system or state EC format we
   didn't write. Scored on the OCR text of normal photos, of bad photos, and on clean text.
2. Outside source: a model trained only on our documents reads AgamiAI's scanned
   bank statements and tax returns, which come from a different generator (sources.py).
The shipped model is trained on everything, including the AgamiAI scans.

It writes:
    artifacts/model.joblib            TF-IDF + logistic regression pipeline
    artifacts/classifier.json         version, types, thresholds and data counts
    reports/metrics.json              accuracy for each check
    reports/per_category.csv          precision, recall and F1 per type, for each check
    reports/confusion_unseen_layouts.csv   which types get mistaken for which
    reports/mistakes_unseen_layouts.csv    every wrong answer on unseen layouts, with its text
    reports/training_data.csv         documents per type and set
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
from sklearn.metrics import accuracy_score, confusion_matrix, f1_score, precision_recall_fscore_support
from sklearn.pipeline import FeatureUnion, Pipeline

from .build_data import OUT_CSV
from .classifier import MIN_CHARS, REVIEW_BELOW, DocumentClassifier, normalise, readable_chars, squash
from .generator import CATEGORIES
from .sources import URLS, load_agami

HERE = Path(__file__).resolve().parent
VERSION = "doc-classifier-v1"
FOLDS = 5


def make_pipeline(C: float = 10.0) -> Pipeline:
    features = FeatureUnion([
        ("words", TfidfVectorizer(preprocessor=normalise, token_pattern=r"(?u)\b[a-z#]{2,}\b", ngram_range=(1, 2),
                                  sublinear_tf=True, min_df=2)),
        ("chars", TfidfVectorizer(preprocessor=squash, analyzer="char", ngram_range=(3, 5), sublinear_tf=True,
                                  min_df=2, max_features=150_000)),
    ])
    return Pipeline([("features", features),
                     ("model", LogisticRegression(C=C, max_iter=5000, class_weight="balanced"))])


def load_data(path: Path = OUT_CSV) -> pd.DataFrame:
    if not Path(path).exists():
        raise FileNotFoundError(f"{path} is missing. Build it first: python -m models.document_classifier.build_data")
    df = pd.read_csv(path, keep_default_na=False)
    df["fold"] = df["layout_no"].astype(int) % FOLDS
    return df


def training_rows(df: pd.DataFrame) -> tuple[list[str], list[str]]:
    """OCR text of every photo (normal and bad), plus each document's clean text once."""
    main = df[df["set"] == "main"]
    texts = list(df["ocr_text"]) + list(main["clean_text"])
    labels = list(df["category"]) + list(main["category"])
    return texts, labels


def per_category(y_true, y_pred, labels, check) -> pd.DataFrame:
    p, r, f, s = precision_recall_fscore_support(y_true, y_pred, labels=labels, zero_division=0)
    return pd.DataFrame({"check": check, "category": labels, "precision": p.round(3), "recall": r.round(3),
                         "f1": f.round(3), "documents": s})


def decisions(texts, y_true, proba, classes) -> dict:
    """What the engine would do: accept the type, or send it for review / a new photo."""
    y_true = np.asarray(y_true)
    pred = np.asarray(classes)[proba.argmax(1)]
    conf = proba.max(1)
    unreadable = np.array([readable_chars(t) < MIN_CHARS for t in texts])
    review = unreadable | (conf < REVIEW_BELOW)
    accepted = ~review
    return {"accepted_share": round(float(accepted.mean()), 4),
            "accuracy_when_accepted": round(float((pred[accepted] == y_true[accepted]).mean()), 4) if accepted.any() else None,
            "accepted_but_wrong_share": round(float(((pred != y_true) & accepted).mean()), 4),
            "sent_for_review_share": round(float(review.mean()), 4),
            "unreadable_share": round(float(unreadable.mean()), 4)}


def summary(y_true, y_pred, labels) -> dict:
    return {"accuracy": round(float(accuracy_score(y_true, y_pred)), 4),
            "macro_f1": round(float(f1_score(y_true, y_pred, labels=labels, average="macro", zero_division=0)), 4),
            "documents": int(len(y_true))}


def train(df: pd.DataFrame | None = None, agami: pd.DataFrame | None = None, out_dir: Path = HERE,
          C: float = 10.0) -> dict:
    df = load_data() if df is None else df
    labels = list(CATEGORIES)
    tables, metrics = [], {}

    # 1. Unseen layouts: hold out every layout once.
    held = {"ocr": {}, "hard": {}, "clean": {}}
    for k in sorted(df["fold"].unique()):
        model = make_pipeline(C).fit(*training_rows(df[df["fold"] != k]))
        test = df[df["fold"] == k]
        main, hard = test[test["set"] == "main"], test[test["set"] == "hard"]
        for name, part, col in (("ocr", main, "ocr_text"), ("hard", hard, "ocr_text"), ("clean", main, "clean_text")):
            if len(part):
                proba = model.predict_proba(list(part[col]))
                for i, (doc, text, cat) in enumerate(zip(part["doc_id"], part[col], part["category"])):
                    held[name][doc] = (text, cat, proba[i], list(model.classes_))
    results = {}
    for name, check in (("ocr", "unseen_layouts"), ("hard", "unseen_layouts_bad_photos"), ("clean", "unseen_layouts_clean_text")):
        docs = sorted(held[name])
        texts = [held[name][d][0] for d in docs]
        y = [held[name][d][1] for d in docs]
        classes = held[name][docs[0]][3]
        proba = np.vstack([held[name][d][2] for d in docs])
        pred = list(np.asarray(classes)[proba.argmax(1)])
        metrics[check] = {**summary(y, pred, labels), **decisions(texts, y, proba, classes)}
        tables.append(per_category(y, pred, labels, check))
        results[check] = (docs, texts, y, pred, proba.max(1))

    # How the review threshold trades automation against mistakes (on documents of unseen layouts).
    predictions = pd.concat([pd.DataFrame({"check": check, "doc_id": d, "true": yy, "predicted": pp,
                                           "confidence": np.round(cc, 4), "readable_chars": [readable_chars(t) for t in tt]})
                             for check, (d, tt, yy, pp, cc) in results.items()], ignore_index=True)
    rows = []
    for check, part in predictions.groupby("check", sort=False):
        readable = part["readable_chars"] >= MIN_CHARS
        for t in (0.3, 0.4, 0.5, 0.6, 0.7):
            ok = readable & (part["confidence"] >= t)
            rows.append({"check": check, "review_below": t, "accepted_share": round(float(ok.mean()), 3),
                         "accuracy_when_accepted": round(float((part["true"] == part["predicted"])[ok].mean()), 4),
                         "accepted_but_wrong": int(((part["true"] != part["predicted"]) & ok).sum())})
    thresholds = pd.DataFrame(rows)

    docs, texts, y, pred, conf = results["unseen_layouts"]
    confusion = pd.DataFrame(confusion_matrix(y, pred, labels=labels), index=labels, columns=labels)
    mistakes = pd.DataFrame({"doc_id": docs, "true": y, "predicted": pred, "confidence": np.round(conf, 3),
                             "text_start": [t.replace("\n", " / ")[:200] for t in texts]})
    mistakes = mistakes[mistakes["true"] != mistakes["predicted"]].sort_values("confidence", ascending=False)

    # 2. Outside source: our documents only -> AgamiAI scans.
    if agami is not None and len(agami):
        model = make_pipeline(C).fit(*training_rows(df))
        proba = model.predict_proba(list(agami["ocr_text"]))
        apred = np.asarray(model.classes_)[proba.argmax(1)]
        metrics["outside_source_agami"] = {**summary(agami["category"], apred, sorted(agami["category"].unique())),
                                           **decisions(list(agami["ocr_text"]), agami["category"], proba, list(model.classes_))}
        for src, part in agami.assign(pred=apred).groupby("source"):
            metrics[f"outside_source_{src}"] = {"accuracy": round(float((part["pred"] == part["category"]).mean()), 4),
                                                "documents": int(len(part)),
                                                "predicted_as": part["pred"].value_counts().to_dict()}
        tables.append(per_category(agami["category"], apred, sorted(agami["category"].unique()), "outside_source_agami"))

    # The shipped model: everything we have.
    texts, ys = training_rows(df)
    if agami is not None and len(agami):
        texts, ys = texts + list(agami["ocr_text"]), ys + list(agami["category"])
    final = make_pipeline(C).fit(texts, ys)
    counts = df.groupby(["category", "set"]).size().unstack(fill_value=0)
    meta = {"model": "document_classifier", "version": VERSION, "trained_at": date.today().isoformat(),
            "sklearn_version": sklearn.__version__, "document_types": CATEGORIES,
            "review_below": REVIEW_BELOW, "min_readable_chars": MIN_CHARS,
            "training_documents": {"generated_main": int((df["set"] == "main").sum()),
                                   "generated_bad_photos": int((df["set"] == "hard").sum()),
                                   "agami_scans": int(0 if agami is None else len(agami))},
            "sources": {"nirnay_generator": "models/document_classifier/generator.py", **{f"agami_{k}": v for k, v in URLS.items()}}}
    (out_dir / "artifacts").mkdir(parents=True, exist_ok=True)
    (out_dir / "reports").mkdir(parents=True, exist_ok=True)
    joblib.dump(final, out_dir / "artifacts" / "model.joblib", compress=3)
    (out_dir / "artifacts" / "classifier.json").write_text(json.dumps(meta, indent=2), encoding="utf-8")

    # The saved classifier must give exactly what the trained pipeline gives.
    clf = DocumentClassifier.load(out_dir / "artifacts")
    sample = df.sample(min(100, len(df)), random_state=0)
    got = [r["top3"][0]["document_type"] for r in clf.classify_many(list(sample["ocr_text"]))]
    if got != list(final.predict(list(sample["ocr_text"]))):
        raise RuntimeError("Saved classifier differs from the trained pipeline.")

    table = pd.concat(tables, ignore_index=True)
    metrics = {"model": "document_classifier", "version": VERSION, "trained_at": meta["trained_at"],
               "training_documents": meta["training_documents"], "review_below": REVIEW_BELOW,
               "checks": metrics, "export_matches_model": True}
    (out_dir / "reports" / "metrics.json").write_text(json.dumps(metrics, indent=2), encoding="utf-8")
    table.to_csv(out_dir / "reports" / "per_category.csv", index=False)
    confusion.to_csv(out_dir / "reports" / "confusion_unseen_layouts.csv")
    mistakes.to_csv(out_dir / "reports" / "mistakes_unseen_layouts.csv", index=False)
    predictions.to_csv(out_dir / "reports" / "predictions_unseen_layouts.csv", index=False)
    thresholds.to_csv(out_dir / "reports" / "review_thresholds.csv", index=False)
    counts.to_csv(out_dir / "reports" / "training_data.csv")
    return {"metrics": metrics, "per_category": table, "confusion": confusion, "mistakes": mistakes,
            "thresholds": thresholds}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--C", type=float, default=10.0)
    args = parser.parse_args()
    r = train(agami=load_agami(), C=args.C)
    for check, m in r["metrics"]["checks"].items():
        extra = f"  accepted {m['accepted_share']:.0%}, wrong-but-accepted {m['accepted_but_wrong_share']:.1%}" if "accepted_share" in m else ""
        print(f"{check:34s} accuracy {m['accuracy']:.3f}" + (f"  macro F1 {m['macro_f1']:.3f}" if "macro_f1" in m else "") + extra)
    wide = r["per_category"].pivot(index="category", columns="check", values="f1")
    print("\nF1 per type:\n" + wide.to_string())
    print("\nConfusions on unseen layouts (rows = true type):\n" + r["confusion"].to_string())
    print("\nReview threshold trade-off:\n" + r["thresholds"].to_string(index=False))


if __name__ == "__main__":
    main()
