"""Load and clean public Indian property listings for the Nirnay valuation model (model 7).

Main data: "House Price" (Kaggle, juhibhojani/house-price, CDLA-Sharing 1.0), scraped
from a property portal in 2023: 187,531 rows across about 80 Indian cities. About two
thirds are exact duplicates, so 68,192 real listings remain. All of them are flats.

Outside check: "Housing Prices in Metropolitan Areas of India" (Kaggle,
ruchi798/housing-prices-in-metropolitan-areas-of-india, CC0), a different scrape
from 2020 covering 6 metros.

Both are *asking prices* on listings, not registered sale prices. See the model card.
Download them into data/raw/property/houseprice and data/raw/property/metros (Git ignores data/raw):
    curl -L -o archive.zip https://www.kaggle.com/api/v1/datasets/download/juhibhojani/house-price
    curl -L -o archive.zip https://www.kaggle.com/api/v1/datasets/download/ruchi798/housing-prices-in-metropolitan-areas-of-india
"""
from __future__ import annotations

import re
from pathlib import Path

import numpy as np
import pandas as pd

ROOT = Path(__file__).resolve().parents[2]
RAW = ROOT / "data" / "raw" / "property"
HOUSEPRICE_CSV = RAW / "houseprice" / "house_prices.csv"
METROS_DIR = RAW / "metros"
SQFT_PER = {"sqft": 1.0, "sqyrd": 9.0, "sqm": 10.7639, "marla": 272.25, "kanal": 5445.0, "ground": 2400.0,
            "cent": 435.6, "acre": 43560.0}
CITY_NAMES = {"new-delhi": "delhi", "gurgaon": "gurugram"}
METRO_FILES = {"Bangalore": "bangalore", "Chennai": "chennai", "Delhi": "delhi", "Hyderabad": "hyderabad",
               "Kolkata": "kolkata", "Mumbai": "mumbai"}

NUMERIC = ["area_sqft", "is_carpet_area", "bhk", "bathrooms", "balconies", "floor", "total_floors",
           "floor_share", "parking", "covered_parking", "is_new", "overlooks_park", "overlooks_pool",
           "overlooks_main_road", "has_society", "circle_rate_sqft"]
CATEGORICAL = ["city", "furnishing", "facing", "ownership"]
TARGET_ENCODED = ["city_locality", "city_sublocality", "city_society"]
# Any input the engine may not have is allowed to be missing; LightGBM sends missing values down a learned branch.


def _amount(s: pd.Series) -> pd.Series:
    m = s.str.extract(r"([\d.]+)\s*(Lac|Cr)", expand=True)
    return pd.to_numeric(m[0], errors="coerce") * m[1].map({"Lac": 1e5, "Cr": 1e7})


def _area(s: pd.Series) -> pd.Series:
    m = s.str.extract(r"([\d.,]+)\s*([A-Za-z]+)", expand=True)
    return pd.to_numeric(m[0].str.replace(",", ""), errors="coerce") * m[1].map(SQFT_PER)


def _count(s: pd.Series) -> pd.Series:
    digits = s.astype("string").str.replace(">", "", regex=False).str.extract(r"(\d+)")[0]
    return pd.to_numeric(digits, errors="coerce").astype("float64")


def _floor(s: pd.Series) -> tuple[pd.Series, pd.Series]:
    s = s.astype("string").str.strip()
    first = s.str.split(" out of ").str[0]
    floor = pd.to_numeric(first, errors="coerce").astype("float64")
    floor = floor.mask(first.str.contains("Ground", na=False), 0)
    floor = floor.mask(first.str.contains("Upper Basement", na=False), -1)
    floor = floor.mask(first.str.contains("Lower Basement", na=False), -2)
    total = pd.to_numeric(s.str.extract(r"out of (\d+)")[0], errors="coerce").astype("float64")
    return floor, total


def clean_place(text) -> str:
    if text is None or (isinstance(text, float) and np.isnan(text)) or pd.isna(text):
        return ""
    return re.sub(r"\s+", " ", str(text)).strip(" ,.-").lower()


def place_key(city: str, place) -> str:
    """'Sector 10 Dwarka' and 'Dwarka Sector 10' get the same key: city plus the sorted words."""
    words = sorted(set(re.findall(r"[a-z0-9]+", clean_place(place))))
    return f"{city}|{' '.join(words)}" if words else ""


def _locality(df: pd.DataFrame) -> tuple[pd.Series, pd.Series]:
    """The portal's locality ('Dwarka Sector 11') from the description, else from the title."""
    from_desc = df["Description"].astype("string").str.extract(r"for (?:sale|resale) in ([^,.]+),", expand=False)
    rest = df["Title"].astype("string").str.split(" for sale ", n=1).str[1].fillna("").str.replace(r"^in ", "", regex=True)
    society = df["Society"].astype("string").fillna("")
    rest = pd.Series([r.replace(s, "", 1) if s else r for r, s in zip(rest, society)], index=df.index)
    sub, main = [], []
    for r, city in zip(rest, df["location"].astype("string").fillna("")):
        city_words = set(city.replace("-", " ").split()) | {"new delhi", "delhi", "gurgaon", "gurugram"}
        parts = [p.strip() for p in r.split(",") if p.strip()]
        parts = [p for p in parts if p.lower() not in city_words and not any(p.lower() == w or p.lower().endswith(" " + w) and len(p.split()) <= 2 for w in city_words)] or parts
        sub.append(parts[0] if parts else "")
        main.append(parts[-1] if parts else "")
    main = from_desc.fillna(pd.Series(main, index=df.index))
    return main.map(clean_place), pd.Series(sub, index=df.index).map(clean_place)


def load_houseprice(path: Path = HOUSEPRICE_CSV) -> pd.DataFrame:
    if not Path(path).exists():
        raise FileNotFoundError(f"{path} is missing. See the download notes at the top of features.py.")
    raw = pd.read_csv(path).drop(columns="Index").drop_duplicates()
    out = pd.DataFrame(index=raw.index)
    out["city"] = raw["location"].map(lambda c: CITY_NAMES.get(c, c))
    out["price"] = _amount(raw["Amount(in rupees)"])
    carpet, super_ = _area(raw["Carpet Area"]), _area(raw["Super Area"])
    out["area_sqft"] = carpet.fillna(super_)
    out["is_carpet_area"] = carpet.notna().astype(float).where(out["area_sqft"].notna())
    out["bhk"] = _count(raw["Title"].str.extract(r"^(\d+|>\s*\d+)\s*BHK")[0])
    out.loc[raw["Title"].str.startswith("Studio"), "bhk"] = 0.5
    out["bathrooms"], out["balconies"] = _count(raw["Bathroom"]), _count(raw["Balcony"])
    out["floor"], out["total_floors"] = _floor(raw["Floor"])
    out["floor_share"] = (out["floor"] / out["total_floors"]).clip(-0.5, 1)
    park = raw["Car Parking"].astype("string")
    out["parking"] = _count(park).clip(upper=4)
    out["covered_parking"] = park.str.contains("Covered", na=False).astype(float).where(park.notna())
    out["is_new"] = raw["Transaction"].map({"New Property": 1.0, "Resale": 0.0})
    over = raw["overlooking"].astype("string")
    for flag, word in (("overlooks_park", "Garden"), ("overlooks_pool", "Pool"), ("overlooks_main_road", "Main Road")):
        out[flag] = over.str.contains(word, na=False).astype(float).where(over.notna())
    out["furnishing"], out["facing"], out["ownership"] = raw["Furnishing"], raw["facing"], raw["Ownership"]
    out["society"] = raw["Society"].map(clean_place).replace("", np.nan)
    out["has_society"] = out["society"].notna().astype(float)
    out["locality"], out["sublocality"] = _locality(raw)
    out["source"] = "houseprice_2023"
    return clean(out)


def clean(df: pd.DataFrame) -> pd.DataFrame:
    """Drop listings with no price or area, and the impossible ones (typos in price or area)."""
    df = df[df["price"].notna() & df["area_sqft"].notna()].copy()
    df["price_per_sqft"] = df["price"] / df["area_sqft"]
    ok = (df["area_sqft"].between(150, 15000) & df["price"].between(3e5, 5e9) & df["price_per_sqft"].between(400, 150000))
    df = df[ok].copy()
    # Within each city, drop price per sq ft far outside the city's own spread (likely unit errors).
    lp = np.log(df["price_per_sqft"])
    med = lp.groupby(df["city"]).transform("median")
    mad = (lp - med).abs().groupby(df["city"]).transform("median").clip(lower=0.05)
    df = df[(lp - med).abs() <= 5 * 1.4826 * mad].copy()
    df["log_ppsf"] = np.log(df["price_per_sqft"])
    for col in ("locality", "sublocality", "society"):
        if col not in df:
            df[col] = np.nan
    df["city_locality"] = [place_key(c, p) for c, p in zip(df["city"], df["locality"])]
    df["city_sublocality"] = [place_key(c, p) for c, p in zip(df["city"], df["sublocality"])]
    df["city_society"] = [place_key(c, p) for c, p in zip(df["city"], df["society"])]
    return df.reset_index(drop=True)


def load_metros(folder: Path = METROS_DIR) -> pd.DataFrame | None:
    """The 2020 CC0 scrape of 6 metros, in the same columns (what it lacks stays missing)."""
    frames = []
    for name, city in METRO_FILES.items():
        p = Path(folder) / f"{name}.csv"
        if not p.exists():
            continue
        raw = pd.read_csv(p)
        df = pd.DataFrame({"city": city, "price": raw["Price"].astype(float), "area_sqft": raw["Area"].astype(float),
                           "bhk": raw["No. of Bedrooms"].astype(float),
                           "is_new": (1 - raw["Resale"]).astype(float),
                           "locality": raw["Location"].map(clean_place), "sublocality": raw["Location"].map(clean_place)})
        df["source"] = "metros_2020"
        frames.append(df)
    if not frames:
        return None
    return clean(pd.concat(frames, ignore_index=True)).drop_duplicates()
