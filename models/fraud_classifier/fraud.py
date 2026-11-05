"""Score one application with the fraud classifier (model 3).

The model gives each application a fraud probability and an alert level:

* ``clear``:  below the review threshold, so the application carries on.
* ``review``: at or above the threshold set for a 5% false-alarm rate.
* ``high``:   at or above the threshold set for a 1% false-alarm rate.

It never declares fraud. Under RBI's fraud risk rules, a person must be heard
before an account is called fraudulent, so ``review`` and ``high`` both send
the application to the fraud team (flag ``refer``, reason ``R-FRD-01``). SHAP
values give the reasons in plain words.

Try it from the repo root:
    .venv/Scripts/python -m models.fraud_classifier.fraud models/fraud_classifier/example_input.json
"""
from __future__ import annotations

import json
import math
import sys
from pathlib import Path

import lightgbm as lgb
import numpy as np
import pandas as pd

DEFAULT_DIR = Path(__file__).resolve().parent / "artifacts"
REASON_CODE = "R-FRD-01"


class FraudModel:
    """A trained fraud classifier, loaded from model.txt and fraud.json."""

    def __init__(self, booster: lgb.Booster, meta: dict):
        self.booster = booster
        self.meta = meta
        self.version = meta["version"]
        self.features = meta["features"]
        self.inputs = meta["inputs"]
        self.thresholds = meta["thresholds"]  # {"review": p, "high": p}

    @classmethod
    def load(cls, folder: str | Path = DEFAULT_DIR) -> "FraudModel":
        folder = Path(folder)
        if not (folder / "model.txt").exists():
            raise FileNotFoundError(
                f"No trained fraud model in {folder}. Train it first: python -m models.fraud_classifier.train")
        meta = json.loads((folder / "fraud.json").read_text(encoding="utf-8"))
        return cls(lgb.Booster(model_file=str(folder / "model.txt")), meta)

    def frame(self, rows: pd.DataFrame) -> pd.DataFrame:
        """Put raw inputs into the exact columns and types the model was trained on."""
        X = pd.DataFrame(index=rows.index)
        for name in self.features:
            s = self.inputs[name]
            col = rows[name] if name in rows else pd.Series(np.nan, index=rows.index)
            if s["type"] == "categorical":
                X[name] = pd.Categorical(col.astype("object"), categories=s["categories"])  # unknown -> missing
            else:
                col = pd.to_numeric(col, errors="coerce").astype(float)
                if s.get("missing_if_negative"):
                    col = col.where(~(col < 0))
                X[name] = col
        return X

    def _explain(self, X: pd.DataFrame) -> tuple[np.ndarray, np.ndarray]:
        contrib = self.booster.predict(X, pred_contrib=True)  # TreeSHAP, in log-odds of fraud
        return contrib[:, :-1], contrib[:, -1]

    def alert(self, p: np.ndarray) -> np.ndarray:
        return np.where(p >= self.thresholds["high"], "high",
                        np.where(p >= self.thresholds["review"], "review", "clear"))

    def score_frame(self, rows: pd.DataFrame) -> pd.DataFrame:
        p = self.booster.predict(self.frame(rows))
        return pd.DataFrame({"fraud_probability": p, "alert": self.alert(p)}, index=rows.index)

    def score(self, inputs: dict) -> dict:
        X = self.frame(pd.DataFrame([{name: inputs.get(name) for name in self.features}]))
        shap_values, bias = self._explain(X)
        p = 1 / (1 + math.exp(-float(shap_values[0].sum() + bias[0])))
        alert = str(self.alert(np.array([p]))[0])
        contributions = []
        for j, name in enumerate(self.features):
            value = X[name].iloc[0]
            missing = pd.isna(value)
            contributions.append({
                "input": name,
                "label": self.inputs[name]["label"],
                "india_check": self.inputs[name]["india"],
                "value": None if missing else (value.item() if hasattr(value, "item") else value),
                "shap": round(float(shap_values[0, j]), 5),
            })
        raised = sorted((c for c in contributions if c["shap"] > 0), key=lambda c: -c["shap"])
        return {
            "model": "fraud_classifier",
            "model_version": self.version,
            "trained_on": self.meta["dataset"],
            "fraud_probability": round(p, 5),
            "alert": alert,
            "flag": "pass" if alert == "clear" else "refer",
            "reason_code": None if alert == "clear" else REASON_CODE,
            "thresholds": self.thresholds,
            "contributions": contributions,
            "top_reasons": [
                f"{c['label']} ({'missing' if c['value'] is None else c['value']}): check {c['india_check']}"
                for c in raised[:3]
            ],
        }


_loaded: FraudModel | None = None


def predict(application: dict) -> dict:
    """What the decision engine's Fraud gate calls. Loads the model once, then scores."""
    global _loaded
    if _loaded is None:
        _loaded = FraudModel.load()
    return _loaded.score(application)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Usage: python -m models.fraud_classifier.fraud <input.json or JSON text>")
    arg = sys.argv[1]
    text = Path(arg).read_text(encoding="utf-8") if Path(arg).exists() else arg
    print(json.dumps(predict(json.loads(text)), indent=2, ensure_ascii=False))
