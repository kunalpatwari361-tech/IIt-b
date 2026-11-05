"""Generate labelled Indian bank-statement narrations for the 15 Nirnay categories.

Public Indian narration datasets cover spending categories but not what a
lender needs most (cheque and NACH bounces, cash deposits, bank charges, salary
credits in real NEFT formats), so we generate them. Formats follow the styles
of SBI, HDFC, ICICI, Axis, Kotak and PNB statements. Every name, reference,
account and UPI ID is random. None of this is a real transaction.

Each row records its `template` id, so tests can hold out whole templates and
check the model on formats it has never seen.
"""
from __future__ import annotations

import random
import string

import pandas as pd

CATEGORIES = {
    "salary": "credit", "other_income": "credit", "cash_deposit": "credit", "refund": "credit",
    "emi": "debit", "rent": "debit", "cash_withdrawal": "debit", "bounce": "debit", "bank_charges": "debit",
    "bills": "debit", "insurance": "debit", "investment": "debit", "tax": "debit", "spend": "debit",
    "transfer": "either",
}

EMPLOYERS = ["INFOSYS LIMITED", "TATA CONSULTANCY SERVICES", "WIPRO LTD", "HCL TECHNOLOGIES LTD", "TECH MAHINDRA",
             "RELIANCE INDUSTRIES LTD", "LARSEN AND TOUBRO", "MARUTI SUZUKI INDIA", "ASIAN PAINTS LTD",
             "COGNIZANT TECHNOLOGY", "ACCENTURE SOLUTIONS", "HERO MOTOCORP LTD", "DTO TREASURY MAHARASHTRA",
             "PAO CENTRAL GOVT", "APOLLO HOSPITALS", "BHARTI AIRTEL LTD", "ZOMATO LTD", "ICICI LOMBARD"]
LENDERS = ["BAJAJ FINANCE LTD", "HDFC BANK LTD", "ICICI BANK LTD", "TATA CAPITAL FIN", "LIC HOUSING FINANCE",
           "HERO FINCORP LTD", "MUTHOOT FINANCE", "AXIS BANK LTD", "SBI HOME LOAN", "IDFC FIRST BANK",
           "L AND T FINANCE", "MAHINDRA FINANCE", "PNB HOUSING FIN", "SHRIRAM FINANCE", "AAVAS FINANCIERS",
           "CHOLAMANDALAM INV", "HOME FIRST FINANCE", "KOTAK MAHINDRA PRIME"]
INSURERS = ["LIC OF INDIA", "HDFC LIFE INSURANCE", "ICICI PRU LIFE", "SBI LIFE INSURANCE", "STAR HEALTH INSURANCE",
            "BAJAJ ALLIANZ GENERAL", "MAX LIFE INSURANCE", "TATA AIA LIFE", "NIVA BUPA HEALTH", "POLICYBAZAAR"]
INVEST = ["ZERODHA BROKING", "GROWW INVEST TECH", "BSE STAR MF", "NSE CLEARING LTD", "HDFC MUTUAL FUND",
          "SBI MUTUAL FUND", "ICICI PRU AMC", "NPS TRUST", "UPSTOX", "ANGEL ONE", "PPF ACCOUNT", "KUVERA"]
BILLERS = ["MSEDCL", "BESCOM", "TATA POWER DDL", "ADANI ELECTRICITY", "TNEB", "AIRTEL POSTPAID", "JIO PREPAID",
           "VI POSTPAID", "BSNL LANDLINE", "IGL GAS", "MAHANAGAR GAS", "TATA PLAY DTH", "DELHI JAL BOARD",
           "ACT FIBERNET", "BBMP PROPERTY TAX"]
MERCHANTS = ["SWIGGY", "ZOMATO", "AMAZON PAY", "FLIPKART", "BIGBASKET", "DMART", "RELIANCE RETAIL", "UBER INDIA",
             "OLA CABS", "IRCTC", "MAKEMYTRIP", "INDIAN OIL", "HPCL", "BPCL FUEL", "APOLLO PHARMACY", "MYNTRA",
             "BOOKMYSHOW", "NETFLIX", "ZEPTO", "BLINKIT", "NYKAA", "DECATHLON", "CROMA", "MEDPLUS"]
PEOPLE = ["RAMESH KUMAR", "PRIYA SHARMA", "ANIL VERMA", "SUNITA DEVI", "MOHAMMED IRFAN", "LAKSHMI NARAYANAN",
          "ARJUN SINGH", "KAVITA PATIL", "SURESH REDDY", "FATIMA SHAIKH", "GURPREET KAUR", "ROHIT JAIN",
          "MEENA IYER", "VIKRAM CHAUHAN", "DEEPA NAIR", "JOSEPH THOMAS"]
BANKS = ["HDFC", "ICIC", "SBIN", "UTIB", "KKBK", "PUNB", "BARB", "IDFB", "YESB", "CNRB"]
HANDLES = ["okicici", "oksbi", "okhdfcbank", "ybl", "paytm", "axl", "ibl", "upi"]
CITIES = ["MUMBAI", "PUNE", "DELHI", "BENGALURU", "CHENNAI", "HYDERABAD", "JAIPUR", "LUCKNOW", "KOLKATA", "INDORE"]
MONTHS = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"]


def _r(rng: random.Random):
    """Random fill-ins used by the templates."""
    name = rng.choice(PEOPLE)
    return {
        "ifsc": rng.choice(BANKS) + "0" + "".join(rng.choices(string.digits, k=6)),
        "utr": rng.choice(BANKS) + "N" + "".join(rng.choices(string.digits, k=11)),
        "ref": "".join(rng.choices(string.digits, k=12)),
        "ref6": "".join(rng.choices(string.digits, k=6)),
        "chq": "".join(rng.choices(string.digits, k=6)),
        "acct": "XXXXXX" + "".join(rng.choices(string.digits, k=4)),
        "card": "4" + "".join(rng.choices(string.digits, k=3)) + "XXXXXXXX" + "".join(rng.choices(string.digits, k=4)),
        "atm": rng.choice(["S1AN", "S1BW", "HDFC", "ICIC", "SBIN"]) + "".join(rng.choices(string.digits, k=4)),
        "mandate": rng.choice(["P", "N", "B"]) + "".join(rng.choices(string.ascii_uppercase + string.digits, k=9)),
        "name": name,
        "first": name.split()[0].lower(),
        "vpa": f"{name.split()[0].lower()}{rng.randint(1, 999)}@{rng.choice(HANDLES)}",
        "bank": rng.choice(["HDFC BANK", "ICICI BANK", "STATE BANK OF INDIA", "AXIS BANK", "KOTAK BANK", "PNB"]),
        "city": rng.choice(CITIES),
        "mon": rng.choice(MONTHS),
        "yyyy": rng.choice(["2024", "2025", "2026"]),
        "n": rng.randint(1, 60),
        "m": rng.choice([12, 24, 36, 48, 60, 120, 180, 240]),
        "employer": rng.choice(EMPLOYERS),
        "lender": rng.choice(LENDERS),
        "insurer": rng.choice(INSURERS),
        "invest": rng.choice(INVEST),
        "biller": rng.choice(BILLERS),
        "merchant": rng.choice(MERCHANTS),
        "inv": "INV" + "".join(rng.choices(string.digits, k=5)),
    }


TEMPLATES = {
    "salary": [
        "NEFT CR-{ifsc}-{employer}-SALARY {mon} {yyyy}-{utr}",
        "BY TRANSFER-NEFT*{ifsc}*{utr}*{employer} SAL--",
        "NEFT-{utr}-{employer}-SAL FOR {mon}{yyyy}-{acct}-{ifsc}",
        "CMS/ {employer} SALARY {mon} {yyyy}",
        "SALARY CREDIT {employer} {mon}-{yyyy}",
        "IMPS/{ref}/{employer}/SALARY {mon}",
        "NEFT/{utr}/{employer}/{bank}/PAYROLL {mon}",
        "BULK SAL CR {employer} REF {ref6}",
        "ACH C- {employer}-SALARY-{mandate}",
        "SAL {mon} {yyyy} {employer}",
    ],
    "other_income": [
        "INT.PD:01-{mon}-{yyyy} TO 30-{mon}-{yyyy}",
        "CREDIT INTEREST CAPITALISED",
        "SB INT CR {mon} {yyyy}",
        "NEFT CR-{ifsc}-{name} TRADERS-{inv}-{utr}",
        "UPI/CR/{ref}/{name}/{bank}/payment for goods",
        "DIVIDEND {employer} FY{yyyy}",
        "NEFT/{utr}/{name}/RENTAL INCOME {mon}",
        "IMPS/P2A CR/{ref}/{name}/CONSULTING FEES",
        "CLAIM SETTLEMENT {insurer} {ref6}",
        "REIMBURSEMENT {employer} {mon}",
        "RTGS CR-{ifsc}-{name} ENTERPRISES-{inv}",
        "BY CLG-{chq}-{name} AND CO",
    ],
    "cash_deposit": [
        "CASH DEPOSIT-CDM {atm} {city}",
        "BY CASH-{city} BRANCH",
        "CASH DEP SELF {city}",
        "CSH DEP BNA {atm} {city}",
        "CASH DEPOSIT BY {name}",
        "CDM/{atm}/CASH DEP/{city}",
        "BY CASH DEPOSIT-BNA {ref6}",
        "CASH-DEP-{city}-{ref6}",
        "CASH DEPOSITED AT BRANCH {city}",
    ],
    "refund": [
        "REFUND {merchant} ORDER {ref6}",
        "REV-UPI/{ref}/{merchant}",
        "UPI REVERSAL {ref} FAILED TXN",
        "CASHBACK {merchant} {ref6}",
        "REVERSAL OF TXN {ref}",
        "{merchant} REFUND CREDIT",
        "IMPS REVERSAL {ref}",
        "POS REFUND {card} {merchant}",
        "CHARGE REVERSAL SMS CHGS",
    ],
    "emi": [
        "ACH D- {lender}-{mandate}",
        "NACH DR {lender} EMI {mon}",
        "ECS DR {lender} {ref6}",
        "EMI {n}/{m} LOAN A/C {acct}",
        "LOAN REPAYMENT {lender} {acct}",
        "SI-EMI {lender} {mon} {yyyy}",
        "DEBIT-ACHDr {lender} {mandate}",
        "NACH/{lender}/{mandate}/EMI",
        "AUTO DEBIT EMI {lender}",
        "TO LOAN A/C {acct} EMI {mon}",
        "UPI/{ref}/{lender}/emi payment/{bank}",
    ],
    "rent": [
        "UPI/{ref}/RENT {mon}/{vpa}/{bank}",
        "NEFT DR-{ifsc}-{name}-HOUSE RENT {mon}-{utr}",
        "IMPS/{ref}/RENT/{name}/{bank}",
        "NOBROKER RENT PAYMENT {ref6}",
        "TO TRANSFER-UPI/DR/{ref}/{name}/rent--",
        "HOUSE RENT {mon} {yyyy} {name}",
        "CRED RENTPAY {name} {ref6}",
        "MAGICBRICKS RENT {mon}",
        "RENT FOR FLAT {n} {mon}",
    ],
    "cash_withdrawal": [
        "ATM WDL-ATM CASH {atm} {city}",
        "NWD-{card}-{atm}-{city}",
        "ATW-{card}-{atm}-{city}",
        "CASH WDL SELF CHQ {chq}",
        "ATM-CASH/{atm}/{city}",
        "CASH WITHDRAWAL {city} BRANCH",
        "ATM CASH {ref6} {city}",
        "SELF CHQ PAID {chq}",
        "CARDLESS CASH WDL {ref6}",
    ],
    "bounce": [
        "ACH D RETURN-{lender}-INSUFFICIENT FUNDS",
        "NACH RTN {lender} INSUFF BAL {mandate}",
        "ECS RETURN CHGS {lender}",
        "CHQ RTN-INSUFFICIENT FUNDS-{chq}",
        "I/W CHQ RET {chq} FUNDS INSUFFICIENT",
        "RETURN CHGS ACH {mandate}",
        "CHQ BOUNCE CHARGES {chq}",
        "O/W CHQ RET {chq} {name} FUNDS INSUFF",
        "NACH DR RTN-ACCOUNT BALANCE INSUFFICIENT",
        "INW CHQ RTN CHGS {chq}",
        "ECS DR RETURN {lender} {ref6}",
    ],
    "bank_charges": [
        "SMS ALERT CHGS {mon}{yyyy}",
        "DEBIT CARD ANNUAL FEE {card}",
        "MIN BAL CHGS {mon}",
        "NON MAINTENANCE CHGS QTR",
        "GST ON CHGS {ref6}",
        "IMPS CHGS {ref}",
        "CHQ BOOK ISSUE CHGS",
        "LOCKER RENT {yyyy}",
        "ATM DECLINE CHGS {card}",
        "CONSOLIDATED CHARGES {mon}",
        "EMI CARD ANNUAL FEE BAJAJ",
    ],
    "bills": [
        "BBPS/{biller}/{ref6}",
        "BILLDESK-{biller}-{ref}",
        "UPI/{ref}/{biller} BILL/{vpa}",
        "{biller} ELECTRICITY BILL {mon}",
        "MOBILE RECHARGE {biller} {ref6}",
        "BIL/BPAY/{ref}/{biller}",
        "PAYU {biller} {ref6}",
        "AUTOPAY {biller} {mon}",
    ],
    "insurance": [
        "{insurer} PREMIUM {ref6}",
        "ACH D- {insurer}-{mandate}",
        "NACH DR {insurer} POLICY {ref6}",
        "UPI/{ref}/{insurer}/premium",
        "BILLDESK-{insurer}-RENEWAL",
        "POLICY PREMIUM {insurer} {yyyy}",
    ],
    "investment": [
        "SIP {invest} {ref6}",
        "ACH D- {invest}-{mandate}",
        "BSE LTD MF {invest} {ref6}",
        "UPI/{ref}/{invest}/Payment",
        "PPF DEPOSIT {acct}",
        "RD INSTALLMENT {acct} {mon}",
        "NPS CONTRIBUTION {ref6}",
        "FD BOOKED {acct}",
        "NEFT DR-{ifsc}-{invest}-{utr}",
    ],
    "tax": [
        "CBDT TAX {ref6} AY{yyyy}",
        "GST CHALLAN CPIN {ref}",
        "INCOME TAX CHALLAN 280 {ref6}",
        "ADVANCE TAX {yyyy} {ref6}",
        "TDS PAYMENT {ref6}",
        "PROFESSIONAL TAX {mon}",
        "TIN NSDL {ref}",
    ],
    "spend": [
        "UPI/{ref}/{merchant}/{vpa}/Payment",
        "POS {card} {merchant} {city}",
        "UPI-{merchant}-{vpa}-{ifsc}-{ref}-UPI",
        "{merchant} {city} IN",
        "PCD/{card}/{merchant}/{city}",
        "UPI/P2M/{ref}/{merchant}/order/{bank}",
        "ECOM PUR {merchant} {ref6}",
        "VPS/{merchant}/{city}/{ref6}",
    ],
    "transfer": [
        "UPI/P2A/{ref}/{name}/{bank}",
        "IMPS/P2A/{ref}/{name}/{bank}",
        "NEFT DR-{ifsc}-{name}-{utr}",
        "TRF TO OWN A/C {acct}",
        "SELF TRANSFER {acct}",
        "UPI/{ref}/sent/{vpa}/{bank}",
        "TO TRANSFER-INB {name}",
        "FUND TRF FROM {acct} {name}",
        "MMT/IMPS/{ref}/{name}/{bank}",
        "BY TRANSFER-UPI/CR/{ref}/{name}/{bank}--",
    ],
}


def generate(per_category: int = 140, seed: int = 0) -> pd.DataFrame:
    """Labelled narrations: `text`, `category`, `direction`, `template`, `source`."""
    rng = random.Random(seed)
    rows = []
    for category, templates in TEMPLATES.items():
        for i in range(per_category):
            t = i % len(templates)
            text = templates[t].format(**_r(rng))
            if rng.random() < 0.25:
                text = text.lower() if rng.random() < 0.5 else text.title()
            direction = CATEGORIES[category]
            if direction == "either":
                direction = "credit" if "CR" in templates[t] or "FROM" in templates[t] else "debit"
            rows.append({"text": text, "category": category, "direction": direction,
                         "template": f"{category}:{t}", "source": "nirnay_generator"})
    return pd.DataFrame(rows)
