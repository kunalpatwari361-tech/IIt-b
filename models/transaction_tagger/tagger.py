"""Tag bank-statement entries (model 5) and summarise them for the Affordability gate.

TF-IDF on words and character fragments, then a logistic regression. Character
fragments matter because Indian narrations are full of codes ("NACH RTN",
"NWD-", "INT.PD"). The debit/credit direction is added as a token when known,
which is always the case with Account Aggregator data.

Try it from the repo root:
    .venv/Scripts/python -m models.transaction_tagger.tagger "NACH RTN BAJAJ FINANCE LTD INSUFF BAL"
    .venv/Scripts/python -m models.transaction_tagger.tagger models/transaction_tagger/example_statement.json
"""
from __future__ import annotations

import json
import re
import sys
from collections import defaultdict
from pathlib import Path

import joblib
import numpy as np

DEFAULT_DIR = Path(__file__).resolve().parent / "artifacts"
REVIEW_BELOW = 0.5  # confidence under this goes to an officer (or the LLM file note)

_DIGITS = re.compile(r"\d+")
_PUNCT = re.compile(r"[^a-z0-9#]+")


def normalise(text: str) -> str:
    """Lower-case, turn every number into '#', and keep only letters, digits and '#'."""
    text = _DIGITS.sub("#", str(text).lower())
    return _PUNCT.sub(" ", text).strip()


def document(text: str, direction: str | None) -> str:
    d = (direction or "").lower()
    token = "zzdircredit" if d.startswith("c") else "zzdirdebit" if d.startswith("d") else "zzdirunknown"
    return f"{normalise(text)} {token}"


class TransactionTagger:
    """A trained tagger, loaded from model.joblib and tagger.json (our own files only)."""

    def __init__(self, pipeline, meta: dict):
        self.pipeline = pipeline
        self.meta = meta
        self.version = meta["version"]
        self.classes = list(pipeline.classes_)
        features = pipeline.named_steps["features"]
        self._names = np.asarray(features.get_feature_names_out())

    @classmethod
    def load(cls, folder: str | Path = DEFAULT_DIR) -> "TransactionTagger":
        folder = Path(folder)
        if not (folder / "model.joblib").exists():
            raise FileNotFoundError(
                f"No trained tagger in {folder}. Train it first: python -m models.transaction_tagger.train")
        meta = json.loads((folder / "tagger.json").read_text(encoding="utf-8"))
        # joblib uses pickle, which can run code when loading. This only ever loads the model that
        # train.py wrote into this repo. Never point it at a model.joblib from anywhere else.
        import sklearn
        if meta.get("sklearn_version") and meta["sklearn_version"] != sklearn.__version__:
            import warnings
            warnings.warn(f"Tagger was trained with scikit-learn {meta['sklearn_version']}, you have "
                          f"{sklearn.__version__}. Retrain it if tags look wrong.")
        return cls(joblib.load(folder / "model.joblib"), meta)

    def _reasons(self, doc: str, cls: str, k: int = 3) -> list[str]:
        """Text fragments that pushed hardest towards the chosen category."""
        x = self.pipeline.named_steps["features"].transform([doc])
        coef = self.pipeline.named_steps["model"].coef_[self.classes.index(cls)]
        contrib = x.multiply(coef).tocsr()
        idx = contrib.indices[np.argsort(-contrib.data)]
        out = []
        for name in self._names[idx]:
            frag = name.split("__", 1)[-1].strip()
            if frag.startswith("zzdir"):
                frag = "direction: " + frag.removeprefix("zzdir")
            else:
                frag = frag.replace("zzdircredit", "(credit)").replace("zzdirdebit", "(debit)")
                frag = frag.replace("zzdirunknown", "").strip()
            if frag and frag not in out and not any(frag in o for o in out):
                out.append(frag)
            if len(out) == k:
                break
        return out

    def tag_many(self, transactions: list[dict]) -> list[dict]:
        docs = [document(t.get("text", ""), t.get("direction")) for t in transactions]
        proba = self.pipeline.predict_proba(docs)
        results = []
        for t, doc, p in zip(transactions, docs, proba):
            order = np.argsort(-p)
            best = self.classes[order[0]]
            results.append({
                **{k: t[k] for k in ("date", "amount", "direction", "text") if k in t},
                "category": best,
                "confidence": round(float(p[order[0]]), 4),
                "top3": [{"category": self.classes[i], "confidence": round(float(p[i]), 4)} for i in order[:3]],
                "needs_review": bool(p[order[0]] < REVIEW_BELOW),
                "reasons": self._reasons(doc, best),
            })
        return results

    def tag(self, text: str, direction: str | None = None, **extra) -> dict:
        return self.tag_many([{"text": text, "direction": direction, **extra}])[0]


def summarise(tagged: list[dict]) -> dict:
    """Monthly totals the Affordability and Fraud gates use (needs `date` as YYYY-MM-DD and `amount`)."""
    months = defaultdict(lambda: defaultdict(float))
    for t in tagged:
        if "date" not in t or "amount" not in t:
            continue
        months[str(t["date"])[:7]][t["category"]] += float(t["amount"])
    n = max(len(months), 1)
    total = defaultdict(float)
    for m in months.values():
        for k, v in m.items():
            total[k] += v
    credits = sum(total[c] for c in ("salary", "other_income", "cash_deposit", "refund"))
    # A bounce usually shows twice: the return itself and the bank's return charge. Count events.
    bounce_rows = [t for t in tagged if t["category"] == "bounce"]
    charge_rows = [t for t in bounce_rows if re.search(r"chg|charge", str(t.get("text", "")), re.I)]
    events = len(bounce_rows) - len(charge_rows) or len(charge_rows)
    return {
        "months": sorted(months),
        "avg_monthly_salary": round(total["salary"] / n, 2),
        "salary_months": sum(1 for m in months.values() if m.get("salary", 0) > 0),
        "avg_monthly_emi": round(total["emi"] / n, 2),
        "avg_monthly_rent": round(total["rent"] / n, 2),
        "bounces": events,
        "bounce_entries": len(bounce_rows),
        "cash_deposit_share_of_credits": round(total["cash_deposit"] / credits, 4) if credits else None,
        "entries_needing_review": sum(1 for t in tagged if t["needs_review"]),
        "by_month": {k: {c: round(v, 2) for c, v in m.items()} for k, m in sorted(months.items())},
    }


_loaded: TransactionTagger | None = None


def _tagger() -> TransactionTagger:
    global _loaded
    if _loaded is None:
        _loaded = TransactionTagger.load()
    return _loaded


def predict(transaction: dict) -> dict:
    """Tag one entry: {"text": ..., "direction": "debit"/"credit", ...}."""
    return _tagger().tag_many([transaction])[0]


def tag_statement(transactions: list[dict]) -> dict:
    """Tag a whole statement (for example, Account Aggregator data) and summarise it."""
    tagged = _tagger().tag_many(transactions)
    return {"model": "transaction_tagger", "model_version": _tagger().version,
            "transactions": tagged, "summary": summarise(tagged)}


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit('Usage: python -m models.transaction_tagger.tagger "<narration>" | <statement.json>')
    arg = sys.argv[1]
    if Path(arg).exists():
        print(json.dumps(tag_statement(json.loads(Path(arg).read_text(encoding="utf-8"))), indent=2, ensure_ascii=False))
    else:
        print(json.dumps(predict({"text": arg}), indent=2, ensure_ascii=False))
