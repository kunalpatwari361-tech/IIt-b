"""Reason codes.

The engine keeps the exact internal code in the decision record and shows officers what
it means and what to check. Customers see a code from the app's reviewed set
(app/lib/reasons.dart), in their language. Fraud, AML and screening reasons are shown
to the customer only as a general review: PMLA forbids tipping off.
"""
from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class ReasonInfo:
    code: str
    gate: str
    customer_code: str
    officer_text: str
    officer_check: str


_R = [
    ("R-KYC-01", "identity", "R-KYC-01", "Selfie liveness or face match failed, or no usable face.",
     "Run a video KYC call and compare the face with the eKYC photo."),
    ("R-KYC-02", "identity", "R-RSK-01", "Name differs between PAN, eKYC and the uploaded documents.",
     "Compare the names on PAN, Aadhaar eKYC and the income documents; ask for proof of a name change."),
    ("R-AML-01", "aml", "R-RSK-01", "Possible match on a sanctions or PEP list.",
     "Compliance officer to confirm or clear the match using date of birth, nationality and address."),
    ("R-AML-02", "aml", "R-RSK-01", "Screening list was unavailable, so screening did not run.",
     "Reload the sanctions list (python -m backend.fetch) and re-run screening."),
    ("R-FRD-01", "fraud_documents", "R-RSK-01", "Fraud model score at or above the review threshold.",
     "Check the Indian signals named in the fraud model's top reasons."),
    ("R-FRD-02", "fraud_documents", "R-FRD-02", "Income on the salary slip is well above the salary credits in the bank statement.",
     "Ask for Form 16 or fetch it with consent; verify with the employer."),
    ("R-FRD-03", "fraud_documents", "R-FRD-03", "A document failed verification with its issuer (payroll or registry).",
     "Treat as a possible forged document; follow the fraud reporting process."),
    ("R-FRD-04", "fraud_documents", "R-RSK-01", "Application is unusual for the loan book, or breaks an integrity rule.",
     "Look at the anomaly detector's unusual inputs and confirm them with the source data."),
    ("R-FRD-05", "fraud_documents", "R-RSK-01", "Shares a device, phone, email or bank account with applicants who have other PANs.",
     "Review the linked applications for a fraud ring."),
    ("R-FRD-06", "fraud_documents", "R-RSK-01", "A photo on this file also appears on another applicant's file.",
     "Compare both files' photos and documents."),
    ("R-DOC-01", "fraud_documents", "R-RSK-01", "A required document was not recognised as the type asked for.",
     "Check the uploaded document and ask the customer for the right one."),
    ("R-DOC-02", "fraud_documents", "R-RSK-01", "A required document could not be read.",
     "Ask for a clearer photo or the original PDF."),
    ("R-DOC-03", "fraud_documents", "R-RSK-01", "A document shows signs of editing (file metadata or editing software).",
     "Get the original from the issuer or fetch it from DigiLocker."),
    ("R-DOC-04", "fraud_documents", "R-RSK-01", "A required document is missing.",
     "Ask the customer to upload it."),
    ("R-POL-01", "policy", "R-POL-01", "Applicant is under the minimum age.", "None: policy reject."),
    ("R-POL-02", "policy", "R-POL-02", "Loan would end after the maximum age.", "Consider a shorter tenure or a younger co-applicant."),
    ("R-BUR-01", "policy", "R-BUR-01", "Bureau score below the minimum.", "None: policy reject."),
    ("R-BUR-04", "policy", "R-BUR-04", "No credit history.", "Assess repayment ability from 12-24 months of bank cash flow."),
    ("R-BUR-05", "policy", "R-BUR-05", "Bureau score in the band that needs an officer.", "Review the bureau report for recent delinquencies."),
    ("R-AFF-01", "affordability", "R-AFF-01", "Existing EMIs already use the maximum share of income.", "None: affordability reject."),
    ("R-AFF-02", "affordability", "R-RSK-01", "Two or more EMI or cheque bounces in the bank statement.",
     "Read the bounces in the statement and ask the customer about them."),
    ("R-AFF-03", "affordability", "R-RSK-01", "Bank credits don't support the declared business income.",
     "Reconcile ITR income, GST turnover and bank credits."),
    ("R-AFF-04", "affordability", "R-RSK-01", "Income is not proven by a document (no salary credits, slip or ITR read).",
     "Ask for the salary account statement, a recent salary slip or the ITR, and check the account shared."),
    ("R-RSK-01", "risk_grade", "R-RSK-01", "Scorecard grade C.", "Review the scorecard's top reasons and the bureau report."),
    ("R-RSK-02", "risk_grade", "R-RSK-02", "Scorecard grade D or E.", "None: risk reject."),
    ("R-AUT-01", "authority", "R-AUT-01", "Loan above the auto-sanction limit.", "Senior officer to sanction."),
    ("R-PRP-01", "property", "R-PRP-01", "Title not clear: land records or the deed reader found a gap or a charge.",
     "Send to an empanelled lawyer with the deed reader's quoted issues."),
    ("R-PRP-02", "property", "R-PRP-03", "Valuation model could not value this property with confidence, or the photos failed checks.",
     "Assign an empanelled valuer for a site visit."),
    ("R-PRP-03", "property", "R-PRP-03", "Agreement value above the valuation model's range.", "Assign an empanelled valuer for a site visit."),
    ("R-PRP-04", "property", "R-PRP-04", "Agreement value below the government circle value.", "Check the sale agreement for an off-book payment."),
    ("R-CMP-01", "compliance", "R-RSK-01", "A compliance rule failed, so the decision was held.", "Read the failed rule in the record."),
]

REASONS: dict[str, ReasonInfo] = {r[0]: ReasonInfo(*r) for r in _R}


def info(code: str) -> ReasonInfo:
    return REASONS[code]


def customer_code(code: str) -> str:
    return REASONS[code].customer_code if code in REASONS else "R-RSK-01"
