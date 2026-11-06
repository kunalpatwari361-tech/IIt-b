"""Sandbox data sources: fictional people, and stand-ins for UIDAI eKYC, the credit bureau,
the Account Aggregator, payroll (EPFO / employer), the ITR and land records.

The demo cases follow the report (and the app's sample engine):
  Ravi  (98765 00001)  salaried, HL Rs 45 lakh on a Rs 60 lakh flat  -> approved in both stages
  Meena (98765 00002)  shop owner, LAP Rs 60 lakh on Rs 1.2 crore    -> approved in principle, referred at the property (title gap)
  Arjun (98765 00003)  salaried, HL Rs 30 lakh, edited salary slip   -> rejected (the slip fails payroll verification)
Any other number behaves like a clean salaried applicant (Priya). Every person here is fictional.

In the sandbox only the *data sources* are fake. The models and rules that judge the
data are the real ones. Real adapters replace these functions one by one.
"""
from __future__ import annotations

import hashlib
import io
import random
from dataclasses import dataclass, field
from datetime import date, timedelta

DEMO_OTP = "123456"


@dataclass(frozen=True)
class Persona:
    key: str
    phone: str
    name: str
    dob: date
    gender: str
    employment: str              # "salaried" | "selfEmployed"
    employer: str
    income: float                # real net monthly income
    existing_emi: float
    email: str
    address: str
    city: str
    pincode: str
    address_months: int
    ifsc: str
    account: str                 # masked salary / main account
    account_months: int
    bureau: dict = field(default_factory=dict)
    renting: float = 0.0         # monthly rent, if the person rents
    edited_salary_slip: bool = False
    title_gap: bool = False
    itr_annual_income: float | None = None
    gstin: str | None = None
    lender: str = "HDFC BANK LTD"


def _bureau(score, years, total, active, outstanding, sanctioned, cards=True, enquiries=1):
    return {"score": score, "status": "scored" if score else "no_history", "history_years": years, "total_accounts": total,
            "active_accounts": active, "overdue_accounts": 0, "recent_delinquencies": 0, "enquiries_6m": enquiries,
            "new_accounts_6m": 0, "outstanding": outstanding, "sanctioned_total": sanctioned,
            "disbursed_total": round(sanctioned * 0.97), "avg_account_age_years": round(years * 0.45, 1),
            "has_credit_card": cards}


PERSONAS = {
    "ravi": Persona("ravi", "9876500001", "Ravi Kumar", date(1994, 3, 14), "M", "salaried", "Nimbus Software Pvt Ltd",
                    100000, 10000, "ravi.kumar@nimbussoftware.in", "Flat 304, Lake View Road, Kothrud, Pune, Maharashtra 411038",
                    "Pune", "411038", 62, "HDFC0000240", "XXXXXX0912", 88,
                    _bureau(765, 8.0, 3, 2, 420000, 900000)),
    "meena": Persona("meena", "9876500002", "Meena Sharma", date(1981, 7, 2), "F", "selfEmployed", "Sharma Garments (proprietor)",
                     180000, 15000, "meenasharma.garments@gmail.com", "12, Laxmi Road, Sadashiv Peth, Pune, Maharashtra 411030",
                     "Pune", "411030", 140, "SBIN0001234", "XXXXXX4410", 150,
                     _bureau(728, 12.0, 4, 2, 900000, 2200000, enquiries=0), title_gap=True,
                     itr_annual_income=2160000, gstin="27AFRPS4821K1Z5", lender="BAJAJ FINANCE LTD"),
    "arjun": Persona("arjun", "9876500003", "Arjun Mehta", date(1997, 11, 21), "M", "salaried", "Coral Retail India Pvt Ltd",
                     62000, 0, "arjun.mehta@coralretail.in", "B-7, Sai Residency, Wakad, Pune, Maharashtra 411057",
                     "Pune", "411057", 30, "ICIC0000611", "XXXXXX2287", 40,
                     _bureau(742, 3.0, 1, 1, 15000, 60000), renting=18000, edited_salary_slip=True),
    "priya": Persona("priya", "", "Priya Nair", date(1990, 5, 9), "F", "salaried", "Orchid Health Systems Ltd",
                     85000, 5000, "priya.nair@orchidhealth.in", "Flat 21, Green Park, Viman Nagar, Pune, Maharashtra 411014",
                     "Pune", "411014", 48, "UTIB0000123", "XXXXXX7731", 70,
                     _bureau(748, 6.0, 2, 1, 120000, 300000)),
}
BY_PHONE = {p.phone: p for p in PERSONAS.values() if p.phone}


def persona_for(phone: str) -> Persona:
    return BY_PHONE.get(phone, PERSONAS["priya"])


# --------------------------------------------------------------------------- UIDAI eKYC, PAN, bureau

def ekyc(p: Persona, aadhaar_last4: str) -> dict:
    return {"source": "sandbox-uidai-ekyc", "name": p.name, "dob": p.dob.isoformat(), "gender": p.gender,
            "address": p.address, "pincode": p.pincode, "aadhaar_masked": f"XXXX XXXX {aadhaar_last4}",
            "address_months": p.address_months, "photo": None}


def pan_verify(p: Persona, pan: str) -> dict:
    return {"source": "sandbox-nsdl-pan", "pan_masked": f"{pan[:2]}XXX{pan[5:9]}X", "name": p.name.upper(), "status": "valid",
            "aadhaar_linked": True}


def bureau(p: Persona) -> dict:
    return {"source": "sandbox-bureau", **p.bureau, "existing_emi": p.existing_emi}


# --------------------------------------------------------------------------- Account Aggregator

MON = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]


def _months_back(n: int, today: date) -> list[date]:
    first = today.replace(day=1)
    out = []
    for _ in range(n):
        first = (first - timedelta(days=1)).replace(day=1)
        out.append(first)
    return sorted(out)


def _ref(rng: random.Random, k: int = 12) -> str:
    return "".join(rng.choice("0123456789") for _ in range(k))


def aa_statement(p: Persona, months: int, accounts: dict[str, bool], today: date | None = None) -> dict:
    """Transactions from the accounts the customer chose to share, for the months they chose."""
    today = today or date.today()
    rng = random.Random(int(hashlib.sha256(f"{p.key}{months}".encode()).hexdigest()[:8], 16))
    txns: list[dict] = []
    emp = p.employer.upper().replace(" (PROPRIETOR)", "")
    for m in _months_back(months, today):
        tag = f"{MON[m.month - 1]} {m.year}"
        d = lambda day: m.replace(day=min(day, 28)).isoformat()
        if accounts.get("salary"):
            if p.employment == "salaried":
                txns.append({"date": d(1), "amount": p.income, "direction": "credit",
                             "text": f"NEFT CR-{p.ifsc}-{emp}-SALARY {tag}-{p.ifsc[:4]}N{_ref(rng, 11)}"})
            else:
                for i, buyer in enumerate(rng.sample(["RELIANCE TRENDS", "MAX FASHION", "VISHAL MEGA MART", "PANTALOONS",
                                                       "SHOPPERS STOP", "ZUDIO RETAIL"], 3)):
                    txns.append({"date": d(5 + 7 * i), "amount": round(p.income * 0.33 * rng.uniform(0.85, 1.2), -2),
                                 "direction": "credit", "text": f"NEFT CR-{p.ifsc}-{buyer} LTD-INV {rng.randint(1000, 9999)}-{_ref(rng)}"})
                txns.append({"date": d(26), "amount": round(p.income * 0.18, -2), "direction": "credit",
                             "text": f"CASH DEPOSIT-CDM S1AN{rng.randint(1000, 9999)} PUNE"})
                txns.append({"date": d(20), "amount": round(p.income * 0.05, -2), "direction": "debit",
                             "text": f"GST PMT CPIN {_ref(rng, 14)} {p.gstin}"})
            if p.existing_emi:
                txns.append({"date": d(5), "amount": p.existing_emi, "direction": "debit",
                             "text": f"ACH D- {p.lender}-P{rng.randint(100, 999)}ABC{rng.randint(1000, 9999)}"})
            if p.renting:
                txns.append({"date": d(3), "amount": p.renting, "direction": "debit",
                             "text": f"UPI/{_ref(rng)}/RENT {MON[m.month - 1]}/landlord{rng.randint(10, 99)}@oksbi/SBI"})
            txns.append({"date": d(9), "amount": rng.choice([1180, 1420, 1650, 2210]), "direction": "debit",
                         "text": f"BBPS/MSEDCL/{_ref(rng, 6)}"})
            txns.append({"date": d(12), "amount": rng.choice([399, 599, 799]), "direction": "debit",
                         "text": f"BIL/ONL/AIRTEL POSTPAID/{_ref(rng, 9)}"})
            for day in (6, 14, 22):
                shop = rng.choice(["SWIGGY", "BIGBASKET", "DMART", "AMAZON PAY", "ZOMATO"])
                txns.append({"date": d(day), "amount": rng.randint(300, 4200), "direction": "debit",
                             "text": f"UPI/{_ref(rng)}/{shop}/{shop.lower().replace(' ', '')}@ybl/Payment"})
            txns.append({"date": d(17), "amount": rng.choice([2000, 3000, 5000]), "direction": "debit",
                         "text": f"ATM WDL-ATM CASH S1B{rng.randint(1000, 9999)} PUNE"})
        if accounts.get("savings"):
            txns.append({"date": d(15), "amount": rng.choice([2000, 5000, 10000]), "direction": "debit",
                         "text": f"ACH D- ICICI PRU MF SIP-{_ref(rng, 8)}"})
            txns.append({"date": d(25), "amount": round(rng.uniform(80, 400), 2), "direction": "credit",
                         "text": "INT.PD:SB INTEREST CREDIT"})
    txns.sort(key=lambda t: t["date"])
    shared = [k for k, v in accounts.items() if v]
    return {"source": "sandbox-account-aggregator", "fip": p.ifsc[:4], "accounts": shared, "months": months,
            "account_masked": p.account, "account_months": p.account_months, "transactions": txns}


# --------------------------------------------------------------------------- verification sources

def payroll_net_pay(p: Persona) -> float | None:
    """What the employer's payroll (or EPFO wage record) says the person is paid."""
    return p.income if p.employment == "salaried" else None


def itr(p: Persona) -> dict | None:
    if p.itr_annual_income is None:
        return None
    return {"source": "sandbox-itd", "assessment_year": "2026-27", "total_income": p.itr_annual_income}


def land_records(p: Persona, city: str, locality: str) -> dict:
    """State land records + encumbrance certificate + CERSAI search, as one sandbox answer."""
    if p.title_gap:
        return {"source": "sandbox-land-records", "title": "gap",
                "detail": "One co-owner (Late Shri Ramesh Sharma) is recorded as deceased; no mutation in favour of the legal heirs.",
                "encumbrance_certificate": "nil encumbrance (13 years)", "cersai": "no charge registered"}
    return {"source": "sandbox-land-records", "title": "clear", "detail": "Seller's name is on the record of rights.",
            "encumbrance_certificate": "nil encumbrance (13 years)", "cersai": "no charge registered"}


# --------------------------------------------------------------------------- sample documents for demos

def _inr(x: float) -> str:
    s = f"{x:,.2f}"
    whole, dec = s.split(".")
    digits = whole.replace(",", "")
    if len(digits) > 3:
        head, tail = digits[:-3], digits[-3:]
        groups = []
        while len(head) > 2:
            groups.insert(0, head[-2:])
            head = head[:-2]
        if head:
            groups.insert(0, head)
        whole = ",".join(groups + [tail])
    return f"{whole}.{dec}"


def sample_lines(p: Persona, slot: str, pan: str = "ABCPK1234K") -> tuple[str, list] | None:
    """The printed lines of a sample document for this person (the document generator's format)."""
    month = MON[(date.today().month - 2) % 12].title()
    if slot == "pan":
        return "card", [("hi", "आयकर विभाग"), ("sub", "INCOME TAX DEPARTMENT"), ("sub", "GOVT. OF INDIA"),
                        ("photo", ""), ("kv", f"Name\t{p.name.upper()}"), ("kv", f"Date of Birth\t{p.dob:%d/%m/%Y}"),
                        ("sub", "Permanent Account Number Card"), ("title", pan)]
    if slot == "aadhaar":
        return "card", [("hi", "भारत सरकार"), ("sub", "Government of India"), ("photo", ""), ("kv", f"Name\t{p.name}"),
                        ("kv", f"DOB\t{p.dob:%d/%m/%Y}"), ("kv", f"Gender\t{'FEMALE' if p.gender == 'F' else 'MALE'}"),
                        ("title", "XXXX XXXX 4821"), ("hi", "मेरा आधार, मेरी पहचान")]
    if slot == "salarySlip" and p.employment == "salaried":
        net = p.income * (1.5 if p.edited_salary_slip else 1.0)
        gross = round(net * 1.12, -2)
        return "page", [("head", p.employer), ("title", f"Payslip for the month of {month} 2026"),
                        ("kv", f"Employee Name\t{p.name}"), ("kv", f"PAN\t{pan}"), ("kv", f"Bank A/c No.\t{p.account}"),
                        ("rowh", "Earnings | Amount (Rs.) | Deductions | Amount (Rs.)"),
                        ("row", f"Basic | {_inr(gross * 0.45)} | Provident Fund | {_inr(gross * 0.06)}"),
                        ("row", f"House Rent Allowance | {_inr(gross * 0.2)} | Professional Tax | 200.00"),
                        ("row", f"Special Allowance | {_inr(gross * 0.35)} | Income Tax (TDS) | {_inr(gross - net - gross * 0.06 - 200)}"),
                        ("sub", f"Net Pay: Rs. {_inr(net)}"),
                        ("small", "This is a computer generated payslip and does not require a signature.")]
    if slot == "form16" and p.employment == "salaried":
        annual = p.income * 12 * 1.12
        tax = max(annual - 1200000, 0) * 0.15
        return "page", [("title", "FORM NO. 16"), ("small", "[See rule 31(1)(a)]"), ("sub", "PART A"),
                        ("text", "Certificate under section 203 of the Income-tax Act, 1961 for tax deducted at source on "
                                 "salary paid to an employee under section 192"),
                        ("kv", f"Name and address of the Employer\t{p.employer}, {p.city}"),
                        ("kv", f"Name and address of the Employee\t{p.name.upper()}, {p.city}"),
                        ("kv", f"PAN of the Employee\t{pan}"), ("kv", "TAN of the Deductor\tPNEN04821C"),
                        ("kv", "Assessment Year\t2026-27"), ("kv", "Period with the Employer\tFrom 01-Apr-2025 To 31-Mar-2026"),
                        ("rowh", "Quarter(s) | Amount paid/credited | Amount of tax deducted (Rs.)"),
                        *[("row", f"Q{i} | {_inr(annual / 4)} | {_inr(tax / 4)}") for i in range(1, 5)],
                        ("row", f"Total (Rs.) | {_inr(annual)} | {_inr(tax)}"),
                        ("small", "Verification: I, the person responsible for deducting tax, certify that the information is true.")]
    if slot == "itr" and p.itr_annual_income:
        return "page", [("title", "INDIAN INCOME TAX RETURN ACKNOWLEDGEMENT"), ("kv", "Assessment Year\t2026-27"),
                        ("kv", f"Name\t{p.name.upper()}"), ("kv", f"PAN\t{pan}"), ("kv", "Form Number\tITR-3"),
                        ("kv", f"Gross Total Income\t{_inr(p.itr_annual_income * 1.1)}"),
                        ("kv", f"Total Income\t{_inr(p.itr_annual_income)}"),
                        ("small", "Income Tax Department, Centralized Processing Centre, Bengaluru")]
    if slot == "gst" and p.gstin:
        return "page", [("title", "Government of India"), ("title", "Form GST REG-06"), ("sub", "Registration Certificate"),
                        ("kv", f"Registration Number\t{p.gstin}"), ("kv", f"Legal Name\t{p.name.upper()}"),
                        ("kv", f"Trade Name, if any\t{p.employer.replace(' (proprietor)', '').upper()}"),
                        ("kv", "Constitution of Business\tProprietorship"), ("kv", f"Address of Principal Place of Business\t{p.address}"),
                        ("kv", "Date of Liability\t01/07/2017")]
    if slot == "bankStatement":
        return "page", [("head", "Bharat National Bank"), ("title", "STATEMENT OF ACCOUNT"),
                        ("kv", f"Account Holder\t{p.name.upper()}"), ("kv", f"Account Number\t{p.account}"),
                        ("kv", f"IFSC\t{p.ifsc}"), ("kv", f"Period\t01-May-2026 to 31-{month[:3]}-2026"),
                        ("rowh", "Date | Narration | Withdrawal | Deposit | Balance"),
                        ("row", f"01-10-2026 | NEFT CR SALARY | | {_inr(p.income)} | {_inr(p.income * 1.4)}"),
                        *([("row", f"05-10-2026 | ACH D- {p.lender} | {_inr(p.existing_emi)} | | {_inr(p.income * 1.3)}")]
                          if p.existing_emi else []),
                        ("small", "This is a system generated statement.")]
    if slot == "saleDeed":
        heirs = ("WHEREAS the said property was jointly owned by the Vendor and Late Shri Ramesh Sharma, who died on "
                 "4 March 2019, and no succession certificate or mutation in favour of his legal heirs has been obtained.")
        clean = "WHEREAS the Vendor is the absolute owner of the Schedule Property under a registered deed of sale dated 12 June 2011."
        return "page", [("title", "SALE DEED"),
                        ("text", f"This Sale Deed is made and executed on this 2 day of October, 2026 at {p.city}."),
                        ("text", "BY Shri Anil Deshmukh, aged about 58 years, residing at Shivaji Nagar, Pune, hereinafter "
                                 "called the VENDOR."),
                        ("text", f"IN FAVOUR OF {p.name}, residing at {p.address}, hereinafter called the PURCHASER."),
                        ("text", heirs if p.title_gap else clean),
                        ("text", "1. In consideration of Rs. 1,20,00,000/- paid by the Purchaser, the Vendor hereby sells the "
                                 "Schedule Property to the Purchaser."),
                        ("text", "2. The Vendor assures that the Schedule Property is free from all encumbrances."),
                        ("sub", "SCHEDULE OF PROPERTY"),
                        ("text", "Flat No. 702, Palm Meadows, Survey No. 141/2, Kharadi, Pune, Maharashtra, carpet area 1050 sq. ft."),
                        ("kv", "Document No.\t8812/2026"), ("kv", "Sub-Registrar\tHaveli No. 11, Pune"),
                        ("sign", "VENDOR"), ("sign", "PURCHASER")]
    return None


def sample_document(p: Persona, slot: str, pan: str = "ABCPK1234K", seed: str = "") -> bytes | None:
    """A JPEG of a sample document, drawn the same way as model 6's training documents.

    `seed` (the application id) changes the font and layout a little, so two demo
    applications never upload byte-identical files (which the engine flags as reuse).
    """
    spec = sample_lines(p, slot, pan)
    if spec is None:
        return None
    from models.document_classifier import render
    kind, lines = spec
    rng = random.Random(7 if not seed else int(hashlib.sha256(seed.encode()).hexdigest()[:8], 16))
    img = render.render({"kind": kind, "lines": lines}, rng)
    buf = io.BytesIO()
    img.save(buf, "JPEG", quality=88)
    return buf.getvalue()


def sample_photo(seed: str) -> bytes:
    """A stand-in property photo: coloured blocks, different for every seed (so no two look alike)."""
    from PIL import Image, ImageDraw
    rng = random.Random(int(hashlib.sha256(seed.encode()).hexdigest()[:8], 16))
    img = Image.new("RGB", (960, 720), tuple(rng.randint(0, 255) for _ in range(3)))
    d = ImageDraw.Draw(img)
    for _ in range(30):
        x, y = rng.randint(0, 900), rng.randint(0, 660)
        d.rectangle([x, y, x + rng.randint(30, 300), y + rng.randint(30, 240)], fill=tuple(rng.randint(0, 255) for _ in range(3)))
    buf = io.BytesIO()
    img.save(buf, "JPEG", quality=85)
    return buf.getvalue()
