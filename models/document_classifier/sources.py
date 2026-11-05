"""Outside test data: AgamiAI's synthetic Indian document sets (Hugging Face, Apache-2.0).

AgamiAI made their own synthetic bank statements and income tax returns, with a different
generator from ours, and printed and *scanned* them. We OCR page 1 of each scan
and check whether a model trained only on our documents still recognises them.

    Bank statements: https://huggingface.co/datasets/AgamiAI/Indian-Bank-Statements
                     (train/India_Bank_Statement_Scanned_Type1 and Type2)
    Tax returns:     https://huggingface.co/datasets/AgamiAI/Indian-Income-Tax-Returns
                     (train/India_Income_Tax_Return_Scanned: ITR-4, ITR-5 and ITR-6)

We use a sample: 12 statements of each type and 30 returns (about 200 MB). Download into
data/raw/agami/bank_type1, bank_type2 and itr. Git ignores the folder. For example:

    curl -L -o data/raw/agami/itr/00001.pdf \
      https://huggingface.co/datasets/AgamiAI/Indian-Income-Tax-Returns/resolve/main/train/India_Income_Tax_Return_Scanned/00001.pdf
"""
from __future__ import annotations

import time
from multiprocessing import Pool
from pathlib import Path

import pandas as pd

ROOT = Path(__file__).resolve().parents[2]
AGAMI_DIR = ROOT / "data" / "raw" / "agami"
AGAMI_CSV = AGAMI_DIR / "agami_ocr.csv"
FOLDERS = {"bank_type1": "bank_statement", "bank_type2": "bank_statement", "itr": "itr"}
URLS = {"bank_statement": "https://huggingface.co/datasets/AgamiAI/Indian-Bank-Statements",
        "itr": "https://huggingface.co/datasets/AgamiAI/Indian-Income-Tax-Returns"}


def _page_one(path: Path, dpi: int = 150):
    import pypdfium2 as pdfium
    pdf = pdfium.PdfDocument(str(path))
    try:
        return pdf[0].render(scale=dpi / 72).to_pil().convert("RGB")
    finally:
        pdf.close()


def _work(job):
    from .ocr import read_text
    path, folder = job
    t = time.time()
    text = read_text(_page_one(Path(path)), 2)
    return {"doc_id": f"agami/{folder}/{Path(path).stem}", "source": f"agami_{folder}", "category": FOLDERS[folder],
            "ocr_text": text, "ocr_seconds": round(time.time() - t, 2)}


def _init():
    from .ocr import engine
    engine(2)


def build_agami(folder: Path = AGAMI_DIR, out_csv: Path = AGAMI_CSV, workers: int | None = None) -> pd.DataFrame:
    todo = [(str(p), sub) for sub in FOLDERS for p in sorted((folder / sub).glob("*.pdf"))]
    if not todo:
        raise FileNotFoundError(f"No AgamiAI PDFs in {folder}. See the download notes in sources.py.")
    print(f"OCR-ing page 1 of {len(todo)} AgamiAI scans...")
    with Pool(workers or 6, initializer=_init) as pool:
        rows = list(pool.imap_unordered(_work, todo, chunksize=1))
    df = pd.DataFrame(rows).sort_values("doc_id").reset_index(drop=True)
    df.to_csv(out_csv, index=False, encoding="utf-8")
    return df


def load_agami(path: Path = AGAMI_CSV) -> pd.DataFrame | None:
    return pd.read_csv(path, keep_default_na=False) if Path(path).exists() else None
