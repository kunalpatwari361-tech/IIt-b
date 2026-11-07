"""Engine settings, read once from environment variables. Nothing secret has a default."""
from __future__ import annotations

import os
from dataclasses import dataclass, field
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def _flag(name: str, default: bool) -> bool:
    v = os.environ.get(name)
    return default if v is None else v.strip().lower() in ("1", "true", "yes", "on")


@dataclass
class Settings:
    # Sandbox: fictional people and stand-in data sources (bureau, Account Aggregator, UIDAI,
    # payroll and land records), and the fixed demo OTP 123456. Turn off only with real adapters.
    sandbox: bool = field(default_factory=lambda: _flag("NIRNAY_SANDBOX", True))
    # Staff endpoints (file notes, records, replay) need this key in the X-Staff-Key header.
    # Unset: staff endpoints are switched off.
    staff_key: str | None = field(default_factory=lambda: os.environ.get("NIRNAY_STAFF_KEY") or None)
    # Where decision records (the hash-chained audit ledger) are written.
    var_dir: Path = field(default_factory=lambda: Path(os.environ.get("NIRNAY_VAR_DIR", ROOT / "backend" / "var")))
    # Browser origins allowed to call the API (the Flutter web build during development).
    cors_origins: list[str] = field(default_factory=lambda: [
        o.strip() for o in os.environ.get("NIRNAY_CORS_ORIGINS", "http://localhost:8765,http://127.0.0.1:8765").split(",")
        if o.strip()])
    # Keep uploaded document files in the database for officers (never Aadhaar images).
    store_files: bool = field(default_factory=lambda: _flag("NIRNAY_STORE_FILES", True))
    otp_ttl_seconds: int = 300
    otp_max_attempts: int = 5
    session_ttl_hours: int = 12
    max_upload_bytes: int = 10 * 1024 * 1024


settings = Settings()
