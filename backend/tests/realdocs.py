"""Documents for a fictional *real-mode* applicant (Kavya Rao), drawn like the sandbox samples.

Real mode has no sandbox data sources, so these stand in for what a tester photographs:
PAN, Aadhaar, salary slip, Form 16 and a three-month bank statement. `face` puts a face
on the PAN card's photo, so the selfie can match it.
"""
from __future__ import annotations

import io
import random
from datetime import date

from backend import sandbox

KAVYA = sandbox.Persona("kavya", "9000011111", "Kavya Rao", date(1992, 8, 19), "F", "salaried", "Lotus Analytics Pvt Ltd",
                        95000, 8000, "kavya.rao@lotusanalytics.in", "Flat 12, Hill View, Aundh, Pune, Maharashtra 411007",
                        "Pune", "411007", 36, "HDFC0001111", "XXXXXX5521", 50)
PAN = "AKVPR4821K"
DECLARED = {"name": "Kavya Rao", "dob": "1992-08-19", "email": "kavya.rao@lotusanalytics.in",
            "address": "Flat 12, Hill View, Aundh, Pune", "employment": "salaried", "employer": "Lotus Analytics Pvt Ltd",
            "monthly_income": 95000, "existing_emi": 8000, "credit_score": 772}


def _jpeg(img) -> bytes:
    buf = io.BytesIO()
    img.convert("RGB").save(buf, "JPEG", quality=90)
    return buf.getvalue()


def document(slot: str, seed: str = "kavya") -> bytes:
    return sandbox.sample_document(KAVYA, slot, PAN, seed=seed)


def pan_with_face(face_jpeg: bytes, seed: str = "kavya") -> bytes:
    """The PAN card with a real face pasted where the photo goes (left side of the card)."""
    from PIL import Image
    card = Image.open(io.BytesIO(document("pan", seed))).convert("RGB")
    face = Image.open(io.BytesIO(face_jpeg)).convert("RGB")
    from PIL import ImageOps
    face = ImageOps.exif_transpose(face)
    w = card.width // 4
    face = face.resize((w, int(face.height * w / face.width)))
    card.paste(face, (card.width - w - 20, card.height // 2 - face.height // 2))
    return _jpeg(card)


def statement(seed: str = "kavya") -> bytes:
    """Three months of salary, EMI, rent and spending, with a running balance."""
    from models.document_classifier import render
    rows, bal = [], 20000.0

    def add(day, text, amount, credit):
        nonlocal bal
        bal = bal + amount if credit else bal - amount
        dep, wd = (f"{amount:,.2f}", "") if credit else ("", f"{amount:,.2f}")
        rows.append(("row", f"{day} | {text} | {wd} | {dep} | {bal:,.2f}"))

    rows.append(("row", f"01-07-2026 | Opening balance | | | {bal:,.2f}"))
    for mon, mm in (("JUL", "07"), ("AUG", "08"), ("SEP", "09")):
        add(f"01-{mm}-2026", f"NEFT CR-HDFC0001111-LOTUS ANALYTICS-SALARY {mon} 2026", 95000, True)
        add(f"05-{mm}-2026", "ACH D- BAJAJ FINANCE LTD-P400ABC1234", 8000, False)
        add(f"09-{mm}-2026", "BBPS/MSEDCL/558213", 1420, False)
        add(f"14-{mm}-2026", "UPI/518912345671/SWIGGY/swiggy@ybl/Payment", 640, False)
    lines = [("head", "Bharat National Bank"), ("title", "STATEMENT OF ACCOUNT"),
             ("kv", "Account Holder\tKAVYA RAO"), ("kv", "Account Number\tXXXXXX5521"), ("kv", "IFSC\tHDFC0001111"),
             ("kv", "Period\t01-Jul-2026 to 30-Sep-2026"),
             ("rowh", "Date | Narration | Withdrawal | Deposit | Balance"), *rows,
             ("small", "This is a system generated statement.")]
    img = render.render({"kind": "page", "lines": lines}, random.Random(seed))
    return _jpeg(img)
