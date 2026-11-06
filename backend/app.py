"""Nirnay decision engine: the HTTP API.

Run it from the repo root:
    .venv/Scripts/python -m uvicorn backend.app:app --port 8000

The customer app's calls (app/lib/services/api.dart) map one to one onto /v1 routes.
Customers authenticate with the session token from OTP sign-in (Authorization: Bearer)
plus their device id (X-Device-Id), and can only reach their own application.
Staff routes need the X-Staff-Key header (NIRNAY_STAFF_KEY).
"""
from __future__ import annotations

import hmac
import json
import logging
from typing import Annotated, Literal

from fastapi import Depends, FastAPI, File, Form, Header, HTTPException, Request, Response, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field

from . import intake, letters, pipeline, registry, sandbox
from .config import settings
from .intake import IntakeError
from .ledger import Ledger
from .store import Application, Store, now

log = logging.getLogger("nirnay")
store = Store()
ledger = Ledger(settings.var_dir / "ledger.jsonl")

app = FastAPI(title="Nirnay decision engine", version=pipeline.ENGINE_VERSION,
              description="Automated mortgage underwriting: 12 models, 8 gates, a compliance gate and hash-chained records.")
app.add_middleware(CORSMiddleware, allow_origins=settings.cors_origins, allow_methods=["GET", "POST", "PUT"],
                   allow_headers=["Authorization", "X-Device-Id", "Content-Type", "X-Staff-Key"])


@app.exception_handler(IntakeError)
def _intake_error(_: Request, e: IntakeError):
    return JSONResponse({"error": e.code}, status_code=e.status)


@app.exception_handler(Exception)
def _unexpected(_: Request, e: Exception):
    log.exception("unexpected error")       # details stay in the server log, not the response
    return JSONResponse({"error": "internal_error"}, status_code=500)


# --------------------------------------------------------------------------- auth

def customer(application_id: str, authorization: Annotated[str | None, Header()] = None,
             x_device_id: Annotated[str | None, Header()] = None) -> Application:
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(401, "missing_token")
    a = store.app_for(authorization[7:], x_device_id)
    if a is None:
        raise HTTPException(401, "invalid_session")
    if a.id != application_id:
        raise HTTPException(403, "not_your_application")
    return a


def staff(x_staff_key: Annotated[str | None, Header()] = None) -> None:
    if not settings.staff_key:
        raise HTTPException(403, "staff_api_disabled")
    if not x_staff_key or not hmac.compare_digest(x_staff_key, settings.staff_key):
        raise HTTPException(403, "bad_staff_key")


Customer = Annotated[Application, Depends(customer)]


def _read(file: UploadFile) -> bytes:
    data = file.file.read(settings.max_upload_bytes + 1)
    if len(data) > settings.max_upload_bytes:
        raise IntakeError("file_too_large", 413)
    if not data:
        raise IntakeError("empty_file")
    return data


# --------------------------------------------------------------------------- public

@app.get("/v1/health")
def health():
    return {"ok": True, "engine": pipeline.ENGINE_VERSION, "sandbox": settings.sandbox}


@app.get("/v1/models")
def models():
    return registry.status()


class OtpSend(BaseModel):
    phone: str = Field(pattern=r"^[6-9]\d{9}$")


class OtpVerify(OtpSend):
    otp: str = Field(pattern=r"^\d{6}$")
    deviceId: str = Field(min_length=4, max_length=128)


@app.post("/v1/otp/send", status_code=204)
def otp_send(body: OtpSend):
    if not settings.sandbox:
        raise IntakeError("sms_not_configured", 501)
    store.put_otp(body.phone, sandbox.DEMO_OTP, settings.otp_ttl_seconds, settings.otp_max_attempts)
    return Response(status_code=204)


@app.post("/v1/otp/verify")
def otp_verify(body: OtpVerify):
    result = store.check_otp(body.phone, body.otp)
    if result != "ok":
        raise IntakeError(result, 401)
    a, token = store.new_application(body.phone, body.deviceId, sandbox.persona_for(body.phone), settings.session_ttl_hours)
    return {"token": token, "deviceId": body.deviceId, "applicationId": a.id}


@app.get("/v1/sandbox/personas/{key}/documents/{slot}")
def sample_document(key: str, slot: str):
    """A sample document for a fictional demo person, to photograph or upload in a demo."""
    if not settings.sandbox or key not in sandbox.PERSONAS:
        raise HTTPException(404, "not_found")
    data = sandbox.sample_document(sandbox.PERSONAS[key], slot)
    if data is None:
        raise HTTPException(404, "no_sample_for_slot")
    return Response(data, media_type="image/jpeg")


# --------------------------------------------------------------------------- customer

@app.get("/v1/applications/{application_id}/samples/{kind}")
def sample(kind: str, a: Customer):
    """Sandbox only: a sample document for this demo person (kind = an upload slot) or a
    stand-in property photo (kind = photo-<label>), so a demo can run without a camera."""
    if not settings.sandbox:
        raise HTTPException(404, "not_found")
    if kind.startswith("photo-"):
        return Response(sandbox.sample_photo(a.id + kind), media_type="image/jpeg")
    data = sandbox.sample_document(a.persona, kind, a.pan or "ABCPK1234K", seed=a.id)
    if data is None:
        raise HTTPException(404, "no_sample")
    return Response(data, media_type="image/jpeg")


class Consents(BaseModel):
    given: dict[str, bool]
    options: dict = {}
    optional: dict[str, bool] = {}


@app.put("/v1/applications/{application_id}/consents")
def put_consents(body: Consents, a: Customer):
    return intake.record_consents(a, body.model_dump())


class ProfileRequest(BaseModel):
    pan: str = Field(min_length=10, max_length=10)


@app.post("/v1/applications/{application_id}/profile")
def profile(body: ProfileRequest, a: Customer):
    p = intake.fetch_profile(a, body.pan)
    return {"name": p["name"], "dateOfBirth": p["dob"], "panMasked": p["pan_masked"], "aadhaarMasked": p["aadhaar_masked"],
            "address": p["address"], "employment": p["employment"], "employer": p["employer"],
            "monthlyIncome": p["monthly_income"], "existingEmi": p["existing_emi"], "bureauScore": p["bureau"].get("score")}


@app.post("/v1/applications/{application_id}/selfie")
def selfie(a: Customer, file: UploadFile = File(...)):
    if a.profile is None:
        raise IntakeError("profile_required", 409)
    r = intake.check_selfie(a, _read(file))
    fm = a.face_match
    return {"faceFound": r["face_found"], "live": r["live"], "livenessScore": (r["liveness"] or {}).get("score", 0.0),
            "faceMatch": fm["match"] if fm else r["face_found"], "matchScore": (fm or {}).get("similarity") or 0.0,
            "matchPending": fm is None}


@app.post("/v1/applications/{application_id}/documents")
def document(a: Customer, slot: Annotated[str, Form()], file: UploadFile = File(...)):
    if a.profile is None:
        raise IntakeError("profile_required", 409)
    rec = intake.upload_document(store, a, slot, _read(file), file.filename or "")
    return intake.doc_result(rec)


class LoanRequest(BaseModel):
    product: Literal["homeLoan", "lap"]
    amount: float = Field(gt=0, le=1e9)
    years: int = Field(ge=1, le=40)
    propertyValue: float = Field(gt=0, le=1e10)


def _signals(a: Application) -> dict:
    return {"session_minutes": (now() - a.signed_in_at).total_seconds() / 60}


@app.post("/v1/applications/{application_id}/in-principle")
def in_principle(body: LoanRequest, a: Customer):
    if a.profile is None:
        raise IntakeError("profile_required", 409)
    r = pipeline.run(store, ledger, a, body.model_dump(), signals=_signals(a))
    return pipeline.app_decision(r)


class PropertyIn(BaseModel):
    city: str = Field(min_length=2, max_length=60)
    locality: str = Field(min_length=2, max_length=80)
    society: str | None = Field(default=None, max_length=80)
    areaSqft: float = Field(gt=100, lt=50000)
    bhk: int = Field(ge=1, le=10)
    declaredPrice: float = Field(gt=0, le=1e10)
    isNew: bool = False


class PhotoMeta(BaseModel):
    label: str = Field(max_length=40)
    takenAt: str
    latitude: float | None = None
    longitude: float | None = None
    accuracyM: float | None = None


@app.post("/v1/applications/{application_id}/final")
def final(a: Customer, request: Annotated[str, Form()], property: Annotated[str, Form()],
          photos_meta: Annotated[str, Form()] = "[]", photos: list[UploadFile] = File(default=[])):
    if a.in_principle is None:
        raise IntakeError("in_principle_required", 409)
    try:
        req = LoanRequest.model_validate(json.loads(request)).model_dump()
        prop = PropertyIn.model_validate(json.loads(property)).model_dump()
        meta = [PhotoMeta.model_validate(m).model_dump() for m in json.loads(photos_meta)]
    except (ValueError, TypeError) as e:
        raise IntakeError("bad_request") from e
    if a.in_principle["offer"]["outcome"] == "reject":
        return pipeline.app_decision(a.in_principle)
    if len(photos) > 8 or len(photos) != len(meta):
        raise IntakeError("bad_photos")
    shots = [{**m, "bytes": _read(f)} for m, f in zip(meta, photos)]
    r = pipeline.run(store, ledger, a, req, prop, shots, signals=_signals(a))
    return pipeline.app_decision(r)


@app.get("/v1/applications/{application_id}")
def application(a: Customer):
    def brief(r):
        return r and {"outcome": r["offer"]["outcome"], "amount": r["offer"]["amount"], "record": r["record"]}
    return {"applicationId": a.id, "status": letters.status_text(a), "consents": a.consents is not None,
            "profile": a.profile is not None, "selfie": a.selfie is not None, "documents": sorted(a.documents),
            "inPrinciple": brief(a.in_principle), "final": brief(a.final)}


@app.get("/v1/applications/{application_id}/letter")
def letter(a: Customer, lang: str = "en"):
    try:
        return letters.letter(a, lang)
    except LookupError as e:
        raise IntakeError("no_decision", 409) from e
    except ValueError as e:
        raise IntakeError("unsupported_language") from e


class Question(BaseModel):
    question: str = Field(min_length=1, max_length=1000)
    lang: str = "en"


@app.post("/v1/applications/{application_id}/assistant")
def assistant(body: Question, a: Customer):
    try:
        return letters.assistant(a, body.question, body.lang)
    except ValueError as e:
        raise IntakeError("unsupported_language") from e


# --------------------------------------------------------------------------- staff

Staff = Annotated[None, Depends(staff)]


def _app(application_id: str) -> Application:
    a = store.apps.get(application_id)
    if a is None:
        raise HTTPException(404, "not_found")
    return a


@app.get("/v1/staff/applications/{application_id}/file-note")
def file_note(application_id: str, _: Staff):
    from models.llm import llm
    a = _app(application_id)
    r = a.final or a.in_principle
    if r is None:
        raise IntakeError("no_decision", 409)
    ev = r["evidence"]
    evidence = {"stage": r["stage"], "requested_amount": ev["request"]["amount"], "draft_offer": r["offer"]["amount"],
                "income_used": ev["income"]["income_used"], "income_source": ev["income"]["income_source"],
                "bureau_score": ev["profile"]["bureau"].get("score"),
                "scorecard": f"{ev['models']['scorecard']['score']} grade {ev['models']['scorecard']['grade']}",
                "fraud_probability": ev["models"]["fraud"]["fraud_probability"],
                "anomaly_alert": ev["models"]["anomaly"]["alert"], "aml_hits": len(ev["aml"]["hits"])}
    if ev.get("property"):
        evidence.update(valuation=f"{ev['property']['avm']['low']}-{ev['property']['avm']['high']}",
                        land_records=ev["property"]["land_records"]["detail"])
    case = {"application_id": a.id, "outcome": r["offer"]["outcome"], "evidence": evidence,
            "gates": [{"gate": g["gate"], "outcome": g["outcome"], "reasons": g["reasons"], "notes": g["notes"]}
                      for g in r["gates"]]}
    return llm.write_file_note(case)


@app.get("/v1/staff/applications/{application_id}/records")
def records(application_id: str, _: Staff):
    return ledger.for_application(application_id)


@app.get("/v1/staff/records/{seq}")
def record(seq: int, _: Staff):
    r = ledger.get(seq)
    if r is None:
        raise HTTPException(404, "not_found")
    return r


@app.post("/v1/staff/records/{seq}/replay")
def replay(seq: int, _: Staff):
    r = ledger.get(seq)
    if r is None:
        raise HTTPException(404, "not_found")
    return pipeline.replay(r)


@app.get("/v1/staff/ledger/verify")
def verify(_: Staff):
    return ledger.verify()
