import pytest

from models.translation import translate as t


def test_phrasebook_uses_the_apps_reviewed_sentences(monkeypatch):
    monkeypatch.setenv("NIRNAY_LLM", "off")
    r = t.translate(["Your credit score is below our minimum of 650.", "Something the app never says"], "hi")
    assert r["texts"][0] == t.Phrasebook.table("hi")["Your credit score is below our minimum of 650."]
    assert r["texts"][1] == "Something the app never says"
    assert r["untranslated"] == 1 and r["engines"] == ["phrasebook"]


def test_every_app_language_has_a_code():
    import json
    for f in t.ARB_DIR.glob("app_*.arb"):
        lang = f.stem[4:]
        if lang != "en":
            assert lang in t.LANGUAGES, lang
    assert len(t.LANGUAGES) == 22


def test_numbers_check_reads_indian_digits():
    assert t.numbers_kept("EMI Rs 39,767 at 8.75%", "ईएमआई ₹३९,७६७, ८.७५%")
    assert not t.numbers_kept("EMI Rs 39,767", "ईएमआई ₹३९,७७६")


def test_engine_that_changes_a_number_is_skipped(monkeypatch):
    class Bad:
        name = "bad"
        def ready(self):
            return True
        def translate(self, texts, lang):
            return ["आपकी ईएमआई 40,000 है।" for _ in texts]
    monkeypatch.setattr(t, "ENGINES", [Bad(), t.Phrasebook()])
    r = t.translate(["Your EMI is 39,767."], "hi")
    assert r["texts"] == ["Your EMI is 39,767."] and r["untranslated"] == 1
    assert r["skipped"][0]["error"] == "numbers_changed"


def test_failing_engine_hands_over(monkeypatch):
    class Broken:
        name = "broken"
        def ready(self):
            return True
        def translate(self, texts, lang):
            raise ConnectionError("down")
    monkeypatch.setattr(t, "ENGINES", [Broken(), t.Phrasebook()])
    r = t.translate(["Our lawyer needs to review the property title."], "ta")
    assert r["engines"] == ["phrasebook"] and r["skipped"][0]["engine"] == "broken"


def test_english_and_unknown_languages():
    assert t.translate(["Hello"], "en")["texts"] == ["Hello"]
    with pytest.raises(ValueError):
        t.translate(["Hello"], "xx")
