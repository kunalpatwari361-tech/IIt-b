"""The database layer on real PostgreSQL (as on Supabase), using an embedded server (pgserver)."""
import pytest
import sqlalchemy as sa

from backend.db import Database, _url
from backend.ledger import DbLedger
from backend.store import Store

pgserver = pytest.importorskip("pgserver")


@pytest.fixture(scope="module")
def pg(tmp_path_factory):
    srv = pgserver.get_server(str(tmp_path_factory.mktemp("pg")), cleanup_mode="stop")
    yield Database(srv.get_uri())


def test_supabase_strings_become_tls_psycopg_urls():
    u = _url("postgres://postgres.abc:p%40ss@aws-1-ap-south-1.pooler.supabase.com:5432/postgres", None)
    assert u.startswith("postgresql+psycopg://") and "sslmode=require" in u
    assert "sslmode=verify-full" in _url("postgresql://u:p@db.x.supabase.co:5432/postgres?sslmode=verify-full", None)


def test_tables_live_in_a_private_schema_with_rls(pg):
    with pg.begin() as c:
        rows = c.execute(sa.text("select c.relname, c.relrowsecurity from pg_class c join pg_namespace n on n.oid = c.relnamespace "
                                 "where n.nspname = 'nirnay' and c.relkind = 'r'")).all()
    assert {r.relname for r in rows} == {"applications", "sessions", "otps", "consent_events", "documents", "decision_records"}
    assert all(r.relrowsecurity for r in rows)
    with pg.begin() as c:
        public = c.execute(sa.text("select count(*) from pg_tables where schemaname = 'public'")).scalar()
    assert public == 0                                                    # nothing in the schema the Data API serves


def test_applications_round_trip_and_the_ledger_detects_edits(pg):
    s = Store(pg)
    a, token = s.new_application("9000055555", "dev-pg", None, "real", 1)
    a.profile = {"name": "Test Person", "pan_masked": "ABXXX1234X", "bureau": {"score": 750}}
    a.documents["pan"] = {"slot": "pan", "accepted": True, "scores": [0.5, 1.0]}
    s.save(a)
    assert s.app_for(token, "dev-pg").id == a.id and s.app_for(token, "other-device") is None
    b = Store(pg).apps[a.id]
    assert b.profile["name"] == "Test Person" and b.documents["pan"]["scores"] == [0.5, 1.0]
    led = DbLedger(pg)
    for i in range(3):
        led.append({"application_id": a.id, "stage": "in_principle", "outcome": "approve", "amount": 4500000.0 + i,
                    "probability": 0.000452 * (i + 1)})
    assert led.verify()["ok"] and led.verify()["records"] == 3
    with pg.begin() as c:
        c.execute(sa.text("update nirnay.decision_records set record = jsonb_set(record, '{outcome}', '\"reject\"') where seq = 2"))
    assert led.verify() == {"ok": False, "records": 1, "broken_at": 2}
