"""Model 10: passive liveness. Catches a printed photo or a phone screen held up to the camera.

Minivision's Silent-Face-Anti-Spoofing (Apache-2.0): two MiniFASNet networks look at
the face at two zoom levels (2.7x and 4x the face box), each as an 80x80 BGR crop
with raw 0-255 pixel values. Their three-way softmax outputs are added together;
class 1 means a real face. We run them as ONNX (converted once by convert.py).

The face box comes from model 9's YuNet detector instead of the original RetinaFace.

Try it from the repo root:
    .venv/Scripts/python -m models.liveness.liveness selfie.jpg
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import cv2
import numpy as np

WEIGHTS = Path(__file__).resolve().parent / "weights"
NETWORKS = [("2.7_80x80_MiniFASNetV2.onnx", 2.7), ("4_0_0_80x80_MiniFASNetV1SE.onnx", 4.0)]
VERSION = "minifasnet-v2+v1se"
REAL = 1  # class index for a real face; 0 and 2 are the two spoof types


def crop(img: np.ndarray, box, scale: float, size: int = 80) -> np.ndarray:
    """The original CropImage: a box `scale` times the face, kept inside the image, resized."""
    src_h, src_w = img.shape[:2]
    x, y, w, h = [float(v) for v in box]
    scale = min((src_h - 1) / h, (src_w - 1) / w, scale)
    nw, nh = w * scale, h * scale
    cx, cy = x + w / 2, y + h / 2
    l, t, r, b = cx - nw / 2, cy - nh / 2, cx + nw / 2, cy + nh / 2
    if l < 0:
        r -= l
        l = 0
    if t < 0:
        b -= t
        t = 0
    if r > src_w - 1:
        l -= r - src_w + 1
        r = src_w - 1
    if b > src_h - 1:
        t -= b - src_h + 1
        b = src_h - 1
    patch = img[int(t):int(b) + 1, int(l):int(r) + 1]
    return cv2.resize(patch, (size, size))


def _softmax(z: np.ndarray) -> np.ndarray:
    e = np.exp(z - z.max(axis=1, keepdims=True))
    return e / e.sum(axis=1, keepdims=True)


class LivenessModel:
    def __init__(self, folder: Path = WEIGHTS):
        import onnxruntime as ort
        self.sessions = []
        for name, scale in NETWORKS:
            path = Path(folder) / name
            if not path.exists():
                raise FileNotFoundError(f"Missing {name}. Run: python -m models.liveness.convert <folder>")
            self.sessions.append((ort.InferenceSession(str(path), providers=["CPUExecutionProvider"]), scale))

    def check(self, img_bgr: np.ndarray, face_box) -> dict:
        """Liveness of the face in `face_box` (x, y, w, h) of a BGR image."""
        total = np.zeros(3)
        for sess, scale in self.sessions:
            patch = crop(img_bgr, face_box, scale).astype(np.float32).transpose(2, 0, 1)[None]
            total += _softmax(sess.run(None, {"image": patch})[0])[0]
        label = int(np.argmax(total))
        live = label == REAL
        return {"model": "liveness", "model_version": VERSION, "live": live,
                "score": round(float(total[REAL] / len(self.sessions)), 4),
                "spoof_score": round(float((total.sum() - total[REAL]) / len(self.sessions)), 4),
                "flag": "pass" if live else "refer", "reason_code": None if live else "R-KYC-01"}


_loaded: LivenessModel | None = None


def model() -> LivenessModel:
    global _loaded
    if _loaded is None:
        _loaded = LivenessModel()
    return _loaded


def predict(img_bgr: np.ndarray, face_box) -> dict:
    return model().check(img_bgr, face_box)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("Usage: python -m models.liveness.liveness <selfie.jpg>")
    from models.face_match import face
    found = face.model().describe(Path(sys.argv[1]).read_bytes())
    if found["face_box"] is None:
        sys.exit("No face found")
    print(json.dumps(predict(found["image"], found["face_box"]), indent=2))
