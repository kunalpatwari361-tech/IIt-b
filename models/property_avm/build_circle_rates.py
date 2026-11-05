"""Turn Haryana's scanned collector-rate lists for Gurugram into data/circle_rates_gurugram.csv.

Source: "Updated Predictive Collector Rates for 2024", gurugram.gov.in/collectorrates/
(Tehsil Gurugram and sub-tehsils Wazirabad, Badshahpur and Harsaru, applicable from 1 Dec 2024).
Each row: village, segment (colony or sector), property type, prime (Y/N), the old
2023 rate, the predicted 2024 rate, the rate fixed by the committee for 2024, and the
% change. Rates for plots are per sq yard.

The scans are images, so we OCR them (RapidOCR, run locally). The Hindi columns don't
OCR, so the property type is inferred: within each colony, the residential rate is the
lowest one (commercial rates are always higher), and per-acre farm rates are dropped.

    .venv/Scripts/python -m models.property_avm.build_circle_rates --ocr   # OCR the PDFs (about 5 minutes)
    .venv/Scripts/python -m models.property_avm.build_circle_rates         # parse the saved OCR output

Download the PDFs into data/raw/property/circle_rates/ first, for example:
    curl -L -o data/raw/property/circle_rates/ggn_gurugram_2024.pdf \
      https://cdn.s3waas.gov.in/s325b2822c2f5a3230abfadd476e8b04c9/uploads/2025/01/2025012329.pdf
(Wazirabad .../2025/01/2025012372.pdf, Badshahpur .../2025/01/2025012394.pdf, Harsaru .../2024/12/2024120298.pdf)
"""
from __future__ import annotations

import argparse
import json
import re
from multiprocessing import Pool
from pathlib import Path

import numpy as np
import pandas as pd

from .circle_rates import GURUGRAM_CSV
from .features import RAW

PDF_DIR = RAW / "circle_rates"
OCR_JSON = PDF_DIR / "ggn_ocr_boxes.json"
SOURCES = {"ggn_gurugram_2024.pdf": "Tehsil Gurugram", "ggn_wazirabad_2024.pdf": "Sub-tehsil Wazirabad",
           "ggn_badshahpur_2024.pdf": "Sub-tehsil Badshahpur", "ggn_harsaru_2024.pdf": "Sub-tehsil Harsaru",
           "ggn_kadipur_2024.pdf": "Sub-tehsil Kadipur"}
_ocr = None


def _init():
    global _ocr
    from rapidocr_onnxruntime import RapidOCR
    _ocr = RapidOCR(intra_op_num_threads=2)


def _page(job):
    import pypdfium2 as pdfium
    path, i = job
    pdf = pdfium.PdfDocument(path)
    img = pdf[i].render(scale=1.5).to_pil().convert("RGB")
    pdf.close()
    res, _ = _ocr(np.asarray(img))
    if img.height > img.width:   # a landscape table scanned sideways: try both turns, keep the better read
        best = (sum(s for _, _, s in (res or [])), res, img)
        for angle in (90, -90):
            turned = img.rotate(angle, expand=True)
            r, _ = _ocr(np.asarray(turned))
            best = max(best, (sum(s for _, _, s in (r or [])), r, turned), key=lambda t: t[0])
        _, res, img = best
    boxes = [{"x0": float(min(p[0] for p in b)), "x1": float(max(p[0] for p in b)), "y0": float(min(p[1] for p in b)),
              "y1": float(max(p[1] for p in b)), "text": t, "score": float(s)} for b, t, s in (res or [])]
    return {"file": Path(path).name, "page": i + 1, "width": img.width, "height": img.height, "boxes": boxes}


def ocr_pdfs(folder: Path = PDF_DIR, out: Path = OCR_JSON, only: list[str] | None = None) -> None:
    """OCR the PDFs; with `only`, OCR just those files and keep the other pages already in `out`."""
    import pypdfium2 as pdfium
    files = [f for f in (only or SOURCES) if (folder / f).exists()]
    jobs = [(str(folder / f), i) for f in files for i in range(len(pdfium.PdfDocument(str(folder / f))))]
    with Pool(6, initializer=_init) as pool:
        pages = list(pool.imap_unordered(_page, jobs))
    if only and out.exists():
        pages += [p for p in json.loads(out.read_text(encoding="utf-8")) if p["file"] not in files]
    out.write_text(json.dumps(sorted(pages, key=lambda r: (r["file"], r["page"])), ensure_ascii=False), encoding="utf-8")


_NUM = re.compile(r"^\d{3,9}$")


def _name(text: str) -> str:
    """'DLFColony Old' -> 'DLF Colony Old'; 'Sector-56' -> 'Sector 56'."""
    text = re.sub(r"(?<=[a-z])(?=[A-Z])", " ", text)
    text = re.sub(r"(?i)sector\s*[-.]?\s*(\d)", r"Sector \1", text)
    return re.sub(r"\s+", " ", text).strip(" ,.-")


_NOISE = re.compile(r"(?i)\bdistrict\s*:?\S*|\btehsil\s*:?\S*")


def _split_run(token: str) -> list[str]:
    """OCR drops the commas in sector lists: '626566697071' -> 62..71, '106109' -> 106, 109."""
    digits, suffix = re.match(r"(\d+)([A-Z]?)", token).groups()
    if len(digits) <= 3:
        return [digits + suffix]
    two = [digits[i:i + 2] for i in range(0, len(digits), 2)] if len(digits) % 2 == 0 else []
    if two and not any(c.startswith("0") for c in two):
        return two[:-1] + [two[-1] + suffix]
    three = [digits[i:i + 3] for i in range(0, len(digits), 3)] if len(digits) % 3 == 0 else []
    if three and all(100 <= int(c) <= 120 for c in three):
        return three[:-1] + [three[-1] + suffix]
    return []


def sectors(name: str) -> list[str]:
    """'Sector 626566697071' -> 62, 65, 66, 69, 70, 71; 'Sector 104TO106109 TO115' -> 104..106, 109..115."""
    out = []
    for m in re.finditer(r"(?i)sec(?:tor)?[\s.-]*((?:\d+(?:[A-Z](?![A-Z]))?(?:\s*(?:TO|-|,|&|AND)\s*)?)+)", name):
        tokens = re.findall(r"\d+(?:[A-Z](?![A-Z]))?|TO|-", m.group(1).upper())
        pending_range = False
        for tok in tokens:
            if tok in ("TO", "-"):
                pending_range = bool(out)
                continue
            chunks = _split_run(tok)
            if pending_range and chunks and out and out[-1].isdigit() and chunks[0].isdigit():
                lo, hi = int(out[-1]), int(chunks[0])
                if 0 < hi - lo <= 20:
                    out += [str(i) for i in range(lo + 1, hi)]
            out += chunks
            pending_range = False
    return list(dict.fromkeys(out))


def parse_page(page: dict) -> list[dict]:
    W = page["width"]
    boxes = [dict(b, xc=(b["x0"] + b["x1"]) / 2 / W, yc=(b["y0"] + b["y1"]) / 2) for b in page["boxes"]]
    marks = [b for b in boxes if 0.35 < b["xc"] < 0.6 and b["text"].strip().upper() in {"N", "Y", "IN"}]
    if len(marks) < 3:
        return []
    ax = float(np.median([b["xc"] for b in marks]))     # the "prime" column; rates sit to its right
    anchors = sorted([b for b in marks if abs(b["xc"] - ax) < 0.03], key=lambda b: b["yc"])
    english = [b for b in boxes if 0.12 < b["x0"] / W < ax - 0.05 and re.search(r"[A-Za-z]{3,}", b["text"])
               and "Rates" not in b["text"] and not re.fullmatch(r"[a-z]{1,8}", b["text"])]
    if not english:
        return []
    col_x = pd.Series([round(b["x0"] / W, 2) for b in english]).mode().iloc[0]   # the colony / village column
    names = sorted([b for b in english if abs(b["x0"] / W - col_x) < 0.03], key=lambda b: b["y0"])
    # Join name lines that belong to one cell ("Dhanak Basti Near DSD" + "College").
    groups = []
    for b in names:
        if groups and b["y0"] - groups[-1]["y1"] < 0.6 * (b["y1"] - b["y0"]):
            groups[-1].update(text=groups[-1]["text"] + " " + b["text"], y1=b["y1"])
        else:
            groups.append(dict(b))
    numbers = [b for b in boxes if re.match(r"^\d{2,9}", b["text"].replace(",", "")) and b["xc"] > ax + 0.02]
    rows = []
    ys = np.array([a["yc"] for a in anchors])
    for a_i, a in enumerate(anchors):
        mine = sorted([n for n in numbers if int(np.argmin(np.abs(ys - n["yc"]))) == a_i], key=lambda n: n["xc"])
        values = [int(re.match(r"\d+", n["text"].replace(",", "")).group()) for n in mine]
        rates = [v for v in values if v > 100]
        group = next((g for g in reversed(groups) if g["y0"] <= a["yc"] + 15), None)
        if group is None or not rates:
            continue
        name = _name(_NOISE.sub(" ", group["text"]))
        rows.append({"colony": name, "prime": a["text"].strip().upper() == "Y", "rate_2023_24": rates[0],
                     "rate_2024_25": rates[-1] if len(rates) > 1 else np.nan,
                     "page": page["page"], "source": SOURCES.get(page["file"], page["file"])})
    return rows


def build(ocr_json: Path = OCR_JSON, out_csv: Path = GURUGRAM_CSV) -> pd.DataFrame:
    pages = json.loads(Path(ocr_json).read_text(encoding="utf-8"))
    rows = pd.DataFrame([r for p in pages for r in parse_page(p)])
    rows = rows[~rows["prime"]]
    # Plot rates per sq yard; per-acre farm land rates are in the crores and are dropped.
    rows = rows[rows["rate_2023_24"].between(2_000, 500_000)]
    # A 2024 rate that OCR misread (more than 2x away from the 2023 one) is left blank.
    ok = (rows["rate_2024_25"] / rows["rate_2023_24"]).between(0.8, 2.0)
    rows["rate_2024_25"] = rows["rate_2024_25"].where(ok)
    # Residential = the lowest rate in each colony; commercial ones are higher.
    t = (rows.groupby(["source", "colony"], as_index=False)
         .agg(rate_2023_24=("rate_2023_24", "min"), rate_2024_25=("rate_2024_25", "min"), page=("page", "first"),
              rows=("rate_2023_24", "size")))
    # One row per sector for lists such as "Sector 62, 65, 66".
    expanded = []
    for r in t.itertuples(index=False):
        secs = sectors(r.colony)
        expanded += [r._replace(colony=f"Sector {s}") for s in secs] if secs else [r]
    t = pd.DataFrame(expanded).drop_duplicates(["source", "colony"])
    t["use"] = "residential"
    t["unit"] = "Rs per sq yard"
    t = t.sort_values(["source", "colony"]).reset_index(drop=True)
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    t.to_csv(out_csv, index=False)
    return t


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--ocr", action="store_true", help="OCR the PDFs first (slow)")
    parser.add_argument("--only", nargs="*", help="with --ocr: just these PDF file names")
    args = parser.parse_args()
    if args.ocr:
        ocr_pdfs(only=args.only)
    t = build()
    print(len(t), "colonies and sectors;", t["source"].value_counts().to_dict())
    print(t.sample(min(15, len(t)), random_state=1).to_string(index=False))


if __name__ == "__main__":
    main()
