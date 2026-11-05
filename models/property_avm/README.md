# Model 7: Property valuation, AVM (model card)

| | |
|---|---|
| **Job** | Estimates a value range for the property behind the loan: a middle estimate plus a low (P10) to high (P90) range. The *Property* gate (gate 4) uses it for LTV and to catch inflated prices. |
| **Type** | LightGBM regression on price per sq ft (log scale), three boosters for P10 / P50 / P90, and a conformal adjustment so the range holds 80% of prices |
| **Trained on** | **64,756 public listings of flats in 81 Indian cities** ([Kaggle "House Price"](https://www.kaggle.com/datasets/juhibhojani/house-price), 2023), plus **state circle rates**: Delhi's flat rates from the Revenue Department notifications, and Gurugram's 2024 collector rates, read from the official scans |
| **Status** | Trained and tested. **Typical error 12.9%** (median absolute % error) when the locality has other listings, and **18.2%** for a locality it has never seen. The range catches **79–81%** of prices. Weaker on flats under ₹30 lakh, and on a noisier 2020 scrape. |
| **Version** | `avm-v1`, trained 5 Nov 2026 |
| **Owner** | AI/ML member |

## What it reads

The model reads these inputs:
- **City and locality**, plus a sub-locality and society if known
- **Size:** area in sq ft, and whether it's carpet or super area
- **Rooms:** bedrooms, bathrooms and balconies
- **Building:** the floor and the number of floors
- **Property details:** new or resale, parking, view (park, pool or main road), furnishing, facing and ownership

Anything can be missing except **city and area**. The circle rate is looked up for the city (Delhi, Gurugram) and doesn't need to be passed in.

## The data

| Source | Used for | Notes |
|---|---|---|
| **[House Price](https://www.kaggle.com/datasets/juhibhojani/house-price)** (Kaggle, CDLA-Sharing 1.0) | **Training** | 187,531 rows scraped from a property portal in 2023. **About two thirds are exact duplicates**, leaving 68,192 real listings. After removing impossible prices and areas, **64,756 flats in 81 cities** remain: about 2,900 each in the big cities and fewer in smaller ones. |
| **[Housing Prices in Metropolitan Areas of India](https://www.kaggle.com/datasets/ruchi798/housing-prices-in-metropolitan-areas-of-india)** (Kaggle, CC0) | **Outside check** | A different scrape from 2020, covering 6 metros, with 28,295 listings after cleaning. It has fewer fields: price, area, locality, bedrooms, new/resale. |
| [House Price Prediction Challenge](https://www.kaggle.com/datasets/anmolkumar/house-price-prediction-challenge) (Kaggle) | Not used | It's licensed under GPL, which doesn't fit data well, and its coordinates are noisy. |

**These are asking prices on listings, not registered sale prices.** Sellers usually ask more than they get, and some listings are typos. Treat the accuracy below as accuracy against asking prices. Raw files stay in `data/raw/property/`, which Git ignores. `features.py` gives the download commands.

### Circle rates

No state publishes circle rates as open data. They come as notifications, scanned PDFs or lookup portals. What we did:

| City / state | What it gives | Used |
|---|---|---|
| **Delhi** | Revenue Department notifications. For **flats**, the minimum rate depends on plinth area band, DDA/society vs private, and more than four storeys, not on the colony. 2011 rates are from the official notification. The Sep 2014 revision, still in force, raised every rate 1.465×: ₹50,400–76,200 per m², or ₹87,840 above four storeys. | **Yes:** as an input, as the **circle value**, and for the "declared below circle value" check |
| **Gurugram** | Haryana's *Updated Predictive Collector Rates for 2024*, 5 scanned lists from gurugram.gov.in. We OCR'd 82 pages into [data/circle_rates_gurugram.csv](data/circle_rates_gurugram.csv) (`build_circle_rates.py`): 296 colonies and 100 sectors, with 2023-24 and 2024-25 rates per sq yard of **plot**. | **Yes, as an input only.** These are plot rates, not flat values, so no circle value is shown for Gurugram. |
| Noida / Greater Noida | The district's SRO-wise lists (gbnagar.nic.in, 2019 in force, 2025 proposed): 292 scanned pages of Hindi tables | Not yet |
| Maharashtra, Karnataka, Tamil Nadu, Telangana, Gujarat… | Lookup portals (IGR ready reckoner, Kaveri guidance value, TNREGINet, jantri) with no bulk download | Not yet |

What the circle rates show (`reports/circle_rates.csv`):

| City | Listings matched | Typical listing price vs circle value | Listed below circle value |
|---|---|---|---|
| Delhi | 100% (flat formula) | 1.52× | **23%** |
| Gurugram | 63% | 2.58× the plot rate | 5% |

In Delhi, **almost a quarter of flats are listed below the government's minimum value.** That fits Delhi's 2023–25 circle-rate rebate, given because rates had overtaken market prices in many colonies. For a lender, a deal below the circle value means stamp duty is paid on the higher circle value, and possibly part of the price is paid off the books. So the engine refers it (`R-PRP-04`).

The Gurugram list is read from scans, so a few rates are wrong: OCR misreads, and some rows have the wrong property type. Two parts didn't parse: the Harsaru list (scanned sideways) and the Kadipur list (a different layout). That's why the 2024-25 column is only kept when it's within 0.8–2× of the 2023-24 rate.

## How it works

1. **Clean the data.** Remove duplicates, and convert sq yd, sq m and marla to sq ft. Drop impossible rows: area outside 150–15,000 sq ft, or a price per sq ft far outside the city's own spread.
2. **Work out price levels.** For each city, locality, sub-locality and society, the model learns how far its listings sit above or below the city's typical price per sq ft. Places with few listings are pulled towards zero, a technique called smoothing. While training, each listing's level is computed **without its own price** (5-fold), so nothing leaks.
3. **Add the circle rate** where known, as one more input.
4. **Fit three LightGBM models:** P50 for the estimate, and P10 and P90 for the range. 15% of the rows are held back to stop training and to **widen the range just enough that 80% of held-back prices fall inside** (split conformal).
5. **Explain.** Each estimate comes with its biggest factors, from LightGBM's SHAP contributions, as % above or below the starting point. For example: city +62%, society +28%, neighbourhood +22%.

## Results: typical % error

**Typical % error** is the median absolute % gap between the estimate and the listed price. The **baseline** for comparison is the simplest method: the locality's median price per sq ft.

| Check | Typical % error | Baseline | Within ±10% | Within ±20% | Range holds the price | Range width |
|---|---|---|---|---|---|---|
| **Random 20% of listings** (other flats in the locality are known) | **12.9%** | 18.8% | 40% | 68% | **79%** | ±28% |
| **Unseen localities** (20% of localities held out entirely) | **18.2%** | 25.2% | 30% | 54% | **81%** | ±40% |
| Unseen localities in Delhi and Gurugram: **with** circle rates | **20.5%** | – | 25% | 48% | 88% | ±54% |
| Same, **without** circle rates | 22.3% | – | 25% | 46% | 86% | ±56% |
| **Outside source: the 2020 metro scrape** | 45.2% | – | 14% | 26% | 45% | ±35% |
| The same, without Mumbai | 37.7% | – | 16% | 30% | 48% | ±31% |

**By how much local data there is** (random split, `reports/by_locality_data.csv`):

| Listings in the locality | Typical % error | Range holds the price |
|---|---|---|
| 10 or more | **11.5%** | 79% |
| 1 to 9 | 14.5% | 79% |
| None | 19.5% | 81% |

**By loan band** (random split, `reports/by_price_band.csv`; these are the RBI LTV bands):

| Price band | Typical % error | Median estimate vs price |
|---|---|---|
| Up to ₹30 lakh | **18.1%** | **1.14×** (too high) |
| ₹30–75 lakh | 12.0% | 1.02× |
| Above ₹75 lakh | 13.0% | 0.95× |

**By city** (random split, the 48 cities with 50 or more test listings, `reports/by_city.csv`): the typical error runs from 9.4% (Chandigarh) to 19.2% (Kalyan). Among the big cities, Delhi is 13.7%, Gurugram 13.5%, Bengaluru 14.4% and Kolkata 15.8%.

**Key findings:**
- **The model beats the simple baseline by 6–7 points:** 12.9% vs 18.8% where there are comparables, and 18.2% vs 25.2% where there are none.
- **The range is honest.** It holds 79% of prices on new listings and 81% in unseen localities, against an 80% target. It's wider where the model knows less: ±25% with 10+ comparables, ±42% with none.
- **Circle rates help most where there's no local data.** In Delhi and Gurugram's unseen localities they cut the typical error from 22.3% to 20.5%. Where listings exist, the locality levels already carry that information.
- **Affordable flats are the weak spot.** Under ₹30 lakh the error is 18%, and estimates run **14% high**, because the model pulls cheap flats towards their locality's level. This is the PMAY segment, where LTV can reach 90%. That's why the engine lends on **the lower of the declared price and the estimate**, and refers deals priced above the range.
- **The outside check is weak (45%), for three known reasons:**
  - The 2020 scrape files Thane, Navi Mumbai and Mira Road under "Mumbai", and our data lists them separately. Mumbai alone is 91% off; without it, the error is 38%.
  - Prices rose from 2020 to 2023, so our estimates sit 17% above 2020 prices outside Mumbai.
  - **The 2020 data is noisy in itself.** Even its own locality medians predict it with only 29% typical error. Kolkata is 43% and Mumbai 40%, against 19% on our data. Even with each city's level removed, the model is 37% off on it, so the error isn't just about price level.

  So 45% mostly measures that dataset, not the model. Testing on registered sale prices is the real next step.

## Output

```bash
.venv\Scripts\python -m models.property_avm.avm models/property_avm/example_input.json
```
The example is a 1,650 sq ft 3BHK in Sector 65, Gurugram, declared at ₹3.10 crore:
```json
{"model": "property_avm", "model_version": "avm-v1",
 "estimate": 26311000.0, "low": 18363000.0, "high": 29896000.0, "price_per_sqft": 15946,
 "range_plus_minus_pct": 21.9, "confidence": "high", "comparables_in_locality": 97,
 "circle_value": null, "declared_price": 31000000, "value_for_ltv": 26311000.0,
 "flag": "refer", "reason_code": "R-PRP-03",
 "top_reasons": [{"factor": "city", "effect_pct": 61.8}, {"factor": "society", "effect_pct": 28.3},
                 {"factor": "neighbourhood", "effect_pct": 22.4}, {"factor": "carpet or super area", "effect_pct": -8.5}]}
```

**How the engine uses it:**
- **`value_for_ltv`** is the lower of the declared price and the estimate. The LTV caps apply to it: 90% up to ₹30 lakh, 80% up to ₹75 lakh, 75% above.
- **`confidence`** comes from the comparables and the range:
  - **high:** 10 or more listings in the locality, and a range within ±25%
  - **medium:** 3 or more listings, and a range within ±40%
  - **low:** anything else
- **Refer, never reject.** The AVM only asks for a closer look:

| Code | When | Customer message |
|---|---|---|
| `R-PRP-03` | The declared price is above the range, or confidence is low | We need our valuer to visit the property to confirm its value. |
| `R-PRP-04` | The declared price is below the circle value (Delhi) | The agreement value is below the government circle rate for this property. Please check the sale agreement. |

A physical valuation by an empanelled valuer is still required before disbursal under NHB/RBI rules. The AVM decides how closely that valuation needs checking, and catches inflated prices early.

## Run it

```bash
.venv\Scripts\python -m pip install -r models/property_avm/requirements.txt
```
```bash
.venv\Scripts\python -m models.property_avm.train
```
Training takes about 12 minutes. Download the two Kaggle files first, as `features.py` shows. To rebuild the Gurugram circle rates, download the PDFs (`build_circle_rates.py` lists them), then run:
```bash
.venv\Scripts\python -m models.property_avm.build_circle_rates --ocr
```

**Tests:** 7 tests, run by `.venv\Scripts\python -m pytest`. They use synthetic listings, so they don't need the Kaggle data. They cover:
- **parsing** of crore/lakh prices, area units and floors
- **locality matching**, in any word order
- the **Delhi circle-rate formula**
- **Gurugram** sector lists and "DLF Phase II"-style names
- **accuracy**, and range coverage between 72% and 88%
- **the estimate**: it sits inside the range and grows with area
- **all three engine flags**

**Model files:**
- The boosters are LightGBM text files written with LF line endings. `.gitattributes` keeps Git from converting them on Windows.
- `avm.json` holds the price levels for each locality and society. These are aggregates of the CDLA-Sharing listings, so credit that dataset if you share them.

## Next steps

- **Test against registered sale prices,** not asking prices: state IGR transaction data (Maharashtra and Karnataka publish some), and our own valuers' reports once the platform runs.
- **More circle rates:** Noida/Greater Noida (OCR of the district's Hindi scans), the Maharashtra ready reckoner and Karnataka guidance values. Also Gurugram's separate group-housing (flat) rates, which would give a real circle value there.
- **Locations:** add latitude/longitude, so nearby localities can help each other instead of each standing alone.
- **Affordable segment:** recalibrate below ₹30 lakh, or train on that band separately.
