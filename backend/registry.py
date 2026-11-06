"""Which of Nirnay's 12 models (and the rule-based checks) are ready, and their versions."""
from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

MODELS = [
    (1, "credit_scorecard", "Credit scorecard (live)", "trained", ["models/credit_scorecard/artifacts/scorecard.json"]),
    (2, "credit_challenger", "Credit challenger (shadow)", "trained", ["models/credit_challenger/artifacts"]),
    (3, "fraud_classifier", "Fraud classifier", "trained", ["models/fraud_classifier/artifacts/model.txt"]),
    (4, "anomaly_detector", "Anomaly detector", "trained", ["models/anomaly_detector/artifacts"]),
    (5, "transaction_tagger", "Bank transaction tagger", "trained", ["models/transaction_tagger/artifacts"]),
    (6, "document_classifier", "Document classifier", "trained", ["models/document_classifier/artifacts/model.joblib"]),
    (7, "property_avm", "Property valuation (AVM)", "trained", ["models/property_avm/artifacts/avm.json"]),
    (8, "ocr", "OCR (PP-OCRv4, English + Devanagari)", "ready-made",
     ["models/ocr/weights/devanagari_PP-OCRv4_rec_mobile.onnx"]),
    (9, "face_match", "Face match (YuNet + SFace)", "ready-made",
     ["models/face_match/weights/face_detection_yunet_2023mar.onnx", "models/face_match/weights/face_recognition_sface_2021dec.onnx"]),
    (10, "liveness", "Liveness (MiniFASNet)", "ready-made",
     ["models/liveness/weights/2.7_80x80_MiniFASNetV2.onnx", "models/liveness/weights/4_0_0_80x80_MiniFASNetV1SE.onnx"]),
    (11, "llm", "LLM: deed reader, file notes, letters, assistant", "ready-made", []),
    (12, "translation", "Translation (22 Indian languages)", "ready-made", []),
]

CHECKS = [
    ("aml_screening", "AML name matching (rapidfuzz + jellyfish) against the UN list and a PEP list", ["backend/data/un_sanctions.json"]),
    ("ring_detection", "Fraud rings: shared devices, phones, emails, bank accounts (networkx)", []),
    ("photo_reuse", "Reused photos (imagehash pHash)", []),
    ("tamper", "PDF and photo tamper checks (pypdf, Pillow)", []),
    ("policy_rules", "Eligibility and policy rules (versioned table)", []),
    ("compliance_gate", "Regulation as code (8 coded rules with sources)", []),
]


def status() -> dict:
    from models.llm import llm
    from models.translation import translate
    out = []
    for n, key, name, kind, files in MODELS:
        missing = [f for f in files if not (ROOT / f).exists()]
        entry = {"n": n, "key": key, "name": name, "kind": kind, "ready": not missing, "missing": missing}
        if key == "llm":
            entry.update(llm.status())
            entry["ready"] = True
            entry["note"] = ("Claude Sonnet 5.5 via the Anthropic API" if entry["engine"] == "claude"
                             else "no API credentials: offline rules stand in")
        if key == "translation":
            engines = translate.available()
            entry.update(engines=engines, ready=bool(engines))
        out.append(entry)
    checks = [{"key": k, "name": name, "ready": all((ROOT / f).exists() for f in files)} for k, name, files in CHECKS]
    return {"models": out, "checks": checks}
