import io
import os
from pathlib import Path

import numpy as np
import pytest
from PIL import Image

from models.face_match import face

pytestmark = pytest.mark.skipif(not (face.DETECTOR.exists() and face.RECOGNISER.exists()),
                                reason="face weights missing: python -m backend.fetch")

# Optional real photos (not in the repo): Minivision's Silent-Face-Anti-Spoofing sample images.
SAMPLES = Path(os.environ.get("NIRNAY_FACE_SAMPLES", "K:/tools/downloads/silent-face"))


def _png(color="white", size=(640, 480)) -> bytes:
    buf = io.BytesIO()
    Image.new("RGB", size, color).save(buf, "PNG")
    return buf.getvalue()


def test_no_face_in_a_blank_photo():
    d = face.model().describe(_png())
    assert d["faces_found"] == 0 and d["fingerprint"] is None


def test_no_face_means_no_match_and_refer():
    r = face.model().match(_png(), _png("grey"))
    assert r["match"] is False and r["flag"] == "refer" and r["reason_code"] == "R-KYC-01"
    assert r["note"] == "no face in the selfie"


def test_not_an_image_raises():
    with pytest.raises(ValueError):
        face.decode(b"not an image")


def test_compare_uses_the_published_threshold():
    m = face.model()
    v = np.ones((1, 128), dtype=np.float32)
    same = m.compare({"faces_found": 1, "fingerprint": v, "too_small": False},
                     {"faces_found": 1, "fingerprint": v, "too_small": False})
    assert same["match"] and same["similarity"] == pytest.approx(1.0, abs=1e-4)
    w = v.copy()
    w[0, :64] = -1
    other = m.compare({"faces_found": 1, "fingerprint": v, "too_small": False},
                      {"faces_found": 1, "fingerprint": w, "too_small": False})
    assert not other["match"] and other["similarity"] < face.MATCH_AT


@pytest.mark.skipif(not (SAMPLES / "image_T1.jpg").exists(), reason="sample photos not downloaded")
def test_same_person_matches_and_different_person_does_not():
    m = face.model()
    real = (SAMPLES / "image_T1.jpg").read_bytes()
    same_on_screen = (SAMPLES / "image_F2.jpg").read_bytes()   # the same woman, photographed off a phone screen
    printed_other = (SAMPLES / "image_F1.jpg").read_bytes()    # a printed photo of someone else
    assert m.match(real, same_on_screen)["match"]
    assert not m.match(real, printed_other)["match"]
