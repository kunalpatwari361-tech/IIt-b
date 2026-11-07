"""One-time codes by SMS.

NIRNAY_SMS_PROVIDER picks who sends them:
- `sandbox`: no SMS; the code is always 123456. Only allowed while NIRNAY_SANDBOX=1.
- `twilio`: Twilio Verify. It makes, sends and checks the code, so the engine never sees it.
  Needs TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN and TWILIO_VERIFY_SERVICE_SID.
- `msg91`: MSG91's OTP API (India). Needs MSG91_AUTH_KEY and MSG91_TEMPLATE_ID (a DLT-approved
  OTP template). MSG91 also checks the code itself.
- `console`: for testing on your own laptop before an SMS account exists. Each code is random
  and is printed in the server's terminal instead of being sent. It needs a second switch,
  NIRNAY_ALLOW_CONSOLE_OTP=1, so it can't be left on by mistake. Never use it on a server
  other people can reach: whoever reads the server log could sign in as anyone.

Either way the engine limits sends (3 codes per number per 15 minutes) and wrong tries
(5 per code), so the SMS bill can't be run up and codes can't be guessed. Provider
calls are written from each provider's published API; run one real send before inviting
testers.
"""
from __future__ import annotations

import hashlib
import hmac
import os
import time

import httpx

from .store import Store

MAX_SENDS, WINDOW_MINUTES = 3, 15
DEMO_OTP = "123456"
# Calls to the SMS service: give up on a connection after 5 s and try again, up to 3 times.
# A shaky home connection otherwise turns one dropped packet into a failed sign-in.
TIMEOUT = httpx.Timeout(15.0, connect=5.0)
CONNECT_TRIES, RETRY_PAUSE_SECONDS = 3, 1.0


class OtpError(Exception):
    def __init__(self, code: str, status: int = 400):
        super().__init__(code)
        self.code, self.status = code, status


def _hash(code: str) -> str:
    return hashlib.sha256(code.encode()).hexdigest()


class SandboxOtp:
    name = "sandbox"
    checks_itself = False

    def new_code(self) -> str:
        return DEMO_OTP

    def deliver(self, phone: str, code: str) -> None:
        pass

    def check(self, phone: str, code: str) -> bool:
        raise NotImplementedError


class ConsoleOtp:
    """Local testing only: a random code, printed in the server terminal (see the module notes)."""
    name = "console"
    checks_itself = False

    def new_code(self) -> str:
        import secrets
        return f"{secrets.randbelow(1_000_000):06d}"

    def deliver(self, phone: str, code: str) -> None:
        print(f"\n  >>> OTP for +91 {_mask(phone)}: {code}   (console mode: not sent by SMS)\n", flush=True)

    def check(self, phone: str, code: str) -> bool:
        raise NotImplementedError


def _mask(phone: str) -> str:
    return f"{phone[:2]}XXXXXX{phone[-2:]}"


def _log_refusal(service: str, r: httpx.Response, phone: str) -> None:
    """Print why the SMS service said no (its error code and message, never the keys), with the
    number masked, so whoever runs the server can fix the account: on a Twilio trial, for
    example, only numbers verified in the Twilio console can receive texts."""
    try:
        body = r.json()
        why = f"{body.get('code', '')} {body.get('message', '')}".strip()
    except ValueError:
        why = r.text[:200]
    print(f"  !!! {service} refused +91 {_mask(phone)} ({r.status_code}): {why.replace(phone, _mask(phone))}",
          flush=True)


def _call(service: str, http: httpx.Client, method: str, url: str, phone: str, **kw) -> httpx.Response:
    """One request to the SMS service, or OtpError("sms_failed") (the app says "try again"),
    never a crash. A connection that never opened is tried again: nothing reached the service,
    so no second text can go out. Other network failures (a reply that never came, say) are not
    retried, because the service may already have acted on the request."""
    for attempt in range(1, CONNECT_TRIES + 1):
        try:
            return http.request(method, url, **kw)
        except (httpx.ConnectError, httpx.ConnectTimeout) as e:
            if attempt < CONNECT_TRIES:
                time.sleep(RETRY_PAUSE_SECONDS)
                continue
            print(f"  !!! {service} unreachable for +91 {_mask(phone)}: {type(e).__name__} after {CONNECT_TRIES} "
                  "tries. Check this computer's internet connection.", flush=True)
            raise OtpError("sms_failed", 502) from e
        except httpx.HTTPError as e:
            print(f"  !!! {service} call failed for +91 {_mask(phone)}: {type(e).__name__}", flush=True)
            raise OtpError("sms_failed", 502) from e
    raise AssertionError("unreachable")


class TwilioVerify:
    name = "twilio"
    checks_itself = True
    BASE = "https://verify.twilio.com/v2/Services"

    def __init__(self, client: httpx.Client | None = None):
        self.sid, self.token = os.environ["TWILIO_ACCOUNT_SID"], os.environ["TWILIO_AUTH_TOKEN"]
        self.service = os.environ["TWILIO_VERIFY_SERVICE_SID"]
        self.http = client or httpx.Client(timeout=TIMEOUT)

    def send(self, phone: str) -> None:
        r = _call("Twilio Verify", self.http, "POST", f"{self.BASE}/{self.service}/Verifications", phone,
                  auth=(self.sid, self.token), data={"To": f"+91{phone}", "Channel": "sms"})
        if r.status_code >= 400:
            _log_refusal("Twilio Verify", r, phone)
            raise OtpError("sms_failed", 502)

    def check(self, phone: str, code: str) -> bool:
        r = _call("Twilio Verify", self.http, "POST", f"{self.BASE}/{self.service}/VerificationCheck", phone,
                  auth=(self.sid, self.token), data={"To": f"+91{phone}", "Code": code})
        if r.status_code == 404:        # no pending verification (expired or already used)
            return False
        if r.status_code >= 400:
            _log_refusal("Twilio Verify", r, phone)
            raise OtpError("sms_failed", 502)
        return r.json().get("status") == "approved"


class Msg91:
    name = "msg91"
    checks_itself = True
    BASE = "https://control.msg91.com/api/v5/otp"

    def __init__(self, client: httpx.Client | None = None):
        self.key, self.template = os.environ["MSG91_AUTH_KEY"], os.environ["MSG91_TEMPLATE_ID"]
        self.http = client or httpx.Client(timeout=TIMEOUT)

    def send(self, phone: str) -> None:
        r = _call("MSG91", self.http, "POST", self.BASE, phone, headers={"authkey": self.key},
                  params={"template_id": self.template, "mobile": f"91{phone}", "otp_length": 6, "otp_expiry": 5})
        if r.status_code >= 400 or r.json().get("type") != "success":
            raise OtpError("sms_failed", 502)

    def check(self, phone: str, code: str) -> bool:
        r = _call("MSG91", self.http, "GET", f"{self.BASE}/verify", phone, headers={"authkey": self.key},
                  params={"otp": code, "mobile": f"91{phone}"})
        if r.status_code >= 400:
            raise OtpError("sms_failed", 502)
        return r.json().get("type") == "success"


def provider(sandbox: bool):
    name = os.environ.get("NIRNAY_SMS_PROVIDER", "sandbox" if sandbox else "").strip().lower()
    if name == "sandbox":
        if not sandbox:
            raise OtpError("sms_not_configured", 501)       # a fixed code must never reach real users
        return SandboxOtp()
    if name == "console":
        if os.environ.get("NIRNAY_ALLOW_CONSOLE_OTP") != "1":
            raise OtpError("sms_not_configured", 501)
        return ConsoleOtp()
    try:
        if name == "twilio":
            return TwilioVerify()
        if name == "msg91":
            return Msg91()
    except KeyError as e:
        raise OtpError("sms_not_configured", 501) from e
    raise OtpError("sms_not_configured", 501)


def send(store: Store, sms, phone: str, ttl: int, attempts: int) -> None:
    """Start a sign-in for this number. The send limit is checked BEFORE anything goes out, so a
    refused request never sends (or prints) a code that wouldn't work."""
    if sms.checks_itself:
        if not store.otp_start(phone, None, ttl, attempts, MAX_SENDS, WINDOW_MINUTES):
            raise OtpError("too_many_requests", 429)
        try:
            sms.send(phone)
        except OtpError:
            store.otp_refund(phone, send=True)      # no text went out, so it doesn't count as a send
            raise
        return
    code = sms.new_code()
    if not store.otp_start(phone, _hash(code), ttl, attempts, MAX_SENDS, WINDOW_MINUTES):
        raise OtpError("too_many_requests", 429)
    sms.deliver(phone, code)


def verify(store: Store, sms, phone: str, code: str) -> str:
    """'ok', 'wrong_otp', 'expired_otp' or 'too_many_attempts'."""
    state, code_hash = store.otp_attempt(phone)
    if state != "ok":
        return state
    if sms.checks_itself:
        try:
            good = sms.check(phone, code)
        except OtpError:
            store.otp_refund(phone, attempt=True)   # the code was never checked, so the try isn't used up
            raise
    else:
        good = hmac.compare_digest(code_hash or "", _hash(code))
    if good:
        store.otp_clear(phone)
        return "ok"
    return "wrong_otp" if store.otp_left(phone) > 0 else "too_many_attempts"
