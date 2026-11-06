# NIRNAY AI – Intelligent Mortgage Underwriting Platform

**Hero Housing Fintech Challenge | Problem Statement 2**

NIRNAY AI is an AI-assisted mortgage underwriting prototype designed to support Home Loan and Loan Against Property (LAP) assessment.

The platform combines a React web dashboard, FastAPI backend, machine learning models, configurable eligibility rules, fraud risk checks, explainable decisions, and application audit logging.

**NIRNAY AI aims to make mortgage underwriting more transparent, efficient, and explainable.**

> **Important:** This is a hackathon prototype. Its decisions are based on demo rules and model inputs. It is not a production lending platform, actual loan sanction, verified KYC system, or regulatory compliance certification.

## Project Highlights

- AI-assisted credit risk assessment
- Loan eligibility evaluation using configured demo rules
- Fraud risk assessment and review flags
- Demo document verification inputs
- Explainable underwriting decisions
- Risk factors and decision reasons
- Application audit logging
- Web-based underwriting dashboard
- Flutter mobile application project

## Project Architecture

```text
NIRNAY-AI/
│
├── api/                         # FastAPI backend for the React dashboard
│   ├── main.py
│   └── document.py
│
├── backend/                     # FastAPI decision engine with all 12 models (for the Flutter app)
│
├── frontend/                    # React + Vite dashboard
│
├── app/                         # Flutter mobile application
│
├── models/
│   ├── credit_scorecard/
│   ├── credit_challenger/
│   ├── eligibility/
│   ├── fraud_detection/
│   ├── fraud_classifier/
│   ├── anomaly_detector/
│   ├── document_classifier/
│   ├── transaction_tagger/
│   ├── property_avm/
│   ├── ocr/                     # model 8 (ready-made)
│   ├── face_match/              # model 9 (ready-made)
│   ├── liveness/                # model 10 (ready-made)
│   ├── llm/                     # model 11 (ready-made)
│   ├── translation/             # model 12 (ready-made)
│   ├── explainability/
│   ├── underwriting/
│   └── audit/
│
├── docs/                        # Project documentation
├── INTEGRATION.md
├── requirements-api.txt
├── pytest.ini
├── Nirnay-Underwriting-Report.pdf
└── README.md
```

## Technology Stack

| Component | Technology |
|---|---|
| Web Frontend | React, Vite, Tailwind CSS |
| Backend | Python, FastAPI, Uvicorn |
| Machine Learning | Scikit-learn, LightGBM |
| Data Processing | Pandas, NumPy |
| Explainability | Scorecard and rule-based explanations |
| Mobile Application | Flutter |
| Audit Logging | Python-based audit module |

## Core Underwriting Workflow

1. Enter applicant information.
2. Provide financial and loan details.
3. Select the available credit assessment model.
4. Provide demo document verification inputs.
5. Submit the application to the FastAPI backend.
6. Evaluate credit risk, eligibility, and fraud rules.
7. Generate the final underwriting decision.
8. Display decision explanations, risk factors, and audit information.

Possible outcomes include:

- **APPROVE:** Application passes the configured demo rules.
- **REFER:** Application requires further review.
- **REJECT:** Application fails configured decision rules.

## Backend API Endpoints

The FastAPI backend currently exposes the following endpoints:

| Method | Endpoint | Description |
|---|---|---|
| GET | `/` | Backend health check |
| GET | `/api/v1/models` | List available models |
| POST | `/api/v1/credit-score` | Credit assessment |
| POST | `/api/v1/eligibility/check` | Loan eligibility assessment |
| POST | `/api/v1/underwriting/evaluate` | Combined underwriting evaluation |
| GET | `/api/v1/audit` | Retrieve audit records |
| GET | `/api/v1/audit/verify` | Audit integrity verification |

Interactive API documentation:

`http://127.0.0.1:8001/docs`

## Decision engine with all 12 models (`backend/`)

A second FastAPI service, built for the Flutter customer app, runs **all 12 models**. It covers what `INTEGRATION.md` lists as still open: document AI, models 3–7 in the decision, KYC and AML, a compliance gate with clause tags, and replayable records. Details: [backend/README.md](backend/README.md).

| # | Model | Used for |
|---|---|---|
| 1, 2 | Credit scorecard (live), challenger (shadow) | Risk grade gate; the challenger is recorded but never sets the outcome |
| 3, 4 | Fraud classifier, anomaly detector | Fraud & documents gate |
| 5 | Transaction tagger | Salary, EMI and bounce totals from the Account Aggregator statement |
| 6, 8 | Document classifier, OCR (English + Hindi) | Every upload: type check and field reading |
| 7 | Property AVM | Property gate; LTV uses the lower of price and estimate |
| 9, 10 | [Face match](models/face_match/README.md) (98.7% on LFW pairs, no false accepts), [liveness](models/liveness/README.md) | Identity gate |
| 11 | [LLM](models/llm/README.md) (Claude Sonnet 5.5) | Deed reader (every fact must quote the deed), officer file notes, letters, help assistant; offline rules without an API key |
| 12 | [Translation](models/translation/README.md) | Letters and assistant answers in 22 Indian languages |

Plus AML name screening against the UN list, fraud-ring and reused-file checks, PDF/photo tamper checks, eight gates and a compliance gate (8 coded rules, each with its regulation), the Key Facts Statement, and hash-chained decision records that can be replayed.

```bash
pip install -r backend/requirements.txt
python -m backend.fetch
uvicorn backend.app:app --host 127.0.0.1 --port 8000
```

Run the app against it: `flutter run -d chrome --dart-define=NIRNAY_API_URL=http://127.0.0.1:8000` from `app/`. The report's three demo cases come out as designed: Ravi approved, Meena referred at the property, Arjun rejected.

## Machine Learning and AI Modules

The repository contains the following model and processing modules:

| Module | Purpose |
|---|---|
| Credit Scorecard | Credit risk scoring |
| Credit Challenger | Alternative credit model |
| Eligibility Engine | Configurable loan eligibility rules |
| Fraud Detection Engine | Fraud risk flags and checks |
| Fraud Classifier | Machine learning-based fraud classification |
| Anomaly Detector | Anomalous application detection |
| Document Classifier | Document text classification |
| Transaction Tagger | Bank transaction categorization |
| Property AVM | Automated property valuation model |
| Explainability Engine | Decision explanations |
| Underwriting Engine | Combined underwriting decision logic |
| Audit Module | Application audit logging |

**Integration note:** The credit scorecard, eligibility engine, fraud detection, explainability, and underwriting components are used in the tested demo workflow of `api/`. Other model modules are present in the repository but should be treated as separate or experimental components until their integration and end-to-end performance are verified. The `backend/` engine (above) wires in all 12 models and tests them end to end on the three demo cases.

## Running the Project Locally

### Prerequisites

- Python 3.10 or compatible version
- Node.js and npm
- Flutter SDK (for mobile application development)
- Git

### 1. Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
cd IIt-b
```

Replace the repository URL with the actual GitHub repository URL.

### 2. Backend Setup

```bash
python3 -m venv .venv
source .venv/bin/activate

python -m pip install --upgrade pip
pip install -r requirements-api.txt
pip install -r models/credit_scorecard/requirements.txt
```

Start the backend:

```bash
uvicorn api.main:app --reload --host 127.0.0.1 --port 8001
```

Backend URL:

`http://127.0.0.1:8001`

### 3. Frontend Setup

Open another terminal:

```bash
cd frontend
npm install
npm run dev
```

Frontend URL:

`http://localhost:5173`

### 4. Production Build

```bash
cd frontend
npm run build
```

## Testing

Run the backend test suite from the project root:

```bash
source .venv/bin/activate
python -m pytest
```

The project test suite was previously verified with 140 passed and 2 skipped tests. Re-run the suite on the final submission version to confirm the latest status. `pytest.ini` now also runs `backend/` (the decision engine's API and gate tests; run `python -m backend.fetch` first so the face and OCR weights are there).

## Reports and Documentation

- `Nirnay-Underwriting-Report.pdf` – Project report
- `docs/nirnay-report.html` – HTML report
- `INTEGRATION.md` – Backend and frontend integration notes
- `app/README.md` – Mobile application documentation

## Current Prototype Limitations

- The tested credit scorecard uses L&T vehicle-loan training data. It is not a mortgage-specific validated model.
- Home Credit data represents consumer lending, not mortgage-specific lending.
- Document verification checkboxes are manually supplied demo inputs. They do not perform actual document authentication or KYC.
- Fraud detection is a prototype assessment, not a production AML or sanctions screening solution.
- External credit bureau, KYC, Account Aggregator, GST/ITR, and property-record integrations are not confirmed.
- The configured eligibility rules are demonstration rules, not official Hero Housing Finance lending policies.
- Separate AI modules require further integration, testing, and validation before production use.
- Regulatory compliance and production-grade governance require additional implementation and independent review.

## Security and Privacy

- Never commit API keys, passwords, or access tokens.
- Keep `.env` files local.
- Do not upload real customer documents or personal information.
- Keep generated audit records local.
- Use synthetic or public datasets for demonstrations.
- Review `.gitignore` before publishing the repository.

## Future Scope

- External credit bureau integration
- Digital KYC and document authentication
- Bank statement and Account Aggregator integration
- Automated property verification and valuation
- Stronger fraud and AML screening
- Versioned lending policies and maker-checker workflows
- Production-grade security, governance, and regulatory validation

## Disclaimer

NIRNAY AI is a hackathon prototype developed for demonstration and evaluation. Its underwriting outputs are not actual loan approvals, verified KYC decisions, or financial advice. All lending decisions require appropriate institutional validation and authorization.