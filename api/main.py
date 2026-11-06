from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field, ValidationError
from typing import Literal

from models.credit_scorecard.scorecard import predict
from models.eligibility.engine import evaluate_eligibility
from models.underwriting.engine import evaluate_underwriting
try:
    from api.document import router as document_router
except ModuleNotFoundError:   # models/document_ai is not in the repo yet
    document_router = None

from models.explainability.engine import explain_decision
from models.audit.logger import log_decision, get_audit_logs, verify_audit_chain


app = FastAPI(
    title="LoanGuard AI",
    description="AI-powered Mortgage Underwriting Prototype",
    version="1.1.0"
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
if document_router:
    app.include_router(document_router)


class HomeCreditInput(BaseModel):
    bureau_score_1: float | None = Field(default=None, ge=0, le=1)
    bureau_score_2: float | None = Field(default=None, ge=0, le=1)
    bureau_score_3: float | None = Field(default=None, ge=0, le=1)
    loan_to_price: float | None = Field(default=None, ge=0)
    years_employed: float | None = Field(default=None, ge=0)
    employment_type: Literal["pensioner", "self_employed", "salaried", "other"] | None = None


class LTInput(BaseModel):
    """Inputs of the L&T (Indian) scorecard. The model uses bureau_score, credit_history_years, loan_amount and ltv."""
    bureau_score: float | None = Field(default=None, ge=0, le=900)
    bureau_status: str | None = None
    credit_history_years: float | None = Field(default=None, ge=0)
    loan_amount: float | None = Field(default=None, ge=0)
    ltv: float | None = Field(default=None, ge=0, le=200, description="percent")
    overdue_accounts: float | None = Field(default=None, ge=0)
    recent_delinquencies: float | None = Field(default=None, ge=0)
    enquiries: float | None = Field(default=None, ge=0)
    new_accounts_6m: float | None = Field(default=None, ge=0)
    active_accounts: float | None = Field(default=None, ge=0)
    existing_emi: float | None = Field(default=None, ge=0)
    age_years: float | None = Field(default=None, ge=0, le=100)
    employment_type: str | None = None


CREDIT_INPUTS = {"lt": LTInput, "home_credit": HomeCreditInput}


class EligibilityApplicant(BaseModel):
    age: int = Field(gt=0, le=100)
    monthly_income: float = Field(gt=0)
    years_employed: float = Field(ge=0)
    requested_loan_amount: float = Field(gt=0)
    property_value: float = Field(gt=0)
    existing_monthly_emi: float = Field(ge=0)
    tenure_years: int = Field(gt=0, le=40)


class UnderwritingRequest(BaseModel):
    application_id: str
    model_type: Literal["lt", "home_credit"] = "lt"
    credit_data: dict = Field(default_factory=dict)
    eligibility_data: EligibilityApplicant
    document_verification: dict | None = None
    declared_name: str = ""
    fraud_flags: list = Field(default_factory=list)


def _validate_credit(data: dict, model_type: str) -> dict:
    """Check the credit inputs against the schema of the chosen scorecard (rejects unknown or invalid fields)."""
    schema = CREDIT_INPUTS[model_type]
    unknown = sorted(set(data) - set(schema.model_fields))
    if unknown:
        raise HTTPException(422, f"Unknown {model_type} inputs: {unknown}. Allowed: {sorted(schema.model_fields)}")
    try:
        return schema(**data).model_dump()
    except ValidationError as e:
        raise HTTPException(422, e.errors(include_url=False, include_context=False))


@app.get("/")
def home():
    return {
        "message": "Welcome to LoanGuard AI",
        "status": "API is running",
        "available_models": ["lt", "home_credit"]
    }


@app.get("/api/v1/models")
def available_models():
    return {
        "models": [
            {
                "model_type": "lt",
                "name": "L&T Vehicle Loan Default",
                "dataset": "Indian vehicle loan dataset"
            },
            {
                "model_type": "home_credit",
                "name": "Home Credit Default Risk",
                "dataset": "International consumer loan dataset"
            }
        ]
    }


@app.post("/api/v1/credit-score")
def credit_score(
    applicant: dict,
    model_type: Literal["lt", "home_credit"] = "lt"
):
    checked = _validate_credit(applicant, model_type)
    return predict(checked, model_type=model_type)


@app.post("/api/v1/eligibility/check")
def eligibility_check(applicant: EligibilityApplicant):
    return evaluate_eligibility(applicant.model_dump())


@app.post("/api/v1/underwriting/evaluate")
def underwriting_evaluate(application: UnderwritingRequest):

    payload = application.model_dump()
    payload["credit_data"] = _validate_credit(payload["credit_data"], payload["model_type"])
    result = evaluate_underwriting(payload)

    explanation = explain_decision(result)

    audit_result = log_decision(result, explanation)

    return {
        "underwriting_result": result,
        "explanation": explanation,
        "audit": audit_result
    }


@app.get("/api/v1/audit")
def audit_history():
    logs = get_audit_logs()

    return {
        "total_records": len(logs),
        "audit_logs": logs
    }

@app.get("/api/v1/audit/verify")
def audit_verify():
    return verify_audit_chain()
