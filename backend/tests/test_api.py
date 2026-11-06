import pytest

from backend.ledger import Ledger
from backend.tests.conftest import ALL_CONSENTS, STAFF, Applicant, selfie_image

needs_face = pytest.mark.skipif(selfie_image() is None, reason="sample face photo not on this machine")


def codes(decision):
    return [r["code"] for r in decision["reasons"]]


def internal(records, stage):
    rec = next(r for r in records if r["stage"] == stage)
    return {r["code"] for g in rec["gates"] for r in g["reasons"]}


# --------------------------------------------------------------------------- the report's three demo cases

def test_ravi_is_approved_in_both_stages(ravi):
    ip, fin = ravi["in_principle"], ravi["final"]
    assert ip["outcome"] == "approve" and ip["amount"] == 4500000 and ip["ratePct"] == 8.75
    assert round(ip["emi"]) == 39767
    assert codes(ip) == ["OK-SCORE", "OK-FOIR", "OK-LTV"]
    assert fin["outcome"] == "approve" and "OK-TITLE" in codes(fin) and "OK-VALUE" in codes(fin)
    assert fin["valuation"]["valueForLtv"] == 6000000          # lower of the declared price and the estimate
    assert fin["kfs"]["apr_pct"] > fin["kfs"]["rate_pct"]       # APR includes the processing fee
    assert ravi["profile"]["monthlyIncome"] == 100000           # from salary credits, read by model 5


def test_meena_is_referred_at_the_property(meena):
    assert meena["in_principle"]["outcome"] == "approve"
    fin = meena["final"]
    assert fin["outcome"] == "refer" and codes(fin) == ["R-PRP-01"]
    assert "R-PRP-01" in internal(meena["records"], "final")


def test_arjun_is_rejected_for_the_edited_salary_slip(arjun):
    ip = arjun["in_principle"]
    assert ip["outcome"] == "reject" and codes(ip)[0] == "R-FRD-03"
    assert "final" not in arjun
    assert arjun["docs"]["salarySlip"]["fields"]["netPay"] == "93,000.00"     # OCR read the inflated pay


def test_sample_documents_are_recognised(ravi, meena):
    for flow in (ravi, meena):
        for slot, d in flow["docs"].items():
            assert d["accepted"] and d["detectedType"] == slot, (slot, d)


@needs_face
def test_selfie_is_live_and_waits_for_an_id_photo(ravi):
    s = ravi["selfie"]
    assert s["faceFound"] and s["live"] and s["livenessScore"] > 0.9
    assert s["matchPending"]       # sample ID cards carry a photo box, not a face


def test_records_replay_and_the_chain_verifies(client, ravi, meena, arjun):
    for flow in (ravi, meena, arjun):
        for rec in flow["records"]:
            r = client.post(f"/v1/staff/records/{rec['seq']}/replay", headers=STAFF).json()
            assert r["same_decision"] and r["models_same"], r
    assert client.get("/v1/staff/ledger/verify", headers=STAFF).json()["ok"]


def test_record_holds_versions_and_sources(ravi):
    rec = ravi["records"][-1]
    assert {"credit_scorecard", "credit_challenger", "fraud_classifier", "anomaly_detector",
            "transaction_tagger", "property_avm"} <= set(rec["model_versions"])
    rules = next(g for g in rec["gates"] if g["gate"] == "compliance")["facts"]["rules"]
    assert all(r["ok"] for r in rules) and all(r["source"] for r in rules)


def test_letters_and_assistant_work_offline(ravi, meena):
    a = ravi["applicant"]
    letter = a.get("/letter?lang=hi").json()
    assert letter["kind"] == "sanction" and letter["engines"]["llm"] == "offline"
    assert any("Loan amount: Rs 45,00,000" in line for line in letter["lines"])
    ans = meena["applicant"].post("/assistant", json={"question": "Why was it referred?", "lang": "hi"}).json()
    assert ans["topic"] == "reasons" and "lawyer" in ans["answer_en"]


def test_file_note_for_officers(client, meena):
    note = client.get(f"/v1/staff/applications/{meena['applicant'].id}/file-note", headers=STAFF).json()
    assert note["job"] == "file_note" and "property" in note["headline"]
    assert any("Title" in w for w in note["why_referred"])


# --------------------------------------------------------------------------- sign-in, consent and access

def test_wrong_otp_then_lockout(client):
    client.post("/v1/otp/send", json={"phone": "9000000001"})
    for _ in range(4):
        assert client.post("/v1/otp/verify", json={"phone": "9000000001", "otp": "000000", "deviceId": "dev1"}).json()["error"] == "wrong_otp"
    r = client.post("/v1/otp/verify", json={"phone": "9000000001", "otp": "000000", "deviceId": "dev1"})
    assert r.status_code == 401 and r.json()["error"] == "too_many_attempts"
    assert client.post("/v1/otp/verify", json={"phone": "9000000001", "otp": "123456", "deviceId": "dev1"}).json()["error"] == "too_many_attempts"


def test_bad_phone_is_rejected(client):
    assert client.post("/v1/otp/send", json={"phone": "12345"}).status_code == 422


def test_sessions_are_bound_to_their_application_and_device(client):
    a = Applicant(client, "9000000002", "device-a")
    b = Applicant(client, "9000000003", "device-b")
    assert client.get(a.base).status_code == 401
    assert client.get(a.base, headers=b.h).status_code == 403                       # b's token, a's application
    assert client.get(a.base, headers={**a.h, "X-Device-Id": "device-b"}).status_code == 401
    assert client.get(a.base, headers=a.h).status_code == 200


def test_no_data_pull_without_consent(client):
    a = Applicant(client, "9000000004", "device-c")
    assert a.post("/profile", json={"pan": "ABCPK1234K"}).json()["error"] == "consent_required"
    partial = {**ALL_CONSENTS, "given": {**ALL_CONSENTS["given"], "aa": False}}
    a.put("/consents", json=partial)
    assert a.post("/profile", json={"pan": "ABCPK1234K"}).status_code == 409


def test_sharing_only_the_savings_account_means_no_salary_seen(client):
    a = Applicant(client, "9000000005", "device-d")
    a.put("/consents", json={**ALL_CONSENTS, "options": {"aaMonths": 6, "aaAccounts": {"salary": False, "savings": True}}})
    assert a.post("/profile", json={"pan": "ABCPK1234K"}).json()["monthlyIncome"] == 0
    d = a.post("/in-principle", json={"product": "homeLoan", "amount": 3000000, "years": 20, "propertyValue": 5000000}).json()
    recs = client.get(f"/v1/staff/applications/{a.id}/records", headers=STAFF).json()
    assert d["outcome"] in ("refer", "reject") and "R-AFF-04" in internal(recs, "in_principle")


def test_wrong_document_is_not_accepted(client, ravi):
    from backend import sandbox
    a = Applicant(client, "9876500001", "device-e")
    a.put("/consents", json=ALL_CONSENTS)
    a.post("/profile", json={"pan": "ABCPK1234K"})
    r = a.upload("salarySlip", sandbox.sample_document(sandbox.PERSONAS["ravi"], "pan")).json()
    assert not r["accepted"] and r["reasonCode"] == "R-DOC-01" and r["detectedType"] == "pan"


def test_unsupported_upload(client):
    a = Applicant(client, "9000000006", "device-f")
    a.put("/consents", json=ALL_CONSENTS)
    a.post("/profile", json={"pan": "ABCPK1234K"})
    assert a.upload("pan", b"MZ\x90\x00 not a document").status_code == 415


def test_staff_routes_need_the_key(client):
    assert client.get("/v1/staff/ledger/verify").status_code == 403
    assert client.get("/v1/staff/ledger/verify", headers={"X-Staff-Key": "wrong"}).status_code == 403


def test_models_endpoint_lists_all_twelve(client):
    m = client.get("/v1/models").json()["models"]
    assert [x["n"] for x in m] == list(range(1, 13))
    assert all(x["ready"] for x in m), [x for x in m if not x["ready"]]


def test_ledger_detects_an_edited_record(tmp_path):
    led = Ledger(tmp_path / "l.jsonl")
    for i in range(3):
        led.append({"application_id": "A", "outcome": "approve", "n": i})
    assert led.verify() == {"ok": True, "records": 3, "last_hash": led._last_hash}
    lines = (tmp_path / "l.jsonl").read_text(encoding="utf-8").splitlines()
    lines[1] = lines[1].replace('"approve"', '"reject"')
    (tmp_path / "l.jsonl").write_text("\n".join(lines) + "\n", encoding="utf-8")
    assert Ledger(tmp_path / "l.jsonl").verify()["broken_at"] == 2


def test_sandbox_samples_belong_to_the_signed_in_person(client):
    a = Applicant(client, "9876500003", "device-g")
    b = Applicant(client, "9876500003", "device-h")
    slip_a, slip_b = a.get("/samples/salarySlip"), b.get("/samples/salarySlip")
    assert slip_a.status_code == 200 and slip_a.headers["content-type"] == "image/jpeg"
    assert slip_a.content != slip_b.content            # never byte-identical across applications
    assert a.get("/samples/photo-front").content != b.get("/samples/photo-front").content
    assert a.get("/samples/nonsense").status_code == 404
    assert client.get(a.base + "/samples/pan").status_code == 401
