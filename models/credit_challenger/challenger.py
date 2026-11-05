"""Score one application with the credit challenger (model 2, shadow mode).

The challenger is a LightGBM model. It runs beside the scorecard but never
decides: the engine logs its answer so the two can be compared on real
applications. Its SHAP values are turned into points, so it explains itself
the same way the scorecard does. The score is 650 plus each input's points.

Try it from the repo root:
    .venv/Scripts/python -m models.credit_challenger.challenger models/credit_scorecard/example_input.json
"""
from __future__ import annotations

import json
import math
import sys
from pathlib import Path
from typing import Any

import lightgbm as lgb
import numpy as np
import pandas as pd

from ..credit_scorecard.scorecard import grade_for

DEFAULT_DIR = Path(__file__).resolve().parent / "artifacts"


class Challenger:
    """A trained challenger, loaded from model.txt and challenger.json."""

    def __init__(self, booster: lgb.Booster, meta: dict):
        self.booster = booster
        self.meta = meta
        self.version = meta["version"]
        self.features = meta["features"]
        self.inputs = meta["inputs"]
        self.base = meta["base_score"]
        self.factor = meta["pdo"] / math.log(2)
        self.reference = meta["reference_log_odds"]

    @classmethod
    def load(cls, folder: str | Path = DEFAULT_DIR) -> "Challenger":
        folder = Path(folder)
        if not (folder / "model.txt").exists():
            raise FileNotFoundError(
                f"No trained challenger in {folder}. Train it first: python -m models.credit_challenger.train")
        meta = json.loads((folder / "challenger.json").read_text(encoding="utf-8"))
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
                if s.get("missing_below") is not None:
                    col = col.where(~(col < s["missing_below"]))  # e.g. bureau score 0 = no score
                X[name] = col
        return X

    def _explain(self, X: pd.DataFrame) -> tuple[np.ndarray, np.ndarray]:
        contrib = self.booster.predict(X, pred_contrib=True)  # TreeSHAP, in log-odds of default
        return contrib[:, :-1], contrib[:, -1]

    def score_frame(self, rows: pd.DataFrame) -> pd.DataFrame:
        """Score many applications at once. Used for validation and comparison."""
        shap_values, bias = self._explain(self.frame(rows))
        log_odds_bad = shap_values.sum(axis=1) + bias
        points = np.rint(-self.factor * shap_values)
        base = self.base + np.rint(-self.factor * (bias - self.reference))
        score = np.clip(base + points.sum(axis=1), 300, 900).astype(int)
        return pd.DataFrame({
            "score": score,
            "probability_of_default": 1 / (1 + np.exp(-log_odds_bad)),
            "log_odds_bad": log_odds_bad,
        }, index=rows.index)

    def score(self, inputs: dict) -> dict:
        row = pd.DataFrame([{name: inputs.get(name) for name in self.features}])
        X = self.frame(row)
        shap_values, bias = self._explain(X)
        log_odds_bad = float(shap_values[0].sum() + bias[0])
        base = int(self.base + round(-self.factor * (bias[0] - self.reference)))
        factors = []
        for j, name in enumerate(self.features):
            value = X[name].iloc[0]
            missing = pd.isna(value)
            factors.append({
                "input": name,
                "label": self.inputs[name]["label"],
                "group": self.inputs[name]["group"],
                "value": None if missing else (value.item() if hasattr(value, "item") else value),
                "shap": round(float(shap_values[0, j]), 5),
                "points": int(round(-self.factor * shap_values[0, j])),
            })
        score = int(min(900, max(300, base + sum(f["points"] for f in factors))))
        grade, flag, code = grade_for(score)
        lost = sorted((f for f in factors if f["points"] < 0), key=lambda f: f["points"])
        return {
            "model": "credit_challenger",
            "mode": "shadow",  # logged next to the scorecard; never sets the outcome
            "model_version": self.version,
            "trained_on": self.meta["dataset"],
            "score": score,
            "grade": grade,
            "flag": flag,
            "reason_code": code,
            "probability_of_default": round(1 / (1 + math.exp(-log_odds_bad)), 4),
            "base_score": base,
            "points": factors,
            "top_reasons": [
                f"{f['label']} ({'missing' if f['value'] is None else f['value']}): {f['points']} points"
                for f in lost[:3]
            ],
        }


_loaded: Challenger | None = None


def predict(application: dict) -> dict:
    """What the decision engine calls in shadow mode. Loads the model once, then scores."""
    global _loaded
    if _loaded is None:
        _loaded = Challenger.load()
    return _loaded.score(application)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Usage: python -m models.credit_challenger.challenger <input.json or JSON text>")
    arg = sys.argv[1]
    text = Path(arg).read_text(encoding="utf-8") if Path(arg).exists() else arg
    print(json.dumps(predict(json.loads(text)), indent=2, ensure_ascii=False))
