# Model 1: Credit scorecard (model card)

| | |
|---|---|
| **Job** | Gives each applicant a 300–900 credit score and a grade from A to E. This drives the *Risk grade* gate (gate 7). |
| **Type** | Points scorecard: optimal binning, weight of evidence and logistic regression |
| **Status** | Code and tests done. **Not yet trained on real data**: see [Train it](#train-it). |
| **Version** | `scorecard-v1` |
| **Owner** | AI/ML member |

## How it works

1. **Bins.** Each input is split into ranges. For numbers, the default rate only rises or only falls from one range to the next, so the points always make sense. A better bureau score never costs points.
2. **Weight of evidence.** Each range gets a number showing how much safer or riskier it is than average.
3. **Logistic regression** learns how much each input matters. If an input's direction comes out reversed, the model drops it, so every input can still be explained.
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

## Inputs

We train on the [Home Credit Default Risk](https://www.kaggle.com/competitions/home-credit-default-risk) dataset: about 3 lakh real loan applications, published by Home Credit on Kaggle. Each column below stands for data Nirnay collects in India.

| Input | Built from (Home Credit) | Nirnay equivalent in India | Group |
|---|---|---|---|
| `bureau_score_1/2/3` | `EXT_SOURCE_1/2/3` (scores from outside data sources, 0–1) | CIBIL, Experian and CRIF scores | Repayment history |
| `payment_to_income` | `AMT_ANNUITY ÷ AMT_INCOME_TOTAL` | FOIR for this loan | Affordability |
| `loan_to_income` | `AMT_CREDIT ÷ AMT_INCOME_TOTAL` | Loan ÷ yearly income | Affordability |
| `loan_to_price` | `AMT_CREDIT ÷ AMT_GOODS_PRICE` | LTV (loan ÷ property value) | Collateral |
| `owns_property` | `FLAG_OWN_REALTY` | Owns other property | Collateral |
| `years_employed` | `DAYS_EMPLOYED` (the "not working" code becomes missing) | Years in current job or business | Stability |
| `age_years` | `DAYS_BIRTH` | Age | Stability |
| `employment_type` | `NAME_INCOME_TYPE` grouped as salaried, self-employed, pensioner or other | Salaried / self-employed | Stability |

**Left out on purpose:**
- **Gender, marital status and family size:** decisions must not depend on them, and they can stand in for gender.
- **Education:** can stand in for social background.
- **Region and city flags:** can stand in for community or caste.
- **Raw rupee amounts:** Home Credit amounts are not in rupees, so we use ratios instead.

Gender is read **only** to check fairness afterwards.

**Limitation to state honestly:** Home Credit is a consumer-lending dataset from outside India, and `EXT_SOURCE` scores are not CIBIL scores. This model proves the method, the explanations and the governance. A live lender would retrain the same code on its own Indian loan book and bureau data before going live.

## Output (what the decision engine receives)

```json
{
  "model": "credit_scorecard",
  "model_version": "scorecard-v1",
  "score": 712,
  "grade": "B",
  "flag": "pass",
  "reason_code": null,
  "probability_of_default": 0.031,
  "base_score": 650,
  "points": [{"input": "bureau_score_2", "label": "Bureau score 2", "group": "Repayment history",
              "value": 0.58, "bin": "0.516 to 0.629", "points": 26}],
  "top_reasons": ["Age (30.7 to 35.8): -15 points"]
}
```
The score always equals `base_score` plus the sum of `points`, so every number can be explained. A missing input scores as its own "missing" bin. An unknown category scores 0 points.

## Train it

1. **Get the data.** You need a Kaggle account, and you must accept the competition rules once.
   - Open the [Home Credit data page](https://www.kaggle.com/competitions/home-credit-default-risk/data).
   - Download `application_train.csv`. It's about 158 MB, or smaller if it comes as a zip.
   - Put it in `data/raw/`. Git ignores that folder, so the data is never uploaded.
2. **Set up Python.** Run this once, from the repo root:
   ```bash
   py -3.11 -m venv .venv
   .venv\Scripts\python -m pip install -r models/credit_scorecard/requirements.txt
   ```
3. **Train:**
   ```bash
   .venv\Scripts\python -m models.credit_scorecard.train
   ```
4. **Score an example:**
   ```bash
   .venv\Scripts\python -m models.credit_scorecard.scorecard models/credit_scorecard/example_input.json
   ```
5. **Run the tests.** They use made-up data and don't need the Kaggle file:
   ```bash
   .venv\Scripts\python -m pytest
   ```

## How we check it

`train.py` keeps 20% of applications aside as a **test set** that the model never sees during training. It then writes these files to `reports/`:

| File | What it shows | What good looks like |
|---|---|---|
| `metrics.json` | AUC, Gini and KS on train and test | Test Gini about 0.45 or higher, and train close to test (not overfitting) |
| `grades.csv` | Applicants, actual default rate and predicted default rate per grade | Default rate rises A → E; predicted ≈ actual |
| `fairness.csv` | Approval rate by gender and age band | Each group's approval rate at least 80% of the best group's (the four-fifths rule). If not, investigate before going live. |
| `points_table.csv` | Every bin of every input and its points | Points move in one direction across bins |

`train.py` also checks that the exported `scorecard.json` gives *exactly* the same answers as the fitted model. If it doesn't, training stops with an error.

## Results

*To be filled in after training on the real Home Credit data.*
