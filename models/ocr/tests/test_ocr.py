import io
import random

import pytest
from PIL import Image

from models.ocr import ocr

pytestmark = pytest.mark.skipif(not ocr.devanagari_ready(), reason="Devanagari weights missing: python -m backend.fetch")


def _page(lines):
    from models.document_classifier import render
    img = render.render({"kind": "page", "lines": lines}, random.Random(3))
    buf = io.BytesIO()
    img.save(buf, "JPEG", quality=90)
    return buf.getvalue(), img


def test_reads_english_and_hindi_on_one_page():
    data, _ = _page([("hi", "भारत सरकार"), ("sub", "GOVERNMENT OF INDIA"), ("title", "SALE DEED"),
                     ("kv", "Name\tRavi Kumar"), ("text", "Registration No. 4821/2026 at Haveli No. 11, Pune.")])
    r = ocr.read(data)
    assert r["error"] is None
    assert r["has_hindi"] and "भारत" in r["text"]
    squashed = r["text"].replace(" ", "")      # OCR sometimes drops the space between words
    assert "RaviKumar" in squashed and "4821/2026" in squashed
    assert r["passes"] == ["latin", "devanagari"]


def test_english_only_pass_cannot_read_hindi():
    data, _ = _page([("hi", "भारत सरकार"), ("sub", "GOVERNMENT OF INDIA")])
    assert not ocr.read(data, script="latin")["has_hindi"]


def test_scanned_pdf_is_ocrd():
    _, img = _page([("title", "SALARY SLIP"), ("kv", "Name of Employee\tPriya Nair"), ("kv", "Net Salary Payable\t85,000.00")])
    buf = io.BytesIO()
    img.save(buf, "PDF", resolution=150)
    r = ocr.read(buf.getvalue(), "slip.pdf")
    assert r["sources"] == ["ocr"] and "PriyaNair" in r["text"].replace(" ", "")


def test_not_an_image_reports_an_error():
    r = ocr.read(b"hello, not an image")
    assert r["text"] == "" and r["error"]


def test_blank_page_has_no_text():
    buf = io.BytesIO()
    Image.new("RGB", (800, 600), "white").save(buf, "PNG")
    r = ocr.read(buf.getvalue())
    assert r["text"] == "" and r["error"] is None
