"""Decision records: an append-only, hash-chained ledger (JSON lines on disk).

Each record holds what the decision was made from (the evidence), the rule and model
versions, every gate's result and the outcome. Its hash covers its content and the
previous record's hash, so editing or deleting any past record breaks the chain, and
`verify()` finds where. `backend.pipeline.replay` re-runs a record's decision.

In production the records would also be written to WORM storage; here the file in
backend/var/ is enough. The sandbox data in records is fictional.
"""
from __future__ import annotations

import hashlib
import json
import threading
from pathlib import Path

GENESIS = "0" * 64


def canonical(obj) -> str:
    return json.dumps(obj, sort_keys=True, ensure_ascii=False, separators=(",", ":"), default=str)


def digest(body: dict, prev: str) -> str:
    return hashlib.sha256((prev + canonical(body)).encode("utf-8")).hexdigest()


class Ledger:
    def __init__(self, path: Path):
        self.path = Path(path)
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self.lock = threading.Lock()
        self._last_hash, self._seq = GENESIS, 0
        for rec in self._read():
            self._last_hash, self._seq = rec["hash"], rec["seq"]

    def _read(self):
        if not self.path.exists():
            return
        with self.path.open(encoding="utf-8") as f:
            for line in f:
                if line.strip():
                    yield json.loads(line)

    def append(self, body: dict) -> dict:
        with self.lock:
            seq = self._seq + 1
            body = {"seq": seq, **body}
            rec = {**body, "prev_hash": self._last_hash, "hash": digest(body, self._last_hash)}
            with self.path.open("a", encoding="utf-8") as f:
                f.write(canonical(rec) + "\n")
            self._last_hash, self._seq = rec["hash"], seq
            return rec

    def get(self, seq: int) -> dict | None:
        return next((r for r in self._read() if r["seq"] == seq), None)

    def for_application(self, app_id: str) -> list[dict]:
        return [r for r in self._read() if r.get("application_id") == app_id]

    def verify(self) -> dict:
        prev, count = GENESIS, 0
        for rec in self._read():
            body = {k: v for k, v in rec.items() if k not in ("prev_hash", "hash")}
            if rec["prev_hash"] != prev or digest(body, prev) != rec["hash"]:
                return {"ok": False, "records": count, "broken_at": rec["seq"]}
            prev, count = rec["hash"], count + 1
        return {"ok": True, "records": count, "last_hash": prev}
