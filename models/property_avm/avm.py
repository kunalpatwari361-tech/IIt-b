"""Estimate a property's value range (model 7: automated valuation model).

LightGBM learns price per sq ft (on a log scale) from public listings. Three boosters:
the middle estimate (P50), and the low (P10) and high (P90) edges of the range. The
range is then widened by a fixed amount so that, on held-out listings, 80% of prices
fall inside it (conformal calibration).

The locality, sub-locality and society are turned into "price level" numbers: how far
their listings sit above or below the city's typical price per sq ft, with few
listings pulled towards zero. Where a state's circle rate is known (Delhi, Gurugram)
it is an input too.

Try it from the repo root:
    .venv/Scripts/python -m models.property_avm.avm models/property_avm/example_input.json
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import lightgbm as lgb
import numpy as np
import pandas as pd

from .circle_rates import FLAT_MINIMUM_CITIES, circle_rate_sqft
from .features import clean_place, place_key

DEFAULT_DIR = Path(__file__).resolve().parent / "artifacts"
SMOOTHING = 3.0                  # listings it takes before a locality's own level counts as much as the city's
KEYS = {"locality": "city_locality", "sublocality": "city_sublocality", "society": "city_society"}
NUMERIC = ["area_sqft", "is_carpet_area", "bhk", "bathrooms", "balconies", "floor", "total_floors", "floor_share",
           "parking", "covered_parking", "is_new", "overlooks_park", "overlooks_pool", "overlooks_main_road",
           "has_society", "circle_rate_sqft"]
CATEGORICAL = ["furnishing", "facing", "ownership"]
ENCODED = ["city_level", "locality_level", "locality_listings", "sublocality_level", "sublocality_listings",
           "society_level", "society_listings"]
FEATURES = NUMERIC + CATEGORICAL + ENCODED
LABELS = {
    "city_level": "city price level", "locality_level": "locality price level", "locality_listings": "listings in locality",
    "sublocality_level": "neighbourhood price level", "sublocality_listings": "listings in neighbourhood",
    "society_level": "society price level", "society_listings": "listings in society", "area_sqft": "size",
    "is_carpet_area": "carpet or super area", "bhk": "bedrooms", "bathrooms": "bathrooms", "balconies": "balconies",
    "floor": "floor", "total_floors": "building height", "floor_share": "floor within building", "parking": "parking",
    "covered_parking": "covered parking", "is_new": "new or resale", "overlooks_park": "park view",
    "overlooks_pool": "pool view", "overlooks_main_road": "main-road facing", "has_society": "in a society",
    "circle_rate_sqft": "circle rate", "furnishing": "furnishing", "facing": "facing", "ownership": "ownership",
}
GROUPS = {"city_level": "city", "locality_level": "locality", "locality_listings": "locality",
          "sublocality_level": "neighbourhood", "sublocality_listings": "neighbourhood",
          "society_level": "society", "society_listings": "society", "floor": "floor", "floor_share": "floor",
          "total_floors": "building height", "parking": "parking", "covered_parking": "parking"}
REASONS = {
    "R-PRP-03": "We need our valuer to visit the property to confirm its value.",
    "R-PRP-04": "The agreement value is below the government circle rate for this property. Please check the sale agreement.",
}


class Encoder:
    """City price levels and smoothed locality / sub-locality / society levels (log price per sq ft)."""

    def __init__(self, city: dict, overall: float, levels: dict):
        self.city, self.overall, self.levels = city, overall, levels

    @classmethod
    def fit(cls, df: pd.DataFrame) -> "Encoder":
        city = df.groupby("city")["log_ppsf"].median().to_dict()
        overall = float(df["log_ppsf"].median())
        dev = df["log_ppsf"] - df["city"].map(city)
        levels = {}
        for name, key in KEYS.items():
            g = dev.groupby(df[key]).agg(["sum", "count"])
            g = g[g.index != ""]
            levels[name] = {k: (float(s / (n + SMOOTHING)), int(n)) for k, (s, n) in g.iterrows()}
        return cls(city, overall, levels)

    def transform(self, df: pd.DataFrame) -> pd.DataFrame:
        out = pd.DataFrame(index=df.index)
        out["city_level"] = df["city"].map(self.city).fillna(self.overall)
        for name, key in KEYS.items():
            hit = df[key].map(self.levels[name])
            out[f"{name}_level"] = hit.map(lambda v: v[0] if isinstance(v, tuple) else np.nan)
            out[f"{name}_listings"] = hit.map(lambda v: v[1] if isinstance(v, tuple) else 0).astype(float)
        return out

    def to_json(self) -> dict:
        return {"city": self.city, "overall": self.overall,
                "levels": {n: {k: list(v) for k, v in d.items()} for n, d in self.levels.items()}}

    @classmethod
    def from_json(cls, d: dict) -> "Encoder":
        return cls(d["city"], d["overall"], {n: {k: tuple(v) for k, v in m.items()} for n, m in d["levels"].items()})


def frame(df: pd.DataFrame, encoder: Encoder, categories: dict) -> pd.DataFrame:
    X = pd.concat([df.reindex(columns=NUMERIC).astype(float), encoder.transform(df)], axis=1)
    for c in CATEGORICAL:
        X[c] = pd.Categorical(df[c] if c in df else pd.Series(np.nan, index=df.index), categories=categories[c])
    return X[FEATURES]


class PropertyAVM:
    def __init__(self, boosters: dict, encoder: Encoder, meta: dict):
        self.boosters, self.encoder, self.meta = boosters, encoder, meta
        self.version = meta["version"]
        self.widen = meta["conformal_widen_log"]

    @classmethod
    def load(cls, folder: str | Path = DEFAULT_DIR) -> "PropertyAVM":
        folder = Path(folder)
        if not (folder / "avm.json").exists():
            raise FileNotFoundError(f"No trained model in {folder}. Train it first: python -m models.property_avm.train")
        meta = json.loads((folder / "avm.json").read_text(encoding="utf-8"))
        boosters = {q: lgb.Booster(model_file=str(folder / f"model_{q}.txt")) for q in ("p10", "p50", "p90")}
        return cls(boosters, Encoder.from_json(meta.pop("encoder")), meta)

    def prepare(self, rows: pd.DataFrame) -> pd.DataFrame:
        rows = rows.copy()
        for col in ("locality", "sublocality", "society"):
            rows[col] = rows[col].map(clean_place) if col in rows else ""
        rows["sublocality"] = rows["sublocality"].where(rows["sublocality"] != "", rows["locality"])
        rows["city"] = rows["city"].map(lambda c: {"new-delhi": "delhi", "new delhi": "delhi", "gurgaon": "gurugram"}.get(
            str(c).strip().lower(), str(c).strip().lower()))
        for name, key in KEYS.items():
            rows[key] = [place_key(c, p) for c, p in zip(rows["city"], rows[name])]
        if "has_society" not in rows:
            rows["has_society"] = (rows["society"] != "").astype(float)
        if "floor_share" not in rows and {"floor", "total_floors"} <= set(rows):
            rows["floor_share"] = (rows["floor"] / rows["total_floors"]).clip(-0.5, 1)
        if "circle_rate_sqft" not in rows:
            get = lambda c: rows[c] if c in rows else pd.Series(np.nan, index=rows.index)  # noqa: E731
            rows["circle_rate_sqft"] = [circle_rate_sqft(c, a, f, s or None, l, sl) for c, a, f, s, l, sl in
                                        zip(rows["city"], rows["area_sqft"], get("total_floors"), rows["society"],
                                            rows["locality"], rows["sublocality"])]
        return rows

    def predict_log(self, X: pd.DataFrame) -> dict:
        lo = self.boosters["p10"].predict(X) - self.widen
        mid = self.boosters["p50"].predict(X)
        hi = self.boosters["p90"].predict(X) + self.widen
        return {"low": np.minimum(lo, mid), "mid": mid, "high": np.maximum(hi, mid)}

    def value_many(self, properties: list[dict]) -> list[dict]:
        rows = self.prepare(pd.DataFrame(properties))
        X = frame(rows, self.encoder, self.meta["categories"])
        q = self.predict_log(X)
        contrib = self.boosters["p50"].predict(X, pred_contrib=True)
        out = []
        for i, prop in enumerate(properties):
            area = float(rows["area_sqft"].iloc[i])
            est, low, high = (float(np.exp(q[k][i]) * area) for k in ("mid", "low", "high"))
            comps = int(X["locality_listings"].iloc[i])
            spread = (high - low) / 2 / est
            confidence = "high" if comps >= 10 and spread <= 0.25 else "medium" if comps >= 3 and spread <= 0.4 else "low"
            rate = rows["circle_rate_sqft"].iloc[i]
            circle = float(rate * area) if rows["city"].iloc[i] in FLAT_MINIMUM_CITIES and not np.isnan(rate) else None
            r = {"model": "property_avm", "model_version": self.version,
                 "estimate": round(est, -3), "low": round(low, -3), "high": round(high, -3),
                 "price_per_sqft": round(est / area), "range_plus_minus_pct": round(100 * spread, 1),
                 "confidence": confidence, "comparables_in_locality": comps,
                 "circle_value": round(circle, -3) if circle else None,
                 "declared_price": prop.get("declared_price"), "value_for_ltv": round(est, -3),
                 "flag": "pass", "reason_code": None, "top_reasons": self._reasons(contrib[i])}
            declared = prop.get("declared_price")
            if declared:
                r["value_for_ltv"] = round(min(float(declared), est), -3)
                if circle and declared < circle:
                    r.update(flag="refer", reason_code="R-PRP-04")
                elif declared > high or confidence == "low":
                    r.update(flag="refer", reason_code="R-PRP-03")
            elif confidence == "low":
                r.update(flag="refer", reason_code="R-PRP-03")
            out.append(r)
        return out

    def value(self, prop: dict) -> dict:
        return self.value_many([prop])[0]

    def _reasons(self, contrib: np.ndarray, k: int = 4) -> list[dict]:
        """What moved the estimate most, as % above or below the model's starting point."""
        groups = {}
        for name, c in zip(FEATURES, contrib[:-1]):
            label = GROUPS.get(name, LABELS[name])
            groups[label] = groups.get(label, 0.0) + float(c)
        top = sorted(groups.items(), key=lambda kv: -abs(kv[1]))[:k]
        return [{"factor": f, "effect_pct": round(100 * (np.exp(c) - 1), 1)} for f, c in top if abs(c) > 0.005]


_loaded: PropertyAVM | None = None


def _model() -> PropertyAVM:
    global _loaded
    if _loaded is None:
        _loaded = PropertyAVM.load()
    return _loaded


def predict(prop: dict) -> dict:
    """Value one property: {"city", "locality", "area_sqft", "bhk", ...; optional "declared_price"}."""
    return _model().value(prop)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Usage: python -m models.property_avm.avm <property.json>")
    print(json.dumps(predict(json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))), indent=2))
