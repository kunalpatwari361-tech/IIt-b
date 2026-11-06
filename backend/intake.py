"""What happens when the customer gives consent, takes a selfie or uploads a document.

Each step runs its models straight away, so the app can show the result, and keeps
the evidence on the application for the decision gates.
"""
from __future__ import annotations

import hashlib
from datetime import date

from models.document_classifier import classifier
from models.transaction_tagger import tagger

from . import fields, sandbox
from .checks import links, tamper
from .config import settings
from .store import Application, Store, now

REQUIRED_CONSENTS = ("bureau", "aa", "kyc", "privacy")
SLOT_TYPES = {"pan": "pan_card", "aadhaar": "aadhaar_card", "salarySlip": "salary_slip", "form16": "form_16", "itr": "itr",
              "gst": "gst_certificate", "bankStatement": "bank_statement", "saleDeed": "sale_deed",
              "allotmentLetter": "allotment_letter", "encumbrance": "encumbrance_certificate",
              "propertyTax": "property_tax_receipt"}
TYPE_SLOTS = {v: k for k, v in SLOT_TYPES.items()}
NAMED_SLOTS = ("pan", "aadhaar", "salarySlip", "form16", "itr", "gst", "bankStatement")
ID_PHOTO_SLOTS = ("pan", "aadhaar")


class IntakeError(Exception):
    def __init__(self, code: str, status: int = 400):
        super().__init__(code)
        self.code, self.status = code, status


# --------------------------------------------------------------------------- consent

def record_consents(app: Application, body: dict) -> dict:
    """Save the customer's consent choices (DPDP Act 2023: specific, informed, and withdrawable)."""
    given = {k: bool(body.get("given", {}).get(k)) for k in REQUIRED_CONSENTS}
    options = body.get("options", {})
    accounts = {k: bool(v) for k, v in options.get("aaAccounts", {"salary": True}).items()}
    months = int(options.get("aaMonths", 12))
    if months not in (6, 12, 24):
        raise IntakeError("bad_aa_months")
    app.consents = {
        "given": given, "at": now().isoformat(),
        "aa": {"months": months, "accounts": accounts},
        "kyc": {"method": options.get("kycMethod", "aadhaarOtp"), "use_ckyc": bool(options.get("useCkyc"))},
        "bureau": {"recheck_before_payout": bool(options.get("recheckBeforePayout"))},
        "optional": {k: bool(v) for k, v in body.get("optional", {}).items()},
        "notice_version": "privacy-notice-v1",
    }
    app.consent_log.append({"at": app.consents["at"], "given": given, "optional": app.consents["optional"]})
    return app.consents


def consents_ok(app: Application) -> bool:
    c = app.consents
    return bool(c and all(c["given"].get(k) for k in REQUIRED_CONSENTS) and any(c["aa"]["accounts"].values()))


# --------------------------------------------------------------------------- data pull (eKYC, PAN, bureau, AA)

def fetch_profile(app: Application, pan: str) -> dict:
    if not consents_ok(app):
        raise IntakeError("consent_required", 409)
    pan = pan.strip().upper()
    if not fields.PAN.fullmatch(pan):
        raise IntakeError("bad_pan")
    p = app.persona
    app.pan = pan
    aadhaar_last4 = str(int(app.id.split("-")[-1]) % 10000).zfill(4)
    ekyc = sandbox.ekyc(p, aadhaar_last4)
    pan_check = sandbox.pan_verify(p, pan)
    bureau = sandbox.bureau(p)
    aa = sandbox.aa_statement(p, app.consents["aa"]["months"], app.consents["aa"]["accounts"])
    tagged = tagger.tag_statement(aa["transactions"])
    s = tagged["summary"]
    credits = sum(m.get(c, 0) for m in s["by_month"].values() for c in ("salary", "other_income", "cash_deposit"))
    s["avg_monthly_credits"] = round(credits / max(len(s["months"]), 1), 2)
    app.bank = {"model": tagged["model"], "model_version": tagged["model_version"], "summary": s,
                "account_masked": aa["account_masked"], "account_months": aa["account_months"],
                "accounts_shared": aa["accounts"], "months": aa["months"], "transactions": len(aa["transactions"])}
    itr = sandbox.itr(p)
    if p.employment == "salaried":
        income = s["avg_monthly_salary"] if s["salary_months"] else 0.0
    else:
        income = round(itr["total_income"] / 12, 2) if itr else 0.0
    existing_emi = max(bureau["existing_emi"], s["avg_monthly_emi"])
    app.sources = {"ekyc": ekyc, "pan": pan_check, "bureau": bureau, "itr": itr,
                   "aa": {k: v for k, v in aa.items() if k != "transactions"}}
    app.profile = {"name": ekyc["name"], "dob": ekyc["dob"], "gender": ekyc["gender"], "address": ekyc["address"],
                   "pincode": ekyc["pincode"], "address_months": ekyc["address_months"], "email": p.email,
                   "employment": p.employment, "employer": p.employer, "monthly_income": income,
                   "income_source": "bank salary credits (model 5)" if p.employment == "salaried" else "ITR via consent",
                   "existing_emi": existing_emi, "bureau": bureau, "pan_masked": pan_check["pan_masked"],
                   "pan_name": pan_check["name"], "aadhaar_masked": ekyc["aadhaar_masked"]}
    return app.profile


# --------------------------------------------------------------------------- selfie (models 9 and 10)

def check_selfie(app: Application, data: bytes) -> dict:
    from models.face_match import face
    from models.liveness import liveness
    try:
        d = face.model().describe(data)
    except ValueError as e:
        raise IntakeError("not_an_image", 415) from e
    result = {"face_found": d["faces_found"] > 0, "faces": d["faces_found"], "live": False, "liveness": None,
              "face_score": d["face_score"], "too_small": d["too_small"], "at": now().isoformat()}
    if d["fingerprint"] is not None:
        live = liveness.model().check(d["image"], d["face_box"])
        result.update(live=live["live"], liveness=live)
        app.selfie_fingerprint = d["fingerprint"]
    app.selfie = result
    _match_faces(app)
    return result


def _match_faces(app: Application) -> None:
    """Selfie against the ID photo, whichever of the two arrives second."""
    if app.selfie_fingerprint is None or app.id_fingerprint is None:
        return
    from models.face_match import face
    m = face.model()
    a = {"faces_found": 1, "fingerprint": app.selfie_fingerprint, "too_small": False}
    b = {"faces_found": 1, "fingerprint": app.id_fingerprint, "too_small": False}
    app.face_match = {**m.compare(a, b), "id_photo_from": app.id_photo_slot, "at": now().isoformat()}


# --------------------------------------------------------------------------- documents (models 8, 6, 11 + checks)

def _kind(data: bytes) -> str | None:
    if data[:5] == b"%PDF-":
        return "pdf"
    if data[:3] == b"\xff\xd8\xff":
        return "jpeg"
    if data[:8] == b"\x89PNG\r\n\x1a\n":
        return "png"
    if data[:4] == b"RIFF" and data[8:12] == b"WEBP":
        return "webp"
    return None


def upload_document(store: Store, app: Application, slot: str, data: bytes, filename: str) -> dict:
    from models.ocr import ocr
    if slot not in SLOT_TYPES:
        raise IntakeError("unknown_slot")
    if len(data) > settings.max_upload_bytes:
        raise IntakeError("file_too_large", 413)
    kind = _kind(data)
    if kind is None:
        raise IntakeError("unsupported_file", 415)
    read = ocr.read(data, filename)
    text = read["text"]
    cls = classifier.predict({"ocr_text": text, "expected_type": SLOT_TYPES[slot]})
    found = fields.extract(slot, text) if cls["flag"] == "pass" else {}
    rec = {"slot": slot, "file_kind": kind, "uploaded_at": now().isoformat(),
           "ocr": {k: read[k] for k in ("model_version", "pages", "sources", "passes", "mean_confidence", "has_hindi", "error")},
           "text_chars": len(text), "classifier": {k: cls[k] for k in ("model_version", "document_type", "confidence", "top3",
                                                                      "needs_review", "flag", "reason_code")},
           "accepted": cls["flag"] == "pass", "reason_code": cls["reason_code"], "fields": found,
           "tamper": tamper.check(data)}
    # The same file on another applicant's application. Documents are compared byte for byte:
    # every PAN card shares one template, so "looks alike" would match different people.
    digest = hashlib.sha256(data).hexdigest()
    rec["reuse"] = links.duplicate_check(app.id, digest, store.file_digests())
    app.file_digests.add(digest)
    if app.profile and found.get("name") and slot in NAMED_SLOTS:
        rec["name_score"] = round(fields.name_score(found["name"], app.profile["name"]), 1)
    if slot == "pan" and found.get("pan") and app.pan:
        rec["pan_matches"] = found["pan"] == app.pan
    if slot in ID_PHOTO_SLOTS and kind != "pdf" and rec["accepted"]:
        _id_photo(app, slot, data, rec)
    if slot == "saleDeed" and rec["accepted"]:
        from models.llm import llm
        rec["deed"] = llm.read_deed(text)
    app.documents[slot] = rec
    return rec


def _id_photo(app: Application, slot: str, data: bytes, rec: dict) -> None:
    from models.face_match import face
    d = face.model().describe(data)
    rec["id_photo_face"] = d["fingerprint"] is not None
    if d["fingerprint"] is not None and (app.id_fingerprint is None or slot == "aadhaar"):
        app.id_fingerprint, app.id_photo_slot = d["fingerprint"], slot
        _match_faces(app)


def doc_result(rec: dict) -> dict:
    """The app's DocResult."""
    detected = TYPE_SLOTS.get(rec["classifier"]["document_type"], rec["classifier"]["document_type"])
    shown = {k: v for k, v in rec["fields"].items() if k in ("name", "pan", "aadhaar", "employer", "netPay", "period", "year",
                                                              "income", "business", "gstin")}
    return {"slot": rec["slot"], "detectedType": detected, "confidence": rec["classifier"]["confidence"],
            "accepted": rec["accepted"], "reasonCode": rec["reason_code"], "fields": shown}


def today() -> date:
    return now().date()
