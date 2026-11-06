"""Check model 9 on LFW's standard face-verification pairs (the model table's test).

    .venv/Scripts/python -m models.face_match.evaluate [data_home]

scikit-learn downloads LFW (about 230 MB) into data_home (default K:/tools/downloads/lfw).
Writes reports/lfw_pairs.json: false-accept and false-reject rates at the 0.363
threshold, and how many pairs had no detectable face. LFW photos are public news photos
of public figures; nothing from LFW is stored in the repo.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import cv2
import numpy as np

from .face import MATCH_AT, VERSION, model

REPORTS = Path(__file__).resolve().parent / "reports"


def main(data_home: str = "K:/tools/downloads/lfw") -> dict:
    from sklearn.datasets import fetch_lfw_pairs
    m = model()
    out = {"model_version": VERSION, "threshold": MATCH_AT, "subsets": {}}
    for subset in ("train", "test"):
        lfw = fetch_lfw_pairs(subset=subset, data_home=data_home, color=True, slice_=None, resize=1.0,
                              download_if_missing=True)
        sims, labels, no_face = [], [], 0
        scale = 255.0 if lfw.pairs.max() <= 1.0 else 1.0      # scikit-learn gives pixels as 0-1 floats

        def bgr(x):
            return cv2.cvtColor(np.clip(x * scale, 0, 255).astype(np.uint8), cv2.COLOR_RGB2BGR)

        for (a, b), same in zip(lfw.pairs, lfw.target):
            fa, fb = m.describe(bgr(a)), m.describe(bgr(b))
            if fa["fingerprint"] is None or fb["fingerprint"] is None:
                no_face += 1
                continue
            sims.append(m.similarity(fa["fingerprint"], fb["fingerprint"]))
            labels.append(int(same))
        sims, labels = np.array(sims), np.array(labels)
        accept = sims >= MATCH_AT
        same, diff = labels == 1, labels == 0
        out["subsets"][subset] = {
            "pairs": int(len(lfw.target)), "scored": int(len(sims)), "no_face_found": no_face,
            "false_accept_rate": round(float(accept[diff].mean()), 4),
            "false_reject_rate": round(float((~accept[same]).mean()), 4),
            "accuracy": round(float((accept == same).mean()), 4),
        }
        print(subset, out["subsets"][subset])
    REPORTS.mkdir(exist_ok=True)
    (REPORTS / "lfw_pairs.json").write_text(json.dumps(out, indent=2), encoding="utf-8")
    return out


if __name__ == "__main__":
    main(*sys.argv[1:2])
