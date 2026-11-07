"""The engine's database: Supabase PostgreSQL in production, SQLite for local runs and tests.

Set DATABASE_URL to the Supabase connection string (Connect dialog; on an IPv4-only host,
the *session pooler* string). Without it, the engine uses backend/var/nirnay.db.

Every write is committed straight away, so each step an applicant takes is stored as it
happens and survives restarts.

Security on Supabase:
- All tables live in their own schema, `nirnay`, which the Data API does not serve.
- RLS is on for every table with no policies, and the `anon` / `authenticated` roles get
  no rights on the schema, so a leaked publishable key can't read applicants' data.
- The engine connects as the database owner from the server only; the app never sees
  the connection string.
- Connections use TLS (sslmode=require is added if missing).
"""
from __future__ import annotations

import os
from datetime import datetime, timezone
from pathlib import Path
from urllib.parse import parse_qsl, urlencode, urlsplit, urlunsplit

import sqlalchemy as sa
from sqlalchemy.dialects.postgresql import BYTEA, JSONB

SCHEMA = "nirnay"
TABLES = ("applications", "sessions", "otps", "consent_events", "documents", "decision_records")


def _url(raw: str | None, default_path: Path) -> str:
    if not raw:
        default_path.parent.mkdir(parents=True, exist_ok=True)
        return f"sqlite:///{default_path.as_posix()}"
    if raw.startswith("postgres://"):
        raw = "postgresql://" + raw[len("postgres://"):]
    if raw.startswith("postgresql://"):
        raw = "postgresql+psycopg://" + raw[len("postgresql://"):]
    if raw.startswith("postgresql+psycopg://"):
        parts = urlsplit(raw)
        q = dict(parse_qsl(parts.query))
        q.setdefault("sslmode", "require" if parts.hostname not in ("127.0.0.1", "localhost") else "prefer")
        raw = urlunsplit(parts._replace(query=urlencode(q)))
    return raw


def now() -> datetime:
    return datetime.now(timezone.utc)


class Database:
    def __init__(self, url: str | None = None, default_path: Path | None = None):
        default_path = default_path or Path(os.environ.get("NIRNAY_VAR_DIR", Path(__file__).parent / "var")) / "nirnay.db"
        self.url = _url(url if url is not None else os.environ.get("DATABASE_URL"), default_path)
        self.postgres = self.url.startswith("postgresql")
        kw = {"pool_pre_ping": True}
        if self.postgres:
            kw.update(pool_size=5, max_overflow=5)
        else:
            kw["connect_args"] = {"check_same_thread": False}
        self.engine = sa.create_engine(self.url, **kw)
        schema = SCHEMA if self.postgres else None
        md = sa.MetaData(schema=schema)
        JSON = sa.JSON().with_variant(JSONB(), "postgresql")
        BLOB = sa.LargeBinary().with_variant(BYTEA(), "postgresql")
        ts = sa.DateTime(timezone=True)
        self.applications = sa.Table(
            "applications", md,
            sa.Column("id", sa.String(32), primary_key=True),
            sa.Column("phone", sa.String(16), nullable=False, index=True),
            sa.Column("device_id", sa.String(128), nullable=False),
            sa.Column("mode", sa.String(8), nullable=False),           # "sandbox" or "real"
            sa.Column("name", sa.Text), sa.Column("pan_masked", sa.String(10)),
            sa.Column("status", sa.Text),
            sa.Column("in_principle_outcome", sa.String(8)), sa.Column("final_outcome", sa.String(8)),
            sa.Column("data", JSON, nullable=False),
            sa.Column("selfie_fingerprint", BLOB), sa.Column("id_fingerprint", BLOB),
            sa.Column("created_at", ts, nullable=False), sa.Column("updated_at", ts, nullable=False))
        self.sessions = sa.Table(
            "sessions", md,
            sa.Column("token_hash", sa.String(64), primary_key=True),
            sa.Column("application_id", sa.String(32), sa.ForeignKey(self.applications.c.id, ondelete="CASCADE"),
                      nullable=False, index=True),
            sa.Column("device_id", sa.String(128), nullable=False),
            sa.Column("expires_at", ts, nullable=False))
        self.otps = sa.Table(
            "otps", md,
            sa.Column("phone", sa.String(16), primary_key=True),
            sa.Column("code_hash", sa.String(64)),                     # sandbox only; SMS providers check codes themselves
            sa.Column("expires_at", ts, nullable=False),
            sa.Column("attempts_left", sa.Integer, nullable=False),
            sa.Column("sends_in_window", sa.Integer, nullable=False, server_default="0"),
            sa.Column("window_started", ts, nullable=False))
        self.consent_events = sa.Table(
            "consent_events", md,
            sa.Column("id", sa.Integer, primary_key=True, autoincrement=True),
            sa.Column("application_id", sa.String(32), sa.ForeignKey(self.applications.c.id, ondelete="CASCADE"),
                      nullable=False, index=True),
            sa.Column("at", ts, nullable=False), sa.Column("record", JSON, nullable=False))
        self.documents = sa.Table(
            "documents", md,
            sa.Column("id", sa.Integer, primary_key=True, autoincrement=True),
            sa.Column("application_id", sa.String(32), sa.ForeignKey(self.applications.c.id, ondelete="CASCADE"),
                      nullable=False, index=True),
            sa.Column("slot", sa.String(24), nullable=False),
            sa.Column("uploaded_at", ts, nullable=False),
            sa.Column("accepted", sa.Boolean, nullable=False),
            sa.Column("sha256", sa.String(64), nullable=False, index=True),
            sa.Column("content_type", sa.String(32)),
            sa.Column("result", JSON, nullable=False),                 # OCR summary, model 6, fields, checks
            sa.Column("file", BLOB))                                   # None for Aadhaar (never kept) or if storage is off
        self.decision_records = sa.Table(
            "decision_records", md,
            sa.Column("seq", sa.Integer, primary_key=True, autoincrement=False),
            sa.Column("application_id", sa.String(32), nullable=False, index=True),
            sa.Column("stage", sa.String(16), nullable=False),
            sa.Column("outcome", sa.String(8), nullable=False),
            sa.Column("at", ts, nullable=False),
            sa.Column("record", JSON, nullable=False),
            sa.Column("prev_hash", sa.String(64), nullable=False),
            sa.Column("hash", sa.String(64), nullable=False, unique=True))
        self.metadata = md
        self._create()

    def _create(self) -> None:
        with self.engine.begin() as c:
            if self.postgres:
                c.execute(sa.text(f'create schema if not exists "{SCHEMA}"'))
        self.metadata.create_all(self.engine)
        if self.postgres:
            with self.engine.begin() as c:
                for t in TABLES:
                    c.execute(sa.text(f'alter table "{SCHEMA}"."{t}" enable row level security'))
                # Supabase's API roles exist only on Supabase; elsewhere this does nothing.
                c.execute(sa.text(f"""
                    do $$ begin
                      if exists (select 1 from pg_roles where rolname = 'anon') then
                        revoke all on schema "{SCHEMA}" from anon, authenticated;
                        revoke all on all tables in schema "{SCHEMA}" from anon, authenticated;
                      end if;
                    end $$;"""))

    def begin(self):
        return self.engine.begin()

    def describe(self) -> dict:
        u = sa.engine.make_url(self.url)
        return {"backend": "postgresql" if self.postgres else "sqlite", "host": u.host,
                "schema": SCHEMA if self.postgres else None}
