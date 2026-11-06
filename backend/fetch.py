"""Download the model weights and lists the engine needs but the repo doesn't hold.

    .venv/Scripts/python -m backend.fetch

Every file is checked against its SHA-256 before it is used. The liveness weights are
already in the repo (converted to ONNX by models/liveness/convert.py).
"""
from __future__ import annotations

import hashlib
import sys
import tempfile
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FILES = [
    ("models/face_match/weights/face_detection_yunet_2023mar.onnx",
     "https://huggingface.co/opencv/face_detection_yunet/resolve/main/face_detection_yunet_2023mar.onnx",
     "8f2383e4dd3cfbb4553ea8718107fc0423210dc964f9f4280604804ed2552fa4"),
    ("models/face_match/weights/face_recognition_sface_2021dec.onnx",
     "https://huggingface.co/opencv/face_recognition_sface/resolve/main/face_recognition_sface_2021dec.onnx",
     "0ba9fbfa01b5270c96627c4ef784da859931e02f04419c829e83484087c34e79"),
    ("models/ocr/weights/devanagari_PP-OCRv4_rec_mobile.onnx",
     "https://www.modelscope.cn/models/RapidAI/RapidOCR/resolve/master/onnx/PP-OCRv4/rec/devanagari_PP-OCRv4_rec_mobile.onnx",
     "a62b6148303187907aa0b0d3a0125bdc62557d07966468cab9056949e36035e8"),
]
UN_LIST = "https://scsanctions.un.org/resources/xml/en/consolidated.xml"


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest()


def fetch_weights() -> None:
    for rel, url, digest in FILES:
        target = ROOT / rel
        if target.exists() and sha256(target) == digest:
            print(f"ok      {rel}")
            continue
        target.parent.mkdir(parents=True, exist_ok=True)
        tmp = target.with_suffix(".part")
        print(f"fetch   {rel}")
        urllib.request.urlretrieve(url, tmp)
        if sha256(tmp) != digest:
            tmp.unlink()
            sys.exit(f"SHA-256 mismatch for {rel}; not using it")
        tmp.replace(target)


def fetch_un_list() -> None:
    from backend.checks import aml
    with tempfile.TemporaryDirectory() as d:
        xml = Path(d) / "consolidated.xml"
        print("fetch   UN consolidated sanctions list")
        urllib.request.urlretrieve(UN_LIST, xml)
        n = aml.convert_un_xml(xml)
    print(f"ok      backend/data/un_sanctions.json ({n} entries)")


if __name__ == "__main__":
    fetch_weights()
    if "--no-lists" not in sys.argv:
        fetch_un_list()
