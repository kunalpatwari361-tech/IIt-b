"""The decision gates. Each is a pure function of the evidence and the policy table.

Gates never call a model or a data source; the pipeline gathers everything first. So the
same evidence always gives the same decision, and an auditor can replay any record.
Outcomes: pass < refer < reject. The most severe gate result wins.
"""
from __future__ import annotations

from datetime import date

from . import policy as pol
from .reasons import REASONS

SEVERITY = {"pass": 0, "refer": 1, "reject": 2}


class Gate:
    def __init__(self, name: str):
        self.name, self.outcome, self.reasons, self.notes, self.facts = name, "pass", [], [], {}

    def refer(self, code: str, **values):
        self._add(code, "refer", values)

    def reject(self, code: str, **values):
        self._add(code, "reject", values)

    def _add(self, code: str, outcome: str, values: dict):
        assert code in REASONS, code
        same = next((r for r in self.reasons if r["code"] == code), None)
        if same is not None:          # one entry per reason; later findings add their values
            same["values"].update({k: str(v) for k, v in values.items()})
            if SEVERITY[outcome] > SEVERITY[same["outcome"]]:
                same["outcome"] = outcome
            if SEVERITY[outcome] > SEVERITY[self.outcome]:
                self.outcome = outcome
            return
        self.reasons.append({"code": code, "outcome": outcome, "values": {k: str(v) for k, v in values.items()},
                             "officer_text": REASONS[code].officer_text, "officer_check": REASONS[code].officer_check})
        if SEVERITY[outcome] > SEVERITY[self.outcome]:
            self.outcome = outcome

    def to_dict(self) -> dict:
        return {"gate": self.name, "outcome": self.outcome, "reasons": self.reasons, "notes": self.notes, "facts": self.facts}


def _age(dob: str, day: date) -> float:
    return (day - date.fromisoformat(dob)).days / 365.25


# --------------------------------------------------------------------------- 1 identity

def identity(ev: dict) -> Gate:
    g = Gate("identity")
    s = ev["identity"]["selfie"]
    if not s:
        g.refer("R-KYC-01")
        g.notes.append("no selfie taken")
    elif not s["face_found"]:
        g.refer("R-KYC-01")
        g.notes.append("no face in the selfie")
    elif not s["live"]:
        g.refer("R-KYC-01", liveness=s["liveness"]["score"])
        g.notes.append("liveness failed: possible photo or screen")
    fm = ev["identity"]["face_match"]
    if fm is None:
        if ev["sandbox"]:
            g.notes.append("face match not run: the sandbox has no UIDAI eKYC photo and no ID document photo with a face")
        else:
            g.refer("R-KYC-01")
            g.notes.append("face match not run: no reference photo")
    elif not fm["match"]:
        g.refer("R-KYC-01", similarity=fm["similarity"])
    g.facts["face_match_similarity"] = fm and fm["similarity"]
    g.facts["pan_name_score"] = ev["identity"]["pan_name_score"]
    if ev["identity"]["pan_name_score"] is not None and ev["identity"]["pan_name_score"] < 85:
        g.refer("R-KYC-02", score=ev["identity"]["pan_name_score"])
    low = {k: v for k, v in ev["identity"]["document_name_scores"].items() if v < 80}
    if low:
        g.refer("R-KYC-02", documents=",".join(sorted(low)))
    if ev["identity"]["pan_on_card_matches"] is False:
        g.refer("R-KYC-02", documents="pan")
        g.notes.append("PAN on the card differs from the PAN entered")
    return g


# --------------------------------------------------------------------------- 2 AML

def aml(ev: dict) -> Gate:
    g = Gate("aml")
    a = ev["aml"]
    g.facts.update(lists=a["lists"], hits=len(a["hits"]), cleared=len(a["cleared"]))
    if a["flag"] == "refer":
        g.refer(a["reason_code"])
    if a["cleared"]:
        g.notes.append(f"{len(a['cleared'])} namesake(s) cleared automatically: different date of birth")
    return g


# --------------------------------------------------------------------------- 3 fraud and documents

def fraud_documents(ev: dict, p: dict) -> Gate:
    g = Gate("fraud_documents")
    m = ev["models"]
    if m["fraud"]["flag"] == "refer":
        g.refer("R-FRD-01", probability=m["fraud"]["fraud_probability"])
    if m["anomaly"]["flag"] == "refer":
        g.refer("R-FRD-04", alert=m["anomaly"]["alert"])
    if ev["links"]["ring"]["flag"] == "refer":
        g.refer("R-FRD-05", linked=ev["links"]["ring"]["linked_applications"])
    g.facts.update(fraud_probability=m["fraud"]["fraud_probability"], anomaly_alert=m["anomaly"]["alert"])
    docs = ev["documents"]
    for slot in ev["required_documents"]:
        d = docs.get(slot)
        if d is None:
            g.refer("R-DOC-04", document=slot)
        elif not d["accepted"]:
            g.refer(d["reason_code"] or "R-DOC-01", document=slot)
    for slot, d in docs.items():
        if d["tamper_signals"]:
            g.refer("R-DOC-03", document=slot)
            g.notes.append(f"{slot}: " + "; ".join(d["tamper_signals"]))
        if d["reused_from"]:
            g.refer("R-FRD-06", document=slot)
    inc = ev["income"]
    if inc["employment"] == "salaried" and inc["slip_net_pay"] and inc["bank_salary"]:
        over = inc["slip_net_pay"] / inc["bank_salary"] - 1
        g.facts["slip_over_bank"] = round(over, 3)
        if over > p["slip_over_bank_tolerance"]:
            payroll = inc["payroll_net_pay"]
            if payroll and inc["slip_net_pay"] / payroll - 1 > p["slip_over_bank_tolerance"]:
                g.reject("R-FRD-03", slip=inc["slip_net_pay"], payroll=payroll)
                g.notes.append("salary slip net pay does not match the employer's payroll record")
            elif payroll:
                g.notes.append("slip is above bank credits, but the payroll record confirms it")
            else:
                g.refer("R-FRD-02", slip=inc["slip_net_pay"], bank=inc["bank_salary"])
    return g


# --------------------------------------------------------------------------- 4 policy

def policy_rules(ev: dict, p: dict) -> Gate:
    g = Gate("policy")
    prof, req = ev["profile"], ev["request"]
    age = _age(prof["dob"], date.fromisoformat(ev["today"]))
    g.facts.update(age=round(age, 1), age_at_end=round(age + req["years"], 1))
    if age < p["min_age"]:
        g.reject("R-POL-01", age=int(age))
    if age + req["years"] > p["max_age_at_end"][prof["employment"]]:
        g.refer("R-POL-02", age_at_end=int(age + req["years"]))
    b = prof["bureau"]
    score = b.get("score")
    if b.get("status") == "self_declared":
        g.notes.append("credit score is self-declared: no bureau is connected")
    if not score:
        g.refer("R-BUR-04")
    elif score < p["bureau_reject_below"]:
        g.reject("R-BUR-01", score=score)
    elif score < p["bureau_refer_below"]:
        g.refer("R-BUR-05", score=score)
    if req["asked_years"] > req["years"]:
        g.notes.append(f"tenure capped at the product maximum of {req['years']} years")
    return g


# --------------------------------------------------------------------------- 5 affordability

def affordability(ev: dict, p: dict) -> tuple[Gate, pol.Eligibility]:
    g = Gate("affordability")
    req, inc, bank = ev["request"], ev["income"], ev["bank"]
    income = inc["income_used"]
    if not inc["proven"]:
        g.refer("R-AFF-04")
        g.notes.append("income not proven by a document; the declared figure was used")
    elif inc.get("declared") and inc["declared"] > 1.25 * income:
        g.notes.append(f"declared income {inc['declared']:.0f} is above what the documents show; using {income:.0f}")
    if inc["employment"] == "selfEmployed" and income and bank["avg_monthly_credits"] < p["business_credits_min_share"] * income:
        g.refer("R-AFF-03", credits=bank["avg_monthly_credits"], declared=income)
    if bank["bounces"] >= p["bounces_refer_at"]:
        g.refer("R-AFF-02", bounces=bank["bounces"])
    e = pol.eligibility(req["product"], income, inc["existing_emi"], req["property_value"], req["amount"], req["years"])
    if e.max_emi <= 0:
        g.reject("R-AFF-01")
    g.facts.update(income_used=income, income_source=inc["income_source"], existing_emi=inc["existing_emi"],
                   **{k: v for k, v in e.to_dict().items()})
    return g, e


# --------------------------------------------------------------------------- 6 risk grade

def risk_grade(ev: dict) -> Gate:
    g = Gate("risk_grade")
    sc, ch = ev["models"]["scorecard"], ev["models"]["challenger"]
    g.facts.update(score=sc["score"], grade=sc["grade"], challenger_score=ch["score"], challenger_grade=ch["grade"])
    if sc["grade"] == "C":
        g.refer("R-RSK-01", grade="C")
    elif sc["grade"] in ("D", "E"):
        g.reject("R-RSK-02", grade=sc["grade"])
    g.notes.append(f"challenger (shadow, not used): {ch['score']} grade {ch['grade']}")
    return g


# --------------------------------------------------------------------------- 7 authority

def authority(e: pol.Eligibility, p: dict) -> Gate:
    g = Gate("authority")
    if e.eligible > p["auto_sanction_limit"]:
        g.refer("R-AUT-01", amount=e.eligible)
    return g


# --------------------------------------------------------------------------- 8 property (final stage)

def property_gate(ev: dict) -> tuple[Gate, float | None]:
    g = Gate("property")
    pr = ev["property"]
    avm = pr["avm"]
    g.facts.update(estimate=avm["estimate"], low=avm["low"], high=avm["high"], confidence=avm["confidence"],
                   circle_value=avm["circle_value"], declared=avm["declared_price"])
    if avm["confidence"] == "low":
        g.refer("R-PRP-02")
        g.notes.append("valuation model unsure (few comparable listings or a wide range)")
    if avm["reason_code"] == "R-PRP-03":
        g.refer("R-PRP-03", declared=avm["declared_price"], high=avm["high"])
    if avm["reason_code"] == "R-PRP-04":
        g.refer("R-PRP-04", declared=avm["declared_price"], circle=avm["circle_value"])
    land = pr["land_records"]
    g.facts["land_records"] = land["title"]
    if land["title"] == "not_connected":
        g.notes.append(land["detail"])
        if pr["deed"] is None:
            g.refer("R-PRP-01")
            g.notes.append("no sale deed uploaded, so the title could not be checked")
    elif land["title"] != "clear":
        g.refer("R-PRP-01")
        g.notes.append(f"land records: {land['detail']}")
    deed = pr["deed"]
    if deed is None:
        g.notes.append("no sale deed uploaded; title checked from land records only")
    else:
        g.facts.update(deed_engine=deed["engine"], deed_grounded=deed["grounded"], deed_issues=len(deed["issues"]))
        if deed["flag"] == "refer":
            g.refer("R-PRP-01")
            g.notes += [f"deed: {i['kind']}: \"{i['quote'][:120]}\"" for i in deed["issues"]]
            if deed["unverified"]:
                g.notes.append(f"deed: {len(deed['unverified'])} fact(s) could not be found in the deed text")
        if pr["deed_buyer_score"] is not None and pr["deed_buyer_score"] < 80:
            g.refer("R-PRP-01")
            g.notes.append("deed: buyer's name differs from the applicant")
    photos = pr["photos"]
    if not photos:
        g.refer("R-PRP-02")
        g.notes.append("no property photos")
    for ph in photos:
        problems = [k for k in ("not_geotagged", "old", "reused") if ph.get(k)]
        if problems:
            g.refer("R-PRP-02")
            g.notes.append(f"photo '{ph['label']}': {', '.join(problems)}")
    return g, avm["value_for_ltv"]


# --------------------------------------------------------------------------- compliance gate

def compliance(ev: dict, gates: list[Gate], offer: dict, stage: str) -> Gate:
    """Regulation as code. Every rule names its source; one failure holds the decision."""
    g = Gate("compliance")
    rules = []

    def rule(rid: str, source: str, ok: bool, detail: str = ""):
        rules.append({"rule": rid, "source": source, "ok": bool(ok), "detail": detail})

    c = ev["consents"]
    rule("CMP-01 consent before data pull", "DPDP Act 2023 s.6; RBI Digital Lending Directions 2025 (consent for data)",
         c and all(c["given"].get(k) for k in ("bureau", "aa", "kyc", "privacy")))
    rule("CMP-02 KYC completed", "RBI KYC Directions 2016 (as amended): customer identification",
         ev["identity"]["selfie"] is not None and bool(ev["profile"].get("pan_masked")))
    rule("CMP-03 sanctions screening ran", "PMLA 2002 and RBI KYC Directions: screening against UN lists",
         ev["aml"]["lists"].get("un_list") is not None)
    if offer["product"] == "homeLoan" and offer["outcome"] != "reject" and offer["value_for_ltv"]:
        ltv = offer["amount"] / offer["value_for_ltv"]
        cap = pol.ltv_cap("homeLoan", offer["amount"])
        rule("CMP-04 LTV within RBI tiers", "RBI Housing Finance Companies Directions: LTV limits for housing loans",
             ltv <= cap + 1e-9, f"{ltv:.3f} vs {cap}")
    rule("CMP-05 Key Facts Statement with APR", "RBI Key Facts Statement circular (2024); Digital Lending Directions",
         offer["outcome"] == "reject" or (offer.get("kfs") or {}).get("apr_pct") is not None)
    adverse = [r for gt in gates for r in gt.reasons]
    rule("CMP-06 every adverse outcome has a reason", "RBI Fair Practices Code for HFCs: reasons for rejection",
         offer["outcome"] == "approve" or bool(adverse))
    llm_rejects = [r for gt in gates for r in gt.reasons if gt.name == "property" and r["outcome"] == "reject"]
    rule("CMP-07 AI is not the final judge", "RBI FREE-AI framework (2025): human oversight of AI outcomes",
         not llm_rejects, "LLM findings can only refer")
    rule("CMP-08 cooling-off period stated", "RBI Digital Lending Directions 2025: cooling-off / look-up period",
         offer["outcome"] == "reject" or (offer.get("kfs") or {}).get("cooling_off_days", 0) >= 1)
    g.facts["rules"] = rules
    for r in rules:
        if not r["ok"]:
            g.refer("R-CMP-01", rule=r["rule"])
    return g
