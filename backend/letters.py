"""Customer letters and the help assistant: model 11 drafts, model 12 translates.

A letter is a fixed template (amounts, rate, Key Facts, legal lines and grievance route
come from the decision, never from the LLM) with three free-text paragraphs the LLM
writes. The help assistant answers from the application's facts and an approved FAQ.
"""
from __future__ import annotations

import json
import re
from functools import lru_cache

from models.llm import llm
from models.translation import translate as tr

from .pipeline import LENDER
from .store import Application

CODE_KEYS = {"R-KYC-01": "reasonKyc01", "R-FRD-02": "reasonFrd02", "R-FRD-03": "reasonFrd03", "R-POL-01": "reasonPol01",
             "R-POL-02": "reasonPol02", "R-BUR-01": "reasonBur01", "R-BUR-04": "reasonBur04", "R-BUR-05": "reasonBur05",
             "R-PRP-01": "reasonPrp01", "R-PRP-03": "reasonPrp03", "R-PRP-04": "reasonPrp04", "R-AFF-01": "reasonAff01",
             "R-AUT-01": "reasonAut01", "R-RSK-01": "reasonRsk01", "R-RSK-02": "reasonRsk02", "OK-SCORE": "okScore",
             "OK-FOIR": "okFoir", "OK-LTV": "okLtv", "OK-TITLE": "okTitle"}

FAQ = [
    {"q": "Which documents do I need?", "topic": "documents",
     "a": "Salaried: PAN, Aadhaar, your latest salary slip and a bank statement. Self-employed: PAN, Aadhaar, your ITR, "
          "GST certificate and a bank statement. The app shows which ones are still needed."},
    {"q": "How long does a decision take?", "topic": "status",
     "a": "The in-principle offer comes in minutes once your data is in. The final sanction takes minutes for a "
          "pre-approved project, or one to two working days if we need to visit the property."},
    {"q": "What is FOIR?", "topic": "offer_and_emi",
     "a": "FOIR is the share of your monthly income that goes to EMIs, including the new loan. We keep it within a limit so "
          "the EMI stays affordable."},
    {"q": "What is LTV?", "topic": "offer_and_emi",
     "a": "LTV is the loan as a share of the property's value. RBI sets the highest LTV for home loans: 90% up to Rs 30 lakh, "
          "80% up to Rs 75 lakh and 75% above that."},
    {"q": "Can I cancel the loan after signing?", "topic": "offer_and_emi",
     "a": "Yes. During the cooling-off period shown in your Key Facts Statement you can cancel by repaying the amount "
          "drawn, with no penalty."},
    {"q": "Are there charges for paying off early?", "topic": "offer_and_emi",
     "a": "There is no charge for paying off a floating-rate home loan early, in part or in full."},
    {"q": "How do I withdraw my consent?", "topic": "consent_and_privacy",
     "a": "Open Manage consents in the app. You can turn optional consents off at any time. Withdrawing a needed consent "
          "pauses your application, and we delete the data fetched under it."},
    {"q": "Who can see my data?", "topic": "consent_and_privacy",
     "a": "Only the checks you agreed to on the consent screen use your data, and only for this loan. We never sell it."},
    {"q": "I disagree with the decision. What can I do?", "topic": "grievance",
     "a": "You can ask for a review by a person. Contact our grievance officer from the decision screen. If you are not "
          "satisfied within 30 days, you can complain to the RBI Ombudsman at cms.rbi.org.in."},
    {"q": "Why do I need a video KYC call?", "topic": "documents",
     "a": "If we can't confirm your identity from the selfie, a short video call with our officer completes your KYC."},
]


@lru_cache(maxsize=1)
def _english() -> dict:
    return json.loads((tr.ARB_DIR / "app_en.arb").read_text(encoding="utf-8"))


def reason_sentence(r: dict) -> str:
    key = CODE_KEYS.get(r["code"])
    if key is None:
        return ""
    text = _english().get(key, "")
    return re.sub(r"\{(\w+)\}", lambda m: r.get("values", {}).get(m.group(1), m.group(0)), text)


def _kind(result: dict) -> str:
    o = result["offer"]["outcome"]
    if o == "approve":
        return "sanction" if result["stage"] == "final" else "in_principle"
    return "refer" if o == "refer" else "rejection"


NEXT_STEPS = {
    "in_principle": ["Add your property details and photos in the app to get your final sanction.",
                     "This offer is valid for 30 days."],
    "sanction": ["Read the Key Facts Statement, then e-sign the agreement and set up your EMI mandate in the app."],
    "refer": ["You don't need to do anything now unless we ask. We will update you in the app and by SMS."],
    "rejection": ["You can ask for a review by a person through our grievance officer.",
                  "You can apply again after improving the points above."],
}


def _rupees(x: float) -> str:
    whole = f"{x:,.0f}".replace(",", "")
    if len(whole) > 3:
        head, tail = whole[:-3], whole[-3:]
        parts = []
        while len(head) > 2:
            parts.insert(0, head[-2:])
            head = head[:-2]
        whole = ",".join(([head] if head else []) + parts + [tail])
    return f"Rs {whole}"


def letter(app: Application, lang: str = "en") -> dict:
    result = app.final or app.in_principle
    if result is None:
        raise LookupError("no_decision")
    kind = _kind(result)
    o = result["offer"]
    reasons = [s for s in (reason_sentence(r) for r in result["customer_reasons"]) if s]
    facts = {"letter": kind, "applicant_first_name": app.profile["name"].split()[0], "reasons": reasons,
             "next_steps": NEXT_STEPS[kind]}
    draft = llm.fill_letter(facts)
    head = [f"{LENDER['name']}", f"Application number: {app.id}", f"Dear {app.profile['name']},"]
    terms = []
    if kind in ("in_principle", "sanction") and o["kfs"]:
        k = o["kfs"]
        terms = [f"Loan amount: {_rupees(o['amount'])}", f"Tenure: {o['years']} years",
                 f"Interest rate: {o['rate_pct']}% a year, {k['rate_type']}", f"EMI: {_rupees(o['emi'])} a month",
                 f"Processing fee: {_rupees(k['processing_fee'])} plus GST {_rupees(k.get('gst_on_fee', 0))}",
                 f"Annual percentage rate (APR): {k['apr_pct']}%",
                 f"Cooling-off period: {k['cooling_off_days']} days"]
    foot = [f"Grievance officer: {LENDER['grievance_officer']}, {LENDER['grievance_email']}.",
            f"If your complaint is not resolved in 30 days: {LENDER['escalation']}.",
            "This decision was made by our automated underwriting engine under our credit policy. You can ask for a review by a person."]
    body = [draft["opening"], draft["explanation"], draft["next_steps"]]
    lines = head + body + terms + foot
    translated = tr.translate(lines, lang)
    return {"application_id": app.id, "kind": kind, "lang": lang, "lines": translated["texts"],
            "text": "\n\n".join(translated["texts"]),
            "engines": {"llm": draft["engine"], "translation": translated["engines"], "untranslated": translated["untranslated"]},
            "record": result["record"]}


def status_text(app: Application) -> str:
    if app.final:
        return {"approve": "Your loan is sanctioned.", "refer": "Your application is with our team for a final check.",
                "reject": "We could not sanction this loan."}[app.final["offer"]["outcome"]]
    if app.in_principle:
        return {"approve": "You have an in-principle offer. Add your property details to get the final sanction.",
                "refer": "Your application is with our team for a review.",
                "reject": "We could not offer this loan."}[app.in_principle["offer"]["outcome"]]
    if app.profile:
        return "We have your details. Next: take a selfie and upload your documents."
    return "Your application has started. Next: give consent so we can fetch your details."


def assistant(app: Application, question: str, lang: str = "en") -> dict:
    result = app.final or app.in_principle
    facts = {"application_id": app.id, "status_text": status_text(app),
             "reasons": [reason_sentence(r) for r in (result or {}).get("customer_reasons", []) if reason_sentence(r)],
             "documents_uploaded": sorted(app.documents),
             "grievance": {"officer": LENDER["grievance_officer"], "email": LENDER["grievance_email"],
                           "escalation": LENDER["escalation"]}}
    if result and result["offer"]["outcome"] == "approve":
        o = result["offer"]
        facts["offer"] = {"amount": _rupees(o["amount"]), "years": o["years"], "rate_pct": o["rate_pct"],
                          "emi": _rupees(o["emi"]), "cooling_off_days": (o["kfs"] or {}).get("cooling_off_days")}
    r = llm.answer(question, facts, FAQ)
    t = tr.translate([r["answer"]], lang)
    return {"answer": t["texts"][0], "answer_en": r["answer"], "topic": r["topic"], "handoff_to_human": r["handoff_to_human"],
            "engines": {"llm": r["engine"], "translation": t["engines"]}}
