"""Read text from a document image with RapidOCR (PP-OCR models, run locally with ONNX Runtime).

This is only used to *build the training data*: the classifier itself takes OCR
text from whichever OCR engine the platform uses. RapidOCR keeps no data and
calls no web service. It often drops the spaces between English words
("PermanentAccountNumberCard"), so the classifier is built to cope with that.
"""
from __future__ import annotations

import numpy as np

_engine = None


def engine(threads: int = -1):
    global _engine
    if _engine is None:
        from rapidocr_onnxruntime import RapidOCR
        _engine = RapidOCR(intra_op_num_threads=threads) if threads > 0 else RapidOCR()
    return _engine


def read_text(img, threads: int = -1) -> str:
    """OCR an image (PIL or array) and return its text, one printed line per output line."""
    result, _ = engine(threads)(np.asarray(img.convert("RGB")) if hasattr(img, "convert") else img)
    if not result:
        return ""
    boxes = []
    for box, text, _score in result:
        ys = [p[1] for p in box]
        boxes.append((sum(ys) / 4, max(ys) - min(ys), min(p[0] for p in box), text))
    boxes.sort()
    height = float(np.median([b[1] for b in boxes])) or 10.0
    lines, current, y_line = [], [], None
    for yc, _h, x, text in boxes:
        if y_line is not None and abs(yc - y_line) > 0.5 * height:
            lines.append(" ".join(t for _, t in sorted(current)))
            current = []
        if not current:
            y_line = yc
        current.append((x, text))
    if current:
        lines.append(" ".join(t for _, t in sorted(current)))
    return "\n".join(lines)
