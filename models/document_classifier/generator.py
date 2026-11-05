"""Generate fake Indian lending documents for the Nirnay document classifier (model 6).

Real customer papers never enter this repo (DPDP Act), and no public labelled
set covers what an Indian home-loan file holds, so we generate the documents.
Each has several *layouts*: different issuers and formats of the same type,
such as a corporate payslip, a government pay slip and a wage slip.
Tests hold out whole layouts, so accuracy is measured on formats the model has never seen.

Every person, firm, bank, builder and number here is made up. Bank, employer and
builder names are invented on purpose, so no document copies a real firm's papers.
Aadhaar numbers are always masked (XXXX XXXX 1234), as UIDAI requires for stored copies.

A document is a list of (style, text) lines that render.py draws as an image:
    head   coloured band with white text (letterhead)   title  big bold centred
    sub    bold line                                    text   paragraph (wrapped)
    kv     "label<TAB>value" in two columns             row    table cells split by " | "
    rowh   table header row                             small  small grey print
    hi     Hindi line (OCR usually garbles it, as in real scans)
    rule   horizontal line                              sign   signature line on the right
    photo / qr   boxes (cards only)
"""
from __future__ import annotations

import random
import string
from datetime import date, timedelta

CATEGORIES = {
    "pan_card": "PAN card or e-PAN (KYC)",
    "aadhaar_card": "Aadhaar card or e-Aadhaar letter, masked (KYC)",
    "salary_slip": "Monthly salary slip or pay advice (income)",
    "form_16": "Form 16 TDS certificate from the employer (income)",
    "itr": "Income tax return, ITR-V acknowledgement or computation of income (income)",
    "bank_statement": "Bank statement or passbook (income and banking)",
    "gst_certificate": "GST registration certificate or GSTIN details (self-employed)",
    "sale_deed": "Sale deed or conveyance deed (property title)",
    "allotment_letter": "Allotment letter from a builder or development authority (property)",
    "encumbrance_certificate": "Encumbrance certificate (property charges)",
    "property_tax_receipt": "Property tax receipt or bill (property)",
    "utility_bill": "Electricity, gas, water or phone bill (address proof)",
    "other": "Anything else: rent agreement, credit card statement, offer letter, invoice, policy",
}

FIRST_M = ["Rahul", "Amit", "Suresh", "Venkatesh", "Arjun", "Mohammed", "Imran", "Rajesh", "Sanjay", "Prakash",
           "Karthik", "Harpreet", "Joseph", "Anand", "Vivek", "Manoj", "Abhishek", "Siddharth", "Nitin", "Ganesh",
           "Ravi", "Sandeep", "Deepak", "Aditya", "Farhan", "Balaji", "Subhash", "Gaurav"]
FIRST_F = ["Priya", "Sunita", "Anjali", "Lakshmi", "Fatima", "Kavita", "Meena", "Deepa", "Pooja", "Neha", "Shalini",
           "Gurpreet", "Ayesha", "Divya", "Sneha", "Rekha", "Swati", "Nandini", "Revathi", "Shabnam", "Asha"]
SURNAMES = ["Sharma", "Verma", "Patel", "Reddy", "Iyer", "Nair", "Singh", "Khan", "Shaikh", "Joshi", "Kulkarni",
            "Patil", "Gupta", "Agarwal", "Das", "Banerjee", "Mukherjee", "Menon", "Pillai", "Rao", "Naidu", "Chauhan",
            "Yadav", "Mishra", "Thomas", "Fernandes", "Gill", "Sandhu", "Bhat", "Hegde", "Jain", "Mehta", "Shah",
            "Desai", "Ansari", "Kumar", "Gowda", "Saxena"]
# city, state, GST state code, PIN prefix
CITIES = [("Mumbai", "Maharashtra", "27", "400"), ("Pune", "Maharashtra", "27", "411"),
          ("Nagpur", "Maharashtra", "27", "440"), ("Bengaluru", "Karnataka", "29", "560"),
          ("Mysuru", "Karnataka", "29", "570"), ("Chennai", "Tamil Nadu", "33", "600"),
          ("Coimbatore", "Tamil Nadu", "33", "641"), ("Hyderabad", "Telangana", "36", "500"),
          ("Delhi", "Delhi", "07", "110"), ("Jaipur", "Rajasthan", "08", "302"),
          ("Lucknow", "Uttar Pradesh", "09", "226"), ("Noida", "Uttar Pradesh", "09", "201"),
          ("Kolkata", "West Bengal", "19", "700"), ("Ahmedabad", "Gujarat", "24", "380"),
          ("Surat", "Gujarat", "24", "395"), ("Indore", "Madhya Pradesh", "23", "452"),
          ("Bhopal", "Madhya Pradesh", "23", "462"), ("Kochi", "Kerala", "32", "682"),
          ("Gurugram", "Haryana", "06", "122"), ("Patna", "Bihar", "10", "800"),
          ("Chandigarh", "Chandigarh", "04", "160"), ("Visakhapatnam", "Andhra Pradesh", "37", "530")]
LOCALITIES = ["Shivaji Nagar", "Gandhi Road", "MG Road", "Sector 21", "Anna Nagar", "Jayanagar 4th Block",
              "Salt Lake", "Banjara Hills", "Civil Lines", "Model Town", "Vijay Nagar", "Kothrud", "Andheri East",
              "Indiranagar", "T Nagar", "Gomti Nagar", "Navrangpura", "Kakkanad", "Ashok Vihar", "Hadapsar"]
STREETS = ["Lake View Road", "Station Road", "Temple Street", "Main Road", "Cross Road", "Ring Road", "Park Lane",
           "Market Road", "Church Street", "Nehru Marg"]
EMPLOYERS = ["Nimbus Software Pvt Ltd", "Sahyadri Engineering Works Ltd", "Bluewave Logistics Pvt Ltd",
             "Orchid Health Systems Ltd", "Kaveri Textiles Ltd", "Pinnacle Infotech Solutions LLP",
             "Greenleaf Agro Foods Pvt Ltd", "Meridian Auto Components Ltd", "Brightpath Education Services",
             "Vertex Pharma Labs Pvt Ltd", "Coral Retail India Pvt Ltd", "Trident Power Systems Ltd"]
GOVT_OFFICES = ["Office of the Accountant General", "Directorate of Health Services", "District Collectorate",
                "Public Works Department", "Office of the Commissioner of Customs", "State Water Resources Department"]
BANKS = [("Bharat National Bank", "BNBK"), ("Sahyadri Co-operative Bank", "SCBL"), ("Unity Commercial Bank", "UCBX"),
         ("Deccan Grameen Bank", "DGBK"), ("Indus Valley Bank", "IVBL"), ("Coastal Federal Bank", "CFBK"),
         ("Metro City Bank", "MCBL"), ("Ganga Yamuna Bank", "GYBK")]
BUILDERS = ["Sai Krupa Developers", "Shree Ganesh Infra LLP", "Green Valley Builders", "Skyline Constructions Pvt Ltd",
            "Riverstone Realty", "Lotus Habitat LLP", "Vrindavan Estates", "Sunrise Infraprojects Ltd",
            "Coastal Homes Pvt Ltd", "Silver Oak Developers"]
PROJECTS = ["Palm Meadows", "Sapphire Heights", "Green Acres", "Lake Vista", "Royal Enclave", "Orchid Residency",
            "Silver Springs", "Tulip Towers", "Emerald Park", "Sunshine Avenue"]
DISCOMS = ["City Power Distribution Co Ltd", "Western Electricity Supply Ltd", "Southern Power Distribution Co",
           "Northern Grid Electricity Ltd", "Eastern Power Supply Corporation"]
FIRMS = ["Shree Balaji Traders", "Ganesh Electricals", "Annapurna Sweets", "Kaveri Hardware Stores", "Royal Tailors",
         "Sai Medicals", "New India Auto Works", "Lakshmi Textiles", "Patel Agro Agencies", "Om Sai Enterprises"]
MONTHS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October",
          "November", "December"]


# ---------------------------------------------------------------- fill-ins

def _digits(rng, k):
    return "".join(rng.choices(string.digits, k=k))


def _letters(rng, k):
    return "".join(rng.choices(string.ascii_uppercase, k=k))


def inr(x: float, decimals: bool = True) -> str:
    """Indian grouping: 12,34,567.00"""
    neg, x = x < 0, abs(x)
    whole, frac = divmod(round(x * 100), 100)
    s = str(int(whole))
    if len(s) > 3:
        head, tail = s[:-3], s[-3:]
        head = ",".join([head[max(i - 2, 0):i] for i in range(len(head), 0, -2)][::-1])
        s = head + "," + tail
    return ("-" if neg else "") + s + (f".{int(frac):02d}" if decimals else "")


_ONES = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve",
         "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"]
_TENS = ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]


def words(n: int) -> str:
    """Rupees in words, Indian system (lakh, crore)."""
    def two(k):
        return _ONES[k] if k < 20 else (_TENS[k // 10] + (" " + _ONES[k % 10] if k % 10 else ""))

    def three(k):
        return (_ONES[k // 100] + " Hundred" + (" " if k % 100 else "") if k >= 100 else "") + (two(k % 100) if k % 100 else "")
    n = int(n)
    if n == 0:
        return "Zero"
    parts = []
    for size, name in ((10**7, "Crore"), (10**5, "Lakh"), (1000, "Thousand")):
        if n >= size:
            parts.append(f"{words(n // size) if n // size >= 100 else two(n // size)} {name}")
            n %= size
    if n:
        parts.append(three(n))
    return " ".join(parts)


def _date(rng, start=date(2023, 1, 1), days=1300) -> date:
    return start + timedelta(days=rng.randrange(days))


def _d(dt: date, style: int = 0) -> str:
    return [dt.strftime("%d/%m/%Y"), dt.strftime("%d-%m-%Y"), dt.strftime("%d-%b-%Y"), dt.strftime("%d.%m.%Y"),
            dt.strftime("%d %B %Y")][style % 5]


def _pan(rng, kind="P", surname="K"):
    return _letters(rng, 3) + kind + surname[0].upper() + _digits(rng, 4) + _letters(rng, 1)


def _person(rng: random.Random) -> dict:
    female = rng.random() < 0.4
    first = rng.choice(FIRST_F if female else FIRST_M)
    surname = rng.choice(SURNAMES)
    father = f"{rng.choice(FIRST_M)} {surname}"
    city, state, gst_code, pin = rng.choice(CITIES)
    dob = date(rng.randint(1965, 2001), rng.randint(1, 12), rng.randint(1, 28))
    house = f"{rng.choice(['Flat', 'House No.', 'Plot No.', 'Door No.'])} {rng.randint(1, 999)}"
    return {
        "name": f"{first} {surname}", "first": first, "surname": surname, "father": father,
        "female": female, "rel": "D/o" if female else "S/o", "gender": "FEMALE" if female else "MALE",
        "dob": dob, "age": 2025 - dob.year, "pan": _pan(rng, "P", surname),
        "aadhaar": "XXXX XXXX " + _digits(rng, 4), "mobile": "XXXXXX" + _digits(rng, 4),
        "city": city, "state": state, "gst_code": gst_code, "pin": pin + _digits(rng, 3),
        "line1": f"{house}, {rng.choice(STREETS)}", "locality": rng.choice(LOCALITIES),
    }


def _address(p: dict) -> str:
    return f"{p['line1']}, {p['locality']}, {p['city']}, {p['state']} - {p['pin']}"


def _fy(rng) -> tuple[str, str]:
    y = rng.choice([2022, 2023, 2024, 2025])
    return f"{y}-{str(y + 1)[2:]}", f"{y + 1}-{str(y + 2)[2:]}"  # financial year, assessment year


def _bank(rng):
    name, code = rng.choice(BANKS)
    return name, f"{code}0{_digits(rng, 6)}"


def _gstin(rng, p):
    return p["gst_code"] + p["pan"] + str(rng.randint(1, 3)) + "Z" + rng.choice(string.ascii_uppercase + string.digits)


def _survey(rng):
    return f"{rng.randint(1, 450)}/{rng.randint(1, 9)}{rng.choice(['', 'A', 'B'])}"


def _builder_area(rng):
    return rng.choice([450, 520, 610, 685, 742, 810, 905, 1050, 1180, 1320])


# ---------------------------------------------------------------- document types
# Each returns (kind, lines). kind is "card" (ID-card sized) or "page" (A4).

def pan_card(L, rng):
    p = _person(rng)
    if L == 0:  # new-style card
        return "card", [("hi", "आयकर विभाग"), ("sub", "INCOME TAX DEPARTMENT"), ("hi", "भारत सरकार"),
                        ("sub", "GOVT. OF INDIA"), ("photo", ""), ("small", "स्थायी लेखा संख्या कार्ड"),
                        ("small", "Permanent Account Number Card"), ("sub", p["pan"]), ("small", "नाम / Name"),
                        ("sub", p["name"].upper()), ("small", "पिता का नाम / Father's Name"), ("sub", p["father"].upper()),
                        ("small", "जन्म की तारीख / Date of Birth"), ("sub", _d(p["dob"])), ("small", "हस्ताक्षर / Signature")]
    if L == 1:  # old-style card
        return "card", [("sub", "INCOME TAX DEPARTMENT"), ("sub", "GOVT. OF INDIA"), ("photo", ""),
                        ("text", p["name"].upper()), ("text", p["father"].upper()), ("text", _d(p["dob"])),
                        ("small", "Permanent Account Number"), ("sub", p["pan"]), ("small", "Signature")]
    if L == 2:  # e-PAN
        return "card", [("hi", "आयकर विभाग भारत सरकार"), ("sub", "INCOME TAX DEPARTMENT  GOVT. OF INDIA"),
                        ("title", "e - Permanent Account Number (e-PAN) Card"), ("photo", ""), ("qr", ""),
                        ("kv", f"Permanent Account Number\t{p['pan']}"), ("kv", f"Name\t{p['name'].upper()}"),
                        ("kv", f"Father's Name\t{p['father'].upper()}"), ("kv", f"Date of Birth\t{_d(p['dob'])}"),
                        ("kv", f"Gender\t{p['gender'].title()}"),
                        ("small", "This is an electronically generated e-PAN card. Signature not required.")]
    if L == 3:  # firm or company card
        firm = rng.choice(FIRMS + [b for b in BUILDERS])
        kind = "F" if "LLP" in firm or rng.random() < 0.5 else "C"
        return "card", [("hi", "आयकर विभाग"), ("sub", "INCOME TAX DEPARTMENT"), ("sub", "GOVT. OF INDIA"),
                        ("small", "Permanent Account Number Card"), ("sub", _pan(rng, kind, firm)), ("qr", ""),
                        ("small", "Name"), ("sub", firm.upper()),
                        ("small", "Date of Incorporation/Formation"), ("sub", _d(_date(rng, date(1995, 1, 1), 9000)))]
    # L == 4: PAN allotment letter that comes with the card
    ack = _digits(rng, 15)
    return "page", [("title", "PERMANENT ACCOUNT NUMBER (PAN) ALLOTMENT LETTER"),
                    ("small", "Income Tax PAN Services Unit"), ("kv", f"Acknowledgement Number\t{ack}"),
                    ("kv", f"Date\t{_d(_date(rng), 2)}"), ("text", f"To,\n{p['name']}\n{_address(p)}"),
                    ("text", f"Dear {p['first']}, We are pleased to inform you that, based on your application, "
                             f"the Income Tax Department has allotted you the Permanent Account Number given below. "
                             f"Your PAN card is enclosed with this letter."),
                    ("kv", f"PAN\t{p['pan']}"), ("kv", f"Name on PAN\t{p['name'].upper()}"),
                    ("kv", f"Father's Name\t{p['father'].upper()}"), ("kv", f"Date of Birth\t{_d(p['dob'])}"),
                    ("text", "Please quote your PAN in all your transactions with the Income Tax Department, "
                             "and in all documents and returns. Keep this letter safely for future reference."),
                    ("small", "This is a computer generated letter and does not require a signature.")]


def aadhaar_card(L, rng):
    p = _person(rng)
    enrol = f"{_digits(rng, 4)}/{_digits(rng, 5)}/{_digits(rng, 5)}"
    vid = "XXXX XXXX XXXX " + _digits(rng, 4)
    addr = f"{p['rel']} {p['father']}, {p['line1']}, {p['locality']}, {p['city']}, {p['state']} - {p['pin']}"
    front = [("hi", "भारत सरकार"), ("sub", "Government of India"), ("photo", ""), ("text", p["name"]),
             ("text", f"जन्म तिथि / DOB: {_d(p['dob'])}"), ("text", f"{'महिला' if p['female'] else 'पुरुष'} / {p['gender']}"),
             ("title", p["aadhaar"]), ("hi", "मेरा आधार, मेरी पहचान")]
    back = [("hi", "भारतीय विशिष्ट पहचान प्राधिकरण"), ("sub", "Unique Identification Authority of India"),
            ("text", f"Address: {addr}"), ("qr", ""), ("title", p["aadhaar"]),
            ("small", "1947   help@uidai.gov.in   www.uidai.gov.in")]
    if L == 0:
        return "card", front
    if L == 1:
        return "card", back
    if L == 2:  # e-Aadhaar letter
        return "page", [("hi", "भारतीय विशिष्ट पहचान प्राधिकरण"), ("head", "Unique Identification Authority of India"),
                        ("hi", "भारत सरकार"), ("sub", "Government of India"),
                        ("kv", f"Enrolment No.\t{enrol}"), ("text", f"To\n{p['name']}\n{addr}"),
                        ("kv", f"Mobile\t{p['mobile']}"), ("hi", "आपका आधार क्रमांक / Your Aadhaar No. :"),
                        ("title", p["aadhaar"]), ("kv", f"VID\t{vid}"), ("hi", "मेरा आधार, मेरी पहचान"),
                        ("text", "Aadhaar is a proof of identity, not of citizenship. Verify identity using "
                                 "Secure QR Code / Offline XML / Online Authentication."),
                        ("text", "This is electronically generated letter."),
                        ("kv", f"Issue Date\t{_d(_date(rng, date(2012, 1, 1), 4000))}"),
                        ("kv", f"Download Date\t{_d(_date(rng))}"), ("qr", "")] + front[1:7] + back[1:4]
    if L == 3:  # masked Aadhaar print
        return "page", [("head", "Unique Identification Authority of India"), ("title", "Masked Aadhaar"),
                        ("text", "In a Masked Aadhaar the first 8 digits of the Aadhaar number are replaced with "
                                 "characters like XXXX-XXXX and only the last 4 digits are visible."),
                        ("kv", f"Name\t{p['name']}"), ("kv", f"Date of Birth\t{_d(p['dob'])}"),
                        ("kv", f"Gender\t{p['gender']}"), ("kv", f"Aadhaar No.\t{p['aadhaar']}"),
                        ("kv", f"Address\t{addr}"), ("qr", ""),
                        ("small", "Aadhaar is valid throughout the country. You need to enrol only once for Aadhaar.")]
    # L == 4: PVC card scanned front and back together
    return "card", [("sub", "Government of India"), ("photo", ""), ("text", p["name"]),
                    ("text", f"DOB: {_d(p['dob'])}  {p['gender']}"), ("sub", p["aadhaar"]),
                    ("small", f"Issue Date: {_d(_date(rng, date(2015, 1, 1), 3000))}  Print Date: {_d(_date(rng))}"),
                    ("sub", "Unique Identification Authority of India"), ("small", f"Address: {addr}"),
                    ("qr", ""), ("small", f"VID: {vid}")]


def _pay(rng, gross):
    basic = round(gross * rng.uniform(0.4, 0.5), -1)
    hra = round(basic * rng.choice([0.4, 0.5]), -1)
    conv = rng.choice([1600, 1920, 2000])
    special = round(gross - basic - hra - conv, -1)
    pf = round(min(basic, 15000) * 0.12)
    ptax = 200
    tds = round(max(gross - 50000, 0) * rng.uniform(0.05, 0.12), -1)
    earn = [("Basic", basic), ("House Rent Allowance", hra), ("Conveyance Allowance", conv), ("Special Allowance", special)]
    ded = [("Provident Fund", pf), ("Professional Tax", ptax), ("Income Tax (TDS)", tds)]
    return earn, ded


def salary_slip(L, rng):
    p = _person(rng)
    emp = rng.choice(EMPLOYERS)
    m, y = rng.choice(MONTHS), rng.choice([2024, 2025, 2026])
    gross = rng.choice(range(25000, 260000, 2500))
    earn, ded = _pay(rng, gross)
    te, td = sum(v for _, v in earn), sum(v for _, v in ded)
    net = te - td
    bank, ifsc = _bank(rng)
    acct = "XXXXXX" + _digits(rng, 4)
    if L == 0:  # corporate payroll system
        rows = [("rowh", "Earnings | Amount (Rs.) | Deductions | Amount (Rs.)")]
        for i in range(max(len(earn), len(ded))):
            e = earn[i] if i < len(earn) else ("", None)
            d = ded[i] if i < len(ded) else ("", None)
            rows.append(("row", f"{e[0]} | {inr(e[1]) if e[1] is not None else ''} | {d[0]} | {inr(d[1]) if d[1] is not None else ''}"))
        return "page", [("head", emp), ("small", f"{p['locality']}, {p['city']}"),
                        ("title", f"Payslip for the month of {m} {y}"),
                        ("kv", f"Employee Code\tE{_digits(rng, 5)}"), ("kv", f"Employee Name\t{p['name']}"),
                        ("kv", f"Designation\t{rng.choice(['Senior Engineer', 'Manager', 'Analyst', 'Executive', 'Team Lead'])}"),
                        ("kv", f"Department\t{rng.choice(['Operations', 'Finance', 'Technology', 'Sales', 'HR'])}"),
                        ("kv", f"Date of Joining\t{_d(_date(rng, date(2012, 1, 1), 4000))}"),
                        ("kv", f"PAN\t{p['pan']}"), ("kv", f"UAN\t{_digits(rng, 12)}"),
                        ("kv", f"Bank A/c No.\t{acct}"), ("kv", f"Days Paid\t{rng.choice([30, 31, 28])}"),
                        *rows, ("row", f"Gross Earnings | {inr(te)} | Total Deductions | {inr(td)}"),
                        ("sub", f"Net Pay: Rs. {inr(net)}"), ("text", f"(Rupees {words(net)} Only)"),
                        ("small", "This is a computer generated payslip and does not require a signature.")]
    if L == 1:  # small firm, typed
        return "page", [("title", emp.upper()), ("title", "SALARY SLIP"), ("kv", f"Name of Employee\t{p['name']}"),
                        ("kv", f"Month\t{m} {y}"), ("kv", f"Working Days\t{rng.randint(24, 26)}"),
                        ("rule", ""), ("kv", f"Basic Salary\t{inr(earn[0][1])}"), ("kv", f"D.A.\t{inr(earn[2][1])}"),
                        ("kv", f"H.R.A.\t{inr(earn[1][1])}"), ("kv", f"Other Allowance\t{inr(earn[3][1])}"),
                        ("kv", f"Total Salary\t{inr(te)}"), ("rule", ""),
                        ("kv", f"Less: P.F.\t{inr(ded[0][1])}"), ("kv", f"Less: Prof. Tax\t{inr(ded[1][1])}"),
                        ("kv", f"Less: Advance\t{inr(0)}"), ("kv", f"Net Salary Payable\t{inr(te - ded[0][1] - ded[1][1])}"),
                        ("text", f"Paid by bank transfer to {bank} A/c {acct}."),
                        ("sign", "Authorised Signatory"), ("sign", "Signature of Employee")]
    if L == 2:  # government pay slip
        level = rng.randint(4, 13)
        basic = rng.choice([25500, 35400, 44900, 56100, 67700, 78800, 123100])
        da, hra, ta = round(basic * 0.5), round(basic * rng.choice([0.1, 0.2, 0.3])), rng.choice([1800, 3600, 7200])
        nps, cgegis, it = round((basic + da) * 0.1), rng.choice([30, 60, 120]), round(basic * 0.08)
        return "page", [("hi", "भारत सरकार"), ("sub", "GOVERNMENT OF INDIA"), ("title", rng.choice(GOVT_OFFICES)),
                        ("title", f"PAY SLIP FOR {m.upper()} {y}"), ("kv", f"Name\t{p['name'].upper()}"),
                        ("kv", f"Designation\t{rng.choice(['Assistant Section Officer', 'Junior Engineer', 'Staff Nurse', 'Upper Division Clerk', 'Inspector'])}"),
                        ("kv", f"Employee ID / GPF No.\t{_digits(rng, 8)}"), ("kv", f"Pay Level\tLevel {level}"),
                        ("kv", f"DDO Code\t{_digits(rng, 6)}"), ("rowh", "Pay and Allowances | Amount | Deductions | Amount"),
                        ("row", f"Basic Pay | {basic} | NPS Employee Share | {nps}"),
                        ("row", f"Dearness Allowance | {da} | CGEGIS | {cgegis}"),
                        ("row", f"House Rent Allowance | {hra} | Income Tax | {it}"),
                        ("row", f"Transport Allowance | {ta} | Licence Fee | 0"),
                        ("row", f"Gross Pay | {basic + da + hra + ta} | Total Deductions | {nps + cgegis + it}"),
                        ("sub", f"Net Amount Payable: Rs. {basic + da + hra + ta - nps - cgegis - it}"),
                        ("small", "Generated from the Public Financial Management System payroll module.")]
    if L == 3:  # pay advice / salary statement
        return "page", [("head", emp), ("title", f"PAY ADVICE - {m[:3].upper()}-{y}"),
                        ("kv", f"Associate\t{p['name']}"), ("kv", f"Associate ID\t{_digits(rng, 7)}"),
                        ("kv", f"Location\t{p['city']}"), ("kv", f"PF No.\t{p['state'][:2].upper()}/{_digits(rng, 5)}/{_digits(rng, 4)}"),
                        ("sub", "EARNINGS"), *[("kv", f"{k}\t{inr(v)}") for k, v in earn],
                        ("kv", f"Total Earnings\t{inr(te)}"), ("sub", "STATUTORY DEDUCTIONS"),
                        *[("kv", f"{k}\t{inr(v)}") for k, v in ded], ("kv", f"Total Deductions\t{inr(td)}"),
                        ("sub", f"NET TRANSFER TO BANK: INR {inr(net)}"), ("kv", f"Bank\t{bank}"),
                        ("kv", f"Account\t{acct}"), ("kv", f"IFSC\t{ifsc}"),
                        ("small", f"Year-to-date gross: INR {inr(te * rng.randint(2, 11))}. Contact payroll for queries.")]
    # L == 4: wage slip for a factory / establishment worker
    rate = rng.choice([450, 520, 610, 700, 850])
    days = rng.randint(22, 27)
    ot = rng.randint(0, 20) * rate // 8
    gross_w = rate * days + ot
    esi, pf = round(gross_w * 0.0075), round(rate * days * 0.12)
    return "page", [("title", "FORM XIX"), ("small", "[See Rule 78(1)(b)]"), ("title", "WAGE SLIP"),
                    ("kv", f"Name of the Establishment\t{emp}"), ("kv", f"Name of the Worker\t{p['name']}"),
                    ("kv", f"Father's Name\t{p['father']}"), ("kv", f"Nature of Employment\t{rng.choice(['Machine Operator', 'Helper', 'Fitter', 'Packer', 'Driver'])}"),
                    ("kv", f"Wage Period\t{m} {y}"), ("kv", f"Rate of Wages Payable\tRs. {rate} per day"),
                    ("kv", f"Total attendance / Units of work done\t{days} days"), ("kv", f"Overtime wages\t{ot}"),
                    ("kv", f"Gross wages payable\t{gross_w}"), ("kv", f"Deductions (ESI {esi}, PF {pf})\t{esi + pf}"),
                    ("kv", f"Net wages paid\t{gross_w - esi - pf}"), ("sign", "Signature of the Employer / Manager")]


def form_16(L, rng):
    p = _person(rng)
    emp = rng.choice(EMPLOYERS)
    city, state, _, pin = rng.choice(CITIES)
    fy, ay = _fy(rng)
    tan = _letters(rng, 4) + _digits(rng, 5) + _letters(rng, 1)
    cert = _letters(rng, 7)
    gross = rng.choice(range(400000, 3500000, 25000))
    taxable = gross - 50000 - rng.choice([0, 150000])
    tax = round(max(taxable - 500000, 0) * rng.uniform(0.08, 0.2))
    q = [round(tax * w) for w in (0.2, 0.25, 0.25)]
    q.append(tax - sum(q))
    head = [("title", "FORM NO. 16"), ("small", "[See rule 31(1)(a)]")]
    parties = [("kv", f"Name and address of the Employer\t{emp}, {city}, {state} - {pin}{_digits(rng, 3)}"),
               ("kv", f"Name and address of the Employee\t{p['name'].upper()}, {_address(p)}"),
               ("kv", f"PAN of the Deductor\t{_pan(rng, 'C', emp)}"), ("kv", f"TAN of the Deductor\t{tan}"),
               ("kv", f"PAN of the Employee\t{p['pan']}"), ("kv", f"Assessment Year\t{ay}"),
               ("kv", f"Period with the Employer\tFrom 01-Apr-{fy[:4]} To 31-Mar-{int(fy[:4]) + 1}")]
    if L == 0:  # Part A, TRACES layout
        rows = [("rowh", "Quarter(s) | Receipt Numbers of original quarterly statements of TDS | Amount paid/credited | Amount of tax deducted (Rs.)")]
        rows += [("row", f"Q{i + 1} | {_letters(rng, 8)} | {inr(gross / 4)} | {inr(t)}") for i, t in enumerate(q)]
        return "page", head + [("sub", "PART A"),
                               ("text", "Certificate under section 203 of the Income-tax Act, 1961 for tax deducted at source on salary paid to an employee under section 192"),
                               ("kv", f"Certificate No.\t{cert}"), ("kv", f"Last updated on\t{_d(_date(rng), 2)}")] + parties + [
                               ("kv", f"CIT (TDS)\tThe Commissioner of Income Tax (TDS), {city}"),
                               ("sub", "Summary of amount paid/credited and tax deducted at source thereon in respect of the employee"),
                               *rows, ("row", f"Total (Rs.) | | {inr(gross)} | {inr(tax)}"),
                               ("sub", "I. DETAILS OF TAX DEDUCTED AND DEPOSITED IN THE CENTRAL GOVERNMENT ACCOUNT THROUGH BOOK ADJUSTMENT"),
                               ("small", "Verification: I, the person responsible for deduction of tax, certify that a sum of "
                                         f"Rs. {inr(tax)} [Rs. {words(tax)} only] has been deducted and deposited to the credit of the Central Government.")]
    if L == 1:  # Part B annexure
        return "page", head + [("sub", "PART B (Annexure)"),
                               ("sub", "Details of Salary Paid and any other income and tax deducted"),
                               ("kv", f"1. Gross Salary\t{inr(gross)}"),
                               ("kv", f"(a) Salary as per provisions contained in section 17(1)\t{inr(gross)}"),
                               ("kv", "(b) Value of perquisites under section 17(2)\t0.00"),
                               ("kv", "2. Less: Allowances to the extent exempt under section 10\t0.00"),
                               ("kv", "4. Deductions under section 16: (a) Standard deduction under section 16(ia)\t50,000.00"),
                               ("kv", f"6. Income chargeable under the head \"Salaries\"\t{inr(gross - 50000)}"),
                               ("kv", f"10. Deductions under Chapter VI-A: (a) section 80C\t{inr(gross - 50000 - taxable)}"),
                               ("kv", f"12. Total taxable income\t{inr(taxable)}"), ("kv", f"13. Tax on total income\t{inr(tax / 1.04)}"),
                               ("kv", f"16. Health and education cess\t{inr(tax - tax / 1.04)}"), ("kv", f"17. Tax payable\t{inr(tax)}"),
                               ("sub", "Verification"),
                               ("text", f"I, {rng.choice(FIRST_M)} {rng.choice(SURNAMES)}, son of {rng.choice(FIRST_M)} {rng.choice(SURNAMES)}, "
                                        f"working in the capacity of Finance Manager, do hereby certify that the information given above is "
                                        f"true, complete and correct and is based on the books of account, documents, TDS statements, and other available records."),
                               ("kv", f"Place\t{city}"), ("kv", f"Date\t{_d(_date(rng))}"),
                               ("sign", "Signature of person responsible for deduction of tax")]
    if L == 2:  # TRACES header and certificate summary
        return "page", [("hi", "भारत सरकार / आयकर विभाग"), ("head", "Government of India, Income Tax Department"),
                        ("small", "TDS Reconciliation Analysis and Correction Enabling System"), *head,
                        ("sub", "Certificate under Section 203 of the Income-tax Act, 1961 for Tax deducted at source on Salary"),
                        ("kv", f"Certificate No.\t{cert}"), ("kv", f"Employee Reference No. provided by the Employer\t{_digits(rng, 6)}"),
                        *parties, ("rowh", "Quarter | Amount of tax deducted | Amount of tax deposited / remitted"),
                        *[("row", f"Q{i + 1} | {inr(t)} | {inr(t)}") for i, t in enumerate(q)],
                        ("small", "Notes: 1. Government deductors to fill information in item I if tax is paid without production "
                                  "of an income-tax challan. 2. Non-Government deductors to fill information in item II.")]
    if L == 3:  # new-regime Part B
        rebate = min(tax, 25000) if taxable <= 700000 else 0
        return "page", head + [("sub", "PART B"), ("sub", "Details of Salary Paid and any other income and tax deducted"),
                               ("kv", "A. Whether opting out of taxation u/s 115BAC(1A)?\tNo"),
                               ("kv", f"1. Total amount of salary received from current employer\t{inr(gross)}"),
                               ("kv", "Standard deduction under section 16(ia)\t75,000.00"),
                               ("kv", f"Total taxable income\t{inr(gross - 75000)}"),
                               ("kv", f"Tax on total income\t{inr(tax)}"), ("kv", f"Rebate under section 87A, if applicable\t{inr(rebate)}"),
                               ("kv", f"Net tax payable\t{inr(tax - rebate)}"), ("kv", f"Less: Relief under section 89\t0.00"),
                               ("small", f"Certified that the tax deducted at source for the financial year {fy} has been deposited."),
                               ("sign", "Signature of the person responsible for deduction of tax"), ("kv", f"Full Name\t{rng.choice(FIRST_F)} {rng.choice(SURNAMES)}"),
                               ("kv", "Designation\tHead - Payroll")]
    # L == 4: compact payroll-software Form 16 summary
    return "page", [("head", emp), ("title", "Form 16 - Certificate of Tax Deducted at Source on Salary"),
                    ("kv", f"Financial Year\t{fy}"), ("kv", f"Assessment Year\t{ay}"), ("kv", f"Employer TAN\t{tan}"),
                    ("kv", f"Employee\t{p['name']}"), ("kv", f"Employee PAN\t{p['pan']}"),
                    ("kv", f"Gross Total Income\t{inr(gross)}"), ("kv", f"Total Tax Deducted (TDS u/s 192)\t{inr(tax)}"),
                    ("text", "This certificate is issued under section 203 of the Income-tax Act and should be used "
                             "while filing your income tax return. Part A is downloaded from TRACES."),
                    ("kv", f"Place\t{city}"), ("kv", f"Date\t{_d(_date(rng))}"), ("sign", "Authorised Signatory (Payroll)")]


def itr(L, rng):
    p = _person(rng)
    fy, ay = _fy(rng)
    ack = _digits(rng, 15)
    filed = _d(_date(rng), 0)
    income = rng.choice(range(350000, 4500000, 10000))
    tax = round(max(income - 500000, 0) * rng.uniform(0.05, 0.2))
    paid = tax + rng.choice([0, 0, 2500, -1800])
    form = rng.choice(["ITR-1", "ITR-2", "ITR-3", "ITR-4"])
    if L == 0:  # ITR-V
        return "page", [("hi", "आयकर विभाग"), ("title", "INDIAN INCOME TAX RETURN ACKNOWLEDGEMENT"),
                        ("small", f"[Where the data of the Return of Income in Form ITR-1 (SAHAJ), ITR-2, ITR-3, ITR-4 (SUGAM), "
                                  f"ITR-5, ITR-6, ITR-7 filed and verified]"),
                        ("kv", f"Assessment Year\t{ay}"), ("kv", f"PAN\t{p['pan']}"), ("kv", f"Name\t{p['name'].upper()}"),
                        ("kv", f"Address\t{_address(p).upper()}"), ("kv", "Status\tIndividual"), ("kv", f"Form Number\t{form}"),
                        ("kv", f"e-Filing Acknowledgement Number\t{ack}"), ("kv", f"Date of filing\t{filed}"),
                        ("kv", f"Total Income\t{inr(income, False)}"), ("kv", f"Net tax payable\t{inr(tax, False)}"),
                        ("kv", "Interest and Fee Payable\t0"), ("kv", f"Total tax, interest and Fee payable\t{inr(tax, False)}"),
                        ("kv", f"Taxes Paid\t{inr(paid, False)}"), ("kv", f"(+) Tax Payable /(-) Refundable\t{inr(tax - paid, False)}"),
                        ("text", f"This return has been digitally signed by {p['name'].upper()} in the capacity of Self having PAN {p['pan']}."),
                        ("small", "System Generated. Barcode/QR Code")]
    if L == 1:  # e-filing acknowledgement (verified by Aadhaar OTP)
        return "page", [("head", "e-Filing Anywhere Anytime"), ("title", "INDIAN INCOME TAX RETURN ACKNOWLEDGEMENT"),
                        ("kv", f"Acknowledgement Number\t{ack}"), ("kv", f"Date of filing\t{filed}"),
                        ("kv", f"Assessment Year\t{ay}"), ("kv", f"Name\t{p['name']}"), ("kv", f"PAN\t{p['pan']}"),
                        ("rowh", "Particulars | Amount (Rs.)"), ("row", f"Current Year business loss, if any | 0"),
                        ("row", f"Total Income | {inr(income, False)}"), ("row", f"Book Profit under MAT | 0"),
                        ("row", f"Total Tax Paid | {inr(paid, False)}"), ("row", f"Refund / Demand | {inr(paid - tax, False)}"),
                        ("text", f"Income Tax Return submitted electronically on {filed} from IP address 10.{rng.randint(0, 255)}.{rng.randint(0, 255)}.{rng.randint(0, 255)} "
                                 f"and verified by {p['name']} having PAN {p['pan']} on {filed} using Electronic Verification Code "
                                 f"{_letters(rng, 10)} generated through Aadhaar OTP mode."),
                        ("small", "DO NOT SEND THIS ACKNOWLEDGEMENT TO CPC, BENGALURU")]
    if L == 2:  # ITR-1 SAHAJ form pages
        return "page", [("title", "FORM ITR-1 SAHAJ"), ("sub", "INDIAN INCOME TAX RETURN"),
                        ("small", "[For individuals being a resident (other than not ordinarily resident) having total income upto "
                                  "Rs.50 lakh, having Income from Salaries, one house property, other sources (Interest etc.), and "
                                  "agricultural income upto Rs.5 thousand]"),
                        ("kv", f"Assessment Year\t{ay}"), ("sub", "PART A GENERAL INFORMATION"),
                        ("kv", f"(A1) PAN\t{p['pan']}"), ("kv", f"(A2) Name\t{p['name'].upper()}"),
                        ("kv", f"(A3) Date of Birth\t{_d(p['dob'])}"), ("kv", f"(A4) Aadhaar Number\t{p['aadhaar']}"),
                        ("kv", "(A9) Filed u/s\t139(1) - On or before due date"), ("sub", "PART B GROSS TOTAL INCOME"),
                        ("kv", f"B1 Gross Salary\t{inr(income + 50000, False)}"), ("kv", "B2 Income from One House Property\t0"),
                        ("kv", f"B3 Income from Other Sources\t{inr(rng.randint(2000, 40000), False)}"),
                        ("sub", "PART C DEDUCTIONS AND TAXABLE TOTAL INCOME"), ("kv", f"C20 Total Income\t{inr(income, False)}"),
                        ("sub", "PART D COMPUTATION OF TAX PAYABLE"), ("kv", f"D1 Tax payable on total income\t{inr(tax, False)}"),
                        ("kv", f"D13 Total Taxes Paid\t{inr(paid, False)}"), ("sub", "VERIFICATION"),
                        ("text", f"I, {p['name']}, son/daughter of {p['father']}, solemnly declare that to the best of my knowledge and "
                                 "belief, the information given in the return is correct and complete.")]
    if L == 3:  # ITR-4 SUGAM for a business
        turnover = rng.choice(range(1500000, 19000000, 50000))
        return "page", [("title", "FORM ITR-4 SUGAM"), ("sub", "INDIAN INCOME TAX RETURN"),
                        ("small", "[For Individuals, HUFs and Firms (other than LLP) being a resident having total income upto "
                                  "Rs.50 lakh and having income from Business or Profession which is computed under sections "
                                  "44AD, 44ADA or 44AE]"),
                        ("kv", f"Assessment Year\t{ay}"), ("kv", f"PAN\t{p['pan']}"), ("kv", f"Name\t{p['name'].upper()}"),
                        ("kv", f"Name of Business\t{rng.choice(FIRMS)}"), ("kv", f"Business Code\t{_digits(rng, 5)}"),
                        ("sub", "SCHEDULE BP - DETAILS OF INCOME FROM BUSINESS"),
                        ("kv", f"E1 Gross Turnover or Gross Receipts\t{inr(turnover, False)}"),
                        ("kv", f"E3 Presumptive Income under section 44AD\t{inr(turnover * 0.08, False)}"),
                        ("kv", f"Gross Total Income\t{inr(income, False)}"), ("kv", f"Total Income\t{inr(income, False)}"),
                        ("kv", f"Tax payable on Total Income\t{inr(tax, False)}"),
                        ("sub", "SCHEDULE IT - DETAILS OF ADVANCE TAX AND SELF ASSESSMENT TAX PAYMENTS"),
                        ("row", f"BSR Code {_digits(rng, 7)} | Date of Deposit {filed} | Challan No {_digits(rng, 5)} | Tax paid {inr(paid, False)}")]
    # L == 4: computation of total income prepared by a CA
    sal, hp, bus = income * rng.uniform(0.5, 0.9), rng.choice([0, -200000, 60000]), 0
    bus = income - sal - hp
    return "page", [("title", "STATEMENT OF COMPUTATION OF TOTAL INCOME"),
                    ("kv", f"Name of Assessee\t{p['name']}"), ("kv", f"PAN\t{p['pan']}"),
                    ("kv", f"Previous Year\t{fy}"), ("kv", f"Assessment Year\t{ay}"), ("kv", "Status\tResident Individual"),
                    ("rowh", "Particulars | Amount (Rs.) | Amount (Rs.)"), ("row", f"Income from Salary | {inr(sal, False)} |"),
                    ("row", f"Income from House Property | {inr(hp, False)} |"),
                    ("row", f"Profits and Gains of Business or Profession | {inr(bus, False)} |"),
                    ("row", f"Gross Total Income | | {inr(income + 150000, False)}"),
                    ("row", "Less: Deductions under Chapter VI-A (80C, 80D) | | 1,50,000"),
                    ("row", f"Total Income | | {inr(income, False)}"), ("row", f"Rounded off u/s 288A | | {inr(round(income, -1), False)}"),
                    ("row", f"Tax thereon | | {inr(tax, False)}"), ("row", f"Less: TDS / Advance Tax | | {inr(paid, False)}"),
                    ("kv", f"Return filed vide acknowledgement no.\t{ack} dated {filed}"),
                    ("sign", f"For {rng.choice(SURNAMES)} & Associates, Chartered Accountants")]


def bank_statement(L, rng):
    from models.transaction_tagger.generator import generate as narrations
    p = _person(rng)
    bank, ifsc = _bank(rng)
    acct = _digits(rng, rng.choice([11, 12, 14]))
    start = _date(rng)
    n = rng.randint(9, 15)
    rows = narrations(per_category=3, seed=rng.randint(0, 10**6)).sample(n, random_state=rng.randint(0, 10**6))
    bal = rng.choice(range(5000, 400000, 500))
    opening = bal
    lines, total_dr, total_cr = [], 0, 0
    for i, (_, r) in enumerate(rows.iterrows()):
        amt = rng.choice([150, 499, 1200, 2500, 5000, 12500, 18000, 45000, 62000, 85000])
        credit = r["direction"] == "credit" or (r["direction"] == "either" and rng.random() < 0.5)
        bal += amt if credit else -amt
        total_cr += amt if credit else 0
        total_dr += 0 if credit else amt
        dt = _d(start + timedelta(days=2 * i), [0, 3, 2, 1, 2][L])
        lines.append((dt, r["text"][:48], "" if credit else inr(amt), inr(amt) if credit else "", inr(bal), _digits(rng, 6)))
    period = f"{_d(start, 2)} to {_d(start + timedelta(days=30), 2)}"
    if L == 0:
        return "page", [("head", bank), ("title", "STATEMENT OF ACCOUNT"), ("kv", f"Account Name\t{p['name'].upper()}"),
                        ("kv", f"Address\t{_address(p)}"), ("kv", f"Account Number\t{acct}"), ("kv", f"IFSC\t{ifsc}"),
                        ("kv", f"Branch\t{p['locality']}, {p['city']}"), ("kv", f"Statement Period\t{period}"),
                        ("rowh", "Date | Narration | Chq./Ref.No. | Withdrawal Amt. | Deposit Amt. | Closing Balance"),
                        *[("row", f"{d} | {t} | {ref} | {w} | {c} | {b}") for d, t, w, c, b, ref in lines],
                        ("sub", "STATEMENT SUMMARY"),
                        ("row", f"Opening Balance {inr(opening)} | Dr Count {sum(1 for l in lines if l[2])} | Cr Count {sum(1 for l in lines if l[3])} | Debits {inr(total_dr)} | Credits {inr(total_cr)} | Closing Bal {inr(bal)}"),
                        ("small", "This is a computer generated statement and does not require a signature.")]
    if L == 1:  # account statement with customer details block
        return "page", [("head", bank), ("kv", f"Account Name\t{p['name']}"), ("kv", f"Address\t{_address(p)}"),
                        ("kv", f"Date\t{_d(start + timedelta(days=31), 2)}"), ("kv", f"Account Number\t{acct}"),
                        ("kv", "Account Description\tSAVINGS ACCOUNT - REGULAR"), ("kv", f"Branch\t{p['city'].upper()} MAIN"),
                        ("kv", "Drawing Power\t0.00"), ("kv", "Interest Rate(% p.a.)\t2.7"), ("kv", f"CIF No.\t{_digits(rng, 11)}"),
                        ("kv", f"IFS Code\t{ifsc}"), ("kv", f"MICR Code\t{_digits(rng, 9)}"),
                        ("kv", f"Balance as on {_d(start, 2)}\t{inr(opening)}"),
                        ("sub", f"Account Statement from {period}"),
                        ("rowh", "Txn Date | Value Date | Description | Ref No./Cheque No. | Debit | Credit | Balance"),
                        *[("row", f"{d} | {d} | {t} | {ref} | {w} | {c} | {b}") for d, t, w, c, b, ref in lines],
                        ("small", "**This is a computer generated statement and does not require signature.")]
    if L == 2:  # passbook page
        return "page", [("title", bank.upper()), ("sub", "SAVINGS BANK PASSBOOK"),
                        ("kv", f"A/c No.\t{acct}"), ("kv", f"Name\t{p['name']}"),
                        ("rowh", "Date | Particulars | Cheque No. | Withdrawals | Deposits | Balance"),
                        ("row", f"{lines[0][0]} | B/F | | | | {inr(opening)}"),
                        *[("row", f"{d} | {t[:30]} | | {w} | {c} | {b}") for d, t, w, c, b, ref in lines],
                        ("row", f"{lines[-1][0]} | C/F | | | | {inr(bal)}")]
    if L == 3:  # monthly e-statement with summary box
        return "page", [("head", bank), ("title", "Your Monthly Account Statement"),
                        ("text", f"Dear {p['name']}, here is your statement for {period}."),
                        ("sub", "Your Account Summary"),
                        ("row", f"Opening Balance | + Total Credits | - Total Debits | = Closing Balance"),
                        ("row", f"{inr(opening)} | {inr(total_cr)} | {inr(total_dr)} | {inr(bal)}"),
                        ("kv", f"Savings Account No.\t{acct}"), ("kv", f"Customer ID\t{_digits(rng, 9)}"),
                        ("sub", "Transaction Details"), ("rowh", "Date | Description | Debit (INR) | Credit (INR) | Balance (INR)"),
                        *[("row", f"{d} | {t} | {w} | {c} | {b}") for d, t, w, c, b, ref in lines],
                        ("small", "Important: Please check the entries and report any discrepancy within 30 days. "
                                  "Deposits in your account are insured up to Rs. 5 lakh by DICGC.")]
    # L == 4: current account statement for a business
    firm = rng.choice(FIRMS)
    return "page", [("head", bank), ("title", "CURRENT ACCOUNT STATEMENT"), ("kv", f"Customer Name\tM/S {firm.upper()}"),
                    ("kv", f"Customer ID\t{_digits(rng, 8)}"), ("kv", "Account Type\tCURRENT ACCOUNT - BUSINESS"),
                    ("kv", f"Account No\t{acct}"), ("kv", f"Period\t{period}"), ("kv", "Currency\tINR"),
                    ("rowh", "Tran Id | Tran Date | Particulars | Dr/Cr | Amount | Balance"),
                    *[("row", f"S{_digits(rng, 8)} | {d} | {t} | {'DR' if w else 'CR'} | {w or c} | {b}") for d, t, w, c, b, ref in lines],
                    ("kv", f"Closing Balance\t{inr(bal)} CR"),
                    ("small", "Unless the constituent notifies the bank immediately of any discrepancy found, the statement will be taken as correct.")]


def gst_certificate(L, rng):
    p = _person(rng)
    firm = rng.choice(FIRMS)
    gstin = _gstin(rng, p)
    const = rng.choice(["Proprietorship", "Partnership", "Private Limited Company", "Limited Liability Partnership"])
    liab = _d(_date(rng, date(2017, 7, 1), 2500))
    addr = f"{rng.randint(1, 300)}, {rng.choice(STREETS)}, {p['locality']}, {p['city']}, {p['state']}, {p['pin']}"
    if L == 0:  # REG-06
        return "page", [("hi", "भारत सरकार"), ("sub", "Government of India"), ("title", "Form GST REG-06"),
                        ("small", "[See Rule 10(1)]"), ("title", "Registration Certificate"),
                        ("kv", f"Registration Number\t{gstin}"), ("kv", f"1. Legal Name\t{p['name'].upper()}"),
                        ("kv", f"2. Trade Name, if any\t{firm.upper()}"), ("kv", f"3. Constitution of Business\t{const}"),
                        ("kv", f"4. Address of Principal Place of Business\t{addr}"), ("kv", f"5. Date of Liability\t{liab}"),
                        ("kv", f"6. Period of Validity\tFrom {liab} To Not Applicable"), ("kv", "7. Type of Registration\tRegular"),
                        ("sub", "8. Particulars of Approving Authority"),
                        ("kv", "Signature\tSignature Not Verified, Digitally signed by Goods and Services Tax Network"),
                        ("kv", f"Name\t{rng.choice(FIRST_M)} {rng.choice(SURNAMES)}"), ("kv", "Designation\tSuperintendent"),
                        ("kv", f"Jurisdictional Office\t{p['city']} Range - {rng.randint(1, 30)}"),
                        ("kv", f"9. Date of issue of Certificate\t{liab}"),
                        ("small", "Note: The registration certificate is required to be prominently displayed at all places of business in the State.")]
    if L == 1:  # Annexure A
        return "page", [("title", "Annexure A"), ("kv", f"GSTIN\t{gstin}"), ("kv", f"Legal Name\t{p['name'].upper()}"),
                        ("kv", f"Trade Name, if any\t{firm.upper()}"), ("kv", "Details of Additional Places of Business\t1"),
                        ("rowh", "Sr. No. | Address"),
                        ("row", f"1 | {rng.randint(1, 300)}, {rng.choice(STREETS)}, {rng.choice(LOCALITIES)}, {p['city']}, {p['state']}"),
                        ("small", "Goods and Services Tax Network. This is a system generated digitally signed Registration Certificate "
                                  "issued based on the approval granted on the registration application.")]
    if L == 2:  # Annexure B
        return "page", [("title", "Annexure B"), ("kv", f"GSTIN\t{gstin}"), ("kv", f"Legal Name\t{p['name'].upper()}"),
                        ("kv", f"Trade Name, if any\t{firm.upper()}"),
                        ("sub", "Details of Managing / Authorized Partners / Karta / Proprietor"),
                        ("kv", f"1 Name\t{p['name'].upper()}"), ("kv", "Designation/Status\tProprietor"),
                        ("kv", f"Resident of State\t{p['state']}"),
                        ("kv", f"2 Name\t{rng.choice(FIRST_M).upper()} {p['surname'].upper()}"), ("kv", "Designation/Status\tAuthorised Signatory"),
                        ("kv", f"Resident of State\t{p['state']}"),
                        ("small", "Goods and Services Tax Network. This is a system generated digitally signed Registration Certificate.")]
    if L == 3:  # portal search printout
        return "page", [("head", "Goods and Services Tax"), ("title", "Search Taxpayer"),
                        ("kv", f"GSTIN/UIN of the Taxpayer\t{gstin}"), ("kv", f"Legal Name of Business\t{p['name'].upper()}"),
                        ("kv", f"Trade Name\t{firm.upper()}"), ("kv", f"Effective Date of registration\t{liab}"),
                        ("kv", f"Constitution of Business\t{const}"), ("kv", "GSTIN / UIN Status\tActive"),
                        ("kv", "Taxpayer Type\tRegular"), ("kv", f"Administrative Office\tSTATE - {p['state'].upper()}, ZONE - {p['city'].upper()}"),
                        ("kv", f"Principal Place of Business\t{addr}"),
                        ("kv", "Nature Of Business Activities\tRetail Business, Wholesale Business, Supplier of Services"),
                        ("rowh", "HSN | Description"), ("row", f"{_digits(rng, 4)} | {rng.choice(['Electrical apparatus', 'Cotton fabrics', 'Sweets and confectionery', 'Hand tools', 'Medicaments'])}"),
                        ("kv", "Aadhaar Authenticated?\tYes"), ("kv", "e-KYC Verified?\tNo")]
    # L == 4: provisional registration certificate (migrated taxpayer)
    return "page", [("title", "Form GST REG-25"), ("small", "[See Rule 24(1)]"), ("title", "Certificate of Provisional Registration"),
                    ("kv", f"Provisional ID\t{gstin}"), ("kv", f"Legal Name\t{p['name'].upper()}"),
                    ("kv", f"Trade Name, if any\t{firm.upper()}"), ("kv", f"Constitution of Business\t{const}"),
                    ("kv", f"Address of Principal Place of Business\t{addr}"), ("kv", "Date of Issue\t01/07/2017"),
                    ("text", "This is a Certificate of Provisional Registration issued under the provisions of the Act. "
                             "Subject to the provisions of the Act, the Certificate of Registration in FORM GST REG-06 shall be "
                             "made available on the common portal on verification of the information furnished."),
                    ("sign", "Signature of the Authorised Officer")]


def _parties(rng):
    v, b = _person(rng), _person(rng)
    return v, b, v["city"], v["state"]


def sale_deed(L, rng):
    v, b, city, state = _parties(rng)
    dt = _date(rng, date(2005, 1, 1), 7000)
    price = rng.choice(range(1500000, 25000000, 50000))
    sy = _survey(rng)
    stamp = round(price * rng.choice([0.05, 0.06, 0.07]))
    bounds = [("kv", f"East\t{rng.choice(['Road', 'Property of ' + rng.choice(SURNAMES), 'Open plot', 'Drain'])}"),
              ("kv", f"West\tProperty of {rng.choice(FIRST_M)} {rng.choice(SURNAMES)}"),
              ("kv", f"North\t{rng.choice(['30 ft Road', 'Plot No. ' + str(rng.randint(1, 99)), 'Nala'])}"),
              ("kv", f"South\tPlot No. {rng.randint(1, 99)}")]
    vend = (f"Shri/Smt. {v['name']}, {v['rel']} {v['father']}, aged about {v['age']} years, residing at {_address(v)}, "
            f"PAN {v['pan']}")
    buy = f"Shri/Smt. {b['name']}, {b['rel']} {b['father']}, aged about {b['age']} years, residing at {_address(b)}"
    if L == 0:
        return "page", [("title", "SALE DEED"),
                        ("text", f"This Sale Deed is made and executed on this {dt.day} day of {MONTHS[dt.month - 1]}, {dt.year} at {city}."),
                        ("sub", "BY"), ("text", vend + ", hereinafter called the 'VENDOR' (which expression shall include his heirs, "
                                                   "legal representatives, executors and assigns) of the ONE PART."),
                        ("sub", "IN FAVOUR OF"), ("text", buy + ", hereinafter called the 'PURCHASER' of the OTHER PART."),
                        ("text", f"WHEREAS the Vendor is the absolute owner and in peaceful possession of the property bearing Survey No. {sy}, "
                                 f"more fully described in the Schedule below, having acquired the same under a registered deed."),
                        ("sub", "NOW THIS DEED OF SALE WITNESSETH AS FOLLOWS:"),
                        ("text", f"1. In consideration of Rs. {inr(price, False)}/- (Rupees {words(price)} only) paid by the Purchaser, the receipt "
                                 "of which the Vendor hereby acknowledges, the Vendor hereby sells, conveys and transfers the Schedule Property "
                                 "to the Purchaser absolutely and forever."),
                        ("text", "2. The Vendor assures that the Schedule Property is free from all encumbrances, charges, liens, mortgages and attachments."),
                        ("sub", "SCHEDULE OF PROPERTY"),
                        ("text", f"All that piece and parcel of land bearing Survey No. {sy}, measuring {rng.randint(800, 4000)} sq. ft., "
                                 f"situated at {v['locality']}, {city}, {state}, bounded by:"), *bounds,
                        ("text", "IN WITNESS WHEREOF the Vendor has signed this Sale Deed on the day, month and year first above written."),
                        ("kv", "WITNESSES:\t1.\n2."), ("sign", "VENDOR"), ("sign", "PURCHASER")]
    if L == 1:  # conveyance (indenture) style
        return "page", [("title", "DEED OF CONVEYANCE"),
                        ("text", f"THIS INDENTURE made this {dt.day} day of {MONTHS[dt.month - 1]}, Two Thousand {words(dt.year - 2000)} BETWEEN "
                                 f"{vend}, hereinafter referred to as the VENDOR, of the FIRST PART AND {buy}, hereinafter referred to as the PURCHASER, of the SECOND PART."),
                        ("text", "WHEREAS by virtue of a registered Deed of Gift the Vendor became seized and possessed of and otherwise "
                                 "well and sufficiently entitled to ALL THAT the land and building described in the FIRST SCHEDULE hereunder written."),
                        ("text", f"NOW THIS INDENTURE WITNESSETH that in pursuance of the said agreement and in consideration of the sum of "
                                 f"Rs. {inr(price, False)}/- well and truly paid by the Purchaser to the Vendor, the Vendor doth hereby grant, "
                                 "transfer, convey, assign and assure unto the Purchaser the said property free from all encumbrances."),
                        ("sub", "THE FIRST SCHEDULE ABOVE REFERRED TO"),
                        ("text", f"ALL THAT piece and parcel of land measuring {rng.randint(2, 6)} Cottahs {rng.randint(0, 15)} Chittacks, more or less, "
                                 f"together with a building standing thereon, lying at Mouza {v['locality']}, J.L. No. {rng.randint(1, 120)}, "
                                 f"R.S. Dag No. {rng.randint(10, 999)}, P.S. {city}."),
                        ("sub", "MEMO OF CONSIDERATION"),
                        ("text", f"RECEIVED from the within named Purchaser the within mentioned sum of Rs. {inr(price, False)}/- "
                                 f"(Rupees {words(price)} only) being the full consideration money as per memo below."),
                        ("sign", "Signature of the Vendor"), ("kv", "Drafted by me\tAdvocate, " + city)]
    if L == 2:  # e-stamp first page and registration endorsement
        return "page", [("title", "INDIA NON JUDICIAL"), ("sub", f"Government of {state}"), ("title", "e-Stamp"),
                        ("kv", f"Certificate No.\tIN-{state[:2].upper()}{_digits(rng, 14)}{_letters(rng, 1)}"),
                        ("kv", f"Certificate Issued Date\t{_d(dt, 2)} {rng.randint(10, 17)}:{rng.randint(10, 59)} PM"),
                        ("kv", f"Account Reference\tSHCIL (FI)/ {state[:2].lower()}shcil01/ {city.upper()}"),
                        ("kv", f"Unique Doc. Reference\tSUBIN-{state[:2].upper()}{_digits(rng, 14)}"),
                        ("kv", f"Purchased by\t{b['name'].upper()}"), ("kv", "Description of Document\tArticle 23 Conveyance"),
                        ("kv", f"Property Description\tSurvey No. {sy}, {v['locality']}, {city}"),
                        ("kv", f"Consideration Price (Rs.)\t{inr(price, False)}"), ("kv", f"First Party\t{v['name'].upper()}"),
                        ("kv", f"Second Party\t{b['name'].upper()}"), ("kv", f"Stamp Duty Amount(Rs.)\t{inr(stamp, False)}"),
                        ("title", "SALE DEED"),
                        ("text", f"Presented in the Office of the Sub-Registrar, {city}, between the hours of 11 and 12 on {_d(dt, 3)} "
                                 f"by {v['name']}, the executant, with fee of Rs. {inr(price * 0.01, False)}."),
                        ("kv", f"Document No.\t{rng.randint(100, 9999)}/{dt.year}"), ("kv", "Book\tI"),
                        ("kv", f"Registration fee\tRs. {inr(price * 0.01, False)}"), ("sign", "Sub-Registrar")]
    if L == 3:  # apartment absolute sale deed from a builder
        builder = rng.choice(BUILDERS)
        proj = rng.choice(PROJECTS)
        return "page", [("title", "DEED OF ABSOLUTE SALE"),
                        ("text", f"THIS DEED OF ABSOLUTE SALE is executed at {city} on {_d(dt, 4)} by {builder}, a firm having its office at "
                                 f"{city}, represented by its authorised signatory, hereinafter called the VENDOR/DEVELOPER, in favour of "
                                 f"{buy}, hereinafter called the PURCHASER."),
                        ("text", f"WHEREAS the Vendor has constructed a residential complex known as '{proj}' on land bearing "
                                 f"Survey No. {sy}, and the same is registered under RERA vide No. P{_digits(rng, 11)}."),
                        ("text", f"The Vendor hereby sells Apartment No. {rng.randint(1, 30)}{rng.randint(0, 9)}{rng.randint(1, 8)} on the "
                                 f"{rng.randint(1, 30)}th floor, having a carpet area of {_builder_area(rng)} sq. ft., together with "
                                 f"{rng.randint(250, 600)} sq. ft. undivided share of land and one covered car parking, for a total sale "
                                 f"consideration of Rs. {inr(price, False)}/- (Rupees {words(price)} only)."),
                        ("text", "The Purchaser shall become a member of the apartment owners' association and pay the maintenance charges."),
                        ("sub", "SCHEDULE 'A' - DESCRIPTION OF LAND"), *bounds, ("sub", "SCHEDULE 'B' - APARTMENT HEREBY SOLD"),
                        ("text", "IN WITNESS WHEREOF the parties have signed this deed of absolute sale in the presence of the witnesses."),
                        ("sign", "VENDOR"), ("sign", "PURCHASER")]
    # L == 4: plot sale deed with khata and measurements
    return "page", [("title", "ABSOLUTE SALE DEED"),
                    ("text", f"This ABSOLUTE SALE DEED is made on {_d(dt, 4)} at {city} by {vend}, herein after called the SELLER, in "
                             f"favour of {buy}, herein after called the BUYER."),
                    ("text", f"The Seller is the absolute owner of the site bearing Khata No. {rng.randint(100, 9999)}, Municipal No. "
                             f"{rng.randint(1, 500)}, measuring East to West {rng.randint(30, 60)} ft and North to South {rng.randint(40, 80)} ft, "
                             f"in all measuring {rng.randint(1200, 4800)} sq. ft., as per the khata extract issued by the city corporation."),
                    ("text", f"The Seller in consideration of Rs. {inr(price, False)}/- received by way of cheque/RTGS, hereby conveys the "
                             "schedule property with all rights of easements, privileges and appurtenances thereto to the Buyer."),
                    ("text", "The Seller has delivered vacant possession of the Schedule Property to the Buyer on this day and the "
                             "Buyer may get the khata transferred to his/her name."),
                    ("sub", "SCHEDULE"), *bounds, ("kv", "WITNESSES\t1.\n2."), ("sign", "SELLER"), ("sign", "BUYER")]


def allotment_letter(L, rng):
    b = _person(rng)
    builder = rng.choice(BUILDERS)
    proj = rng.choice(PROJECTS)
    unit = f"{rng.choice('ABCDE')}-{rng.randint(1, 30)}{rng.randint(0, 9)}{rng.randint(1, 8)}"
    area = _builder_area(rng)
    price = area * rng.choice([4500, 5600, 6800, 8200, 9900, 12500])
    rera = f"P{_digits(rng, 11)}"
    dt = _d(_date(rng), rng.randint(0, 4))
    sched = [("rowh", "Stage | % of Consideration | Amount (Rs.)"),
             ("row", f"On booking | 10% | {inr(price * 0.1, False)}"),
             ("row", f"Within 30 days of booking | 20% | {inr(price * 0.2, False)}"),
             ("row", f"On completion of plinth | 15% | {inr(price * 0.15, False)}"),
             ("row", f"On completion of slabs | 30% | {inr(price * 0.3, False)}"),
             ("row", f"On possession | 25% | {inr(price * 0.25, False)}")]
    if L == 0:
        return "page", [("head", builder), ("small", f"RERA Registration No. {rera}"), ("title", "ALLOTMENT LETTER"),
                        ("kv", f"Date\t{dt}"), ("text", f"To,\nMr./Ms. {b['name']}\n{_address(b)}"),
                        ("sub", f"Sub: Allotment of Flat No. {unit} in the project '{proj}', {b['city']}"),
                        ("text", f"Dear Sir/Madam, With reference to your application dated {dt}, we are pleased to allot you "
                                 f"Flat No. {unit} in our project '{proj}' as per the details below."),
                        ("kv", f"Carpet Area (as per RERA)\t{area} sq. ft."), ("kv", f"Total Consideration\tRs. {inr(price, False)}"),
                        ("kv", f"Booking Amount Received\tRs. {inr(price * 0.1, False)}"), ("sub", "Payment Schedule"), *sched,
                        ("text", "This allotment is subject to the execution and registration of the Agreement for Sale and "
                                 "to the terms and conditions overleaf."),
                        ("sign", f"For {builder}, Authorised Signatory")]
    if L == 1:  # development authority allotment-cum-demand letter
        auth = f"{b['city']} {rng.choice(['Development Authority', 'Metropolitan Region Development Authority', 'Housing Board'])}"
        plot = rng.randint(1, 900)
        return "page", [("head", f"OFFICE OF THE {auth.upper()}"), ("title", "ALLOTMENT-CUM-DEMAND LETTER"),
                        ("kv", f"Letter No.\t{_letters(rng, 3)}/{rng.randint(100, 999)}/{_d(_date(rng))[-4:]}"), ("kv", f"Dated\t{dt}"),
                        ("text", f"To\n{b['name']}\n{_address(b)}"),
                        ("text", f"Subject: Allotment of {rng.choice(['EWS', 'LIG', 'MIG', 'HIG'])} flat / plot under the "
                                 f"{proj} Housing Scheme through draw of lots held on {_d(_date(rng), 2)}."),
                        ("text", f"Sir/Madam, I am directed to inform you that you have been declared successful in the draw of lots and "
                                 f"Plot No. {plot}, Pocket {rng.choice('ABCD')}, Sector {rng.randint(1, 60)} is hereby allotted to you."),
                        ("kv", f"Premium / Cost of the flat\tRs. {inr(price, False)}"),
                        ("kv", "Amount to be paid within 60 days\tthe balance amount after adjusting the registration money"),
                        ("text", "In case the payment is not made within the stipulated period the allotment shall stand cancelled "
                                 "automatically without any further notice."),
                        ("sign", "Estate Officer / Deputy Director (Housing)")]
    if L == 2:  # provisional allotment
        bsp = price / area
        return "page", [("head", builder), ("title", "PROVISIONAL ALLOTMENT LETTER"), ("kv", f"Application No.\t{_digits(rng, 6)}"),
                        ("kv", f"Date\t{dt}"), ("kv", f"Allottee\t{b['name']}"), ("kv", f"Co-Allottee\t{rng.choice(FIRST_F)} {b['surname']}"),
                        ("sub", "UNIT DETAILS"), ("kv", f"Project\t{proj}"), ("kv", f"Tower/Wing\t{unit[0]}"),
                        ("kv", f"Floor\t{rng.randint(1, 30)}"), ("kv", f"Unit No.\t{unit}"),
                        ("kv", f"Super Built-up Area\t{round(area * 1.3)} sq. ft."), ("kv", f"Basic Sale Price per sq. ft.\tRs. {round(bsp)}"),
                        ("kv", "Preferential Location Charges (PLC)\tRs. 150 per sq. ft."),
                        ("kv", "EDC / IDC\tAs applicable"), ("kv", "Club Membership\tRs. 1,50,000"), ("kv", "GST\tAs applicable"),
                        ("text", "This provisional allotment is subject to realisation of cheques and to the terms of the Builder "
                                 "Buyer Agreement. The final unit number and area may change on approval of the building plans."),
                        ("sign", "Authorised Signatory")]
    if L == 3:  # industrial plot offer-cum-allotment
        return "page", [("head", f"{b['state']} Industrial Development Corporation"), ("title", "OFFER-CUM-ALLOTMENT LETTER"),
                        ("kv", f"Ref. No.\tIDC/RO/{b['city'][:3].upper()}/{rng.randint(1000, 9999)}"), ("kv", f"Date\t{dt}"),
                        ("text", f"To\nM/s {rng.choice(FIRMS)}\nProprietor: {b['name']}"),
                        ("text", f"Sub: Allotment of Plot No. {rng.choice('ABCDEFGH')}-{rng.randint(1, 200)} in {b['city']} Industrial Area."),
                        ("text", f"With reference to your application, the Corporation is pleased to allot Plot No. "
                                 f"{rng.choice('ABCDEFGH')}-{rng.randint(1, 200)} admeasuring {rng.randint(500, 6000)} sq. m. on lease "
                                 "for a period of 95 years for setting up of an industrial unit."),
                        ("kv", f"Lease Premium\tRs. {inr(price, False)}"), ("kv", "Annual Lease Rent\tRe. 1 per annum"),
                        ("text", "You shall execute the Agreement to Lease within 3 months and start production within 3 years."),
                        ("sign", "Regional Officer")]
    # L == 4: booking confirmation e-mail print
    return "page", [("small", f"From: crm@{builder.split()[0].lower()}homes.example"), ("small", f"To: {b['first'].lower()}@example.com"),
                    ("sub", f"Subject: Allotment of Unit {unit} - {proj}"), ("kv", f"Booking ID\tBK{_digits(rng, 7)}"),
                    ("kv", f"Customer ID\tC{_digits(rng, 6)}"),
                    ("text", f"Dear {b['name']}, Congratulations! Your unit {unit} in {proj} has been allotted to you. "
                             "Thank you for choosing us for your new home."),
                    ("sub", "Unit Price Breakup"), ("kv", f"Carpet area\t{area} sq. ft."), ("kv", f"Agreement value\tRs. {inr(price, False)}"),
                    ("kv", f"Stamp duty and registration (approx.)\tRs. {inr(price * 0.06, False)}"),
                    ("kv", f"GST @ 5%\tRs. {inr(price * 0.05, False)}"),
                    ("text", f"Your allotment letter and the draft Agreement for Sale are attached. Please pay the balance booking amount within 15 days. RERA No. {rera}."),
                    ("sign", f"Team CRM, {builder}")]


def encumbrance_certificate(L, rng):
    o, c = _person(rng), _person(rng)
    city, state = o["city"], o["state"]
    a, z = _date(rng, date(1995, 1, 1), 4000), _date(rng)
    sy = _survey(rng)
    village = rng.choice(LOCALITIES)
    entries = []
    for i in range(rng.randint(1, 4)):
        d = _date(rng, a, max((z - a).days, 1))
        entries.append(("row", f"{i + 1} | {rng.randint(100, 9999)}/{d.year} | {_d(d, 1)} | "
                               f"{rng.choice(['Sale', 'Mortgage', 'Settlement', 'Gift', 'Release'])} | "
                               f"{rng.choice(FIRST_M)} {rng.choice(SURNAMES)} | {rng.choice(FIRST_F)} {rng.choice(SURNAMES)} | "
                               f"Rs. {inr(rng.randint(5, 90) * 100000, False)}"))
    if L == 0:
        return "page", [("title", "ENCUMBRANCE CERTIFICATE"), ("small", "Form No. 15"),
                        ("kv", f"Sub Registrar Office\t{city} {rng.choice(['North', 'South', 'East', 'West', 'Central'])}"),
                        ("kv", f"Search Period\t{_d(a, 2)} to {_d(z, 2)}"),
                        ("kv", f"Property Description\tVillage: {village}, Survey No. {sy}, Extent: {rng.randint(1, 40)} cents"),
                        ("rowh", "Sl. No. | Document No. & Year | Date of Registration | Nature | Executant(s) | Claimant(s) | Value"),
                        *entries,
                        ("text", f"It is certified that the above are the only acts and encumbrances affecting the said property "
                                 f"registered during the period {_d(a)} to {_d(z)}, and found after search in the books and indexes."),
                        ("kv", f"Applicant\t{o['name']}"), ("sign", "Sub Registrar")]
    if L == 1:  # nil encumbrance (Form 16 under the Registration Rules)
        return "page", [("title", "Form No. 16"), ("small", "(See Rule 147 of the Registration Rules)"),
                        ("title", "CERTIFICATE OF NIL ENCUMBRANCE ON PROPERTY"),
                        ("text", f"The application of {o['name']}, {o['rel']} {o['father']}, dated {_d(z)} for a certificate giving the "
                                 f"particulars of registered acts and encumbrances, if any, for {z.year - a.year} years in respect of the "
                                 "following property:"),
                        ("kv", "Description of property\t" + f"Survey No. {sy}, {village} village, {city} Taluk, {state}"),
                        ("text", f"I hereby certify that I have made a search in the books and in the indexes for {z.year - a.year} years, "
                                 f"from {_d(a)} to {_d(z)}, and that no acts or encumbrances affecting the said property have been "
                                 "registered during the said period."),
                        ("kv", "Searched by\tJunior Assistant"), ("kv", "Fee paid\tRs. 200"), ("sign", f"Sub-Registrar, {city}")]
    if L == 2:  # online EC service (state registration department)
        return "page", [("head", f"Department of Stamps and Registration, Government of {state}"), ("sub", "Online Services"),
                        ("title", "Encumbrance Certificate"), ("kv", f"Application No.\tEC{_digits(rng, 10)}"),
                        ("kv", f"Applicant Name\t{o['name']}"), ("kv", f"Period\tFrom {_d(a, 2)} To {_d(z, 2)}"),
                        ("sub", "Property Details"), ("kv", f"District\t{city}"), ("kv", f"Taluk\t{city} {rng.choice(['North', 'South'])}"),
                        ("kv", f"Hobli\t{rng.choice(LOCALITIES)}"), ("kv", f"Village\t{village}"), ("kv", f"Survey Number\t{sy}"),
                        ("rowh", "Sl. No. | Document Number | Date | Nature | Executant | Claimant | Consideration"),
                        *entries, ("small", "This is a digitally signed Encumbrance Certificate. Verify at the department website using the application number.")]
    if L == 3:  # statement of encumbrances on property
        return "page", [("head", "Registration and Stamps Department"), ("title", "STATEMENT OF ENCUMBRANCES ON PROPERTY"),
                        ("kv", f"Requested by\t{o['name']}"), ("kv", f"Search Period\t{a.year} to {z.year}"),
                        ("kv", "Description of Property\t" + f"Plot No. {rng.randint(1, 400)}, Sy. No. {sy}, Extent {rng.randint(100, 900)} Sq. Yds., {village}, {city}"),
                        ("kv", "Boundaries\tNorth: Road, South: Plot, East: Plot, West: Road"),
                        ("rowh", "Sl. No. | Doc. No./Year | Date | Nature & Market Value | Name of Parties (Executant / Claimant) | Vol/Page"),
                        *entries,
                        ("text", "Note: Encumbrances are shown only for the documents registered in this office and the details "
                                 "are subject to correction in case of any computer error."),
                        ("sign", "Signature of the Registering Officer")]
    # L == 4: village officer's encumbrance certificate for agricultural land
    return "page", [("hi", "कार्यालय ग्राम अधिकारी"), ("title", f"OFFICE OF THE VILLAGE OFFICER, {village.upper()}"),
                    ("title", "CERTIFICATE OF ENCUMBRANCE"), ("kv", f"No.\tVO/{rng.randint(100, 999)}/{z.year}"), ("kv", f"Date\t{_d(z)}"),
                    ("text", f"This is to certify that the land bearing Re-Survey No. {sy}, measuring {rng.randint(2, 90)} Ares, "
                             f"situated in {village} village, {city} Taluk, stands in the name of {o['name']}, {o['rel']} {o['father']}, "
                             "as per the revenue records of this office."),
                    ("text", f"As per the records available in this office the said property is free from all encumbrances, "
                             f"attachments and charges for the period from {_d(a)} to {_d(z)}."),
                    ("text", "This certificate is issued on the request of the applicant for the purpose of availing a housing loan."),
                    ("sign", "Village Officer")]


def property_tax_receipt(L, rng):
    o = _person(rng)
    city = o["city"]
    fy, _ = _fy(rng)
    pid = f"{rng.randint(10, 99)}-{rng.randint(100, 999)}-{rng.randint(1000, 9999)}"
    arv = rng.choice(range(12000, 180000, 1000))
    gen, water, edu = round(arv * 0.2), round(arv * 0.05), round(arv * 0.03)
    tot = gen + water + edu
    dt = _d(_date(rng), rng.randint(0, 4))
    if L == 0:
        return "page", [("head", f"{city} Municipal Corporation"), ("title", "PROPERTY TAX RECEIPT"),
                        ("kv", f"Financial Year\t{fy}"), ("kv", f"Receipt No.\t{_digits(rng, 10)}"), ("kv", f"Receipt Date\t{dt}"),
                        ("kv", f"Property ID / Assessment No.\t{pid}"), ("kv", f"Owner Name\t{o['name']}"),
                        ("kv", f"Property Address\t{_address(o)}"), ("kv", f"Ward / Zone\t{rng.randint(1, 120)} / {rng.choice(['North', 'South', 'East', 'West'])}"),
                        ("kv", f"Annual Rateable Value\t{inr(arv)}"),
                        ("rowh", "Tax Head | Demand | Paid"), ("row", f"General Tax | {inr(gen)} | {inr(gen)}"),
                        ("row", f"Water Tax | {inr(water)} | {inr(water)}"), ("row", f"Education Cess | {inr(edu)} | {inr(edu)}"),
                        ("row", f"Tree Cess | 0.00 | 0.00"), ("row", f"Total | {inr(tot)} | {inr(tot)}"),
                        ("kv", f"Amount Paid\tRs. {inr(tot)} (Rupees {words(tot)} Only)"), ("kv", "Mode of Payment\tOnline - Net Banking"),
                        ("kv", f"Transaction ID\t{_digits(rng, 12)}"), ("small", "This is a computer generated receipt.")]
    if L == 1:  # online payment acknowledgement
        return "page", [("head", f"{city} Municipal Corporation - Online Services"), ("title", "Property Tax Payment Receipt"),
                        ("text", "Thank you for your payment. Your property tax payment has been received successfully."),
                        ("kv", f"PID\t{pid}"), ("kv", f"Owner\t{o['name']}"), ("kv", f"Payment Date\t{dt}"),
                        ("kv", f"Tax Period\t{fy}"), ("kv", f"Amount\tRs. {inr(tot)}"), ("kv", f"Bank Reference No.\t{_digits(rng, 12)}"),
                        ("kv", "Payment Status\tSUCCESS"), ("small", "Please keep this receipt for your records. Receipts can be re-printed from the citizen portal.")]
    if L == 2:  # gram panchayat house tax receipt
        vil = rng.choice(LOCALITIES)
        return "page", [("hi", "ग्राम पंचायत"), ("title", f"GRAM PANCHAYAT {vil.upper()}"), ("sub", f"Taluka {city}, District {city}"),
                        ("title", "HOUSE TAX / PROPERTY TAX RECEIPT"), ("kv", f"Receipt Book No.\t{rng.randint(1, 60)}"),
                        ("kv", f"Receipt No.\t{rng.randint(1, 100)}"), ("kv", f"Assessment No. (Milkat No.)\t{rng.randint(1, 900)}"),
                        ("kv", f"Name of the Owner\t{o['name']}"), ("kv", f"Year\t{fy}"),
                        ("rowh", "Particulars | Arrears | Current | Total"),
                        ("row", f"House Tax | 0 | {gen // 10} | {gen // 10}"), ("row", f"Water Tax | 0 | {water // 10} | {water // 10}"),
                        ("row", f"Light Tax | 0 | {edu // 10} | {edu // 10}"), ("row", f"Total | 0 | {tot // 10} | {tot // 10}"),
                        ("sign", "Gram Sevak / Panchayat Secretary")]
    if L == 3:  # self-assessment application cum challan
        return "page", [("head", f"{city} City Corporation"), ("title", "PROPERTY TAX SELF ASSESSMENT SCHEME"),
                        ("sub", "Form IV - Application cum Challan"), ("kv", f"PID No.\t{pid}"),
                        ("kv", f"Khata No.\t{rng.randint(100, 9999)}"), ("kv", f"Name of the Owner\t{o['name']}"),
                        ("kv", f"Site Area (sq. ft.)\t{rng.randint(600, 4800)}"), ("kv", f"Built up Area (sq. ft.)\t{rng.randint(500, 4000)}"),
                        ("kv", f"Zone Classification\t{rng.choice('ABCDEF')}"), ("kv", "Usage\tResidential - Self occupied"),
                        ("kv", f"Tax rate per sq. ft. per month\tRs. {rng.choice([1.0, 1.5, 2.0, 2.5])}"),
                        ("kv", f"Total tax payable\t{inr(tot)}"), ("kv", f"Less: 5% rebate for full payment\t{inr(tot * 0.05)}"),
                        ("kv", "Cess\t24% of tax"), ("kv", f"Net amount paid\t{inr(tot * 0.95)}"),
                        ("kv", f"Challan No.\t{_digits(rng, 9)}"), ("sign", "Bank seal and signature")]
    # L == 4: demand bill
    pen = round(tot * rng.choice([0, 0.02, 0.1]))
    return "page", [("head", f"{city} Municipal Corporation"), ("title", "PROPERTY TAX BILL"), ("kv", f"Bill No.\t{_digits(rng, 9)}"),
                    ("kv", f"Bill Date\t{dt}"), ("kv", f"Due Date\t{_d(_date(rng), 0)}"), ("kv", f"Property No.\t{pid}"),
                    ("kv", f"Owner / Occupier\t{o['name']}"), ("kv", f"Address\t{_address(o)}"),
                    ("rowh", "Description | Amount (Rs.)"), ("row", f"Arrears | {inr(0)}"),
                    ("row", f"Current year property tax | {inr(tot)}"), ("row", f"Penalty / interest | {inr(pen)}"),
                    ("row", f"Net Payable | {inr(tot + pen)}"),
                    ("text", "Pay before the due date to avoid penalty at 2% per month. Pay online, at ward offices or at citizen facilitation centres."),
                    ("small", "Ignore if already paid.")]


def utility_bill(L, rng):
    o = _person(rng)
    dt = _date(rng)
    cons = _digits(rng, 12)
    due = _d(dt + timedelta(days=18), 2)
    if L == 0:  # electricity
        prev = rng.randint(1000, 40000)
        units = rng.randint(60, 900)
        energy = round(units * rng.uniform(4, 9))
        fixed, duty, fac = rng.choice([90, 120, 150]), round(energy * 0.16), round(units * 0.3)
        total = energy + fixed + duty + fac
        return "page", [("head", rng.choice(DISCOMS)), ("title", "ELECTRICITY BILL"), ("kv", f"Consumer No.\t{cons}"),
                        ("kv", f"Billing Unit\t{rng.randint(1000, 9999)}"), ("kv", f"Bill Month\t{dt.strftime('%b-%Y').upper()}"),
                        ("kv", f"Name\t{o['name'].upper()}"), ("kv", f"Address\t{_address(o)}"),
                        ("kv", "Tariff\tLT-I Residential"), ("kv", f"Sanctioned Load\t{rng.choice([1, 2, 3, 5])} kW"),
                        ("kv", f"Meter No.\t{_digits(rng, 8)}"), ("rowh", "Previous Reading | Current Reading | Units Consumed"),
                        ("row", f"{prev} | {prev + units} | {units}"), ("kv", f"Energy Charges\t{inr(energy)}"),
                        ("kv", f"Fixed Charges\t{inr(fixed)}"), ("kv", f"Electricity Duty\t{inr(duty)}"),
                        ("kv", f"Fuel Adjustment Charge\t{inr(fac)}"), ("sub", f"Total Bill Amount: Rs. {inr(total)}"),
                        ("kv", f"Due Date\t{due}"), ("small", f"Pay by {due} to avoid delayed payment charges. Save electricity, save the nation.")]
    if L == 1:  # piped gas
        scm = rng.randint(8, 60)
        amt = round(scm * rng.uniform(48, 56))
        return "page", [("head", f"{o['city']} Natural Gas Ltd"), ("title", "PIPED NATURAL GAS BILL"), ("kv", f"BP No.\t{_digits(rng, 10)}"),
                        ("kv", f"Customer Name\t{o['name']}"), ("kv", f"Address\t{_address(o)}"), ("kv", f"Bill Date\t{_d(dt, 2)}"),
                        ("kv", f"Previous Reading (SCM)\t{rng.randint(100, 5000)}"), ("kv", f"Gas Consumption (SCM)\t{scm}"),
                        ("kv", f"Gas Charges\t{inr(amt)}"), ("kv", f"VAT @ {rng.choice([3, 5, 12.5])}%\t{inr(amt * 0.05)}"),
                        ("kv", f"Total Amount Payable\t{inr(amt * 1.05)}"), ("kv", f"Due Date\t{due}"),
                        ("small", "In case of gas leakage call the emergency number immediately. Do not operate electrical switches.")]
    if L == 2:  # water bill
        kl = rng.randint(8, 60)
        amt = kl * rng.choice([7, 12, 18]) + 150
        return "page", [("head", f"{o['city']} Water Supply and Sewerage Board"), ("title", "WATER CHARGES BILL"),
                        ("kv", f"Connection No.\t{_digits(rng, 9)}"), ("kv", f"Consumer Name\t{o['name']}"), ("kv", f"Premises\t{_address(o)}"),
                        ("kv", "Category\tDomestic"), ("kv", f"Meter Reading (KL)\t{rng.randint(100, 9000)}"), ("kv", f"Consumption (KL)\t{kl}"),
                        ("kv", f"Water Charges\t{inr(amt - 150)}"), ("kv", "Sewerage Cess\t150.00"), ("kv", f"Total\t{inr(amt)}"),
                        ("kv", f"Due Date\t{due}"), ("small", "Conserve water. Report leakages to the toll-free number.")]
    if L == 3:  # landline / broadband
        plan = rng.choice([499, 699, 999, 1499])
        return "page", [("head", f"{rng.choice(['Bharat', 'Metro', 'Deccan'])} Telecom Ltd"), ("title", "TELEPHONE & BROADBAND BILL"),
                        ("kv", f"Account No.\t{_digits(rng, 10)}"), ("kv", f"Telephone No.\t0{rng.randint(20, 80)}-{_digits(rng, 8)}"),
                        ("kv", f"Name\t{o['name']}"), ("kv", f"Installation Address\t{_address(o)}"), ("kv", f"Bill Period\t{dt.strftime('%b %Y')}"),
                        ("kv", f"Plan\tFibre {plan}"), ("kv", f"Monthly Rental\t{inr(plan)}"), ("kv", f"Usage Charges\t{inr(rng.randint(0, 200))}"),
                        ("kv", f"CGST @ 9%\t{inr(plan * 0.09)}"), ("kv", f"SGST @ 9%\t{inr(plan * 0.09)}"),
                        ("kv", f"Total Amount Due\t{inr(plan * 1.18)}"), ("kv", f"Pay By\t{due}")]
    # L == 4: spot-billing slip from a handheld machine
    units = rng.randint(40, 500)
    return "card", [("sub", rng.choice(DISCOMS).upper()), ("sub", "SPOT BILL"), ("text", f"SC NO : {_digits(rng, 13)}"),
                    ("text", f"NAME : {o['name'].upper()}"), ("text", f"ADDR : {o['locality'].upper()}"),
                    ("text", f"CAT : LT-1A   MTR NO : {_digits(rng, 7)}"),
                    ("text", f"BILL DT : {_d(dt, 1)}  UNITS : {units}"),
                    ("text", f"ENERGY CHG : {round(units * 5.5)}  CUST CHG : 50"),
                    ("text", f"BILL AMT : {round(units * 5.5) + 50}"), ("text", f"DUE DT : {_d(dt + timedelta(days=15), 1)}"),
                    ("text", f"DISCONN DT : {_d(dt + timedelta(days=30), 1)}")]


def other(L, rng):
    """Papers that are NOT one of the 12 types. The model should say 'other' (or be unsure)."""
    a, b = _person(rng), _person(rng)
    dt = _d(_date(rng), rng.randint(0, 4))
    rent = rng.choice(range(8000, 90000, 500))
    if L == 0:  # leave and licence agreement
        return "page", [("title", "LEAVE AND LICENSE AGREEMENT"),
                        ("text", f"This Agreement is made and executed at {a['city']} on {dt} BETWEEN {a['name']}, {a['rel']} {a['father']}, "
                                 f"residing at {_address(a)}, hereinafter called the LICENSOR, AND {b['name']}, hereinafter called the LICENSEE."),
                        ("text", f"The Licensor hereby grants to the Licensee a licence to use the premises for residential purposes "
                                 f"for a period of 11 months commencing from {dt}."),
                        ("kv", "Monthly licence fee\tRs. " + inr(rent, False)), ("kv", "Refundable security deposit\tRs. " + inr(rent * 3, False)),
                        ("text", "The Licensee shall not sublet the premises and shall pay electricity and maintenance charges."),
                        ("sign", "LICENSOR"), ("sign", "LICENSEE")]
    if L == 1:  # credit card statement
        bank, _ = _bank(rng)
        due = rng.randint(2000, 180000)
        return "page", [("head", bank), ("title", "CREDIT CARD STATEMENT"), ("kv", f"Card Number\t4{_digits(rng, 3)} XXXX XXXX {_digits(rng, 4)}"),
                        ("kv", f"Name\t{a['name'].upper()}"), ("kv", f"Statement Date\t{dt}"), ("kv", f"Payment Due Date\t{_d(_date(rng), 2)}"),
                        ("kv", f"Total Amount Due\tRs. {inr(due)}"), ("kv", f"Minimum Amount Due\tRs. {inr(due * 0.05)}"),
                        ("kv", f"Credit Limit\tRs. {inr(rng.choice([100000, 200000, 350000, 500000]))}"),
                        ("kv", f"Available Credit Limit\tRs. {inr(rng.randint(10000, 90000))}"),
                        ("rowh", "Date | Transaction Details | Amount (Rs.)"),
                        *[("row", f"{_d(_date(rng), 0)} | {rng.choice(['AMAZON', 'SWIGGY', 'FUEL STATION', 'IRCTC', 'DMART', 'APOLLO PHARMACY'])} {a['city'].upper()} | {inr(rng.randint(150, 9000))}") for _ in range(rng.randint(4, 8))],
                        ("small", "Paying only the minimum amount due every month will result in the repayment stretching over years with interest.")]
    if L == 2:  # offer letter
        ctc = rng.choice(range(400000, 4000000, 50000))
        return "page", [("head", rng.choice(EMPLOYERS)), ("title", "OFFER LETTER"), ("kv", "Date\t" + dt),
                        ("text", f"Dear {a['name']},"),
                        ("text", f"We are pleased to offer you the position of {rng.choice(['Software Engineer', 'Sales Manager', 'Accountant', 'Business Analyst'])} "
                                 f"at our {a['city']} office. Your annual Cost to Company (CTC) will be Rs. {inr(ctc, False)}."),
                        ("text", f"Your date of joining will be {_d(_date(rng), 4)}. You will be on probation for six months."),
                        ("text", "Please sign and return a copy of this letter as a token of your acceptance."),
                        ("sign", "Head - Talent Acquisition")]
    if L == 3:  # hospital invoice
        return "page", [("head", f"{rng.choice(['Sunrise', 'Lifeline', 'CarePlus', 'City'])} Multispeciality Hospital"), ("title", "TAX INVOICE"),
                        ("kv", f"Patient Name\t{a['name']}"), ("kv", f"UHID\t{_digits(rng, 8)}"), ("kv", f"Bill Date\t{dt}"),
                        ("rowh", "Service | Qty | Amount"), ("row", f"Consultation | 1 | {rng.choice([500, 800, 1200])}"),
                        ("row", f"Pharmacy | {rng.randint(1, 9)} | {rng.randint(200, 6000)}"), ("row", f"Laboratory | {rng.randint(1, 5)} | {rng.randint(300, 4000)}"),
                        ("kv", f"Net Amount\t{inr(rng.randint(1000, 12000))}"), ("small", "Get well soon.")]
    if L == 4:  # life insurance policy schedule
        sa = rng.choice([500000, 1000000, 2500000, 5000000])
        return "page", [("head", f"{rng.choice(['Suraksha', 'Jeevan Raksha', 'Kavach'])} Life Insurance Co. Ltd"), ("title", "POLICY SCHEDULE"),
                        ("kv", f"Policy No.\t{_digits(rng, 10)}"), ("kv", f"Policyholder\t{a['name']}"), ("kv", f"Life Assured\t{a['name']}"),
                        ("kv", "Plan\tTerm Assurance Plan"), ("kv", f"Sum Assured\tRs. {inr(sa, False)}"),
                        ("kv", f"Annual Premium\tRs. {inr(sa * 0.0012, False)}"), ("kv", f"Nominee\t{b['name']}"),
                        ("kv", f"Date of Commencement\t{dt}"), ("small", "Free look period: 30 days from receipt of this policy document.")]
    if L == 5:  # school fee receipt
        return "page", [("head", f"{rng.choice(['St. Xavier', 'Delhi Public', 'Vidya Mandir', 'Kendriya'])} School"), ("title", "FEE RECEIPT"),
                        ("kv", f"Receipt No.\t{_digits(rng, 6)}"), ("kv", f"Student Name\t{rng.choice(FIRST_F + FIRST_M)} {a['surname']}"),
                        ("kv", f"Class\t{rng.randint(1, 12)} {rng.choice('ABCD')}"), ("kv", f"Term\t{rng.choice(['I', 'II', 'III'])}"),
                        ("kv", f"Tuition Fee\t{inr(rng.randint(8000, 60000))}"), ("kv", f"Transport Fee\t{inr(rng.randint(2000, 9000))}"),
                        ("kv", "Received with thanks\tCashier")]
    if L == 6:  # restaurant / retail tax invoice
        return "card", [("sub", f"{rng.choice(['Annapurna', 'Spice Route', 'Udupi Grand', 'Punjab Dhaba'])} Restaurant"),
                        ("text", f"GSTIN: {_gstin(rng, a)}"), ("text", f"Bill No: {_digits(rng, 5)}  Date: {dt}"),
                        ("text", f"Masala Dosa x2   {rng.randint(160, 300)}"), ("text", f"Paneer Tikka x1   {rng.randint(220, 380)}"),
                        ("text", f"Filter Coffee x2   {rng.randint(60, 120)}"), ("text", "CGST 2.5%  SGST 2.5%"),
                        ("sub", f"TOTAL Rs. {rng.randint(500, 1200)}"), ("small", "Thank you! Visit again.")]
    # L == 7: driving licence (a KYC paper, but not one of our 12 types)
    return "card", [("sub", f"Union of India - {a['state']} State"), ("sub", "DRIVING LICENCE"), ("photo", ""),
                    ("text", f"DL No. {a['state'][:2].upper()}{rng.randint(1, 50):02d} {rng.randint(2005, 2024)}{_digits(rng, 7)}"),
                    ("text", f"Name: {a['name']}"), ("text", f"S/D/W of: {a['father']}"), ("text", f"DOB: {_d(a['dob'])}"),
                    ("text", f"Valid Till (NT): {_d(_date(rng, date(2030, 1, 1), 3000))}"), ("text", "COV: LMV, MCWG"),
                    ("small", "Issuing Authority: Regional Transport Office")]


BUILDERS_BY_TYPE = {name: fn for name, fn in [
    ("pan_card", pan_card), ("aadhaar_card", aadhaar_card), ("salary_slip", salary_slip), ("form_16", form_16),
    ("itr", itr), ("bank_statement", bank_statement), ("gst_certificate", gst_certificate), ("sale_deed", sale_deed),
    ("allotment_letter", allotment_letter), ("encumbrance_certificate", encumbrance_certificate),
    ("property_tax_receipt", property_tax_receipt), ("utility_bill", utility_bill), ("other", other)]}
LAYOUTS = {k: (8 if k == "other" else 5) for k in BUILDERS_BY_TYPE}
assert set(BUILDERS_BY_TYPE) == set(CATEGORIES)


def generate(per_type: int = 36, seed: int = 42, other_count: int = 48) -> list[dict]:
    """Fake documents, spread evenly over each type's layouts.

    Returns dicts with doc_id, category, layout ("salary_slip/2"), layout_no, kind and lines.
    """
    rng = random.Random(seed)
    docs = []
    for cat, fn in BUILDERS_BY_TYPE.items():
        n = other_count if cat == "other" else per_type
        for i in range(n):
            L = i % LAYOUTS[cat]
            kind, lines = fn(L, rng)
            docs.append({"doc_id": f"{cat}-{i:03d}", "category": cat, "layout": f"{cat}/{L}", "layout_no": L,
                         "kind": kind, "lines": lines})
    return docs


def plain_text(lines: list[tuple[str, str]]) -> str:
    """The text a perfect OCR engine would read (photo and QR boxes have no text)."""
    out = []
    for style, text in lines:
        if style in ("photo", "qr", "rule") or not text:
            continue
        out.append(text.replace("\t", " ").replace(" | ", "  "))
    return "\n".join(out)
