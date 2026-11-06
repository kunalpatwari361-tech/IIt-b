"""Read the fields the engine needs from a document's OCR text (rules, no model).

OCR often drops spaces ("Name:ARJUNMEHTA", "NetPay:Rs.93,000.00"), so the patterns
allow missing spaces, and names are compared with spaces removed. A full Aadhaar
number is never kept: only its last four digits.
"""
from __future__ import annotations

import re

MONTHS = "jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec"
PAN = re.compile(r"\b([A-Z]{5}[0-9]{4}[A-Z])\b")
GSTIN = re.compile(r"\b([0-3][0-9][A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z])\b")
AADHAAR = re.compile(r"\b(?:[0-9X]{4}\s?[0-9X]{4}\s?([0-9]{4}))\b")
DATE = re.compile(r"\b(\d{2})[/-](\d{2})[/-](\d{4})\b")
AMOUNT = r"([0-9][0-9,]*(?:\.[0-9]{1,2})?)"


def amount(text: str | None) -> float | None:
    if not text:
        return None
    try:
        return float(text.replace(",", ""))
    except ValueError:
        return None


def squash(name: str) -> str:
    return re.sub(r"[^a-z]", "", (name or "").lower())


def name_score(a: str, b: str) -> float:
    """0-100: how alike two names are, ignoring spaces, case and initials' order."""
    from rapidfuzz import fuzz
    if not a or not b:
        return 0.0
    return max(fuzz.ratio(squash(a), squash(b)), fuzz.token_sort_ratio(a.lower(), b.lower()))


def _after(label: str, text: str) -> str | None:
    m = re.search(label + r"\s*[:.]?\s*([^\n]+)", text, re.I)
    return m.group(1).strip(" :.-") if m else None


def _find(rx: re.Pattern, up: str) -> str | None:
    """Look in the text as read, then with spaces removed (OCR runs words together)."""
    m = rx.search(up)
    if m:
        return m.group(1)
    m = re.search(rx.pattern.replace(r"\b", ""), up.replace(" ", ""))
    return m.group(1) if m else None


def _name(text: str) -> str | None:
    v = (_after(r"(?:employee|associate|legal|worker)?\s*name(?:\s*of\s*(?:the\s*)?(?:employee|worker))?", text)
         or _after(r"account\s*holder", text))
    if v:
        v = re.split(r"\s{2,}|\bDOB\b|\bdate\b", v, flags=re.I)[0].strip()
    # When a value is missing, the next line's label can be picked up instead: that's not a name.
    if v and re.search(r"employe|ofthe|number|panof|year", v.replace(" ", ""), re.I):
        return None
    return v or None


def _period(text: str) -> str | None:
    m = re.search(rf"({MONTHS})[a-z]*[\s,-]*(20\d\d)", text, re.I)
    return f"{m.group(1).title()} {m.group(2)}" if m else None


def extract(slot: str, text: str) -> dict[str, str]:
    """Fields for one document slot. Keys match the app's DocResult.fields."""
    up = text.upper()
    out: dict[str, str] = {}
    name = _name(text)
    if name:
        out["name"] = name
    if slot in ("pan", "salarySlip", "form16", "itr"):
        if _find(PAN, up):
            out["pan"] = _find(PAN, up)
    if slot == "aadhaar":
        m = AADHAAR.search(up)
        if m:
            out["aadhaar"] = f"XXXX XXXX {m.group(1)}"
    if slot in ("pan", "aadhaar"):
        m = DATE.search(text)
        if m:
            out["dob"] = f"{m.group(1)}/{m.group(2)}/{m.group(3)}"
    if slot == "salarySlip":
        lines = [l for l in text.splitlines() if l.strip()]
        if lines:
            out["employer"] = lines[0].strip()
        m = re.search(r"net\s*(?:pay|salary|amount|transfer|wages)[a-z\s]*[:.]?[^0-9\n]{0,25}" + AMOUNT, text, re.I)
        if m:
            out["netPay"] = m.group(1)
        if _period(text):
            out["period"] = _period(text)
    if slot == "form16":
        m = re.search(r"assessment\s*year\s*[:.]?\s*(20\d\d\s*-\s*\d{2,4})", text, re.I)
        if m:
            out["year"] = m.group(1).replace(" ", "")
        emp = _after(r"name\s*and\s*address\s*of\s*the\s*employer", text)
        if emp:
            out["employer"] = emp.split(",")[0].strip()
        employee = _after(r"name\s*and\s*address\s*of\s*the\s*employee", text)
        # A long address wraps, and OCR can put a stray piece (a PIN code) on the label's line.
        parts = [p.strip() for p in (employee or "").split(",") if len(re.sub(r"[^A-Za-z]", "", p)) >= 3]
        if parts:
            out["name"] = parts[0]
        else:
            out.pop("name", None)      # the first "Name" on a Form 16 is the employer's
    if slot == "itr":
        m = re.search(r"assessment\s*year\s*[:.]?\s*(20\d\d\s*-\s*\d{2,4})", text, re.I)
        if m:
            out["year"] = m.group(1).replace(" ", "")
        m = re.search(r"(?<!gross\s)(?<!gross)total\s*income\s*[:.]?\s*(?:rs\.?)?\s*" + AMOUNT, text, re.I)
        if m:
            out["income"] = m.group(1)
    if slot == "gst":
        if _find(GSTIN, up):
            out["gstin"] = _find(GSTIN, up)
        trade = _after(r"trade\s*name(?:,?\s*if\s*any)?", text)
        if trade:
            out["business"] = trade
    if slot == "bankStatement":
        m = re.search(r"account\s*(?:number|no\.?)\s*[:.]?\s*([X0-9]{6,})", text, re.I)
        if m:
            out["account"] = m.group(1)
    return out
