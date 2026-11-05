"""State circle rates: the government's minimum value for stamp duty, used by the valuation model.

Circle rates go by many names: circle rate (Delhi, UP), collector rate (Haryana), ready
reckoner (Maharashtra), guidance value (Karnataka), jantri (Gujarat). No state publishes
them as open data. They come as notifications, scanned PDFs or lookup portals. We use two:

* Delhi, flats: Revenue Department notifications. The flat rate depends on plinth area,
  on DDA / co-operative / group-housing versus private colony, and on more than four
  storeys. It does not depend on the colony. 2011 rates are in the official notification
  (revenue.delhi.gov.in, circle_rate_notification_4_2_11.pdf, and the 15-11-2011
  notification). The 23-Sep-2014 revision, still in force, raised every flat rate by 46.5%.
  50,400 / 54,480 / 76,200 per sq m are as reported by the press; 66,240 and 87,840 follow
  the same 1.465 factor.
* Gurugram: Haryana's "Updated Predictive Collector Rates for 2024" (gurugram.gov.in,
  Tehsil Gurugram and sub-tehsils Wazirabad, Badshahpur and Harsaru). The scans are read
  with OCR into data/circle_rates_gurugram.csv by build_circle_rates.py. Rates are per
  sq yard of *residential plot* for each colony or sector, with both the 2023-24 and
  2024-25 columns.

Other cities get no circle rate (NaN), and the model copes with that.
"""
from __future__ import annotations

import re
from functools import lru_cache
from pathlib import Path

import numpy as np
import pandas as pd

HERE = Path(__file__).resolve().parent
GURUGRAM_CSV = HERE / "data" / "circle_rates_gurugram.csv"
SQFT_PER_SQM = 10.7639
SQFT_PER_SQYD = 9.0
# Where the rate is the legal minimum value of a *flat* (so a circle value and the
# "declared below circle value" check make sense). Gurugram's are plot rates: an input only.
FLAT_MINIMUM_CITIES = {"delhi"}

# Delhi, 2014: Rs per sq m of plinth area, DDA / co-operative / group housing societies
DELHI_FLAT_BANDS_SQM = [(30, 50_400), (50, 54_480), (100, 66_240), (np.inf, 76_200)]
DELHI_PRIVATE_FACTORS = [1.10, 1.15, 1.20, 1.25]   # same bands, private colonies
DELHI_MULTISTOREY_SQM = 87_840                      # buildings of more than four storeys
DELHI_PRIVATE_BUILDER_MULTISTOREY = 1.25
_SOCIETY = re.compile(r"\b(dda|cghs|co ?-?op|cooperative|group housing|society|apartments?|awas|enclave)\b", re.I)


def delhi_flat_rate_sqft(area_sqft: float, total_floors: float | None, society: str | None) -> float:
    """Minimum value per sq ft of a Delhi flat (the listing's area is used as the plinth area)."""
    if not area_sqft or np.isnan(area_sqft):
        return np.nan
    society_flat = bool(society) and bool(_SOCIETY.search(str(society)))
    if total_floors is not None and not np.isnan(total_floors) and total_floors > 4:
        rate = DELHI_MULTISTOREY_SQM * (1.0 if society_flat else DELHI_PRIVATE_BUILDER_MULTISTOREY)
    else:
        sqm = area_sqft / SQFT_PER_SQM
        i = next(k for k, (upper, _) in enumerate(DELHI_FLAT_BANDS_SQM) if sqm <= upper)
        rate = DELHI_FLAT_BANDS_SQM[i][1] * (1.0 if society_flat else DELHI_PRIVATE_FACTORS[i])
    return rate / SQFT_PER_SQM


_ROMAN = {"i": "1", "ii": "2", "iii": "3", "iv": "4", "v": "5"}
_DROP = {"gurgaon", "gurugram", "the", "of", "city", "new"}


def squash(text) -> str:
    """'DLF City Phase 2', 'DLFPHASEII' and 'dlf phase-ii' all become 'dlfphase2'."""
    words = [_ROMAN.get(w, w) for w in re.findall(r"[a-z0-9]+", str(text or "").lower()) if w not in _DROP]
    s = "".join(words)
    return re.sub(r"phase(iii|ii|iv|v|i)(?![a-z])", lambda m: "phase" + _ROMAN[m.group(1)], s)


@lru_cache(maxsize=1)
def gurugram_table() -> pd.DataFrame | None:
    if not GURUGRAM_CSV.exists():
        return None
    t = pd.read_csv(GURUGRAM_CSV)
    t = t[t["use"] == "residential"].copy()
    t["key"] = t["colony"].map(squash)
    t["sector"] = t["colony"].str.extract(r"^Sector (\d+[A-Z]?)$", expand=False).str.lower()
    return t


def gurugram_rate_sqft(*places) -> float:
    """Collector rate (2023-24, per sq ft of *plot*) for the first place that matches a sector or colony."""
    t = gurugram_table()
    if t is None:
        return np.nan
    for place in places:
        key = squash(place)
        if len(key) < 4:
            continue
        sector = re.search(r"\bsector[\s-]*(\d+[a-z]?)\b", str(place).lower())
        if sector:
            hit = t[t["sector"] == sector.group(1)]
        else:
            hit = t[(t["key"] == key) | (t["key"].str.len().ge(6) & t["key"].map(lambda k: k in key))
                    | ((len(key) >= 6) & t["key"].str.contains(key, regex=False))]
        if len(hit):
            return float(hit["rate_2023_24"].median()) / SQFT_PER_SQYD
    return np.nan


def circle_rate_sqft(city: str, area_sqft: float, total_floors: float | None = None, society: str | None = None,
                     locality: str | None = None, sublocality: str | None = None) -> float:
    if city == "delhi":
        return delhi_flat_rate_sqft(area_sqft, total_floors, society)
    if city == "gurugram":
        return gurugram_rate_sqft(locality, sublocality, society)
    return np.nan


def add_circle_rates(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    get = lambda col: df[col] if col in df else pd.Series(np.nan, index=df.index)  # noqa: E731
    df["circle_rate_sqft"] = [circle_rate_sqft(c, a, f, s, l, sl) for c, a, f, s, l, sl in
                              zip(df["city"], df["area_sqft"], get("total_floors"), get("society"),
                                  get("locality"), get("sublocality"))]
    df["circle_value"] = df["circle_rate_sqft"] * df["area_sqft"]
    return df
