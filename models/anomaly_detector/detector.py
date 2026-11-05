"""Score one application with the anomaly detector (model 4).

Two layers, both learned or set without any fraud labels:

1. An IsolationForest learns what normal L&T applications look like. Unusual
   combinations are easy to isolate, so they get a high anomaly score.
2. Integrity rules catch details that cannot all be true together (see
   features.RULES). A forest cannot learn these, because they never occur in
   genuine data.

Alert levels:

* ``unusual``:      forest score in the top 1% of training applications
* ``very_unusual``: forest score in the top 0.1%, or any integrity rule broken

Like the fraud model, it never rejects: either alert sends the application to
the fraud team (flag ``refer``, reason ``R-FRD-04``). SHAP explains which inputs
made the application look odd.

Try it from the repo root:
    .venv/Scripts/python -m models.anomaly_detector.detector models/anomaly_detector/example_input.json
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import joblib
import numpy as np
import pandas as pd

from .features import BASE_FIELDS, RULES, derive, integrity_flags

DEFAULT_DIR = Path(__file__).resolve().parent / "artifacts"
REASON_CODE = "R-FRD-04"


def average_path_length(n: int) -> float:
    """c(n) from the IsolationForest paper: average path length of an unsuccessful search."""
    return 2.0 * (np.log(n - 1) + np.euler_gamma) - 2.0 * (n - 1) / n if n > 2 else 1.0


class AnomalyDetector:
    """A trained detector, loaded from model.joblib and anomaly.json (our own files only)."""

    def __init__(self, model, meta: dict):
        self.model = model
        self.meta = meta
        self.version = meta["version"]
        self.inputs = meta["inputs"]
        self.features = meta["features"]
        self.thresholds = meta["thresholds"]  # {"unusual": score, "very_unusual": score}
        self.quantiles = {k: np.asarray(v) for k, v in meta["quantiles"].items()}
        self.levels = np.asarray(meta["quantile_levels"])
        self._explainer = None

    @classmethod
    def load(cls, folder: str | Path = DEFAULT_DIR) -> "AnomalyDetector":
        folder = Path(folder)
        if not (folder / "model.joblib").exists():
            raise FileNotFoundError(
                f"No trained detector in {folder}. Train it first: python -m models.anomaly_detector.train")
        meta = json.loads((folder / "anomaly.json").read_text(encoding="utf-8"))
        # joblib uses pickle, which can run code when loading. This only ever loads the model
        # that train.py wrote into this repo (only collaborators can push to it). Never point
        # it at a model.joblib from anywhere else.
        import sklearn
        if meta.get("sklearn_version") and meta["sklearn_version"] != sklearn.__version__:
            import warnings
            warnings.warn(f"Detector was trained with scikit-learn {meta['sklearn_version']}, you have "
                          f"{sklearn.__version__}. Retrain it if scores look wrong.")
        return cls(joblib.load(folder / "model.joblib"), meta)

    def frame(self, base: pd.DataFrame) -> pd.DataFrame:
        return derive(base)[self.features]

    def anomaly_score(self, X: pd.DataFrame) -> np.ndarray:
        return -self.model.score_samples(X.to_numpy())  # higher = more unusual, between 0 and 1

    def alert(self, s: np.ndarray, rules_broken: np.ndarray | None = None) -> np.ndarray:
        very = s >= self.thresholds["very_unusual"]
        if rules_broken is not None:
            very = very | (rules_broken > 0)
        return np.where(very, "very_unusual", np.where(s >= self.thresholds["unusual"], "unusual", "normal"))

    def percentile(self, s: np.ndarray) -> np.ndarray:
        """Share of training applications with a lower anomaly score."""
        return np.interp(s, self.meta["score_quantiles"], self.levels)

    def score_frame(self, base: pd.DataFrame) -> pd.DataFrame:
        s = self.anomaly_score(self.frame(base))
        rules = integrity_flags(base)
        broken = rules.sum(axis=1).to_numpy()
        return pd.DataFrame({"anomaly_score": s, "percentile": self.percentile(s),
                             "forest_alert": self.alert(s), "rules_broken": broken,
                             "alert": self.alert(s, broken)}, index=base.index).join(rules)

    def _explain(self, X: pd.DataFrame) -> tuple[np.ndarray, np.ndarray]:
        """SHAP in average-path-length units: negative = made the application easier to isolate (odder)."""
        if self._explainer is None:
            import shap
            self._explainer = shap.TreeExplainer(self.model)
        values = self._explainer.shap_values(X.to_numpy())
        return values, np.full(len(X), float(np.ravel(self._explainer.expected_value)[0]))

    def _describe(self, name: str, value: float) -> str:
        q = self.quantiles[name]
        pct = float(np.interp(value, q, self.levels)) * 100
        if pct >= 50:
            return f"higher than {min(pct, 99.99):.2f}% of past applications"
        return f"lower than {min(100 - pct, 99.99):.2f}% of past applications"

    def score(self, application: dict) -> dict:
        base = pd.DataFrame([{k: application.get(k) for k in BASE_FIELDS}])
        X = self.frame(base)
        s = float(self.anomaly_score(X)[0])
        broken = [name for name, hit in integrity_flags(base).iloc[0].items() if hit]
        forest_alert = str(self.alert(np.array([s]))[0])
        alert = str(self.alert(np.array([s]), np.array([len(broken)]))[0])
        shap_values, _ = self._explain(X)
        contributions = []
        for j, name in enumerate(X.columns):
            spec = self.inputs[name]
            field = spec.get("field")
            raw_value = application.get(field) if field else None
            contributions.append({
                "input": name, "label": spec["label"],
                "value": None if raw_value is None else raw_value,
                "model_value": round(float(X[name].iloc[0]), 4),
                "shap": round(float(shap_values[0, j]), 5),
            })
        odd = sorted((c for c in contributions if c["shap"] < 0), key=lambda c: c["shap"])
        reasons = [f"Integrity check failed: {RULES[r]}" for r in broken]
        # Add the forest's reasons when the forest itself flagged it (or nothing else explains the score).
        forest_reasons = odd if (forest_alert != "normal" or not broken) else []
        for c in forest_reasons[:max(0, 3 - len(reasons))]:
            shown = c["value"] if c["value"] is not None else c["model_value"]
            reasons.append(f"{c['label']} ({shown}): {self._describe(c['input'], c['model_value'])}")
        return {
            "model": "anomaly_detector",
            "model_version": self.version,
            "trained_on": self.meta["dataset"],
            "anomaly_score": round(s, 5),
            "percentile": round(float(self.percentile(np.array([s]))[0]), 5),
            "alert": alert,
            "forest_alert": forest_alert,
            "rules_broken": broken,
            "flag": "pass" if alert == "normal" else "refer",
            "reason_code": None if alert == "normal" else REASON_CODE,
            "thresholds": self.thresholds,
            "contributions": contributions,
            "top_reasons": reasons,
        }


_loaded: AnomalyDetector | None = None


def predict(application: dict) -> dict:
    """What the decision engine's Fraud gate calls. Loads the detector once, then scores."""
    global _loaded
    if _loaded is None:
        _loaded = AnomalyDetector.load()
    return _loaded.score(application)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Usage: python -m models.anomaly_detector.detector <input.json or JSON text>")
    arg = sys.argv[1]
    text = Path(arg).read_text(encoding="utf-8") if Path(arg).exists() else arg
    print(json.dumps(predict(json.loads(text)), indent=2, ensure_ascii=False))
