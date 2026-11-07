"""AML screening: the applicant's name and date of birth against the UN sanctions list and a PEP list.

Not a model, an algorithm (no training): fuzzy name matching with rapidfuzz plus a
sound-alike check with jellyfish's metaphone, so "Mohammed" and "Muhammad" still meet.

- Below the match score: clear.
- A close name whose listed dates of birth all differ from the applicant's: cleared
  automatically, and the record says why (most hits are namesakes).
- A close name with a matching or unknown date of birth: refer to the compliance
  officer. Screening never rejects on its own.

The UN list comes from https://scsanctions.un.org/resources/xml/en/consolidated.xml
(`python -m backend.fetch` downloads and converts it). The PEP list in this repo is
fictional sandbox data; a lender would licence a commercial PEP list.
"""
from __future__ import annotations

import json
import re
import unicodedata
from datetime import date
from functools import lru_cache
from pathlib import Path

DATA = Path(__file__).resolve().parents[1] / "data"
UN_FILE = DATA / "un_sanctions.json"
PEP_FILE = DATA / "pep_sandbox.json"
MATCH_AT = 88        # rapidfuzz score (0-100) for a "close name"
TITLES = {"shri", "smt", "sri", "mr", "mrs", "ms", "miss", "dr", "km", "kumari", "late", "md", "mohd", "s/o", "d/o", "w/o"}


def normalise(name: str) -> str:
    name = unicodedata.normalize("NFKD", name or "").encode("ascii", "ignore").decode().lower()
    tokens = [t for t in re.split(r"[^a-z]+", name) if t and t not in TITLES]
    return " ".join(tokens)


def convert_un_xml(xml_path: Path, out: Path = UN_FILE) -> int:
    """UN consolidated list XML -> the compact JSON the screener reads. Returns the number of entries."""
    import defusedxml.ElementTree as ET  # refuses external entities and entity bombs
    root = ET.parse(xml_path).getroot()
    entries = []
    for ind in root.iter("INDIVIDUAL"):
        parts = [(ind.findtext(t) or "").strip() for t in ("FIRST_NAME", "SECOND_NAME", "THIRD_NAME", "FOURTH_NAME")]
        names = [" ".join(p for p in parts if p)]
        names += [(a.findtext("ALIAS_NAME") or "").strip() for a in ind.iter("INDIVIDUAL_ALIAS")]
        dobs, years = [], []
        for d in ind.iter("INDIVIDUAL_DATE_OF_BIRTH"):
            if d.findtext("DATE"):
                dobs.append(d.findtext("DATE")[:10])
            if d.findtext("YEAR"):
                years.append(int(d.findtext("YEAR")))
            if d.findtext("FROM_YEAR") and d.findtext("TO_YEAR"):
                years += list(range(int(d.findtext("FROM_YEAR")), int(d.findtext("TO_YEAR")) + 1))
        entries.append({"ref": ind.findtext("REFERENCE_NUMBER"), "list": "UN " + (ind.findtext("UN_LIST_TYPE") or ""),
                        "names": sorted({n for n in names if n}), "dobs": sorted(set(dobs)), "years": sorted(set(years))})
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps({"source": "UN Security Council Consolidated List", "generated": root.get("dateGenerated"),
                               "entries": entries}, ensure_ascii=False), encoding="utf-8")
    return len(entries)


@lru_cache(maxsize=2)
def watchlist(sandbox_pep: bool = True) -> tuple[list[dict], dict]:
    entries, info = [], {"un_list": None, "pep_list": None}
    for path, key in ((UN_FILE, "un_list"), (PEP_FILE, "pep_list")):
        if key == "pep_list" and not sandbox_pep:       # the PEP list here is fictional sandbox data
            continue
        if path.exists():
            d = json.loads(path.read_text(encoding="utf-8"))
            entries += [{**e, "keys": [normalise(n) for n in e["names"]]} for e in d["entries"]]
            info[key] = d.get("generated") or d.get("source")
    return entries, info


def _phonetic(a: str, b: str) -> float:
    import jellyfish
    from rapidfuzz import fuzz
    pa = " ".join(sorted(jellyfish.metaphone(t) for t in a.split()))
    pb = " ".join(sorted(jellyfish.metaphone(t) for t in b.split()))
    return fuzz.ratio(pa, pb) * 0.95 if pa and pb else 0.0


def _dob_agrees(entry: dict, dob: date | None) -> bool | None:
    """True: listed DOB matches. False: listed DOBs all differ. None: the list has no DOB."""
    if not entry["dobs"] and not entry["years"]:
        return None
    if dob is None:
        return None
    return dob.isoformat() in entry["dobs"] or dob.year in entry["years"]


def screen(name: str, dob: date | None, sandbox_pep: bool = True) -> dict:
    from rapidfuzz import fuzz
    entries, info = watchlist(sandbox_pep)
    out = {"check": "aml_screening", "lists": info, "name_checked": normalise(name), "hits": [], "cleared": [],
           "flag": "pass", "reason_code": None}
    if info["un_list"] is None:
        out.update(flag="refer", reason_code="R-AML-02", note="sanctions list not loaded")
        return out
    key = normalise(name)
    for e in entries:
        best = 0.0
        for k in e["keys"]:
            if not k:
                continue
            s = max(fuzz.token_sort_ratio(key, k), _phonetic(key, k) if abs(len(key) - len(k)) < 8 else 0.0)
            best = max(best, s)
        if best < MATCH_AT:
            continue
        agrees = _dob_agrees(e, dob)
        hit = {"ref": e["ref"], "list": e["list"], "listed_name": e["names"][0], "score": round(best, 1),
               "pep": bool(e.get("pep"))}
        if agrees is False:
            out["cleared"].append({**hit, "why": "date of birth differs"})
        else:
            out["hits"].append({**hit, "dob": "matches" if agrees else "not on list"})
    if out["hits"]:
        out.update(flag="refer", reason_code="R-AML-01")
    return out
