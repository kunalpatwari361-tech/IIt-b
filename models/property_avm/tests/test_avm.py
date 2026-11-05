import numpy as np
import pandas as pd
import pytest

from models.property_avm.avm import PropertyAVM
from models.property_avm.build_circle_rates import sectors
from models.property_avm.circle_rates import SQFT_PER_SQM, delhi_flat_rate_sqft, squash
from models.property_avm.features import _amount, _area, _floor, clean, place_key
from models.property_avm.train import train

CITIES = {"delhi": 12000, "pune": 8000, "jaipur": 4500}


def synthetic_listings(n=3000, seed=0) -> pd.DataFrame:
    """Listings where price per sq ft = city level x locality level x small effects x noise."""
    rng = np.random.default_rng(seed)
    city = rng.choice(list(CITIES), n)
    loc_no = rng.integers(0, 25, n)
    loc_level = np.exp((loc_no - 12) / 25)          # localities from about 0.6x to 1.6x the city level
    area = rng.uniform(450, 2500, n).round()
    floors = rng.choice([3, 4, 12, 20], n).astype(float)
    new = rng.integers(0, 2, n).astype(float)
    ppsf = np.array([CITIES[c] for c in city]) * loc_level * (1 + 0.08 * new) * (area / 1000) ** -0.1
    ppsf *= np.exp(rng.normal(0, 0.08, n))
    df = pd.DataFrame({
        "city": city, "price": ppsf * area, "area_sqft": area, "is_carpet_area": rng.integers(0, 2, n).astype(float),
        "bhk": np.clip(np.round(area / 550), 1, 5), "bathrooms": np.clip(np.round(area / 600), 1, 5), "balconies": 1.0,
        "floor": np.minimum(rng.integers(0, 20, n), floors), "total_floors": floors, "parking": 1.0, "covered_parking": 1.0,
        "is_new": new, "overlooks_park": 0.0, "overlooks_pool": 0.0, "overlooks_main_road": 0.0,
        "furnishing": rng.choice(["Furnished", "Semi-Furnished", "Unfurnished"], n), "facing": "East", "ownership": "Freehold",
        "society": np.where(rng.random(n) < 0.5, "dda green apartments", None),
        "locality": [f"Locality {i}" for i in loc_no], "sublocality": [f"Locality {i}" for i in loc_no], "source": "test"})
    df["floor_share"] = df["floor"] / df["total_floors"]
    df["has_society"] = df["society"].notna().astype(float)
    return clean(df)


@pytest.fixture(scope="module")
def trained(tmp_path_factory):
    out = tmp_path_factory.mktemp("avm")
    result = train(synthetic_listings(), None, out_dir=out, quick=True)
    return result, PropertyAVM.load(out / "artifacts")


def test_parsers():
    assert _amount(pd.Series(["1.40 Cr", "42 Lac", "Call for Price"])).tolist()[:2] == [1.4e7, 4.2e6]
    assert _area(pd.Series(["110 sqyrd", "1,200 sqft"])).tolist() == [990.0, 1200.0]
    floor, total = _floor(pd.Series(["Ground out of 4", "3 out of 10", "Upper Basement out of 2"]))
    assert floor.tolist() == [0, 3, -1] and total.tolist() == [4, 10, 2]


def test_locality_key_ignores_word_order():
    assert place_key("delhi", "Sector 10 Dwarka") == place_key("delhi", "Dwarka Sector 10") == "delhi|10 dwarka sector"


def test_delhi_circle_rates_follow_the_notification():
    sqft = 60 * SQFT_PER_SQM   # a 60 sq m flat
    assert delhi_flat_rate_sqft(sqft, 4, "DDA Sanskriti Apartments") == pytest.approx(66_240 / SQFT_PER_SQM)
    assert delhi_flat_rate_sqft(sqft, 4, None) == pytest.approx(66_240 * 1.20 / SQFT_PER_SQM)
    assert delhi_flat_rate_sqft(sqft, 12, None) == pytest.approx(87_840 * 1.25 / SQFT_PER_SQM)


def test_gurugram_names_and_sector_lists():
    assert squash("DLF City Phase 2") == squash("DLFPHASEII") == "dlfphase2"
    assert sectors("Sector 626566697071") == ["62", "65", "66", "69", "70", "71"]
    assert sectors("Sector 104TO106109 TO115") == ["104", "105", "106", "109", "110", "111", "112", "113", "114", "115"]


def test_accuracy_and_range_coverage(trained):
    result, _ = trained
    m = result["metrics"]["checks"]["random_split"]
    assert m["typical_pct_error"] < 10
    assert 0.72 <= m["range_coverage"] <= 0.88
    assert result["metrics"]["checks"]["unseen_localities"]["typical_pct_error"] > m["typical_pct_error"]


def test_estimate_inside_range_and_grows_with_area(trained):
    _, avm = trained
    base = {"city": "pune", "locality": "Locality 20", "bhk": 2, "is_new": 1}
    small, big = avm.value_many([dict(base, area_sqft=800), dict(base, area_sqft=1600)])
    assert small["low"] <= small["estimate"] <= small["high"]
    assert big["estimate"] > small["estimate"]
    assert small["top_reasons"] and small["confidence"] in {"high", "medium"}


def test_engine_flags(trained):
    _, avm = trained
    flat = {"city": "pune", "locality": "Locality 12", "area_sqft": 1000, "bhk": 2}
    fair = avm.value(flat)
    assert fair["flag"] == "pass" and fair["value_for_ltv"] == fair["estimate"]
    high = avm.value(dict(flat, declared_price=fair["high"] * 1.3))
    assert high["flag"] == "refer" and high["reason_code"] == "R-PRP-03"
    assert high["value_for_ltv"] == fair["estimate"]           # lend on the lower of price and estimate
    delhi = avm.value({"city": "delhi", "locality": "Locality 3", "area_sqft": 1000, "total_floors": 4,
                       "society": "DDA Green Apartments", "declared_price": 1_000_000})
    assert delhi["circle_value"] and delhi["reason_code"] == "R-PRP-04"    # declared below the circle value
    unknown = avm.value({"city": "pune", "locality": "Nowhere Nagar", "area_sqft": 1000})
    assert unknown["comparables_in_locality"] == 0 and unknown["confidence"] == "low" and unknown["flag"] == "refer"
