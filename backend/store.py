"""Applications, sessions and OTP attempts, kept in the database (backend/db.py).

Each change is written straight through to the database, so the data is stored as the
applicant moves through the app and survives restarts. The process also keeps the
applications in memory for the cross-application checks (shared devices, reused files).
That is fine for one engine process; run a single instance.
"""
from __future__ import annotations

import hashlib
import hmac
import json
import secrets
import threading
from dataclasses import dataclass, field
from datetime import datetime, timedelta, timezone
from typing import Any

import numpy as np
import sqlalchemy as sa

from .db import Database
from .sandbox import PERSONAS, Persona


def now() -> datetime:
    return datetime.now(timezone.utc)


def _hash(secret: str) -> str:
    return hashlib.sha256(secret.encode()).hexdigest()


def plain(obj):
    """Make model outputs JSON-safe (numpy numbers, sets, dates)."""
    if isinstance(obj, dict):
        return {str(k): plain(v) for k, v in obj.items()}
    if isinstance(obj, (list, tuple, set)):
        return [plain(v) for v in obj]
    if isinstance(obj, np.generic):
        return obj.item()
    if isinstance(obj, np.ndarray):
        return obj.tolist()
    if isinstance(obj, datetime):
        return obj.isoformat()
    return obj


def _fp(arr) -> bytes | None:
    return None if arr is None else np.asarray(arr, dtype=np.float32).tobytes()


def _unfp(blob) -> Any:
    return None if blob is None else np.frombuffer(bytes(blob), dtype=np.float32).reshape(1, -1).copy()


@dataclass
class Application:
    id: str
    phone: str
    device_id: str
    persona: Persona | None              # sandbox only; None for real applicants
    mode: str = "sandbox"                # "sandbox" or "real"
    created_at: datetime = field(default_factory=now)
    signed_in_at: datetime = field(default_factory=now)
    consents: dict | None = None
    consent_log: list[dict] = field(default_factory=list)
    pan: str | None = None
    declared: dict | None = None         # what a real applicant typed in (self-declared)
    profile: dict | None = None
    bank: dict | None = None             # model 5 output on the bank statement
    sources: dict = field(default_factory=dict)
    selfie: dict | None = None
    selfie_fingerprint: Any = None
    id_fingerprint: Any = None
    id_photo_slot: str | None = None
    face_match: dict | None = None
    documents: dict[str, dict] = field(default_factory=dict)
    photo_hashes: set[str] = field(default_factory=set)    # pHash of property photos
    file_digests: set[str] = field(default_factory=set)    # SHA-256 of uploaded documents
    in_principle: dict | None = None
    final: dict | None = None
    records: list[int] = field(default_factory=list)   # decision record numbers

    _FIELDS = ("consents", "consent_log", "pan", "declared", "profile", "bank", "sources", "selfie", "id_photo_slot",
               "face_match", "documents", "in_principle", "final", "records")

    def identity(self) -> dict:
        email = (self.profile or {}).get("email")
        return {"pan": self.pan, "device": self.device_id, "phone": self.phone, "email": email,
                "bank_account": (self.bank or {}).get("account_masked")}

    def to_row(self) -> dict:
        data = {k: plain(getattr(self, k)) for k in self._FIELDS}
        data.update(persona=self.persona.key if self.persona else None, signed_in_at=self.signed_in_at.isoformat(),
                    photo_hashes=sorted(self.photo_hashes), file_digests=sorted(self.file_digests))
        p = self.profile or {}
        status = (self.final or self.in_principle or {}).get("offer", {}).get("outcome")
        return {"id": self.id, "phone": self.phone, "device_id": self.device_id, "mode": self.mode,
                "name": p.get("name"), "pan_masked": p.get("pan_masked"), "status": status,
                "in_principle_outcome": (self.in_principle or {}).get("offer", {}).get("outcome"),
                "final_outcome": (self.final or {}).get("offer", {}).get("outcome"),
                "data": data, "selfie_fingerprint": _fp(self.selfie_fingerprint), "id_fingerprint": _fp(self.id_fingerprint),
                "created_at": self.created_at, "updated_at": now()}

    @classmethod
    def from_row(cls, row) -> "Application":
        d = dict(row.data)
        app = cls(id=row.id, phone=row.phone, device_id=row.device_id, mode=row.mode,
                  persona=PERSONAS.get(d.get("persona")) if d.get("persona") else None,
                  created_at=row.created_at if row.created_at.tzinfo else row.created_at.replace(tzinfo=timezone.utc))
        for k in cls._FIELDS:
            if k in d and d[k] is not None:
                setattr(app, k, d[k])
        if d.get("signed_in_at"):
            app.signed_in_at = datetime.fromisoformat(d["signed_in_at"])
        app.photo_hashes, app.file_digests = set(d.get("photo_hashes", [])), set(d.get("file_digests", []))
        app.selfie_fingerprint, app.id_fingerprint = _unfp(row.selfie_fingerprint), _unfp(row.id_fingerprint)
        return app


class Store:
    def __init__(self, db: Database):
        self.db = db
        self.lock = threading.RLock()
        self.apps: dict[str, Application] = {}
        with db.begin() as c:
            for row in c.execute(sa.select(db.applications)):
                self.apps[row.id] = Application.from_row(row)

    # ---- applications
    def save(self, app: Application) -> None:
        """Write the application's current state to the database."""
        row = self.db_row(app)
        t = self.db.applications
        with self.lock, self.db.begin() as c:
            if c.execute(sa.update(t).where(t.c.id == app.id).values(**{k: v for k, v in row.items() if k != "id"})).rowcount == 0:
                c.execute(sa.insert(t).values(**row))

    @staticmethod
    def db_row(app: Application) -> dict:
        row = app.to_row()
        json.dumps(row["data"])          # fail here, loudly, rather than store something half-written
        return row

    def new_application(self, phone: str, device_id: str, persona: Persona | None, mode: str,
                        ttl_hours: int) -> tuple[Application, str]:
        with self.lock:
            salaried = persona is None or persona.employment == "salaried"
            prefix = "HL" if salaried else "LAP"
            app_id = f"{prefix}-{now():%y%m}-{secrets.randbelow(90000) + 10000}"
            while app_id in self.apps:
                app_id = f"{prefix}-{now():%y%m}-{secrets.randbelow(90000) + 10000}"
            app = Application(id=app_id, phone=phone, device_id=device_id, persona=persona, mode=mode)
            token = secrets.token_urlsafe(32)
            self.save(app)
            with self.db.begin() as c:
                c.execute(sa.insert(self.db.sessions).values(token_hash=_hash(token), application_id=app_id,
                                                             device_id=device_id, expires_at=now() + timedelta(hours=ttl_hours)))
            self.apps[app_id] = app
            return app, token

    def app_for(self, token: str, device_id: str | None) -> Application | None:
        s = self.db.sessions
        with self.db.begin() as c:
            row = c.execute(sa.select(s).where(s.c.token_hash == _hash(token))).first()
        if row is None:
            return None
        expires = row.expires_at if row.expires_at.tzinfo else row.expires_at.replace(tzinfo=timezone.utc)
        if now() > expires or (device_id is not None and not hmac.compare_digest(row.device_id, device_id)):
            return None
        return self.apps.get(row.application_id)

    def log_consent(self, app: Application, entry: dict) -> None:
        with self.db.begin() as c:
            c.execute(sa.insert(self.db.consent_events).values(application_id=app.id, at=now(), record=plain(entry)))

    def save_document(self, app: Application, rec: dict, digest: str, data: bytes | None, content_type: str) -> None:
        with self.db.begin() as c:
            c.execute(sa.insert(self.db.documents).values(
                application_id=app.id, slot=rec["slot"], uploaded_at=now(), accepted=rec["accepted"], sha256=digest,
                content_type=content_type, result=plain(rec), file=data))

    # ---- OTP: sending limits and wrong-code counting (SMS providers check the code itself)
    def otp_start(self, phone: str, code_hash: str | None, ttl: int, attempts: int, max_sends: int,
                  window_minutes: int) -> bool:
        """Record a new code. False if this number already had `max_sends` codes in the window."""
        t = self.db.otps
        with self.lock, self.db.begin() as c:
            row = c.execute(sa.select(t).where(t.c.phone == phone)).first()
            start, sends = now(), 1
            if row is not None:
                started = row.window_started if row.window_started.tzinfo else row.window_started.replace(tzinfo=timezone.utc)
                if now() - started < timedelta(minutes=window_minutes):
                    if row.sends_in_window >= max_sends:
                        return False
                    start, sends = started, row.sends_in_window + 1
                c.execute(sa.delete(t).where(t.c.phone == phone))
            c.execute(sa.insert(t).values(phone=phone, code_hash=code_hash, expires_at=now() + timedelta(seconds=ttl),
                                          attempts_left=attempts, sends_in_window=sends, window_started=start))
            return True

    def otp_attempt(self, phone: str) -> tuple[str, str | None]:
        """Use up one try. Returns (state, code hash): state is ok, expired_otp or too_many_attempts."""
        t = self.db.otps
        with self.lock, self.db.begin() as c:
            row = c.execute(sa.select(t).where(t.c.phone == phone)).first()
            if row is None:
                return "expired_otp", None
            expires = row.expires_at if row.expires_at.tzinfo else row.expires_at.replace(tzinfo=timezone.utc)
            if now() > expires:
                return "expired_otp", None
            if row.attempts_left <= 0:
                return "too_many_attempts", None
            c.execute(sa.update(t).where(t.c.phone == phone).values(attempts_left=row.attempts_left - 1))
            return "ok", row.code_hash

    def otp_refund(self, phone: str, *, send: bool = False, attempt: bool = False) -> None:
        """Give back a send or a try that the SMS service never handled (its network call failed)."""
        t = self.db.otps
        with self.lock, self.db.begin() as c:
            row = c.execute(sa.select(t).where(t.c.phone == phone)).first()
            if row is None:
                return
            values = {}
            if send:
                values["sends_in_window"] = max(0, row.sends_in_window - 1)
            if attempt:
                values["attempts_left"] = row.attempts_left + 1
            if values:
                c.execute(sa.update(t).where(t.c.phone == phone).values(**values))

    def otp_left(self, phone: str) -> int:
        t = self.db.otps
        with self.db.begin() as c:
            row = c.execute(sa.select(t.c.attempts_left).where(t.c.phone == phone)).first()
        return row.attempts_left if row else 0

    def otp_clear(self, phone: str) -> None:
        """A used code can't be used again; the send-limit window is kept."""
        t = self.db.otps
        with self.lock, self.db.begin() as c:
            c.execute(sa.update(t).where(t.c.phone == phone).values(attempts_left=0, code_hash=None))

    # ---- cross-application checks
    def identities(self) -> dict[str, dict]:
        with self.lock:
            return {a.id: a.identity() for a in self.apps.values()}

    def photo_hashes(self) -> dict[str, set[str]]:
        with self.lock:
            return {a.id: set(a.photo_hashes) for a in self.apps.values()}

    def file_digests(self) -> dict[str, set[str]]:
        with self.lock:
            return {a.id: set(a.file_digests) for a in self.apps.values()}

    def emails_on_device(self, device_id: str) -> int:
        with self.lock:
            return len({(a.profile or {}).get("email") for a in self.apps.values()
                        if a.device_id == device_id and (a.profile or {}).get("email")})

    def emails_for_dob(self, dob: str) -> int:
        with self.lock:
            return len({(a.profile or {}).get("email") for a in self.apps.values()
                        if (a.profile or {}).get("dob") == dob and (a.profile or {}).get("email")})
