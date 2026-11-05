# Model 1: Credit scorecard (model card)

| | |
|---|---|
| **Job** | Gives each applicant a 300–900 credit score and a grade from A to E. This drives the *Risk grade* gate (gate 7). |
| **Type** | Points scorecard: optimal binning, weight of evidence and logistic regression |
| **Trained on** | [L&T Vehicle Loan Default](https://www.kaggle.com/datasets/mamtadhaker/lt-vehicle-loan-default-prediction): 2.33 lakh real Indian loans. [Home Credit](https://www.kaggle.com/competitions/home-credit-default-risk) is also supported. |
| **Status** | Trained and validated. Accuracy is **weak** on this data, so read the [results](#results-on-lt-data) before using it. |
| **Version** | `scorecard-v1`, trained 5 Nov 2026 |
| **Owner** | AI/ML member |

## How it works

1. **Bins.** Each input is split into ranges. For numbers, the default rate only rises or only falls from one range to the next, so the points always make sense. A higher bureau score never costs points.
2. **Weight of evidence.** Each range gets a number showing how much safer or riskier it is than average.
3. **Selection.** Inputs with an information value below 0.02 barely predict default, so we drop them. A logistic regression then learns how much each remaining input matters. If an input's direction comes out reversed, the model drops it, so every input can still be explained.
4. **Points.** An applicant who is average on every input scores **650**. Each input then adds or takes away points. Every **50 points doubles** the odds of repaying.
5. **Grade and flag.** These are the same bands as in the report:

| Grade | Score | Flag for the engine | Reason code |
|---|---|---|---|
| A | 760–900 | `pass` | – |
| B | 700–759 | `pass` | – |
| C | 650–699 | `refer` (an officer reviews it) | `R-RSK-01` |
| D | 600–649 | `reject` | `R-RSK-02` |
| E | 300–599 | `reject` | `R-RSK-02` |

The inputs that lost the most points become the **top reasons** that Nirnay shows the customer and the officer.

## Data

**L&T Vehicle Loan Default** (`--dataset lt`, the default):
- **What it is:** two-wheeler loans from L&T Financial Services, published on Kaggle from an L&T and Analytics Vidhya hackathon.
- **Size:** 2,33,154 loans.
- **Target:** default on the **first EMI**. 21.7% of loans defaulted.
- **Bureau score:** included (`PERFORM_CNS.SCORE`). Half the borrowers have **no bureau history**.
- **Licence:** listed as "Other". We cite it and never upload the data. Git ignores `data/raw/`.

| Input | Built from (L&T column) | Nirnay equivalent | Group | Used? |
|---|---|---|---|---|
| `bureau_score` | `PERFORM_CNS.SCORE` (scores under 300 are "no score" codes and count as missing) | CIBIL / CRIF / Experian score | Repayment history | **Yes** |
| `credit_history_years` | `CREDIT.HISTORY.LENGTH` | Years since first loan | Repayment history | **Yes** |
| `loan_amount` | `disbursed_amount` | Loan amount asked | Affordability | **Yes** |
| `ltv` | `ltv` | Loan ÷ property value | Collateral | **Yes** |
| `bureau_status` | Score code: scored / no history / not scored | New-to-credit flag | Repayment history | No (IV 0.017) |
| `active_accounts` | `PRI.` + `SEC.ACTIVE.ACCTS` | Live loans in the bureau report | Repayment history | No (IV 0.019) |
| `age_years` | `DisbursalDate` − `Date.of.Birth` | Age | Stability | No (IV 0.012) |
| `new_accounts_6m`, `overdue_accounts`, `recent_delinquencies`, `enquiries` | Bureau counts | Same | Repayment history | No (IV 0.006–0.011) |
| `existing_emi` | `PRIMARY.` + `SEC.INSTAL.AMT` | Existing EMIs | Affordability | No (IV 0.006) |
| `employment_type` | `Employment.Type` | Salaried / self-employed | Stability | No (IV 0.005) |

**Left out on purpose:**
- **State, pincode and branch:** they show where someone lives, which can stand in for community or caste.
- **Dealer, manufacturer and staff IDs:** they describe who handled the loan, not the borrower.
- **Aadhaar, PAN and other ID flags:** these belong to the Identity gate. Aadhaar is voluntary, so not giving it must never cost points.

**Home Credit** (`--dataset home_credit`): Home Credit Default Risk, consumer loans from outside India. It uses three outside scores, payment-to-income, loan-to-income, loan-to-price, owning property, years employed, age and employment type. It leaves out gender, marital status, family size, education and region. Kaggle only allows the download after you join the competition, and that needs a phone-verified account.

## Results on L&T data

The model trained on **Aug–Sep 2018** loans (1,34,790 rows, 20.4% default) and was tested on **Oct 2018** loans it never saw (98,364 rows, 23.5% default). This "out of time" test is stricter than a random split, and closer to how a model behaves after it goes live.

| | Test (Oct 2018) | Train (Aug–Sep 2018) |
|---|---|---|
| AUC | **0.595** | 0.612 |
| Gini | **0.19** | 0.22 |
| KS | **0.14** | 0.17 |

The test results are only a little below train, so the model is not overfitting. But **0.19 Gini is weak**: lenders usually look for 0.4 or more. The reasons:
- First-EMI default on two-wheelers is hard to predict.
- Half the borrowers have no bureau history.
- Our strongest inputs are only "weak" by information value: LTV 0.074, bureau score 0.069, loan amount 0.051.
- Public solutions that score higher usually rely on branch, dealer and staff IDs, which we leave out on purpose.

**Grades on the test set** (`reports/grades.csv`):

| Grade | Applicants | Share | Actual default | Predicted default |
|---|---|---|---|---|
| A | 0 | 0% | – | – |
| B | 6,678 | 6.8% | 12.8% | 9.1% |
| C | 42,183 | 42.9% | 19.5% | 16.3% |
| D | 49,465 | 50.3% | 28.4% | 25.7% |
| E | 38 | 0.04% | 36.8% | 36.0% |

**What these numbers show:**
- **Default rates rise steadily from B to E**, so the grades rank risk correctly.
- **Predictions run about 3 points low.** October's default rate jumped to 23.5%, from 20.4% in the training months. Before live use, the model needs **recalibrating** on recent loans. Monitoring should catch drift like this.
- **Few approvals.** Very few applicants reach A or B, because this book's average default rate (22%) is far above what a home lender accepts. The grade bands are anchored to that average, so a real lender would recalibrate them on its own loan book.

**Fairness** (`reports/fairness.csv`, approve = grade A or B, groups with at least 500 test applicants):
- **Age:** under-30s are approved 4.9% of the time and 60+ 10.0%, a ratio of 0.49. That fails the four-fifths rule, which needs at least 0.8. Ages 30–44 have a ratio of 0.78. Age isn't an input, so the gap comes from shorter credit histories and lower bureau scores among younger borrowers. Their default rate is higher too: 24.9% against 19.7% for 60+.
- **State:** 10 of the 18 states with enough test applicants fall below 0.8. State isn't an input either. Some of the gap tracks real risk (one state defaults at 35%), but it **must be investigated before going live**.
- **New-to-credit applicants:** Nirnay's design already sends them to an officer with a bank-statement review (`R-BUR-04`) rather than relying on this score alone.

**Bottom line for the hackathon:** the scorecard works end to end. It's explainable, every point can be traced, it's tested and the fairness checks run. On this data its accuracy is weak, and we say so openly. A lender's own home-loan book would give much stronger inputs: income, FOIR and repayment history.

## Output (what the decision engine receives)

```json
{
  "model": "credit_scorecard",
  "model_version": "scorecard-v1",
  "trained_on": "lt",
  "score": 715,
  "grade": "B",
  "flag": "pass",
  "reason_code": null,
  "probability_of_default": 0.0947,
  "base_score": 650,
  "points": [
    {"input": "bureau_score", "label": "Bureau score", "group": "Repayment history",
     "value": 742, "bin": "738 or more", "points": 38},
    {"input": "credit_history_years", "label": "Years since first loan", "group": "Repayment history",
     "value": 5.5, "bin": "4.54 or more", "points": 17},
    {"input": "loan_amount", "label": "Loan amount (₹)", "group": "Affordability",
     "value": 48000, "bin": "47,375 to 50,315", "points": 2},
    {"input": "ltv", "label": "Loan-to-value (%)", "group": "Collateral",
     "value": 70, "bin": "69.3 to 72.9", "points": 8}
  ],
  "top_reasons": []
}
```

This is `example_input.json`: 650 + 38 + 17 + 2 + 8 = **715**. The score always equals `base_score` plus the sum of `points`.

**Input rules:**
- A missing input scores as its own "missing" bin.
- A bureau score below 300 counts as "no score".
- An unknown category scores 0.

For example, an applicant with no bureau history and 90% LTV scores **613 (grade D)**. The top reasons would be "Loan-to-value (89.2 or more): −19 points" and "Bureau score (missing): −7 points".

## Run it

1. **Data.** Put the L&T `train.csv` in `data/raw/lt_vehicle_loan/`. Git ignores this folder.
2. **Python.** Set it up once, from the repo root:
   ```bash
   py -3.11 -m venv .venv
   .venv\Scripts\python -m pip install -r models/credit_scorecard/requirements.txt
   ```
3. **Train.** This takes about 6 seconds:
   ```bash
   .venv\Scripts\python -m models.credit_scorecard.train
   ```
   For Home Credit, add `--dataset home_credit`.
4. **Score an example:**
   ```bash
   .venv\Scripts\python -m models.credit_scorecard.scorecard models/credit_scorecard/example_input.json
   ```
5. **Run the tests.** There are 32, run on made-up data for both datasets:
   ```bash
   .venv\Scripts\python -m pytest
   ```

Training writes `artifacts/scorecard.json` (the model) and the `reports/` files. The reports hold only bins, points, rates and counts, never any loan records. Training also checks that `scorecard.json` gives exactly the same answers as the fitted model, and stops with an error if it doesn't.

## Next steps

- **Recalibrate** on the most recent month, and add drift monitoring (PSI and calibration by month).
- **Train on Home Credit** once the Kaggle account is phone-verified, and compare the two.
- **Build model 2,** the LightGBM challenger with SHAP, on the same data. It can pick up combinations of inputs that a scorecard can't.
