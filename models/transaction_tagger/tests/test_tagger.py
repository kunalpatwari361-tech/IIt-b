import pytest

from models.transaction_tagger.generator import CATEGORIES, TEMPLATES, generate
from models.transaction_tagger.sources import HF_PATH, HF_TO_NIRNAY, load_hf
from models.transaction_tagger.tagger import TransactionTagger, document, normalise, summarise
from models.transaction_tagger.train import train


@pytest.fixture(scope="module")
def trained(tmp_path_factory):
    out = tmp_path_factory.mktemp("tagger")
    hf = load_hf() if HF_PATH.exists() else None
    result = train(gen=generate(per_category=80, seed=3), hf=hf, out_dir=out)
    return result, TransactionTagger.load(out / "artifacts"), out


def test_generator_covers_every_category_with_several_formats():
    gen = generate(per_category=30, seed=1)
    assert set(gen["category"]) == set(CATEGORIES) == set(TEMPLATES)
    assert all(len(t) >= 6 for t in TEMPLATES.values())
    assert gen["template"].nunique() == sum(len(t) for t in TEMPLATES.values())


def test_every_hugging_face_category_is_mapped():
    assert set(HF_TO_NIRNAY.values()) <= set(CATEGORIES)


def test_normalise_hides_numbers_and_punctuation():
    assert normalise("NEFT CR-HDFC0001234-INFOSYS/SAL") == "neft cr hdfc# infosys sal"
    assert document("ATM WDL", "debit").endswith("zzdirdebit")
    assert document("ATM WDL", None).endswith("zzdirunknown")


def test_training_writes_every_output(trained):
    *_, out = trained
    for path in ["artifacts/model.joblib", "artifacts/tagger.json", "reports/metrics.json",
                 "reports/per_category.csv", "reports/training_data.csv"]:
        assert (out / path).exists(), path


def test_tags_unseen_formats_well(trained):
    result, _, _ = trained
    assert result["metrics"]["checks"]["unseen_formats"]["macro_f1"] > 0.7


@pytest.mark.parametrize("text, direction, expected", [
    ("NACH RTN BAJAJ FINANCE LTD INSUFF BAL P1234567", "debit", "bounce"),
    ("CHQ RTN-INSUFFICIENT FUNDS-004512", "debit", "bounce"),
    ("NEFT CR-ICIC0000104-INFOSYS LIMITED-SALARY OCT 2025-ICICN12345678901", "credit", "salary"),
    ("ACH D- LIC HOUSING FINANCE-P99ABC1234", "debit", "emi"),
    ("CASH DEPOSIT-CDM S1AN1234 PUNE", "credit", "cash_deposit"),
    ("ATM WDL-ATM CASH S1BW5678 DELHI", "debit", "cash_withdrawal"),
    ("LOCKER RENT 2025", "debit", "bank_charges"),
    ("UPI/123456789012/SWIGGY/swiggy@ybl/Payment", "debit", "spend"),
])
def test_tags_lending_critical_entries(trained, text, direction, expected):
    _, tagger, _ = trained
    assert tagger.tag(text, direction)["category"] == expected


def test_output_has_confidence_top3_and_reasons(trained):
    _, tagger, _ = trained
    out = tagger.tag("NACH RTN BAJAJ FINANCE LTD INSUFF BAL", "debit")
    assert 0 < out["confidence"] <= 1 and len(out["top3"]) == 3 and out["reasons"]
    assert out["needs_review"] == (out["confidence"] < 0.5)


def test_summary_counts_salary_emi_and_bounces(trained):
    _, tagger, _ = trained
    rows = [
        {"date": "2025-08-01", "amount": 60000, "direction": "credit", "text": "NEFT CR-HDFC0000001-WIPRO LTD-SALARY AUG 2025"},
        {"date": "2025-08-05", "amount": 12000, "direction": "debit", "text": "ACH D- BAJAJ FINANCE LTD-P12345ABC"},
        {"date": "2025-09-01", "amount": 60000, "direction": "credit", "text": "NEFT CR-HDFC0000001-WIPRO LTD-SALARY SEP 2025"},
        {"date": "2025-09-05", "amount": 12000, "direction": "debit", "text": "ACH D RETURN-BAJAJ FINANCE LTD-INSUFFICIENT FUNDS"},
    ]
    s = summarise(tagger.tag_many(rows))
    assert s["salary_months"] == 2 and s["avg_monthly_salary"] == 60000
    assert s["bounces"] == 1 and s["months"] == ["2025-08", "2025-09"]


def test_works_without_direction(trained):
    _, tagger, _ = trained
    assert tagger.tag("ATM WDL-ATM CASH S1BW5678 DELHI")["category"] == "cash_withdrawal"
