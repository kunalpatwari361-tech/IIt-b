"""Real mode (NIRNAY_SANDBOX=0): SMS codes, self-declared details, documents as proof, all stored."""
import json

import httpx
import pytest
import sqlalchemy as sa

from backend import otp as otp_module
from backend.config import settings
from backend.ledger import DbLedger
from backend.store import Store
from backend.tests import realdocs
from backend.tests.conftest import ALL_CONSENTS, STAFF, PUNE, selfie_image, site_photo

CODE = "424242"
LOAN = {"product": "homeLoan", "amount": 3000000, "years": 20, "propertyValue": 5000000}   # 60% LTV


class FakeSms:
    """Stands in for Twilio Verify / MSG91: the provider makes and checks the code."""
    name, checks_itself = "fake", True

    def __init__(self):
        self.sent = []

    def send(self, phone):
        self.sent.append(phone)

    def check(self, phone, code):
        return code == CODE


@pytest.fixture
def real(monkeypatch):
    sms = FakeSms()
    monkeypatch.setattr(settings, "sandbox", False)
    monkeypatch.setattr(otp_module, "provider", lambda sandbox: sms)
    return sms


def sign_in(client, phone, device):
    assert client.post("/v1/otp/send", json={"phone": phone}).status_code == 204
    s = client.post("/v1/otp/verify", json={"phone": phone, "otp": CODE, "deviceId": device}).json()
    h = {"Authorization": f"Bearer {s['token']}", "X-Device-Id": device}
    return s["applicationId"], h, f"/v1/applications/{s['applicationId']}"


def upload(client, base, h, slot, data):
    return client.post(base + "/documents", headers=h, data={"slot": slot},
                       files={"file": (f"{slot}.jpg", data, "image/jpeg")}).json()


def final(client, base, h, photo_seed):
    meta = [{"label": "front", "takenAt": "2026-11-05T10:00:00Z", "latitude": 18.56, "longitude": 73.81}]
    return client.post(base + "/final", headers=h,
                       data={"request": json.dumps(LOAN), "property": json.dumps({**PUNE, "declaredPrice": 5000000}),
                             "photos_meta": json.dumps(meta)},
                       files=[("photos", ("front.jpg", site_photo(photo_seed), "image/jpeg"))]).json()


def internal(client, app_id, stage):
    recs = [r for r in client.get(f"/v1/staff/applications/{app_id}/records", headers=STAFF).json() if r["stage"] == stage]
    rec = recs[-1]
    return rec, {r["code"] for g in rec["gates"] for r in g["reasons"]}


def test_sms_sign_in_limits_and_codes(client, real):
    assert client.post("/v1/otp/send", json={"phone": "9000022222"}).status_code == 204
    assert real.sent == ["9000022222"]
    bad = client.post("/v1/otp/verify", json={"phone": "9000022222", "otp": "000000", "deviceId": "dev-r1"})
    assert bad.status_code == 401 and bad.json()["error"] == "wrong_otp"
    ok = client.post("/v1/otp/verify", json={"phone": "9000022222", "otp": CODE, "deviceId": "dev-r1"})
    assert ok.status_code == 200
    again = client.post("/v1/otp/verify", json={"phone": "9000022222", "otp": CODE, "deviceId": "dev-r1"})
    assert again.status_code == 401                                   # a used code can't sign in twice
    for _ in range(2):
        client.post("/v1/otp/send", json={"phone": "9000022222"})
    assert client.post("/v1/otp/send", json={"phone": "9000022222"}).json()["error"] == "too_many_requests"


def twilio(monkeypatch, handler):
    """The real TwilioVerify class, talking to `handler` instead of the internet."""
    for k, v in {"TWILIO_ACCOUNT_SID": "AC" + "0" * 32, "TWILIO_AUTH_TOKEN": "t" * 32,
                 "TWILIO_VERIFY_SERVICE_SID": "VA" + "0" * 32}.items():
        monkeypatch.setenv(k, v)
    monkeypatch.setattr(otp_module, "RETRY_PAUSE_SECONDS", 0)
    sms = otp_module.TwilioVerify(httpx.Client(transport=httpx.MockTransport(handler)))
    monkeypatch.setattr(settings, "sandbox", False)
    monkeypatch.setattr(otp_module, "provider", lambda sandbox: sms)
    return sms


def twilio_ok(request):
    if request.url.path.endswith("/VerificationCheck"):
        return httpx.Response(200, json={"status": "approved"})
    return httpx.Response(201, json={"status": "pending"})


def test_a_dropped_connection_to_twilio_is_tried_again(client, monkeypatch):
    calls = []

    def handler(request):
        calls.append(request.url.path)
        if len(calls) < 3:
            raise httpx.ConnectTimeout("timed out", request=request)
        return twilio_ok(request)
    twilio(monkeypatch, handler)
    assert client.post("/v1/otp/send", json={"phone": "9000077777"}).status_code == 204
    assert len(calls) == 3                       # two connections that never opened, then one text
    ok = client.post("/v1/otp/verify", json={"phone": "9000077777", "otp": CODE, "deviceId": "dev-t1"})
    assert ok.status_code == 200


def test_twilio_out_of_reach_is_a_clean_error_that_uses_up_nothing(client, monkeypatch, capsys):
    down = {"on": True}

    def handler(request):
        if down["on"]:
            raise httpx.ConnectTimeout("timed out", request=request)
        return twilio_ok(request)
    twilio(monkeypatch, handler)
    for _ in range(4):                           # past the 3-sends limit: failed sends don't count
        r = client.post("/v1/otp/send", json={"phone": "9000088888"})
        assert r.status_code == 502 and r.json()["error"] == "sms_failed"
    assert "unreachable for +91 90XXXXXX88" in capsys.readouterr().out
    down["on"] = False
    assert client.post("/v1/otp/send", json={"phone": "9000088888"}).status_code == 204
    down["on"] = True
    for _ in range(6):                           # past the 5-tries limit: unchecked codes don't count
        r = client.post("/v1/otp/verify", json={"phone": "9000088888", "otp": CODE, "deviceId": "dev-t2"})
        assert r.status_code == 502 and r.json()["error"] == "sms_failed"
    down["on"] = False
    ok = client.post("/v1/otp/verify", json={"phone": "9000088888", "otp": CODE, "deviceId": "dev-t2"})
    assert ok.status_code == 200


def test_a_twilio_reply_that_never_came_is_not_sent_again(client, monkeypatch):
    calls = []

    def handler(request):
        calls.append(request.url.path)
        raise httpx.ReadTimeout("timed out", request=request)
    twilio(monkeypatch, handler)
    assert client.post("/v1/otp/send", json={"phone": "9000099999"}).json()["error"] == "sms_failed"
    assert len(calls) == 1                       # Twilio may already have texted: never a second text


def test_fixed_demo_code_is_refused_in_real_mode(monkeypatch):
    monkeypatch.delenv("NIRNAY_SMS_PROVIDER", raising=False)
    with pytest.raises(otp_module.OtpError) as e:
        otp_module.provider(False)
    assert e.value.code == "sms_not_configured"
    monkeypatch.setenv("NIRNAY_SMS_PROVIDER", "sandbox")
    with pytest.raises(otp_module.OtpError):
        otp_module.provider(False)
    monkeypatch.setenv("NIRNAY_SMS_PROVIDER", "twilio")              # chosen, but no keys set
    with pytest.raises(otp_module.OtpError):
        otp_module.provider(False)


def test_real_mode_needs_the_applicants_own_details(client, real):
    app_id, h, base = sign_in(client, "9000033333", "dev-r2")
    client.put(base + "/consents", headers=h, json=ALL_CONSENTS)
    assert client.post(base + "/profile", headers=h, json={"pan": realdocs.PAN}).json()["error"] == "details_required"
    young = {**realdocs.DECLARED, "dob": "2012-01-01"}
    assert client.post(base + "/profile", headers=h, json={"pan": realdocs.PAN, "declared": young}).json()["error"] == "bad_dob"
    assert client.get(base + "/samples/pan", headers=h).status_code == 404          # no sandbox samples for real people
    p = client.post(base + "/profile", headers=h, json={"pan": realdocs.PAN, "declared": realdocs.DECLARED}).json()
    assert p["name"] == "Kavya Rao" and p["selfDeclared"] and p["bureauScore"] == 772
    assert p["requiredDocuments"] == ["pan", "aadhaar", "salarySlip", "form16", "bankStatement"]


def test_without_a_face_on_the_id_card_the_face_match_refers(client, real):
    face = selfie_image()
    if face is None:
        pytest.skip("sample face photo not on this machine")
    app_id, h, base = sign_in(client, "9000044444", "dev-r3")
    client.put(base + "/consents", headers=h, json=ALL_CONSENTS)
    client.post(base + "/profile", headers=h, json={"pan": realdocs.PAN, "declared": realdocs.DECLARED})
    client.post(base + "/selfie", headers=h, files={"file": ("s.jpg", face, "image/jpeg")})
    for slot in ("pan", "aadhaar", "salarySlip", "form16"):
        upload(client, base, h, slot, realdocs.document(slot, seed=app_id))
    upload(client, base, h, "bankStatement", realdocs.statement(seed=app_id))
    d = client.post(base + "/in-principle", headers=h, json=LOAN).json()
    rec, codes = internal(client, app_id, "in_principle")
    assert d["outcome"] == "refer" and "R-KYC-01" in codes             # real mode never skips the face match


@pytest.fixture
def kavya(client, real):
    face = selfie_image()
    if face is None:
        pytest.skip("sample face photo not on this machine")
    app_id, h, base = sign_in(client, "9000011111", "dev-kavya")
    client.put(base + "/consents", headers=h, json=ALL_CONSENTS)
    client.post(base + "/profile", headers=h, json={"pan": realdocs.PAN, "declared": realdocs.DECLARED})
    selfie = client.post(base + "/selfie", headers=h, files={"file": ("s.jpg", face, "image/jpeg")}).json()
    docs = {"pan": upload(client, base, h, "pan", realdocs.pan_with_face(face, seed=app_id))}
    for slot in ("aadhaar", "salarySlip", "form16"):
        docs[slot] = upload(client, base, h, slot, realdocs.document(slot, seed=app_id))
    docs["bankStatement"] = upload(client, base, h, "bankStatement", realdocs.statement(seed=app_id))
    ip = client.post(base + "/in-principle", headers=h, json=LOAN).json()
    return {"id": app_id, "h": h, "base": base, "selfie": selfie, "docs": docs, "in_principle": ip}


def test_real_applicant_is_proven_by_documents(client, kavya):
    assert all(d["accepted"] for d in kavya["docs"].values()), kavya["docs"]
    ip = kavya["in_principle"]
    rec, codes = internal(client, kavya["id"], "in_principle")
    why = [(g["gate"], [r["code"] for r in g["reasons"]], g["notes"]) for g in rec["gates"] if g["outcome"] != "pass"]
    assert ip["outcome"] == "approve" and ip["amount"] == 3000000, why
    ev = rec["evidence"]
    assert ev["mode"] == "real" and "credit_score" in ev["self_declared"]
    assert ev["identity"]["face_match"]["match"]                          # selfie vs the PAN card's photo
    assert ev["income"]["income_source"] == "bank salary credits (model 5)" and ev["income"]["income_used"] == 95000
    assert ev["aml"]["lists"]["pep_list"] is None                         # the fictional PEP list is sandbox-only
    policy = next(g for g in rec["gates"] if g["gate"] == "policy")
    assert any("self-declared" in n for n in policy["notes"])


def test_real_title_needs_the_sale_deed(client, kavya):
    first = final(client, kavya["base"], kavya["h"], "kavya-1")
    _, codes = internal(client, kavya["id"], "final")
    assert first["outcome"] == "refer" and "R-PRP-01" in codes            # no land records, no deed: can't clear title
    deed = upload(client, kavya["base"], kavya["h"], "saleDeed", realdocs.document("saleDeed", seed=kavya["id"]))
    assert deed["accepted"]
    second = final(client, kavya["base"], kavya["h"], "kavya-2")
    rec, codes = internal(client, kavya["id"], "final")
    assert second["outcome"] == "approve", (second, codes)
    prop = next(g for g in rec["gates"] if g["gate"] == "property")
    assert any("sale deed only" in n for n in prop["notes"])


def test_everything_is_in_the_database_and_survives_a_restart(client, kavya):
    from backend.app import db
    again = Store(db)                                                     # what a restarted engine loads
    a = again.apps[kavya["id"]]
    assert a.mode == "real" and a.profile["name"] == "Kavya Rao" and a.in_principle["offer"]["outcome"] == "approve"
    assert a.selfie_fingerprint is not None and a.face_match["match"]
    with db.begin() as c:
        docs = {r.slot: r for r in c.execute(sa.select(db.documents).where(db.documents.c.application_id == kavya["id"]))}
        consents = c.execute(sa.select(sa.func.count()).select_from(db.consent_events)
                             .where(db.consent_events.c.application_id == kavya["id"])).scalar()
        row = c.execute(sa.select(db.applications).where(db.applications.c.id == kavya["id"])).first()
    assert docs["aadhaar"].file is None and docs["pan"].file is not None   # Aadhaar copies are never kept
    assert docs["aadhaar"].result["fields"]["aadhaar"].startswith("XXXX XXXX")
    assert consents >= 1 and row.in_principle_outcome == "approve" and row.name == "Kavya Rao"
    assert DbLedger(db).verify()["ok"]
    listing = client.get("/v1/staff/applications", headers=STAFF).json()
    mine = next(x for x in listing if x["applicationId"] == kavya["id"])
    assert mine["mode"] == "real" and mine["phone"] == "90XXXXXX11"


def test_console_codes_need_the_second_switch_and_work(client, monkeypatch, capsys):
    import re
    monkeypatch.setattr(settings, "sandbox", False)
    monkeypatch.setenv("NIRNAY_SMS_PROVIDER", "console")
    monkeypatch.delenv("NIRNAY_ALLOW_CONSOLE_OTP", raising=False)
    assert client.post("/v1/otp/send", json={"phone": "9000066666"}).json()["error"] == "sms_not_configured"
    monkeypatch.setenv("NIRNAY_ALLOW_CONSOLE_OTP", "1")
    sent = client.post("/v1/otp/send", json={"phone": "9000066666"})
    assert sent.status_code == 204
    assert sent.headers["X-Otp-Delivery"] == "console"  # the app tells the customer where to look
    code = re.search(r"OTP for \+91 90XXXXXX66: (\d{6})", capsys.readouterr().out).group(1)
    ok = client.post("/v1/otp/verify", json={"phone": "9000066666", "otp": code, "deviceId": "dev-console"})
    assert ok.status_code == 200 and client.get("/v1/health").json()["sms"] == "console"
