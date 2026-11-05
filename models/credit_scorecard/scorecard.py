"""Score one application with the trained credit scorecard.

Every model in Nirnay returns the same kind of answer, so the decision engine
can combine them. This one returns a 300-900 score, a grade, a flag for the
Risk grade gate and the points behind the score.

Try it from the repo root:
    .venv/Scripts/python -m models.credit_scorecard.scorecard models/credit_scorecard/example_input.json
"""
from __future__ import annotations

import json
import math
import sys
from pathlib import Path
from typing import Any

import numpy as np
import pandas as pd

DEFAULT_PATH = Path(__file__).resolve().parent / "artifacts" / "scorecard.json"

# Grade bands from the report. A and B pass, C goes to an officer, D and E are
# rejected at the Risk grade gate.
GRADES = [
    ("A", 760, "pass", None),
    ("B", 700, "pass", None),
    ("C", 650, "refer", "R-RSK-01"),
    ("D", 600, "reject", "R-RSK-02"),
    ("E", 300, "reject", "R-RSK-02"),
]


def grade_for(score: int) -> tuple[str, str, str | None]:
    for grade, floor, flag, code in GRADES:
        if score >= floor:
            return grade, flag, code
    return GRADES[-1][0], GRADES[-1][2], GRADES[-1][3]


def _is_missing(value: Any) -> bool:
    return value is None or (isinstance(value, float) and math.isnan(value))


class Scorecard:
    """A trained scorecard, loaded from the JSON file train.py writes."""

    def __init__(self, spec: dict):
        self.spec = spec
        self.version = spec["version"]
        self.base = spec["base_score"]
        self.factor = spec["pdo"] / math.log(2)
        self.intercept = spec["intercept"]
        self.inputs = spec["inputs"]
        self._category_bin = {
            name: {cat: i for i, cats in enumerate(s["categories"]) for cat in cats}
            for name, s in self.inputs.items() if s["type"] == "categorical"
        }

    @classmethod
    def load(cls, path: str | Path = DEFAULT_PATH) -> "Scorecard":
        path = Path(path)
        if not path.exists():
            raise FileNotFoundError(
                f"No trained scorecard at {path}. Train it first: "
                "python -m models.credit_scorecard.train"
            )
        return cls(json.loads(path.read_text(encoding="utf-8")))

    def _missing(self, name: str, value: Any) -> bool:
        """Missing, or a 'no score' code such as a bureau score of 0."""
        floor = self.inputs[name].get("missing_below")
        return _is_missing(value) or (floor is not None and float(value) < floor)

    def _bin(self, name: str, value: Any) -> int | None:
        """Bin index for one value, or None when the value is missing or unknown."""
        s = self.inputs[name]
        if self._missing(name, value):
            return None
        if s["type"] == "numerical":
            return int(np.searchsorted(s["splits"], float(value), side="right"))
        return self._category_bin[name].get(str(value))

    def _woe(self, name: str, value: Any) -> tuple[float, int, str]:
        """Weight of evidence, rounded points and bin label for one input."""
        s = self.inputs[name]
        idx = self._bin(name, value)
        if idx is None:
            missing = self._missing(name, value)
            label = "missing" if missing else "unknown value"
            woe = s["missing_woe"] if missing else 0.0
            points = s["missing_points"] if missing else 0
            return woe, points, label
        return s["woe"][idx], s["points"][idx], s["bins"][idx]

    def score(self, inputs: dict) -> dict:
        """Score one application. Missing inputs score as their 'missing' bin."""
        factors = []
        log_odds_bad = self.intercept
        for name, s in self.inputs.items():
            value = inputs.get(name)
            woe, points, bin_label = self._woe(name, value)
            log_odds_bad += s["coef"] * woe
            factors.append({
                "input": name,
                "label": s["label"],
                "group": s["group"],
                "value": None if _is_missing(value) else value,
                "bin": bin_label,
                "points": points,
            })
        total = self.base + sum(f["points"] for f in factors)
        score = int(min(self.spec["max_score"], max(self.spec["min_score"], total)))
        grade, flag, code = grade_for(score)
        lost = sorted((f for f in factors if f["points"] < 0), key=lambda f: f["points"])
        return {
            "model": "credit_scorecard",
            "model_version": self.version,
            "trained_on": self.spec["dataset"],
            "score": score,
            "grade": grade,
            "flag": flag,
            "reason_code": code,
            "probability_of_default": round(1 / (1 + math.exp(-log_odds_bad)), 4),
            "base_score": self.base,
            "points": factors,
            "top_reasons": [f"{f['label']} ({f['bin']}): {f['points']} points" for f in lost[:3]],
        }

    def score_frame(self, X: pd.DataFrame) -> pd.DataFrame:
        """Score many applications at once. Used for validation."""
        log_odds_bad = np.full(len(X), self.intercept, dtype=float)
        total = np.full(len(X), self.base, dtype=float)
        for name, s in self.inputs.items():
            col = X[name]
            missing = col.isna().to_numpy()
            if s.get("missing_below") is not None:
                missing = missing | (pd.to_numeric(col, errors="coerce") < s["missing_below"]).to_numpy()
            if s["type"] == "numerical":
                idx = np.searchsorted(s["splits"], col.fillna(0).to_numpy(dtype=float), side="right")
                known = ~missing
            else:
                mapped = col.astype("object").map(self._category_bin[name])
                known = mapped.notna().to_numpy()
                idx = mapped.fillna(0).to_numpy(dtype=int)
            woe = np.where(known, np.asarray(s["woe"])[idx], np.where(missing, s["missing_woe"], 0.0))
            pts = np.where(known, np.asarray(s["points"])[idx], np.where(missing, s["missing_points"], 0))
            log_odds_bad += s["coef"] * woe
            total += pts
        score = np.clip(total, self.spec["min_score"], self.spec["max_score"]).astype(int)
        return pd.DataFrame({
            "score": score,
            "probability_of_default": 1 / (1 + np.exp(-log_odds_bad)),
            "log_odds_bad": log_odds_bad,
        }, index=X.index)


_loaded: Scorecard | None = None


def predict(application: dict) -> dict:
    """What the decision engine calls. Loads the scorecard once, then scores."""
    global _loaded
    if _loaded is None:
        _loaded = Scorecard.load()
    return _loaded.score(application)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Usage: python -m models.credit_scorecard.scorecard <input.json or JSON text>")
    arg = sys.argv[1]
    text = Path(arg).read_text(encoding="utf-8") if Path(arg).exists() else arg
    print(json.dumps(predict(json.loads(text)), indent=2))
