# Model 5: Bank transaction tagger (model card)

| | |
|---|---|
| **Job** | Sorts every bank-statement entry into one of **15 lending categories**, then summarises the statement for the *Affordability* gate (gate 6) and the *Fraud* gate (gate 3). Examples: salary per month, EMIs per month, bounces, and cash deposits as a share of credits. |
| **Type** | TF-IDF (words + character fragments), then logistic regression |
| **Trained on** | Our generator of Indian narrations (2,100), plus the [Karthik-Eswar Indian transaction set](https://huggingface.co/datasets/Karthik-Eswar/indian-transaction-categorization-synthetic) (970, MIT licence) |
| **Status** | Trained and tested. Macro F1 is **0.83 on unseen formats** and **0.65 on a different source**. Reliable on salary, EMI, rent and cash. Weaker on transfers and other income. |
| **Version** | `tagger-v1`, trained 5 Nov 2026 |
| **Owner** | AI/ML member |

## The 15 categories

| Credits | Debits | Either way |
|---|---|---|
| `salary`, `other_income` (interest, rent received, business receipts, claims), `cash_deposit`, `refund` (refunds, reversals, cashback) | `emi`, `rent`, `cash_withdrawal`, `bounce` (ACH/NACH/ECS/cheque returns and their charges), `bank_charges`, `bills`, `insurance`, `investment`, `tax`, `spend` (merchant payments) | `transfer` (to or from people, including own accounts) |

**Own-account and other-person transfers share one category.** The narration alone can't tell them apart. The engine checks the counterparty name against the applicant's name instead, so own-account money is never counted as income.

## The data, and why it's built this way

Public Indian narration data covers *spending* categories, such as groceries and travel. It **doesn't cover what a lender needs most**:
- cheque and NACH **bounces**
- **cash deposits**
- **bank charges**
- **salary credits** in real NEFT formats

The datasets we checked:

| Source | What it gave us |
|---|---|
| **Our generator** (`generator.py`) | 140 narrations for each of the 15 categories, written in **SBI, HDFC, ICICI, Axis, Kotak and PNB styles** (NEFT CR-…, BY TRANSFER-NEFT*…, ACH D-…, NACH RTN…, NWD-…, CDM…, INT.PD…). It includes tricky look-alikes, such as "LOCKER RENT" (a bank charge, not rent), "LIC HOUSING FINANCE" (an EMI, not insurance) and "EMI CARD ANNUAL FEE" (a charge, not an EMI). Every name, reference and UPI ID is random. |
| **[Karthik-Eswar](https://huggingface.co/datasets/Karthik-Eswar/indian-transaction-categorization-synthetic)** (Hugging Face, MIT) | 970 narrations from a *different* generator. Its 21 categories are mapped onto ours (`sources.py`). It has no direction, and no bounce, cash-deposit, refund or tax rows. |
| [Indian Banking Transaction Text](https://www.kaggle.com/datasets/coderanand/indian-banking-transaction-text-dataset) (Kaggle) | Not used. Its 11,000 rows are a handful of repeated templates in 5 spending categories. |
| [AgamiAI Indian Bank Statements](https://huggingface.co/datasets/mahendrakumar46/Indian-Bank-Statements) (HF) | Not used. It has realistic narrations but no labels, and it's 1.37 GB. It's a good future check. |
| [Setu AA sandbox](https://docs.setu.co/data/account-aggregator/quickstart) | Not used yet. It needs a Setu sign-up and has only 15–30 mock transactions per account. It's the next step for testing on real AA formats. |

Both labelled sources are synthetic, so all labels are known by construction. The raw Hugging Face file stays in `data/raw/hf_indian_txn/`, and Git ignores it.

## How it works

1. **Normalise.** Lower-case the text, turn every number into `#` (so reference numbers don't matter), and strip punctuation.
2. **Add the direction.** Debit or credit is added as a token. Account Aggregator data always includes it. During training it's hidden on 30% of rows, so the model still works when it's missing.
3. **Read word and character fragments.** Words (1–2 at a time) plus character fragments (2–5 characters), so codes like `nach rtn`, `nwd`, `int pd` and `cdm` are recognised even inside new formats.
4. **Classify.** Logistic regression with balanced classes gives each category a probability. **Confidence below 0.5 is flagged `needs_review`.**
5. **Explain.** The text fragments that pushed hardest towards the chosen category are returned as `reasons`. For example, a NACH bounce gives `rtn`, `insuff` and `nach rtn`.

## Results: F1 per category

We ran three checks, from hardest to easiest (`reports/per_category.csv`):

| Category | **Unseen formats**¹ | **Different source**² | Different source, bank-code rows only | Combined CV³ |
|---|---|---|---|---|
| salary | **0.89** | 0.80 | 0.78 | 1.00 |
| emi | **0.95** | 0.71 | 0.83 | 0.99 |
| rent | 0.80 | 0.86 | 0.78 | 1.00 |
| cash_deposit | **0.94** | – | – | 1.00 |
| cash_withdrawal | 0.87 | **0.98** | 1.00 | 1.00 |
| bounce | 0.80 | – | – | 1.00 |
| bank_charges | 0.77 | 0.59 | 0.65 | 1.00 |
| bills | 0.95 | 0.53 | 0.45 | 1.00 |
| insurance | 0.91 | 0.71 | 0.67 | 1.00 |
| investment | 0.74 | 0.56 | 0.58 | 1.00 |
| tax | 0.83 | – | – | 1.00 |
| refund | 0.87 | – | – | 0.99 |
| spend | 0.78 | 0.49 | 0.56 | 0.99 |
| other_income | 0.65 | 0.46 | 0.55 | 1.00 |
| transfer | 0.62 | 0.44 | 0.40 | 1.00 |
| **Macro F1** | **0.83** | **0.65** | 0.66 | 1.00 |
| **Accuracy** | 0.83 | 0.56 | 0.60 | 1.00 |

1. **Unseen formats:** every narration *template* of our generator is held out once (5-fold GroupKFold). This tests new formats of familiar entry types.
2. **Different source:** trained on our data **only**, tested on all 970 Hugging Face rows. This is the most realistic estimate for brand-new formats and merchants.
3. **Combined CV:** random 5-fold on both sources. It's **too optimistic**, because the same templates and merchants appear on both sides of the split. We report it, but don't rely on it.

**Key findings:**
- **Reliable for lending:** salary, EMI, rent, cash deposits and cash withdrawals hold up (0.71–0.98 even on the different source). Those are what FOIR and income estimates depend on.
- **Bounces score 0.80 on unseen formats.** Precision is 0.90, so when it says "bounce" it's usually right. Recall is 0.73, so about 1 in 4 bounce formats it has never seen gets missed. The Hugging Face set has no bounces to test against.
- **Weak spots:**
  - **transfer** and **other_income** (0.40–0.65). People's names look the same whether they're paying rent, receiving money or making a transfer.
  - **spend** on the different source (0.49). The Hugging Face set uses merchants we don't list (Cleartrip, Practo, Sony LIV). It also includes plain sentences such as "bought vegetables at BigBasket", which real statements never contain. On its bank-code rows alone, accuracy rises from 0.52 to 0.60.
- **The shipped model is trained on both sources**, so it now knows those merchants too. Its true accuracy on new real statements sits somewhere between the two realistic checks.

## Output

One entry:

```bash
.venv\Scripts\python -m models.transaction_tagger.tagger "NACH RTN BAJAJ FINANCE LTD INSUFF BAL"
```
```json
{"category": "bounce", "confidence": 0.9858,
 "top3": [{"category": "bounce", "confidence": 0.9858}, {"category": "emi", "confidence": 0.0049},
          {"category": "insurance", "confidence": 0.0036}],
 "needs_review": false, "reasons": ["rtn", "insuff", "nach rtn"]}
```

A whole statement: `example_statement.json` covers 3 months and 19 entries, with an ACH bounce in August. All 19 are tagged correctly, each with confidence 0.89 or higher:

```json
{"months": ["2025-07", "2025-08", "2025-09"], "avg_monthly_salary": 62000.0, "salary_months": 3,
 "avg_monthly_emi": 14500.0, "avg_monthly_rent": 18000.0, "bounces": 1, "bounce_entries": 2,
 "cash_deposit_share_of_credits": 0.1767, "entries_needing_review": 0}
```

The summary counts bounce **events**, not entries. A bounce usually shows twice: the return itself, then the bank's return charge. Here, the August bounce gives `bounces: 1` from `bounce_entries: 2`.

The engine calls:
- `predict({"text", "direction"})` for one entry,
- `tag_statement([...])` for a whole Account Aggregator statement. Each entry needs `date` (YYYY-MM-DD) and `amount` for the summary.

## Run it

```bash
.venv\Scripts\python -m pip install -r models/transaction_tagger/requirements.txt
```
```bash
.venv\Scripts\python -m models.transaction_tagger.train
```
```bash
.venv\Scripts\python -m models.transaction_tagger.tagger models/transaction_tagger/example_statement.json
```

**Before training:** put `synthetic_indian_transactions.csv` from Hugging Face in `data/raw/hf_indian_txn/`. Training takes about 10 seconds.

**Tests:** 16 tests, all run by `.venv\Scripts\python -m pytest`. Without the Hugging Face file, the tests train on our generator only. They cover the lending-critical entries:
- NACH and cheque bounces
- a salary NEFT
- an LIC Housing EMI
- a cash deposit and an ATM withdrawal
- "LOCKER RENT" as a bank charge
- a Swiggy UPI spend

They also cover the bounce-event count, and tagging without a direction.

**Model file safety:** `model.joblib` is a pickle, so only load the file that `train.py` wrote into this repo. The tagger warns if your scikit-learn version differs from the training one (1.9.1).

## Next steps

- **Test on real Account Aggregator data.** Use the Setu or Finvu sandbox statements, then a few consented real statements, before relying on the tags.
- **Grow the generator** from officers' corrections of `needs_review` entries, especially transfers, other income and new merchants.
- **Name-match transfers** against the applicant, to split own-account from third-party money.
