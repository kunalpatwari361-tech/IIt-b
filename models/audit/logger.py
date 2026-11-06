
import hashlib
import json
from pathlib import Path
from datetime import datetime, timezone


AUDIT_DIR = Path(__file__).resolve().parent / "logs"
AUDIT_DIR.mkdir(parents=True, exist_ok=True)

AUDIT_FILE = AUDIT_DIR / "audit_log.jsonl"


def log_decision(result: dict, explanation: dict) -> dict:

    record = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "application_id": result.get("application_id"),
        "final_decision": result.get("final_decision"),
        "final_status": result.get("final_status"),
        "credit_score": result.get("credit_assessment", {}).get("score"),
        "credit_grade": result.get("credit_assessment", {}).get("grade"),
        "fraud_risk_score": result.get("fraud_assessment", {}).get(
            "risk_score"
        ),
        "fraud_risk_level": result.get("fraud_assessment", {}).get(
            "risk_level"
        ),
        "model_version": result.get("credit_assessment", {}).get(
            "model_version"
        ),
        "decision_reasons": result.get("decision_reasons", {}),
        "explanation_type": explanation.get("explanation_type")
    }

    previous = get_audit_logs()
    record["prev_hash"] = previous[-1].get("hash", "") if previous else ""
    record["hash"] = _digest(record)

    with open(AUDIT_FILE, "a", encoding="utf-8") as file:
        file.write(json.dumps(record) + "\n")

    return {
        "audit_status": "recorded",
        "application_id": record["application_id"],
        "audit_file": str(AUDIT_FILE)
    }


def get_audit_logs():

    if not AUDIT_FILE.exists():
        return []

    records = []

    with open(AUDIT_FILE, "r", encoding="utf-8") as file:
        for line in file:
            if line.strip():
                records.append(json.loads(line))

    return records


def _digest(record: dict) -> str:
    body = {k: v for k, v in record.items() if k != "hash"}
    return hashlib.sha256(json.dumps(body, sort_keys=True).encode()).hexdigest()


def verify_audit_chain() -> dict:
    """Recompute every hash. Records written before the chain existed are skipped."""
    prev, checked = "", 0
    for i, rec in enumerate(get_audit_logs()):
        if "hash" not in rec:
            continue
        if rec.get("prev_hash") != prev or rec["hash"] != _digest(rec):
            return {"intact": False, "first_bad_record": i, "checked": checked}
        prev, checked = rec["hash"], checked + 1
    return {"intact": True, "first_bad_record": None, "checked": checked}
