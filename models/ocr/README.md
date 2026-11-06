# Model 8: OCR (model card)

| | |
|---|---|
| **Job** | Reads the text of every uploaded photo or PDF, in English and Hindi, so model 6 can say what the document is and the engine can read its fields |
| **Type** | Ready-made: PaddleOCR's **PP-OCRv4** models run with ONNX Runtime through [RapidOCR](https://github.com/RapidAI/RapidOCR) (Apache-2.0). Nothing leaves the machine. |
| **Recognisers** | English (ships with `rapidocr-onnxruntime`) and **Devanagari** `devanagari_PP-OCRv4_rec_mobile.onnx` from RapidAI's model hub on ModelScope (7.7 MB, carries its own 167-character list) |
| **Version** | `pp-ocrv4-rapidocr-1.4` |
| **Owner** | Backend member |

## How it works

1. **PDFs** with a text layer are read directly (pypdfium2). Scanned pages are drawn at 200 dpi and OCR'd. At most 10 pages.
2. **Photos** are turned upright from their EXIF tag, then RapidOCR finds the text boxes once.
3. **Both recognisers read every box** (`script="auto"`), and the more confident reading wins, with two rules:
   - A reading in Chinese, Japanese or Korean script scores 0: Indian lending papers never contain them, and the English/Chinese recogniser outputs them when it meets Hindi.
   - The Devanagari recogniser's reading only counts when it contains Devanagari. It also knows Latin letters but reads them worse (`4821/2026` came out as `48212o25`).
4. Boxes are grouped into printed lines, top to bottom.

```python
from models.ocr import ocr
r = ocr.read(open("deed.jpg", "rb").read())
r["text"], r["has_hindi"], r["passes"], r["mean_confidence"]
```

## Checks

`tests/test_ocr.py` draws pages with the same renderer as model 6's training documents and checks:
- a page with Hindi and English lines: both come back, including `4821/2026`;
- the English pass alone cannot read Hindi (why the second recogniser is there);
- a scanned PDF goes through OCR;
- a blank page gives no text, and a non-image gives an error, not a crash.

End to end, the engine's sample PAN, Aadhaar, salary slip, Form 16, ITR, GST and bank-statement images are all read well enough that model 6 names their type correctly (`backend/tests`).

## Limits

- **Spaces go missing** between English words (`PermanentAccountNumberCard`, `RaviKumar`). Model 6 and the field rules are built for it: names are compared with spaces removed.
- One rendered Hindi line (`विक्रय विलेख का पंजीकरण`) still came out garbled, so Hindi reading is good, not perfect.
- **Only Devanagari** among Indian scripts. Tamil and Telugu recognisers exist on the same hub (`ta_`, `te_PP-OCRv4_rec_mobile.onnx`), but the engine doesn't load them yet.
- About 4–9 seconds a page on a laptop CPU, because both recognisers run.
- `ocr.py` calls RapidOCR's own steps so both recognisers see the same crops; `requirements.txt` pins `rapidocr-onnxruntime` to 1.4.x for that reason.

## Get the weights

```bash
.venv/Scripts/python -m backend.fetch
```

This downloads the Devanagari recogniser and checks its SHA-256 (`a62b6148…`). Git ignores the file.
