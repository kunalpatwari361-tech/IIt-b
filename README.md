# Nirnay: Automated Mortgage Underwriting Engine

Our team's entry for the **Hero Housing Fintech Challenge, Problem Statement 2**: *Digitally Automated Mortgage Underwriting Engine, a fully automated, regulator-compliant lending platform.*

Nirnay underwrites Home Loans and Loan Against Property (LAP) without a person reviewing each file. It works through both a **mobile app** for customers and a **web portal** for staff and partners. Every application ends in one of three outcomes: **approve**, **reject** or **refer**. Each decision comes with its reasons and a tamper-evident record.

## Read the report

| File | What it is |
|---|---|
| [Nirnay-Underwriting-Report.pdf](Nirnay-Underwriting-Report.pdf) | The full report as a 40-page PDF to download or print |
| [docs/nirnay-report.html](docs/nirnay-report.html) | The same report as a web page, with a working decision simulator. Download it and open it in Chrome or Edge. |

The report covers:

- the problem
- the features for the app and portal
- the solution architecture (SA) and AI solution architecture (AI SA)
- how we meet each of the 8 challenge requirements
- a build plan for the team
- sources

## How it meets the 8 requirements

| # | Requirement | How Nirnay handles it |
|---|---|---|
| 1 | Integrate data sources | An integration hub with consent manager: KYC, credit bureau, Account Aggregator, GST/ITR, property records |
| 2 | Eligibility & policy | Policy written as versioned rule tables (FOIR, LTV tiers, age, tenure), changed under maker-checker |
| 3 | Fraud / KYC / AML | Face match, liveness, document tamper checks, a fraud model and sanctions/PEP screening, with no manual review |
| 4 | Risk scoring | An explainable credit scorecard (300–900 scale, grades A–E), plus a gradient-boosted challenger model run in shadow |
| 5 | Documents & property | OCR and document classification, an LLM title-deed reader, an automated valuation model |
| 6 | Compliance | Compliance-as-code gate covering RBI/NHB HFC Directions, KYC, Digital Lending (KFS, cooling-off), PMLA and DPDP, with a full audit trail |
| 7 | Instant decisioning | An in-principle offer in minutes, then final sanction. Eight gates run in order, and the most severe result wins. |
| 8 | Explainability & governance | Reason codes for every decision, SHAP for models, model cards, and replayable hash-chained decision records, in line with RBI FREE-AI |

**AI is never the final judge.** The LLM only reads documents and drafts text. Rules and validated models set every outcome.

## Models

| # | Model | Folder | Status |
|---|---|---|---|
| 1 | Credit scorecard (live) | [models/credit_scorecard](models/credit_scorecard/README.md) | Trained on L&T Indian loan data. Test AUC 0.595. |
| 2 | Credit challenger (shadow) | [models/credit_challenger](models/credit_challenger/README.md) | Trained on L&T Indian loan data. Test AUC 0.621, beats model 1 by +0.026. |

To set up Python and run all the tests:

```bash
py -3.11 -m venv .venv
.venv\Scripts\python -m pip install -r models/credit_challenger/requirements.txt
.venv\Scripts\python -m pytest
```

## Updating the PDF

If you edit `docs/nirnay-report.html`, rebuild the PDF:

1. Open the HTML file in Chrome.
2. Press **Ctrl+P**.
3. Choose **Save as PDF**.
4. Under **More settings**, turn on **Background graphics**.

The page already includes the print layout: A4, with diagrams on landscape pages.

## Data rule

Use **synthetic or public datasets only**. Never commit real customer documents or personal data, under the DPDP Act 2023. Keep any local test data in `data/private/`. Git already ignores that folder.
