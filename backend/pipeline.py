"""Stage A (in-principle) and stage B (final sanction): gather evidence, decide, record.

gather()  calls the models and data sources and returns plain JSON evidence.
decide()  runs the gates on that evidence. It is pure, so replay() can re-run any record.
"""
from __future__ import annotations

from datetime import date, datetime

from models.anomaly_detector import detector
from models.credit_challenger import challenger
from models.credit_scorecard import scorecard
from models.fraud_classifier import fraud
from models.property_avm import avm

from . import adapters, fields, gates, policy as pol, sandbox
from .checks import aml, links
from .config import settings
from .intake import today
from .ledger import Ledger
from .store import Application, Store, now

ENGINE_VERSION = "nirnay-engine-0.1"
LENDER = {"name": "Nirnay Housing Finance (sandbox)", "grievance_officer": "Grievance Redressal Officer, Nirnay HFC (sandbox)",
          "grievance_email": "grievance@nirnay.example", "escalation": "RBI Integrated Ombudsman Scheme, cms.rbi.org.in"}
PROCESSING_FEE_PCT = 0.5     # illustrative
PHOTO_MAX_AGE_DAYS = 30


# --------------------------------------------------------------------------- gather

def _request(req: dict) -> dict:
    product = req["product"]
    asked_years = int(req["years"])
    years = min(asked_years, pol.POLICY["max_tenure_years"][product])
    return {"product": product, "amount": float(req["amount"]), "asked_years": asked_years, "years": years,
            "property_value": float(req["propertyValue"])}


def gather(store: Store, app: Application, req: dict, prop: dict | None = None, photos: list[dict] | None = None,
           signals: dict | None = None) -> dict:
    prof, bank = app.profile, app.bank
    request = _request(req)
    day = today()
    ev: dict = {"stage": "final" if prop else "in_principle", "application_id": app.id, "today": day.isoformat(),
                "sandbox": settings.sandbox, "policy_version": pol.POLICY["version"], "request": request,
                "consents": app.consents}
    ev["profile"] = {k: prof[k] for k in ("name", "dob", "employment", "employer", "monthly_income", "existing_emi",
                                          "bureau", "pan_masked", "pan_name", "address_months", "email")}
    docs = app.documents
    ev["identity"] = {
        "selfie": app.selfie, "face_match": app.face_match,
        "pan_name_score": round(fields.name_score(prof["pan_name"], prof["name"]), 1),
        "document_name_scores": {s: d["name_score"] for s, d in docs.items() if d.get("name_score") is not None},
        "pan_on_card_matches": docs.get("pan", {}).get("pan_matches"),
    }
    ev["aml"] = aml.screen(prof["name"], date.fromisoformat(prof["dob"]))
    ev["required_documents"] = pol.POLICY["required_documents"][prof["employment"]]
    ev["documents"] = {s: {"accepted": d["accepted"], "reason_code": d["reason_code"],
                           "type": d["classifier"]["document_type"], "confidence": d["classifier"]["confidence"],
                           "tamper_signals": d["tamper"]["signals"], "reused_from": d.get("reuse", {}).get("reused_from", []),
                           "name_score": d.get("name_score")} for s, d in docs.items()}
    s = bank["summary"]
    ev["bank"] = {k: s[k] for k in ("months", "avg_monthly_salary", "salary_months", "avg_monthly_emi", "avg_monthly_rent",
                                    "bounces", "cash_deposit_share_of_credits", "entries_needing_review", "avg_monthly_credits")}
    ev["bank"].update(accounts_shared=bank["accounts_shared"], model_version=bank["model_version"])
    slip = fields.amount(docs.get("salarySlip", {}).get("fields", {}).get("netPay"))
    itr_doc = fields.amount(docs.get("itr", {}).get("fields", {}).get("income"))
    bank_salary = s["avg_monthly_salary"] if s["salary_months"] >= 3 else None
    if prof["employment"] == "salaried":
        income = bank_salary or slip or 0.0
        source = "bank salary credits (model 5)" if bank_salary else ("salary slip (OCR)" if slip else "none")
    else:
        income = round(itr_doc / 12, 2) if itr_doc else prof["monthly_income"]
        source = "ITR document (OCR)" if itr_doc else prof["income_source"] if "income_source" in prof else "ITR via consent"
    ev["income"] = {"employment": prof["employment"], "income_used": income, "income_source": source,
                    "existing_emi": prof["existing_emi"], "bank_salary": bank_salary, "slip_net_pay": slip,
                    "payroll_net_pay": sandbox.payroll_net_pay(app.persona) if slip else None,
                    "itr_annual_from_document": itr_doc}

    value_for_models = request["property_value"]
    if prop:
        a = avm.predict(adapters.avm_input(prop))
        value_for_models = a["value_for_ltv"]
        deed = docs.get("saleDeed", {}).get("deed")
        buyers = [f["value"] for f in (deed or {}).get("facts", []) if f["field"] == "buyer"]
        ev["property"] = {
            "input": {k: v for k, v in prop.items() if k != "photos"}, "avm": a,
            "land_records": sandbox.land_records(app.persona, prop["city"], prop["locality"]),
            "deed": deed,
            "deed_buyer_score": max((round(fields.name_score(b, prof["name"]), 1) for b in buyers), default=None),
            "photos": _photo_checks(store, app, photos or [], day),
        }

    inputs = {"credit": adapters.credit_inputs(prof, request["amount"], value_for_models, day),
              "anomaly": adapters.anomaly_inputs(prof, request["amount"], value_for_models, day)}
    sig = {"emails_on_device": store.emails_on_device(app.device_id), "emails_for_dob": store.emails_for_dob(prof["dob"]),
           **(signals or {})}
    inputs["fraud"], measured = adapters.fraud_inputs(prof, bank, sig)
    ev["model_inputs"] = inputs
    ev["fraud_measured"] = sorted(measured)
    ev["models"] = {"scorecard": scorecard.predict(inputs["credit"]), "challenger": challenger.predict(inputs["credit"]),
                    "fraud": fraud.predict(inputs["fraud"]), "anomaly": detector.predict(inputs["anomaly"])}
    ev["links"] = {"ring": links.ring_check(app.id, store.identities())}
    return ev


def _photo_checks(store: Store, app: Application, photos: list[dict], day: date) -> list[dict]:
    out = []
    seen = store.photo_hashes()
    for ph in photos:
        h = links.phash(ph["bytes"]) if ph.get("bytes") else None
        reuse = links.reuse_check(app.id, h, seen)
        taken = ph.get("takenAt")
        try:
            age = (day - datetime.fromisoformat(str(taken).replace("Z", "+00:00")).date()).days if taken else None
        except ValueError:
            age = None
        out.append({"label": ph.get("label", "photo"), "not_geotagged": ph.get("latitude") is None or ph.get("longitude") is None,
                    "old": age is None or age > PHOTO_MAX_AGE_DAYS, "reused": bool(reuse["reused_from"]),
                    "accuracy_m": ph.get("accuracyM")})
        if h:
            app.photo_hashes.add(h)
    return out


# --------------------------------------------------------------------------- decide (pure)

def kfs(amount: float, rate: float, years: int) -> dict:
    """Key Facts Statement numbers. APR counts the processing fee (illustrative 0.5%)."""
    n = years * 12
    e = pol.emi(amount, rate, n) if amount > 0 else 0.0
    fee = round(amount * PROCESSING_FEE_PCT / 100)
    apr = None
    if amount > 0:
        lo, hi = 1e-6, 0.1
        for _ in range(80):     # monthly rate r with (amount - fee) = present value of the EMIs
            mid = (lo + hi) / 2
            pv = e * (1 - (1 + mid) ** -n) / mid
            lo, hi = (mid, hi) if pv > amount - fee else (lo, mid)
        apr = round(lo * 12 * 100, 2)
    return {"loan_amount": amount, "tenure_months": n, "rate_pct": rate, "rate_type": "floating (repo-linked)",
            "emi": round(e, 2), "processing_fee": fee, "other_charges": 0, "apr_pct": apr,
            "total_interest": round(e * n - amount, 2), "total_payable": round(e * n + fee, 2),
            "cooling_off_days": pol.POLICY["cooling_off_days"], "lender": LENDER}


def _pct(x: float) -> str:
    s = f"{x * 100:.1f}"
    return (s[:-2] if s.endswith(".0") else s) + "%"


def decide(ev: dict) -> dict:
    p = pol.POLICY
    req = ev["request"]
    gs = [gates.identity(ev), gates.aml(ev), gates.fraud_documents(ev, p), gates.policy_rules(ev, p)]
    value_for_ltv = req["property_value"]
    if ev["stage"] == "final":
        pg, v = gates.property_gate(ev)
        gs.append(pg)
        value_for_ltv = min(req["property_value"], v) if v else req["property_value"]
    aff_ev = {**ev, "request": {**req, "property_value": value_for_ltv}}
    aff, e = gates.affordability(aff_ev, p)
    gs += [aff, gates.risk_grade(ev), gates.authority(e, p)]
    outcome = max((g.outcome for g in gs), key=gates.SEVERITY.get)
    offer = {"product": req["product"], "outcome": {"pass": "approve"}.get(outcome, outcome), "amount": e.eligible,
             "years": req["years"], "rate_pct": e.rate_pct, "emi": round(e.emi, 2), "value_for_ltv": value_for_ltv,
             "limited_by": e.limited_by}
    offer["kfs"] = kfs(e.eligible, e.rate_pct, req["years"]) if offer["outcome"] != "reject" else None
    gs.append(gates.compliance(ev, gs, offer, ev["stage"]))
    outcome = max((g.outcome for g in gs), key=gates.SEVERITY.get)
    offer["outcome"] = {"pass": "approve"}.get(outcome, outcome)
    return {"gates": [g.to_dict() for g in gs], "outcome": offer["outcome"], "offer": offer,
            "customer_reasons": _customer_reasons(ev, gs, offer, e)}


def _customer_reasons(ev: dict, gs: list, offer: dict, e: pol.Eligibility) -> list[dict]:
    from .reasons import customer_code
    if offer["outcome"] == "approve":
        out = []
        score = ev["profile"]["bureau"].get("score")
        if score:
            out.append({"code": "OK-SCORE", "positive": True, "values": {"score": str(score)}})
        out.append({"code": "OK-FOIR", "positive": True, "values": {"pct": _pct(e.foir_after), "cap": _pct(e.foir_cap)}})
        out.append({"code": "OK-LTV", "positive": True, "values": {"pct": _pct(e.ltv), "cap": _pct(e.ltv_cap)}})
        if ev["stage"] == "final":
            a = ev["property"]["avm"]
            out.append({"code": "OK-VALUE", "positive": True, "values": {"low": str(a["low"]), "high": str(a["high"])}})
            out.append({"code": "OK-TITLE", "positive": True, "values": {}})
        return out
    ranked = sorted((r for g in gs for r in g.reasons), key=lambda r: -gates.SEVERITY[r["outcome"]])
    seen, out = set(), []
    for r in ranked:
        c = customer_code(r["code"])
        if c not in seen:
            seen.add(c)
            out.append({"code": c, "positive": False, "values": {}})
    return out


# --------------------------------------------------------------------------- record and replay

def model_versions(ev: dict) -> dict:
    v = {m["model"]: m.get("model_version") for m in ev["models"].values()}
    v["transaction_tagger"] = ev["bank"].get("model_version")
    if ev.get("property"):
        v["property_avm"] = ev["property"]["avm"]["model_version"]
        if ev["property"].get("deed"):
            v["llm_deed_reader"] = ev["property"]["deed"]["model_version"]
    if ev["identity"]["face_match"]:
        v["face_match"] = ev["identity"]["face_match"]["model_version"]
    if (ev["identity"]["selfie"] or {}).get("liveness"):
        v["liveness"] = ev["identity"]["selfie"]["liveness"]["model_version"]
    return v


def run(store: Store, ledger: Ledger, app: Application, req: dict, prop: dict | None = None,
        photos: list[dict] | None = None, signals: dict | None = None) -> dict:
    ev = gather(store, app, req, prop, photos, signals)
    d = decide(ev)
    rec = ledger.append({"application_id": app.id, "stage": ev["stage"], "at": now().isoformat(),
                         "engine_version": ENGINE_VERSION, "policy_version": pol.POLICY["version"],
                         "model_versions": model_versions(ev), "evidence": ev, **d})
    app.records.append(rec["seq"])
    result = {**d, "stage": ev["stage"], "record": {"seq": rec["seq"], "hash": rec["hash"]}, "evidence": ev}
    if ev["stage"] == "final":
        app.final = result
    else:
        app.in_principle = result
    return result


def replay(record: dict) -> dict:
    """Re-run a recorded decision from its evidence, and re-score the models from their recorded inputs."""
    again = decide(record["evidence"])
    same = (again["outcome"] == record["outcome"] and again["offer"]["amount"] == record["offer"]["amount"]
            and [g["outcome"] for g in again["gates"]] == [g["outcome"] for g in record["gates"]])
    inputs = record["evidence"]["model_inputs"]
    rescored = {"scorecard": scorecard.predict(inputs["credit"])["score"],
                "challenger": challenger.predict(inputs["credit"])["score"],
                "fraud": fraud.predict(inputs["fraud"])["fraud_probability"],
                "anomaly": detector.predict(inputs["anomaly"])["anomaly_score"]}
    recorded = {"scorecard": record["evidence"]["models"]["scorecard"]["score"],
                "challenger": record["evidence"]["models"]["challenger"]["score"],
                "fraud": record["evidence"]["models"]["fraud"]["fraud_probability"],
                "anomaly": record["evidence"]["models"]["anomaly"]["anomaly_score"]}
    return {"seq": record["seq"], "same_decision": same, "outcome": again["outcome"], "recorded_outcome": record["outcome"],
            "models_same": rescored == recorded, "rescored": rescored, "recorded": recorded}


def app_decision(result: dict) -> dict:
    """The app's Decision JSON."""
    o = result["offer"]
    val = None
    if result["stage"] == "final":
        a = result["evidence"]["property"]["avm"]
        val = {"estimate": a["estimate"], "low": a["low"], "high": a["high"], "valueForLtv": o["value_for_ltv"]}
    return {"stage": result["stage"], "outcome": o["outcome"], "amount": o["amount"], "years": o["years"],
            "ratePct": o["rate_pct"], "emi": o["emi"], "reasons": result["customer_reasons"], "valuation": val,
            "kfs": o["kfs"], "record": result["record"]}
