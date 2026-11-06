import os
from pathlib import Path

import numpy as np
import pytest

from models.liveness import liveness

pytestmark = pytest.mark.skipif(not all((liveness.WEIGHTS / n).exists() for n, _ in liveness.NETWORKS),
                                reason="liveness ONNX files missing")
SAMPLES = Path(os.environ.get("NIRNAY_FACE_SAMPLES", "K:/tools/downloads/silent-face"))


def test_onnx_matches_the_pytorch_originals():
    """Logits PyTorch gave for this input when convert.py ran; the ONNX files must agree."""
    import onnxruntime as ort
    x = np.random.default_rng(0).uniform(0, 255, (1, 3, 80, 80)).astype(np.float32)
    expected = {"2.7_80x80_MiniFASNetV2.onnx": [-2.461647, 4.0528297, -1.5938413],
                "4_0_0_80x80_MiniFASNetV1SE.onnx": [-1.3051904, 4.686715, -3.383675]}
    for name, want in expected.items():
        got = ort.InferenceSession(str(liveness.WEIGHTS / name), providers=["CPUExecutionProvider"]).run(None, {"image": x})[0][0]
        assert np.allclose(got, want, atol=1e-4)


def test_crop_stays_inside_the_image():
    img = np.zeros((480, 640, 3), dtype=np.uint8)
    for box in ([0, 0, 100, 120], [600, 400, 40, 80], [200, 150, 200, 240]):
        for scale in (2.7, 4.0):
            assert liveness.crop(img, box, scale).shape == (80, 80, 3)


def test_result_shape():
    img = np.full((480, 640, 3), 128, dtype=np.uint8)
    r = liveness.model().check(img, [220, 140, 200, 240])
    assert set(r) >= {"live", "score", "spoof_score", "flag", "reason_code"}
    assert 0 <= r["score"] <= 1 and r["flag"] in ("pass", "refer")


@pytest.mark.skipif(not (SAMPLES / "image_T1.jpg").exists(), reason="sample photos not downloaded")
def test_minivision_samples():
    from models.face_match import face
    for name, live in (("image_T1.jpg", True), ("image_F1.jpg", False), ("image_F2.jpg", False)):
        d = face.model().describe((SAMPLES / name).read_bytes())
        assert liveness.predict(d["image"], d["face_box"])["live"] is live, name
