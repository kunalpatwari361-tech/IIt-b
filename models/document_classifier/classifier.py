"""Tell document types apart from their OCR text (model 6).

Input is the text an OCR engine read from an uploaded photo or PDF. Output is
the document type (PAN card, salary slip, Form 16, bank statement, sale deed and
so on), a confidence score, and what the engine should do next.

OCR engines differ in how they space words ("Permanent Account Number" or
"PermanentAccountNumber"), so the model reads two views of the text:
* words and word pairs, for clean text
* character fragments of the text with all spaces removed, so spacing doesn't matter

Try it from the repo root:
    .venv/Scripts/python -m models.document_classifier.classifier models/document_classifier/example_ocr.txt
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

import joblib
import numpy as np

DEFAULT_DIR = Path(__file__).resolve().parent / "artifacts"
REVIEW_BELOW = 0.5   # less sure than this: an officer (or the customer) checks the document type.
                     # Chosen from reports/review_thresholds.csv: no wrong type was accepted at 0.5 on unseen layouts.
MIN_CHARS = 60       # less readable text than this: ask for a clearer photo
REASONS = {
    "R-DOC-01": "The document you uploaded doesn't look like the one we asked for. Please check and upload the right document.",
    "R-DOC-02": "We couldn't read your document. Please upload a clearer photo, or the original PDF.",
}

_DIGITS = re.compile(r"\d+")
_NON_WORD = re.compile(r"[^a-z#]+")


def normalise(text: str) -> str:
    """Lower-case, numbers become '#', anything that isn't a letter becomes a space."""
    return _NON_WORD.sub(" ", _DIGITS.sub("#", str(text).lower())).strip()


def squash(text: str) -> str:
    """normalise() with every space removed, so 'Form No. 16' and 'FormNo.16' look the same."""
    return normalise(text).replace(" ", "")


def readable_chars(text: str) -> int:
    return len(re.sub(r"[^A-Za-z0-9]", "", str(text)))


class DocumentClassifier:
    """A trained classifier, loaded from model.joblib and classifier.json (our own files only)."""

    def __init__(self, pipeline, meta: dict):
        self.pipeline = pipeline
        self.meta = meta
        self.version = meta["version"]
        self.classes = [str(c) for c in pipeline.classes_]
        self._names = np.asarray(pipeline.named_steps["features"].get_feature_names_out())
        self._is_word = np.char.startswith(self._names.astype(str), "words__")

    @classmethod
    def load(cls, folder: str | Path = DEFAULT_DIR) -> "DocumentClassifier":
        folder = Path(folder)
        if not (folder / "model.joblib").exists():
            raise FileNotFoundError(
                f"No trained classifier in {folder}. Train it first: python -m models.document_classifier.train")
        meta = json.loads((folder / "classifier.json").read_text(encoding="utf-8"))
        # joblib uses pickle, which can run code when loading. This only ever loads the model that
        # train.py wrote into this repo. Never point it at a model.joblib from anywhere else.
        import sklearn
        if meta.get("sklearn_version") and meta["sklearn_version"] != sklearn.__version__:
            import warnings
            warnings.warn(f"Classifier was trained with scikit-learn {meta['sklearn_version']}, you have "
                          f"{sklearn.__version__}. Retrain it if results look wrong.")
        return cls(joblib.load(folder / "model.joblib"), meta)

    def _reasons(self, text: str, cls: str, k: int = 4) -> list[str]:
        """Words in the document that pushed hardest towards the chosen type."""
        x = self.pipeline.named_steps["features"].transform([text]).tocsr()
        coef = self.pipeline.named_steps["model"].coef_[self.classes.index(cls)]
        idx = x.indices[self._is_word[x.indices]]
        contrib = x[0, idx].toarray().ravel() * coef[idx]
        out = []
        for i in idx[np.argsort(-contrib)]:
            word = self._names[i].split("__", 1)[1]
            if "#" not in word and not any(word in o or o in word for o in out):
                out.append(word)
            if len(out) == k:
                break
        return out

    def classify_many(self, texts: list[str], expected: list[str | None] | None = None) -> list[dict]:
        expected = expected or [None] * len(texts)
        proba = self.pipeline.predict_proba(list(texts))
        out = []
        for text, want, p in zip(texts, expected, proba):
            order = np.argsort(-p)
            best, conf = self.classes[order[0]], float(p[order[0]])
            r = {"model": "document_classifier", "model_version": self.version,
                 "document_type": best, "confidence": round(conf, 4),
                 "top3": [{"document_type": self.classes[i], "confidence": round(float(p[i]), 4)} for i in order[:3]],
                 "needs_review": conf < REVIEW_BELOW, "expected_type": want,
                 "flag": "pass", "reason_code": None, "reasons": self._reasons(text, best)}
            if readable_chars(text) < MIN_CHARS:
                r.update(document_type="unreadable", needs_review=True, flag="refer", reason_code="R-DOC-02", reasons=[])
            elif want is not None and (best != want or r["needs_review"]):
                r.update(flag="refer", reason_code="R-DOC-01")
            elif want is None and (best == "other" or r["needs_review"]):
                r.update(flag="refer", reason_code="R-DOC-01")
            out.append(r)
        return out

    def classify(self, text: str, expected: str | None = None) -> dict:
        return self.classify_many([text], [expected])[0]


_loaded: DocumentClassifier | None = None


def _model() -> DocumentClassifier:
    global _loaded
    if _loaded is None:
        _loaded = DocumentClassifier.load()
    return _loaded


def predict(document: dict) -> dict:
    """Classify one upload: {"ocr_text": ..., "expected_type": "salary_slip" (optional)}."""
    return _model().classify(document.get("ocr_text", ""), document.get("expected_type"))


if __name__ == "__main__":
    if len(sys.argv) not in (2, 3):
        sys.exit("Usage: python -m models.document_classifier.classifier <ocr_text.txt | \"text\"> [expected_type]")
    arg = sys.argv[1]
    text = Path(arg).read_text(encoding="utf-8") if Path(arg).exists() else arg
    print(json.dumps(predict({"ocr_text": text, "expected_type": sys.argv[2] if len(sys.argv) == 3 else None}),
                     indent=2, ensure_ascii=False))
