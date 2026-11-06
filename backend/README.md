# Nirnay decision engine (backend)

The FastAPI engine behind the customer app. It runs **all 12 models**, the rule-based checks, the **eight gates** from the report plus the **compliance gate**, and writes every decision to a **hash-chained record** that can be replayed.

**AI is never the final judge.** Rules and validated models set every outcome. The LLM only reads and drafts, and its findings can only send a case to an officer.

## Run it

From the repo root (`K:\IIt b`), with the venv from the main README:

```bash
.venv/Scripts/python -m pip install -r backend/requirements.txt
```

```bash
.venv/Scripts/python -m backend.fetch
```

```bash
.venv/Scripts/python -m uvicorn backend.app:app --host 127.0.0.1 --port 8000
```

- `backend.fetch` downloads the face-match and Hindi OCR weights (checking their SHA-256) and refreshes the UN sanctions list. The liveness weights are already in the repo.
- Open `http://127.0.0.1:8000/docs` for the interactive API, and `/v1/models` to see each model's status.
- Point the app at it: `flutter run -d chrome --dart-define=NIRNAY_API_URL=http://127.0.0.1:8000` (see [app/README.md](../app/README.md)).

**Settings** (environment variables; nothing secret has a default):

| Variable | What it does |
|---|---|
| `NIRNAY_SANDBOX` | `1` (default): fictional people and stand-in data sources, OTP `123456` |
| `NIRNAY_STAFF_KEY` | Turns on the staff routes; send it as `X-Staff-Key` |
| `ANTHROPIC_API_KEY` | Turns on Claude for model 11 (or `NIRNAY_LLM=on` with an `ant auth login` profile). Without it, offline rules stand in. |
| `BHASHINI_USER_ID`, `BHASHINI_ULCA_API_KEY` | Turn on Bhashini for model 12 |
| `NIRNAY_CORS_ORIGINS` | Browser origins allowed (default: the web build on port 8765) |
| `NIRNAY_VAR_DIR` | Where the decision ledger is written (default `backend/var/`, git-ignored) |

## How the 12 models are wired in

| # | Model | Where the engine uses it |
|---|---|---|
| 1 | Credit scorecard | **Risk grade** gate: grade C refers (`R-RSK-01`), D and E reject (`R-RSK-02`) |
| 2 | Credit challenger | Scored and recorded next to model 1, in **shadow**. It never changes the outcome (a test checks this). |
| 3 | Fraud classifier | **Fraud & documents** gate: review or high alert refers (`R-FRD-01`) |
| 4 | Anomaly detector | **Fraud & documents** gate: unusual or broken integrity rule refers (`R-FRD-04`) |
| 5 | Transaction tagger | Tags the Account Aggregator statement when the profile is fetched. Its salary, EMI and bounce totals feed **Affordability** and the slip check. |
| 6 | Document classifier | Every upload: wrong type `R-DOC-01`, unreadable `R-DOC-02` |
| 7 | Property AVM | **Property** gate (final stage): price above range `R-PRP-03`, below circle value `R-PRP-04`, unsure `R-PRP-02`. LTV uses the lower of the price and the estimate. |
| 8 | OCR | Every upload, English and Hindi. Its text feeds model 6, the field rules and the deed reader. |
| 9 | Face match | Selfie against the Aadhaar/PAN photo, whichever arrives second; **Identity** gate (`R-KYC-01`) |
| 10 | Liveness | Every selfie; **Identity** gate (`R-KYC-01`) |
| 11 | LLM | Deed reader on sale-deed uploads (**Property** gate, refer only); officer file notes; letters; help assistant |
| 12 | Translation | Letters and assistant answers in the customer's language |

**Rule-based checks (no training):** AML name matching against the UN list and a sandbox PEP list (rapidfuzz + jellyfish); fraud rings across applications (networkx); reused property photos (imagehash) and duplicate document files (SHA-256); PDF and photo tamper checks (pypdf, Pillow); field reading from OCR text; the policy table.

### Bridging the training data

Models 1, 2 and 4 learned from L&T **vehicle** loans and model 3 from BAF. `adapters.py` writes down how a home-loan application becomes their inputs. Nothing is tuned to the demo cases:
- **Credit:** bureau inputs go in unchanged. Loan amount goes in as missing (0 points), because ₹45 lakh is off the vehicle scale. FOIR judges affordability instead.
- **Anomaly:** loan and property value are rescaled to a typical L&T loan (×0.02), which keeps every ratio the forest learned.
- **Fraud:** what we can measure in India is measured: name vs email, OTP-verified phone, address and account age, emails per device, minutes spent applying. The rest use the median of genuine BAF applications (`data/fraud_neutral.json`), so they push the score neither way.

## The decision

Each stage **gathers** evidence (data sources and models, as plain JSON), then **decides** with pure gate functions, then **records** the result.

| Gate | Refers when | Rejects when |
|---|---|---|
| 1 Identity | No live face, face mismatch, names differ across PAN, eKYC and documents | – |
| 2 AML | Close name match with a matching or unknown date of birth. Namesakes with a different date of birth are cleared automatically. | – |
| 3 Fraud & documents | Fraud or anomaly alert, ring, reused file, missing/unreadable/wrong document, signs of editing, slip above bank salary credits | The slip doesn't match the employer's payroll record (`R-FRD-03`) |
| 4 Policy | No credit history, score 650–699, loan past the maximum age | Under 21, score below 650 |
| 5 Property (final) | Title gap (land records or the deed reader), valuation unsure or price out of range, below circle value, photos not geo-tagged, old or reused | – |
| 6 Affordability | 2+ bounces, no salary credits seen, business credits below 80% of ITR income | EMIs already at the FOIR limit |
| 7 Risk grade | Grade C | Grade D or E |
| 8 Authority | Above ₹1 crore | – |
| Compliance | Any of 8 coded rules fails: consent before data pull, KYC done, screening ran, RBI LTV tiers, KFS with APR, a reason for every adverse outcome, AI not the final judge, cooling-off stated | – |

The most severe result wins. Customers see reason codes from the app's reviewed set, in their language. **Fraud and AML reasons show only as a general review** (`R-RSK-01`), because PMLA forbids tipping off. Officers see the exact internal code, what it means and what to check (`reasons.py`).

**Records:** `ledger.py` appends each decision with its evidence, rule and model versions, gate results and outcome to a JSON-lines file. Each record's SHA-256 covers its body and the previous hash, so any edit breaks the chain. `GET /v1/staff/ledger/verify` finds where. `POST /v1/staff/records/{seq}/replay` re-runs the gates on the stored evidence and re-scores models 1–4 from their stored inputs; both must match.

## API

Customer routes need `Authorization: Bearer <token>` from OTP sign-in and the same `X-Device-Id`. A session reaches only its own application.

| Method and path | What it does |
|---|---|
| `POST /v1/otp/send`, `POST /v1/otp/verify` | Sign in (sandbox OTP `123456`; 5 tries, then locked) |
| `PUT /v1/applications/{id}/consents` | Records the needed and optional consents and their options (months, accounts, KYC method) |
| `POST /v1/applications/{id}/profile` | eKYC, PAN, bureau, Account Aggregator (model 5). Refused until the needed consents are recorded. |
| `POST /v1/applications/{id}/selfie` | Models 9 and 10 |
| `POST /v1/applications/{id}/documents` | Models 8 and 6, field reading, tamper and duplicate checks, ID-photo face, deed reader for sale deeds |
| `POST /v1/applications/{id}/in-principle` | Stage A decision and Key Facts Statement |
| `POST /v1/applications/{id}/final` | Stage B with property details and geo-tagged photos (model 7, title) |
| `GET /v1/applications/{id}` | Status |
| `GET /v1/applications/{id}/letter?lang=hi` | Letter: fixed template, LLM paragraphs, translated |
| `POST /v1/applications/{id}/assistant` | Help assistant, answered in the customer's language |
| `GET /v1/models` | Status of all 12 models and the checks |
| `GET /v1/sandbox/personas/{ravi,meena,arjun,priya}/documents/{slot}` | Sample documents for demos (PAN, Aadhaar, salary slip, Form 16, ITR, GST, bank statement, sale deed) |
| `GET /v1/staff/applications/{id}/file-note` | LLM file note for officers |
| `GET /v1/staff/applications/{id}/records`, `GET /v1/staff/records/{seq}` | Decision records |
| `POST /v1/staff/records/{seq}/replay`, `GET /v1/staff/ledger/verify` | Replay and chain check |

## Demo cases (sandbox)

The data sources are fake. The models and rules that judge the data are the real ones.

| Person | Phone | Result |
|---|---|---|
| Ravi Kumar, salaried | 98765 00001 | HL ₹45 lakh on ₹60 lakh: **approved** in both stages, EMI ₹39,767 at 8.75% |
| Meena Sharma, shop owner | 98765 00002 | LAP ₹60 lakh on ₹1.2 crore: **approved in principle, referred at the property**. Land records and the deed reader both find the deceased co-owner. |
| Arjun Mehta, salaried | 98765 00003 | HL ₹30 lakh: **rejected**. OCR reads ₹93,000 net pay on his slip; bank credits and payroll say ₹62,000. |
| Anyone else | any number | Priya Nair, a clean salaried applicant |

Choices in the app change the result. Share only the savings account through the Account Aggregator, for example, and no salary credits are seen (`R-AFF-04`).

## Tests

```bash
.venv/Scripts/python -m pytest backend
```

37 tests, about 3.5 minutes (OCR is the slow part):
- **`test_api.py`:** the three demo cases end to end through HTTP, sample documents recognised, replay and chain check, letters and assistant offline, file notes, OTP lockout, session/device binding, no data without consent, the savings-only account choice, wrong documents, staff key, and an edited record breaking the chain.
- **`test_gates.py`:** each gate rule on Ravi's real recorded evidence with one fact changed: spoofed selfie, face mismatch, AML hit (shown to the customer only as a review), fraud alert, low score, no history, age, bounces, EMI limit, ₹1 crore limit, missing and edited documents, withdrawn consent, and the challenger never changing the outcome.

The selfie test uses Minivision's sample photo when it is on the machine (`NIRNAY_FACE_SAMPLES`, default `K:/tools/downloads/silent-face`); the repo holds no face photos.

## Not done yet

- **Live LLM and translation runs.** No Anthropic, Bhashini or Hugging Face credentials were available, so Claude, Bhashini and IndicTrans2 are tested only through mocks. The phrasebook and the offline rules are what ran.
- **Real data sources.** UIDAI, the bureaus, the Account Aggregator, payroll/EPFO, ITD and land records are sandbox functions in `sandbox.py`. Each is one function to replace with a real adapter.
- **Storage.** Applications live in memory and are lost on restart; only the ledger is on disk. A deployment needs PostgreSQL, encryption of personal data in records, and WORM storage for the ledger.
- **Officer actions.** Officers can read file notes and records, but there is no route yet to record their decision on a referred case. That belongs to the staff portal.
- **Speed.** A document takes 4–9 seconds (two OCR passes on a CPU). The report's under-2-second target is for the decision itself, which takes well under a second once the evidence is in.
