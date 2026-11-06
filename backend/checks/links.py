"""Links between applications: fraud rings and reused photos. Algorithms, not models.

- Rings: networkx joins applications that share a device, a phone number, an email or a
  bank account. An application linked to two or more others with different PANs is
  referred to the fraud team (one person re-applying keeps the same PAN, so that's fine).
- Photo reuse: a perceptual hash (imagehash pHash) of every property photo, so a resized
  or re-saved copy of another applicant's photo still matches. Documents are compared
  byte for byte instead: printed templates make different people's cards look alike.
"""
from __future__ import annotations

import io

RING_SIZE = 2        # other applicants with different PANs sharing an identifier
REUSE_DISTANCE = 6   # pHash Hamming distance at or below which two photos count as the same


def ring_check(app_id: str, identities: dict[str, dict]) -> dict:
    """identities: app_id -> {"pan", "device", "phone", "email", "bank_account"} for every application."""
    import networkx as nx
    g = nx.Graph()
    owners: dict[tuple, list[str]] = {}
    for aid, ident in identities.items():
        g.add_node(aid)
        for kind in ("device", "phone", "email", "bank_account"):
            if ident.get(kind):
                owners.setdefault((kind, str(ident[kind]).lower()), []).append(aid)
    shared = []
    for (kind, value), apps in owners.items():
        for a in apps[1:]:
            g.add_edge(apps[0], a, kind=kind)
        if app_id in apps and len(apps) > 1:
            shared.append(kind)
    linked = nx.node_connected_component(g, app_id) - {app_id} if app_id in g else set()
    my_pan = identities.get(app_id, {}).get("pan")
    others = {identities[a].get("pan") for a in linked if identities[a].get("pan") and identities[a].get("pan") != my_pan}
    ring = len(others) >= RING_SIZE
    return {"check": "ring", "linked_applications": len(linked), "other_pans": len(others),
            "shared": sorted(set(shared)), "flag": "refer" if ring else "pass", "reason_code": "R-FRD-05" if ring else None}


def phash(data: bytes) -> str | None:
    try:
        import imagehash
        from PIL import Image
        return str(imagehash.phash(Image.open(io.BytesIO(data)).convert("RGB")))
    except Exception:
        return None


def duplicate_check(app_id: str, digest: str, seen: dict[str, set[str]]) -> dict:
    """The exact same document file (SHA-256) on another application."""
    others = [a for a, digests in seen.items() if a != app_id and digest in digests]
    return {"check": "duplicate_file", "reused_from": others, "flag": "refer" if others else "pass",
            "reason_code": "R-FRD-06" if others else None}


def reuse_check(app_id: str, h: str | None, seen: dict[str, set[str]]) -> dict:
    """seen: app_id -> pHashes of that application's photos."""
    out = {"check": "photo_reuse", "hash": h, "reused_from": [], "flag": "pass", "reason_code": None}
    if h is None:
        return out
    import imagehash
    me = imagehash.hex_to_hash(h)
    for other, hashes in seen.items():
        if other == app_id:
            continue
        if any(me - imagehash.hex_to_hash(x) <= REUSE_DISTANCE for x in hashes):
            out["reused_from"].append(other)
    if out["reused_from"]:
        out.update(flag="refer", reason_code="R-FRD-06")
    return out
