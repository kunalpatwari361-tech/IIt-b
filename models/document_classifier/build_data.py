"""Build the OCR training data for the document classifier (model 6).

1. Generate 480 fake documents (generator.py): 36 for each of the 12 lending
   types and 48 "other" papers.
2. Draw each one as an image and make it look like a phone photo or scan (render.py).
3. Read it back with a real OCR engine (ocr.py), so the model learns from real OCR
   mistakes, not clean text.
4. Make a "hard" set of 130 bad uploads (half the page cut off, heavy blur, low
   resolution, strong tilt or a dark photo), 10 for each type.

The result, data/generated_ocr.csv, is committed: it holds only our fake documents.
It takes about 10 minutes on a laptop, so train.py reads the CSV instead of redoing it.

    .venv/Scripts/python -m models.document_classifier.build_data            # our documents
    .venv/Scripts/python -m models.document_classifier.build_data --agami    # also OCR the AgamiAI scans

`--agami` reads the scanned PDFs downloaded into data/raw/agami/ (see sources.py)
and writes data/raw/agami/agami_ocr.csv. That file stays on your computer.
"""
from __future__ import annotations

import argparse
import hashlib
import os
import random
import time
from multiprocessing import Pool
from pathlib import Path

import pandas as pd

from .generator import CATEGORIES, LAYOUTS, generate, plain_text

HERE = Path(__file__).resolve().parent
OUT_CSV = HERE / "data" / "generated_ocr.csv"
SAMPLES = HERE / "samples"
PER_TYPE, OTHER_COUNT, HARD_PER_TYPE, SEED = 36, 48, 10, 42
THREADS_PER_WORKER = 2


def _seed(*parts) -> int:
    return int(hashlib.sha256("|".join(map(str, parts)).encode()).hexdigest()[:12], 16)


def _init():
    from .ocr import engine
    engine(THREADS_PER_WORKER)


def _work(job):
    from .ocr import read_text
    from .render import degrade, render
    doc, level, seed = job
    rng = random.Random(seed)
    img = degrade(render(doc, rng), rng, level)
    t = time.time()
    text = read_text(img, THREADS_PER_WORKER)
    return {"doc_id": doc["doc_id"], "set": "hard" if level == "hard" else "main", "category": doc["category"],
            "layout": doc["layout"], "layout_no": doc["layout_no"], "kind": doc["kind"],
            "clean_text": plain_text(doc["lines"]), "ocr_text": text, "ocr_seconds": round(time.time() - t, 2)}


def jobs(seed: int = SEED, per_type: int = PER_TYPE, other_count: int = OTHER_COUNT, hard_per_type: int = HARD_PER_TYPE):
    docs = generate(per_type, seed, other_count)
    out = [(d, "normal", _seed(seed, d["doc_id"], "main")) for d in docs]
    rng = random.Random(seed)
    for cat in CATEGORIES:
        mine = [d for d in docs if d["category"] == cat]
        # spread the hard copies over every layout of the type
        by_layout = sorted(mine, key=lambda d: (int(d["doc_id"].rsplit("-", 1)[1]) // LAYOUTS[cat], d["layout_no"]))
        for d in by_layout[:hard_per_type]:
            out.append((d, "hard", _seed(seed, d["doc_id"], "hard")))
    rng.shuffle(out)
    return out


def build(out_csv: Path = OUT_CSV, workers: int | None = None, **kw) -> pd.DataFrame:
    todo = jobs(**kw)
    workers = workers or max(1, min(6, (os.cpu_count() or 2) // THREADS_PER_WORKER))
    print(f"Rendering and OCR-ing {len(todo)} documents with {workers} workers...")
    rows, t = [], time.time()
    with Pool(workers, initializer=_init) as pool:
        for i, row in enumerate(pool.imap_unordered(_work, todo, chunksize=2), 1):
            rows.append(row)
            if i % 50 == 0 or i == len(todo):
                print(f"  {i}/{len(todo)} done, {time.time() - t:.0f}s")
    df = pd.DataFrame(rows).sort_values(["set", "doc_id"]).reset_index(drop=True)
    out_csv.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(out_csv, index=False, encoding="utf-8")
    return df


def contact_sheet(path: Path = SAMPLES / "contact_sheet.jpg", seed: int = SEED) -> None:
    """One example of each type, each stamped SYNTHETIC SAMPLE (the stamp is only on these previews)."""
    from PIL import Image, ImageDraw

    from .render import _font, degrade, families, render
    docs = generate(PER_TYPE, seed, OTHER_COUNT)
    picks = [next(d for d in docs if d["category"] == c) for c in CATEGORIES]
    tiles = []
    reg, bold = families()[0]
    for d in picks:
        rng = random.Random(_seed(seed, d["doc_id"], "main"))
        img = degrade(render(d, rng), rng)
        img.thumbnail((420, 560))
        tile = Image.new("RGB", (440, 620), "white")
        tile.paste(img, ((440 - img.width) // 2, 10))
        draw = ImageDraw.Draw(tile)
        draw.text((10, 585), d["category"], fill="black", font=_font(bold, 22))
        stamp = Image.new("RGBA", (420, 60), (0, 0, 0, 0))
        ImageDraw.Draw(stamp).text((10, 5), "SYNTHETIC SAMPLE", fill=(200, 0, 0, 150), font=_font(bold, 40))
        stamp = stamp.rotate(25, expand=True)
        tile.paste(stamp, (20, 180), stamp)
        tiles.append(tile)
    cols = 5
    rows = -(-len(tiles) // cols)
    sheet = Image.new("RGB", (cols * 440, rows * 620), (235, 235, 235))
    for i, tile in enumerate(tiles):
        sheet.paste(tile, ((i % cols) * 440, (i // cols) * 620))
    path.parent.mkdir(parents=True, exist_ok=True)
    sheet.save(path, quality=70)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--agami", action="store_true", help="also OCR the AgamiAI scans in data/raw/agami/")
    parser.add_argument("--skip-generated", action="store_true", help="don't rebuild our own documents")
    parser.add_argument("--workers", type=int, default=None)
    args = parser.parse_args()
    if not args.skip_generated:
        df = build(workers=args.workers)
        print(df.groupby(["set", "category"]).size().unstack(0))
        contact_sheet()
    if args.agami:
        from .sources import build_agami
        print(build_agami(workers=args.workers).groupby(["source", "category"]).size())


if __name__ == "__main__":
    main()
