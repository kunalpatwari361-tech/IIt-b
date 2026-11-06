"""In-memory state: OTPs, sessions and applications.

A real deployment keeps applications in PostgreSQL (see the report's architecture).
For the hackathon one process holds them; decision records also go to the on-disk
ledger, which survives restarts.
"""
from __future__ import annotations

import hashlib
import hmac
import secrets
import threading
from dataclasses import dataclass, field
from datetime import datetime, timedelta, timezone
from typing import Any

from .sandbox import Persona


def now() -> datetime:
    return datetime.now(timezone.utc)


@dataclass
class Application:
    id: str
    phone: str
    device_id: str
    persona: Persona
    created_at: datetime = field(default_factory=now)
    signed_in_at: datetime = field(default_factory=now)
    consents: dict | None = None
    consent_log: list[dict] = field(default_factory=list)
    pan: str | None = None
    profile: dict | None = None          # eKYC + PAN + bureau + income, as the engine sees them
    bank: dict | None = None             # model 5 output on the Account Aggregator statement
    sources: dict = field(default_factory=dict)  # raw answers from each data source, for the record
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
    records: list[int] = field(default_factory=list)   # ledger sequence numbers

    def identity(self) -> dict:
        email = (self.profile or {}).get("email")
        return {"pan": self.pan, "device": self.device_id, "phone": self.phone, "email": email,
                "bank_account": (self.bank or {}).get("account_masked")}


def _hash(secret: str) -> str:
    return hashlib.sha256(secret.encode()).hexdigest()


class Store:
    def __init__(self):
        self.lock = threading.RLock()
        self.apps: dict[str, Application] = {}
        self.sessions: dict[str, tuple[str, str, datetime]] = {}   # token hash -> (app id, device, expiry)
        self.otps: dict[str, tuple[str, datetime, int]] = {}       # phone -> (code hash, expiry, attempts left)
        self._seq = 0

    # ---- OTP
    def put_otp(self, phone: str, code: str, ttl: int, attempts: int) -> None:
        with self.lock:
            self.otps[phone] = (_hash(code), now() + timedelta(seconds=ttl), attempts)

    def check_otp(self, phone: str, code: str) -> str:
        """'ok', 'wrong_otp', 'expired_otp' or 'too_many_attempts'."""
        with self.lock:
            entry = self.otps.get(phone)
            if entry is None:
                return "expired_otp"
            digest, expiry, left = entry
            if now() > expiry:
                del self.otps[phone]
                return "expired_otp"
            if left <= 0:
                return "too_many_attempts"
            if hmac.compare_digest(digest, _hash(code)):
                del self.otps[phone]
                return "ok"
            self.otps[phone] = (digest, expiry, left - 1)
            return "wrong_otp" if left - 1 > 0 else "too_many_attempts"

    # ---- sessions and applications
    def new_application(self, phone: str, device_id: str, persona: Persona, ttl_hours: int) -> tuple[Application, str]:
        with self.lock:
            self._seq += 1
            prefix = "HL" if persona.employment == "salaried" else "LAP"
            app_id = f"{prefix}-{now():%y%m}-{secrets.randbelow(90000) + 10000}"
            while app_id in self.apps:
                app_id = f"{prefix}-{now():%y%m}-{secrets.randbelow(90000) + 10000}"
            app = Application(id=app_id, phone=phone, device_id=device_id, persona=persona)
            self.apps[app_id] = app
            token = secrets.token_urlsafe(32)
            self.sessions[_hash(token)] = (app_id, device_id, now() + timedelta(hours=ttl_hours))
            return app, token

    def app_for(self, token: str, device_id: str | None) -> Application | None:
        with self.lock:
            entry = self.sessions.get(_hash(token))
            if entry is None:
                return None
            app_id, device, expiry = entry
            if now() > expiry or (device_id is not None and not hmac.compare_digest(device, device_id)):
                return None
            return self.apps.get(app_id)

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
