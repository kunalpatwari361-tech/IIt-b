"""Model 9: face match. Checks the selfie against the ID photo.

Two small ONNX models from the OpenCV model zoo, run with OpenCV itself:
- YuNet finds faces and their five landmarks (MIT licence).
- SFace turns an aligned face into a 128-number fingerprint (Apache-2.0 licence).

Two faces belong to the same person when the cosine similarity of their
fingerprints is at least 0.363, the threshold OpenCV publishes for SFace on LFW.
DeepFace offers the same SFace + YuNet pair; we call OpenCV directly, so there is
no TensorFlow and no non-commercial InsightFace weights.

Try it from the repo root:
    .venv/Scripts/python -m models.face_match.face selfie.jpg id_photo.jpg
"""
from __future__ import annotations

import io
import json
import sys
from pathlib import Path

import cv2
import numpy as np

WEIGHTS = Path(__file__).resolve().parent / "weights"
DETECTOR = WEIGHTS / "face_detection_yunet_2023mar.onnx"
RECOGNISER = WEIGHTS / "face_recognition_sface_2021dec.onnx"
VERSION = "sface-2021dec+yunet-2023mar"
MATCH_AT = 0.363       # cosine similarity; OpenCV's published SFace threshold on LFW
MIN_FACE_SCORE = 0.8   # YuNet confidence for "a face is there"
MAX_SIDE = 960         # big phone photos are shrunk before detection, for speed
MIN_FACE_PX = 60       # a face smaller than this is too small to match reliably


def decode(data: bytes | np.ndarray) -> np.ndarray:
    """Bytes of a JPEG/PNG (or an array) to a BGR image, upright per the photo's EXIF."""
    if isinstance(data, np.ndarray):
        return data
    from PIL import Image, ImageOps
    try:
        img = ImageOps.exif_transpose(Image.open(io.BytesIO(data))).convert("RGB")
    except Exception as e:  # not an image at all
        raise ValueError("not_an_image") from e
    return cv2.cvtColor(np.asarray(img), cv2.COLOR_RGB2BGR)


class FaceModel:
    def __init__(self, detector: Path = DETECTOR, recogniser: Path = RECOGNISER):
        for p in (detector, recogniser):
            if not p.exists():
                raise FileNotFoundError(f"Missing {p.name}. Run: python -m backend.fetch")
        self.detector = cv2.FaceDetectorYN.create(str(detector), "", (320, 320), MIN_FACE_SCORE, 0.3, 50)
        self.recogniser = cv2.FaceRecognizerSF.create(str(recogniser), "")

    def faces(self, img: np.ndarray) -> list[np.ndarray]:
        """Every face found, largest first. Each row: x, y, w, h, 5 landmark pairs, score (full-size pixels)."""
        h, w = img.shape[:2]
        scale = min(1.0, MAX_SIDE / max(h, w))
        small = cv2.resize(img, (int(w * scale), int(h * scale))) if scale < 1 else img
        self.detector.setInputSize((small.shape[1], small.shape[0]))
        _, found = self.detector.detect(small)
        if found is None:
            return []
        found = found.copy()
        found[:, :14] /= scale
        return sorted(found, key=lambda f: -f[2] * f[3])

    def fingerprint(self, img: np.ndarray, face: np.ndarray) -> np.ndarray:
        aligned = self.recogniser.alignCrop(img, face)
        return self.recogniser.feature(aligned)

    def similarity(self, a: np.ndarray, b: np.ndarray) -> float:
        return float(self.recogniser.match(a, b, cv2.FaceRecognizerSF_FR_COSINE))

    def describe(self, data: bytes | np.ndarray) -> dict:
        """Find the main face in one photo and fingerprint it."""
        img = decode(data)
        found = self.faces(img)
        out = {"faces_found": len(found), "face_box": None, "face_score": None, "fingerprint": None,
               "too_small": False, "image": img}
        if not found:
            return out
        main = found[0]
        out.update(face_box=[int(v) for v in main[:4]], face_score=round(float(main[-1]), 3),
                   too_small=bool(min(main[2], main[3]) < MIN_FACE_PX))
        out["fingerprint"] = self.fingerprint(img, main)
        return out

    def match(self, selfie: bytes | np.ndarray, id_photo: bytes | np.ndarray) -> dict:
        """1:1 match of a selfie against an ID photo."""
        a, b = self.describe(selfie), self.describe(id_photo)
        return self.compare(a, b)

    def compare(self, a: dict, b: dict) -> dict:
        result = {"model": "face_match", "model_version": VERSION, "threshold": MATCH_AT,
                  "selfie_faces": a["faces_found"], "id_faces": b["faces_found"],
                  "similarity": None, "match": False, "flag": "refer", "reason_code": "R-KYC-01", "note": None}
        if a["fingerprint"] is None:
            result["note"] = "no face in the selfie"
        elif b["fingerprint"] is None:
            result["note"] = "no face in the ID photo"
        else:
            sim = self.similarity(a["fingerprint"], b["fingerprint"])
            ok = sim >= MATCH_AT
            result.update(similarity=round(sim, 4), match=ok, flag="pass" if ok else "refer",
                          reason_code=None if ok else "R-KYC-01",
                          note=None if ok else "the faces do not match")
            if ok and (a["too_small"] or b["too_small"]):
                result["note"] = "matched, but one face is very small"
        return result


_loaded: FaceModel | None = None


def model() -> FaceModel:
    global _loaded
    if _loaded is None:
        _loaded = FaceModel()
    return _loaded


def predict(selfie: bytes, id_photo: bytes) -> dict:
    """What the decision engine calls: match a selfie with an ID photo."""
    return model().match(selfie, id_photo)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit("Usage: python -m models.face_match.face <selfie.jpg> <id_photo.jpg>")
    print(json.dumps(predict(Path(sys.argv[1]).read_bytes(), Path(sys.argv[2]).read_bytes()), indent=2))
