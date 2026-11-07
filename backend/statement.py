"""Read transactions from an uploaded bank statement's text (PDF text layer or OCR).

Real mode has no Account Aggregator, so the statement the customer uploads is where
model 5 (the transaction tagger) gets its entries. Bank layouts differ, so this is a
best-effort reader:
- a row starts with a date (12/10/2026, 12-10-26, 12 Oct 2026, 12-Oct-2026, 2026-10-12);
  lines without a date continue the row above (long narrations wrap);
- the amounts at the end of the row are withdrawal / deposit / balance in the usual layouts;
  "Cr"/"Dr" markers are used when present;
- when the statement has a running balance, each row's amount and direction come from how
  the balance changed, because OCR misreads single amounts more often than it breaks a
  whole column.

Rows it can't read are skipped and counted. Fewer than 5 rows means the statement can't
be used, and the engine falls back to the salary slip or ITR for income.
"""
from __future__ import annotations

import re
from datetime import date

MONTHS = {m: i for i, m in enumerate(["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"], 1)}
_DATE = re.compile(
    r"^\s*(?:(\d{1,2})[/.-](\d{1,2})[/.-](\d{2,4})|(\d{1,2})[\s/-]?([A-Za-z]{3})[a-z]*[\s/,-]*(\d{2,4})|(\d{4})-(\d{2})-(\d{2}))\b")
_AMOUNT = re.compile(r"(?<![\w/])(\d{1,3}(?:,\d{2,3})*(?:,\d{3})*|\d+)\.(\d{2})(?:\s*(Cr|Dr|CR|DR|cr|dr)\b)?")
_OPENING = re.compile(r"opening\s*balance|balance\s*(?:b/?f|brought\s*forward)|^b/?f$", re.I)
_NOT_NARRATION = re.compile(r"statement|page \d|generated|closing balance|total|^date\b|narration|withdrawal", re.I)
MIN_ROWS = 5


def _date(m: re.Match) -> date | None:
    try:
        if m.group(1):
            d, mo, y = int(m.group(1)), int(m.group(2)), int(m.group(3))
        elif m.group(4):
            d, mo, y = int(m.group(4)), MONTHS.get(m.group(5).lower()[:3]), int(m.group(6))
            if mo is None:
                return None
        else:
            y, mo, d = int(m.group(7)), int(m.group(8)), int(m.group(9))
        if y < 100:
            y += 2000
        return date(y, mo, d)
    except (ValueError, TypeError):
        return None


def _rows(text: str) -> tuple[list[dict], int]:
    rows, skipped = [], 0
    for line in text.splitlines():
        m = _DATE.match(line)
        if not m:
            if rows and line.strip() and not _NOT_NARRATION.search(line) and not _AMOUNT.search(line):
                rows[-1]["text"] = (rows[-1]["text"] + " " + line.strip()).strip()
            continue
        day = _date(m)
        rest = _DATE.sub("", line[m.end():], count=1)          # a value-date column after the date
        amounts = [(float(a.group(1).replace(",", "") + "." + a.group(2)), (a.group(3) or "").lower(), a.start())
                   for a in _AMOUNT.finditer(rest)]
        if day is None or not amounts:
            skipped += 1
            continue
        rows.append({"date": day, "text": rest[:amounts[0][2]].strip(" |-:"), "amounts": amounts})
    return rows, skipped


def parse(text: str) -> dict:
    rows, skipped = _rows(text)
    has_balance = bool(rows) and sum(len(r["amounts"]) >= 2 for r in rows) >= 0.5 * len(rows)
    txns, prev_balance = [], None
    for r in rows:
        a = r["amounts"]
        if _OPENING.search(r["text"]):          # a balance, not a transaction
            prev_balance = a[-1][0]
            continue
        balance = a[-1][0] if has_balance else None
        amount = (a[-2][0] if len(a) >= 2 else None) if has_balance else a[0][0]
        direction = None
        marks = [x for x in (a[:-1] if has_balance else a) if x[1] in ("cr", "dr")]
        if marks:
            direction = "credit" if marks[0][1] == "cr" else "debit"
        if balance is not None and prev_balance is not None:
            delta = round(balance - prev_balance, 2)
            if abs(delta) >= 0.01:
                amount, direction = abs(delta), ("credit" if delta > 0 else "debit")
        if balance is not None:
            prev_balance = balance
        if not amount or amount <= 0 or not r["text"]:
            skipped += 1
            continue
        txns.append({"date": r["date"].isoformat(), "amount": round(amount, 2), "direction": direction, "text": r["text"]})
    months = sorted({t["date"][:7] for t in txns})
    return {"transactions": txns, "rows_read": len(txns), "rows_skipped": skipped, "months": months,
            "has_balance": has_balance, "usable": len(txns) >= MIN_ROWS}
