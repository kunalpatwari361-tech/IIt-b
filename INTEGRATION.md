# LoanGuard backend integrated into the Nirnay repo

Apply from the repo root:  `unzip -o nirnay-integration-overlay.zip`, then
`pip install -r models/credit_scorecard/requirements.txt -r requirements-api.txt` and `python -m pytest -q`
(49 pass, 1 skipped). Run the API: `uvicorn api.main:app --reload`.

## What was added
api/ (FastAPI), models/eligibility, fraud_detection (rules), underwriting (orchestrator), explainability,
audit (hash-chained log), per-dataset scorecards (lt, home_credit), reports for both datasets.

## Bugs fixed during integration
1. API did not start: api/document.py imports models.document_ai, which is not in the zip or the repo.
   The document router is now optional (endpoint is off until that package is added).
2. L&T model could not receive its inputs: the API only accepted Home Credit fields, so every L&T
   application scored the "all inputs missing" score (643, grade D) and was rejected. Each model now has
   its own input schema, and wrong or unknown fields return 422.
3. Any case with a fraud flag crashed /underwriting/evaluate (explainability treated string flags as dicts).
4. Audit log read the wrong fraud keys (risk_score / risk_level) and had no tamper evidence.
   Fixed, and added a hash chain plus GET /api/v1/audit/verify.
5. train.py wrote scorecard_lt.json but scorecard.py read scorecard.json, and the repo tests expected scorecard.json
   (22 test errors). Artifact names are consistent now.
6. reports/ was overwritten by whichever dataset trained last. L&T reports stay in reports/,
   Home Credit reports are in reports_home_credit/.

## Results (held-out test data)
| Scorecard | Test AUC | Test Gini | KS | Notes |
|---|---|---|---|---|
| Home Credit (international) | 0.735 | 0.470 | 0.348 | 61,503 test loans, default rate 8.1%, grades monotonic, predicted close to actual |
| L&T vehicle loans (India) | 0.595 | 0.189 | 0.141 | out-of-time test (Oct 2018), weak |

## Still open
- models/document_ai (OCR, field extraction, verification) is missing.
- Models 3 to 7 in the repo (fraud classifier, anomaly detector, transaction tagger, document classifier, property AVM)
  are not wired into the underwriting engine; fraud is rules only and there is no property valuation step.
- Eligibility policy is flat demo policy (LTV 80, DTI 50); no compliance gate with clause tags, no KYC/AML or bureau/AA connectors.
- The audit record does not store the inputs, so a decision cannot be replayed yet.
- Fairness flags: Home Credit (gender M 0.76, age under 30 0.21, age 30-44 0.58); L&T (age and several states).
