"""Model 8: OCR. Reads text from photos and PDFs, including Hindi.

PaddleOCR's PP-OCRv4 models, run locally with ONNX Runtime through RapidOCR
(Apache-2.0). Nothing leaves the machine.
- Text detection, the 180-degree turn check and the English recogniser ship with
  rapidocr-onnxruntime.
- A Devanagari recogniser (Hindi, Marathi, Nepali, Sanskrit and others), from RapidAI's
  model hub, reads Hindi. `script="auto"` runs it only when the English pass finds
  text it can't read, then keeps the better reading of each text box.
- PDFs with a text layer are read directly with pypdfium2. Scanned pages are drawn
  at 200 dpi and OCR'd.

Try it from the repo root:
    .venv/Scripts/python -m models.ocr.ocr some_document.jpg
"""
from __future__ import annotations

import io
import json
import re
import sys
import unicodedata
from pathlib import Path

import numpy as np

WEIGHTS = Path(__file__).resolve().parent / "weights"
DEVANAGARI = WEIGHTS / "devanagari_PP-OCRv4_rec_mobile.onnx"
VERSION = "pp-ocrv4-rapidocr-1.4"
MAX_PAGES = 10
PDF_DPI = 200
MIN_TEXT_LAYER = 60          # a PDF page with fewer letters than this is treated as a scan

# Chinese, Japanese and Korean letters. Full-width punctuation (U+FF00-FFEF) is not here:
# the default recogniser often writes ":" as "：", and NFKC turns it back into ASCII.
_CJK = re.compile("[぀-ヿ㐀-䶿一-鿿가-힯]")
_DEVANAGARI = re.compile(r"[ऀ-ॿ]")
_engines: dict[str, object] = {}


def engine(script: str = "latin"):
    """RapidOCR with the English (default) or Devanagari recogniser, loaded once."""
    if script not in _engines:
        from rapidocr_onnxruntime import RapidOCR
        if script == "devanagari":
            if not DEVANAGARI.exists():
                raise FileNotFoundError(f"Missing {DEVANAGARI.name}. Run: python -m backend.fetch")
            _engines[script] = RapidOCR(rec_model_path=str(DEVANAGARI))
        else:
            _engines[script] = RapidOCR()
    return _engines[script]


def devanagari_ready() -> bool:
    return DEVANAGARI.exists()


def _score(text: str, score: float) -> float:
    """Indian lending papers never contain Chinese, Japanese or Korean, so such a reading is wrong."""
    return 0.0 if _CJK.search(text) else float(score)


def _boxes(img: np.ndarray, scripts: list[str]) -> list[tuple]:
    """Find text boxes once, read every box with each recogniser, keep the more confident reading.

    Uses RapidOCR's own steps (pinned to 1.4.x in requirements) so both recognisers see
    exactly the same crops. Returns (box, text, score, script) per box.
    """
    det = engine("latin")
    raw_h, raw_w = img.shape[:2]
    op: dict = {}
    im, ratio_h, ratio_w = det.preprocess(img)
    op["preprocess"] = {"ratio_h": ratio_h, "ratio_w": ratio_w}
    im, op = det.maybe_add_letterbox(im, op)
    boxes, _ = det.auto_text_det(im)
    if boxes is None:
        return []
    crops = det.get_crop_img_list(im, boxes)
    crops, _, _ = det.text_cls(crops)
    readings = {s: engine(s).text_rec(crops, False)[0] for s in scripts}
    points = det._get_origin_points(boxes, op, raw_h, raw_w)
    out = []
    for i, box in enumerate(points):
        options = []
        for s in scripts:
            text = unicodedata.normalize("NFKC", readings[s][i][0])
            score = _score(text, readings[s][i][1])
            # The Devanagari recogniser also knows Latin letters and digits, but reads them worse
            # than the English one, so its reading only counts when it found Devanagari.
            if s == "devanagari" and len(scripts) > 1 and not _DEVANAGARI.search(text):
                score = 0.0
            options.append((score, text, s))
        score, text, script = max(options)
        if score >= det.text_score and text.strip():
            out.append((box.tolist(), text, score, script))
    return out


def _lines(boxes: list[tuple]) -> list[dict]:
    """Group text boxes into printed lines, top to bottom, left to right."""
    if not boxes:
        return []
    items = []
    for box, text, score, script in boxes:
        ys = [p[1] for p in box]
        items.append((sum(ys) / 4, max(ys) - min(ys), min(p[0] for p in box), text, score, script))
    items.sort()
    height = float(np.median([i[1] for i in items])) or 10.0
    lines, current, y_line = [], [], None
    for yc, _h, x, text, score, script in items:
        if y_line is not None and abs(yc - y_line) > 0.5 * height:
            lines.append(current)
            current = []
        if not current:
            y_line = yc
        current.append((x, text, score, script))
    if current:
        lines.append(current)
    out = []
    for line in lines:
        line.sort()
        out.append({"text": " ".join(t for _, t, _, _ in line),
                    "confidence": round(float(np.mean([s for _, _, s, _ in line])), 4),
                    "scripts": sorted({s for _, _, _, s in line})})
    return out


def read_image(img: np.ndarray, script: str = "auto") -> dict:
    """OCR one RGB image. script: "latin", "devanagari" or "auto" (both, best reading per box)."""
    if script == "auto":
        passes = ["latin", "devanagari"] if devanagari_ready() else ["latin"]
    else:
        passes = [script]
    lines = _lines(_boxes(img, passes))
    return {"lines": lines, "passes": passes,
            "mean_confidence": round(float(np.mean([l["confidence"] for l in lines])), 4) if lines else None}


def _pdf_pages(data: bytes):
    import pypdfium2 as pdfium
    pdf = pdfium.PdfDocument(data)
    try:
        for i in range(min(len(pdf), MAX_PAGES)):
            page = pdf[i]
            text = page.get_textpage().get_text_range()
            readable = len(re.sub(r"[^0-9A-Za-zऀ-ॿ]", "", text))
            if readable >= MIN_TEXT_LAYER:
                yield "pdf_text", text, None
            else:
                yield "ocr", None, np.asarray(page.render(scale=PDF_DPI / 72).to_pil().convert("RGB"))
        if len(pdf) > MAX_PAGES:
            yield "truncated", None, None
    finally:
        pdf.close()


def read(data: bytes, filename: str = "", script: str = "auto") -> dict:
    """Read a photo or PDF. Returns its text and how it was read."""
    out = {"model": "ocr", "model_version": VERSION, "text": "", "pages": 0, "sources": [],
           "passes": [], "mean_confidence": None, "has_hindi": False, "truncated": False, "error": None}
    texts, confidences = [], []
    try:
        if data[:5] == b"%PDF-":
            for source, text, img in _pdf_pages(data):
                if source == "truncated":
                    out["truncated"] = True
                    continue
                out["pages"] += 1
                out["sources"].append(source)
                if source == "pdf_text":
                    texts.append(text.strip())
                else:
                    r = read_image(img, script)
                    texts.append("\n".join(l["text"] for l in r["lines"]))
                    out["passes"] = sorted(set(out["passes"]) | set(r["passes"]))
                    if r["mean_confidence"] is not None:
                        confidences.append(r["mean_confidence"])
        else:
            from PIL import Image, ImageOps
            img = ImageOps.exif_transpose(Image.open(io.BytesIO(data))).convert("RGB")
            r = read_image(np.asarray(img), script)
            out.update(pages=1, sources=["ocr"], passes=r["passes"])
            texts.append("\n".join(l["text"] for l in r["lines"]))
            if r["mean_confidence"] is not None:
                confidences.append(r["mean_confidence"])
    except Exception as e:  # unreadable file: the engine asks for a clearer copy
        out["error"] = f"{type(e).__name__}: {e}"[:200]
    out["text"] = "\n".join(t for t in texts if t)
    out["mean_confidence"] = round(float(np.mean(confidences)), 4) if confidences else None
    out["has_hindi"] = bool(_DEVANAGARI.search(out["text"]))
    return out


def predict(document: dict) -> dict:
    """What the decision engine calls: {"bytes": ..., "filename": ...}."""
    return read(document["bytes"], document.get("filename", ""), document.get("script", "auto"))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Usage: python -m models.ocr.ocr <image or pdf>")
    r = read(Path(sys.argv[1]).read_bytes(), sys.argv[1])
    print(r["text"])
    print(json.dumps({k: v for k, v in r.items() if k != "text"}, indent=2, ensure_ascii=False))
