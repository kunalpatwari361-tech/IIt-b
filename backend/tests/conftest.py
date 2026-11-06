import io
import json
import os
import random
import tempfile

# Settings are read when backend.config is imported, so set them first.
os.environ["NIRNAY_VAR_DIR"] = tempfile.mkdtemp(prefix="nirnay-test-")
os.environ["NIRNAY_STAFF_KEY"] = "test-staff-key"
os.environ["NIRNAY_LLM"] = "off"
os.environ["NIRNAY_SANDBOX"] = "1"

import pytest  # noqa: E402
from fastapi.testclient import TestClient  # noqa: E402

from backend import sandbox  # noqa: E402
from backend.app import app  # noqa: E402

STAFF = {"X-Staff-Key": "test-staff-key"}
PUNE = {"city": "Pune", "locality": "Kharadi", "society": "Palm Meadows", "areaSqft": 1050, "bhk": 2,
        "declaredPrice": 6000000, "isNew": False}
ALL_CONSENTS = {"given": {"bureau": True, "aa": True, "kyc": True, "privacy": True},
                "options": {"aaMonths": 12, "aaAccounts": {"salary": True, "savings": False, "fd": False}}}


def selfie_image() -> bytes | None:
    """A real face for the selfie step, if the sample photos are on this machine (they're not in the repo)."""
    path = os.path.join(os.environ.get("NIRNAY_FACE_SAMPLES", "K:/tools/downloads/silent-face"), "image_T1.jpg")
    return open(path, "rb").read() if os.path.exists(path) else None


def site_photo(seed) -> bytes:
    from PIL import Image, ImageDraw
    rng = random.Random(seed)
    img = Image.new("RGB", (640, 480), tuple(rng.randint(0, 255) for _ in range(3)))
    d = ImageDraw.Draw(img)
    for _ in range(25):
        x, y = rng.randint(0, 600), rng.randint(0, 440)
        d.rectangle([x, y, x + rng.randint(20, 200), y + rng.randint(20, 160)], fill=tuple(rng.randint(0, 255) for _ in range(3)))
    buf = io.BytesIO()
    img.save(buf, "JPEG")
    return buf.getvalue()


@pytest.fixture(scope="session")
def client():
    return TestClient(app)


class Applicant:
    def __init__(self, client, phone, device):
        assert client.post("/v1/otp/send", json={"phone": phone}).status_code == 204
        s = client.post("/v1/otp/verify", json={"phone": phone, "otp": sandbox.DEMO_OTP, "deviceId": device}).json()
        self.c, self.id = client, s["applicationId"]
        self.h = {"Authorization": f"Bearer {s['token']}", "X-Device-Id": device}
        self.base = f"/v1/applications/{self.id}"

    def put(self, path, **kw):
        return self.c.put(self.base + path, headers=self.h, **kw)

    def post(self, path, **kw):
        return self.c.post(self.base + path, headers=self.h, **kw)

    def get(self, path="", **kw):
        return self.c.get(self.base + path, headers=self.h, **kw)

    def upload(self, slot, data, name="doc.jpg"):
        return self.post("/documents", data={"slot": slot}, files={"file": (name, data, "image/jpeg")})

    def final(self, req, prop, photos):
        meta = [{"label": f"photo{i}", "takenAt": "2026-11-05T10:00:00Z", "latitude": 18.55, "longitude": 73.94}
                for i in range(len(photos))]
        return self.post("/final", data={"request": json.dumps(req), "property": json.dumps(prop), "photos_meta": json.dumps(meta)},
                         files=[("photos", (f"p{i}.jpg", p, "image/jpeg")) for i, p in enumerate(photos)])


def run_flow(client, key, req, prop, deed=False):
    p = sandbox.PERSONAS[key]
    a = Applicant(client, p.phone or "9123456789", f"device-{key}")
    assert a.put("/consents", json=ALL_CONSENTS).status_code == 200
    out = {"applicant": a, "profile": a.post("/profile", json={"pan": "ABCPK1234K"}).json()}
    face = selfie_image()
    if face:
        out["selfie"] = a.post("/selfie", files={"file": ("s.jpg", face, "image/jpeg")}).json()
    slots = ["pan", "aadhaar"] + (["salarySlip", "form16"] if p.employment == "salaried" else ["itr", "gst"])
    out["docs"] = {s: a.upload(s, sandbox.sample_document(p, s)).json() for s in slots + (["saleDeed"] if deed else [])}
    out["in_principle"] = a.post("/in-principle", json=req).json()
    if out["in_principle"]["outcome"] != "reject":
        out["final"] = a.final(req, prop, [site_photo(key)]).json()
    out["records"] = client.get(f"/v1/staff/applications/{a.id}/records", headers=STAFF).json()
    return out


@pytest.fixture(scope="session")
def ravi(client):
    return run_flow(client, "ravi", {"product": "homeLoan", "amount": 4500000, "years": 20, "propertyValue": 6000000}, PUNE)


@pytest.fixture(scope="session")
def meena(client):
    return run_flow(client, "meena", {"product": "lap", "amount": 6000000, "years": 15, "propertyValue": 12000000},
                    {**PUNE, "locality": "Baner", "society": None, "areaSqft": 1800, "bhk": 3, "declaredPrice": 12000000},
                    deed=True)


@pytest.fixture(scope="session")
def arjun(client):
    return run_flow(client, "arjun", {"product": "homeLoan", "amount": 3000000, "years": 20, "propertyValue": 4000000}, PUNE)
