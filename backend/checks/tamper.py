"""Tamper checks on uploaded files. Algorithms, not models.

- PDF: who made the file (an editing tool in Producer/Creator), whether it was edited
  after it was made (a modification date well after creation, or extra revisions
  appended to the file).
- Photo: an editing app named in the EXIF Software tag.

These only ever raise a flag for the fraud gate; a clean result proves nothing.
"""
from __future__ import annotations

import io
import re

EDITORS = re.compile(r"photoshop|gimp|illustrator|inkscape|canva|picsart|snapseed|pixlr|ilovepdf|smallpdf|sejda|"
                     r"pdfescape|pdf ?editor|foxit phantom|nitro pro|pdfelement|wondershare|sodapdf|pdffiller|docfly",
                     re.I)


def _pdf_date(value) -> str | None:
    m = re.search(r"(\d{14}|\d{12}|\d{8})", str(value or ""))
    return m.group(1)[:14].ljust(14, "0") if m else None


def check_pdf(data: bytes) -> dict:
    out = {"check": "tamper", "kind": "pdf", "signals": [], "producer": None, "creator": None}
    try:
        from pypdf import PdfReader
        reader = PdfReader(io.BytesIO(data))
        meta = reader.metadata or {}
        out["producer"], out["creator"] = meta.get("/Producer"), meta.get("/Creator")
        for field in ("/Producer", "/Creator"):
            if meta.get(field) and EDITORS.search(str(meta.get(field))):
                out["signals"].append(f"made with an editing tool ({meta.get(field)})")
        created, modified = _pdf_date(meta.get("/CreationDate")), _pdf_date(meta.get("/ModDate"))
        if created and modified and modified[:8] > created[:8]:
            out["signals"].append(f"modified after it was created ({created[:8]} -> {modified[:8]})")
    except Exception as e:
        out["signals"].append(f"PDF could not be parsed ({type(e).__name__})")
    revisions = data.count(b"%%EOF")
    if revisions > 1:
        out["signals"].append(f"{revisions - 1} later revision(s) appended to the file")
    out["suspicious"] = bool(out["signals"])
    return out


def check_image(data: bytes) -> dict:
    out = {"check": "tamper", "kind": "image", "signals": [], "software": None}
    try:
        from PIL import Image
        img = Image.open(io.BytesIO(data))
        software = img.getexif().get(305)  # EXIF tag 305: Software
        out["software"] = software
        if software and EDITORS.search(str(software)):
            out["signals"].append(f"edited with {software}")
    except Exception as e:
        out["signals"].append(f"image could not be parsed ({type(e).__name__})")
    out["suspicious"] = bool(out["signals"])
    return out


def check(data: bytes) -> dict:
    return check_pdf(data) if data[:5] == b"%PDF-" else check_image(data)
