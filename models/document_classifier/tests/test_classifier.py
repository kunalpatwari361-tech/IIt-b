import random
import re

import pytest

from models.document_classifier.build_data import OUT_CSV
from models.document_classifier.classifier import DocumentClassifier, normalise, squash
from models.document_classifier.generator import CATEGORIES, LAYOUTS, generate, inr, plain_text, words
from models.document_classifier.render import degrade, render
from models.document_classifier.train import load_data, train


@pytest.fixture(scope="module")
def trained(tmp_path_factory):
    out = tmp_path_factory.mktemp("doc_classifier")
    df = load_data()
    # A smaller C and every third main document keeps the test quick; the hard set stays in.
    df = df[(df["set"] == "hard") | (df["doc_id"].str[-3:].astype(int) % 3 == 0)]
    result = train(df, None, out_dir=out)
    return result, DocumentClassifier.load(out / "artifacts")


def test_generator_covers_every_type_and_layout():
    docs = generate(per_type=10, seed=1, other_count=16)
    assert {d["category"] for d in docs} == set(CATEGORIES)
    for cat, n in LAYOUTS.items():
        assert {d["layout_no"] for d in docs if d["category"] == cat} == set(range(n))


def test_aadhaar_numbers_are_always_masked():
    for d in generate(per_type=20, seed=2, other_count=8):
        text = plain_text(d["lines"])
        assert not re.search(r"\b\d{4} \d{4} \d{4}\b", text), d["doc_id"]


def test_rupee_formats():
    assert inr(1234567.5) == "12,34,567.50" and inr(999, False) == "999"
    assert words(1234567) == "Twelve Lakh Thirty Four Thousand Five Hundred Sixty Seven"
    assert words(20000000) == "Two Crore"


def test_normalise_and_squash_ignore_spacing_and_numbers():
    assert normalise("FORM NO. 16 [See rule 31(1)(a)]") == "form no # see rule # # a"
    assert squash("Permanent Account Number") == squash("PermanentAccount  Number") == "permanentaccountnumber"


def test_render_and_degrade_make_images():
    docs = generate(per_type=1, seed=3, other_count=1)
    card = next(d for d in docs if d["kind"] == "card")
    page = next(d for d in docs if d["kind"] == "page")
    rng = random.Random(0)
    assert render(card, rng).size[0] == 1012
    img = render(page, rng)
    assert img.size[0] == 1240 and img.size[1] >= 1750
    assert degrade(img, rng, "hard").size[0] > 100


def test_committed_dataset_has_every_type():
    df = load_data(OUT_CSV)
    main = df[df["set"] == "main"]
    assert set(main["category"]) == set(CATEGORIES)
    assert 300 <= len(main) <= 500
    assert (main["ocr_text"].str.len() > 0).mean() > 0.95


def test_accurate_on_unseen_layouts(trained):
    result, _ = trained
    checks = result["metrics"]["checks"]
    assert checks["unseen_layouts"]["accuracy"] > 0.85
    assert checks["unseen_layouts_clean_text"]["accuracy"] > 0.85


@pytest.mark.parametrize("category, layout", [
    ("form_16", 1), ("encumbrance_certificate", 1),   # both say "Form No. 16"
    ("salary_slip", 0), ("form_16", 4),               # both are from the employer and show pay and PAN
    ("sale_deed", 0), ("allotment_letter", 0),         # both describe a property sale
    ("bank_statement", 0), ("pan_card", 0), ("aadhaar_card", 2), ("itr", 0),
])
def test_tells_look_alikes_apart(trained, category, layout):
    _, clf = trained
    doc = next(d for d in generate(per_type=10, seed=99, other_count=16)
               if d["category"] == category and d["layout_no"] == layout)
    assert clf.classify(plain_text(doc["lines"]))["document_type"] == category


def test_engine_flags(trained):
    _, clf = trained
    doc = next(d for d in generate(per_type=5, seed=7, other_count=8) if d["category"] == "salary_slip")
    text = plain_text(doc["lines"])
    ok = clf.classify(text, expected="salary_slip")
    assert ok["flag"] == "pass" and ok["reason_code"] is None and ok["reasons"]
    wrong = clf.classify(text, expected="form_16")
    assert wrong["flag"] == "refer" and wrong["reason_code"] == "R-DOC-01"
    blur = clf.classify("~~ ,. ..", expected="salary_slip")
    assert blur["document_type"] == "unreadable" and blur["reason_code"] == "R-DOC-02"


def test_real_ocr_round_trip(trained):
    pytest.importorskip("rapidocr_onnxruntime")
    from models.document_classifier.ocr import read_text
    _, clf = trained
    doc = next(d for d in generate(per_type=5, seed=11, other_count=8) if d["category"] == "pan_card")
    rng = random.Random(1)
    assert clf.classify(read_text(degrade(render(doc, rng), rng)))["document_type"] == "pan_card"
