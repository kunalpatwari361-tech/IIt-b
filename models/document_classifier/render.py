"""Draw generated documents as images and make them look like real uploads.

`render` turns a document's lines into an A4 page or an ID-card image.
`degrade` then makes it look like a phone photo or scan: a slight tilt,
blur, noise, JPEG compression, and sometimes a table-top background with
perspective. The "hard" level imitates bad uploads: half the page cut off,
heavy blur, low resolution or a strong tilt.

Fonts come from the operating system. Windows fonts are used when present,
then common Linux and macOS fonts, then Pillow's built-in font.
"""
from __future__ import annotations

import io
import random
import re
from functools import lru_cache
from pathlib import Path

import numpy as np
from PIL import Image, ImageDraw, ImageEnhance, ImageFilter, ImageFont

FONT_DIRS = [Path("C:/Windows/Fonts"), Path("/usr/share/fonts"), Path("/Library/Fonts"),
             Path("/System/Library/Fonts"), Path.home() / ".fonts"]
FAMILIES = [("arial.ttf", "arialbd.ttf"), ("calibri.ttf", "calibrib.ttf"), ("times.ttf", "timesbd.ttf"),
            ("verdana.ttf", "verdanab.ttf"), ("tahoma.ttf", "tahomabd.ttf"), ("georgia.ttf", "georgiab.ttf"),
            ("cour.ttf", "courbd.ttf"), ("segoeui.ttf", "segoeuib.ttf"), ("trebuc.ttf", "trebucbd.ttf"),
            ("DejaVuSans.ttf", "DejaVuSans-Bold.ttf"), ("DejaVuSerif.ttf", "DejaVuSerif-Bold.ttf"),
            ("LiberationSans-Regular.ttf", "LiberationSans-Bold.ttf")]
HINDI = ["Nirmala.ttc", "NotoSansDevanagari-Regular.ttf", "Lohit-Devanagari.ttf", "Mangal.ttf"]
ACCENTS = [(0, 51, 102), (153, 0, 0), (0, 102, 51), (102, 0, 102), (204, 85, 0), (0, 76, 153), (64, 64, 64)]


@lru_cache(maxsize=None)
def _find(name: str) -> str | None:
    for d in FONT_DIRS:
        if (d / name).exists():
            return str(d / name)
        if d.exists() and d != Path("C:/Windows/Fonts"):
            hit = next(d.rglob(name), None)
            if hit:
                return str(hit)
    return None


@lru_cache(maxsize=None)
def _font(name: str, size: int):
    path = _find(name)
    return ImageFont.truetype(path, size) if path else ImageFont.load_default(size)


def families() -> list[tuple[str, str]]:
    found = [f for f in FAMILIES if _find(f[0]) and _find(f[1])]
    return found or [("default", "default")]


def _hindi_font(size: int):
    for name in HINDI:
        if _find(name):
            return _font(name, size)
    return None


_DEVANAGARI = re.compile(r"[ऀ-ॿ][ऀ-ॿ\s]*[ऀ-ॿ]|[ऀ-ॿ]")


def _text(d, xy, text, font, fill="black"):
    """Draw text, switching to a Hindi font for any Devanagari runs (as on bilingual Indian documents)."""
    if not _DEVANAGARI.search(text):
        d.text(xy, text, fill=fill, font=font)
        return
    hindi = _hindi_font(getattr(font, "size", 20)) or font
    x, y = xy
    pos = 0
    for m in list(_DEVANAGARI.finditer(text)) + [None]:
        start, end = (m.start(), m.end()) if m else (len(text), len(text))
        for seg, f in ((text[pos:start], font), (text[start:end], hindi)):
            if seg:
                d.text((x, y), seg, fill=fill, font=f)
                x += d.textlength(seg, font=f)
        pos = end


def _wrap(draw, text: str, font, width: int) -> list[str]:
    out = []
    for para in str(text).split("\n"):
        words, line = para.split(" "), ""
        for w in words:
            trial = (line + " " + w).strip()
            if draw.textlength(trial, font=font) <= width or not line:
                line = trial
            else:
                out.append(line)
                line = w
        out.append(line)
    return out


def _photo(draw, x, y, w, h):
    draw.rectangle([x, y, x + w, y + h], fill=(205, 205, 205), outline=(120, 120, 120))
    draw.ellipse([x + w * 0.3, y + h * 0.12, x + w * 0.7, y + h * 0.5], fill=(150, 150, 150))
    draw.chord([x + w * 0.15, y + h * 0.55, x + w * 0.85, y + h * 1.45], 180, 360, fill=(150, 150, 150))


def _qr(draw, x, y, s, rng):
    cells = 25
    c = s / cells
    draw.rectangle([x, y, x + s, y + s], fill="white")
    for i in range(cells):
        for j in range(cells):
            if rng.random() < 0.5:
                draw.rectangle([x + i * c, y + j * c, x + (i + 1) * c, y + (j + 1) * c], fill="black")


def render(doc: dict, rng: random.Random) -> Image.Image:
    reg_name, bold_name = rng.choice(families())
    if doc["kind"] == "card":
        return _render_card(doc, rng, reg_name, bold_name)
    W, M = 1240, rng.randint(70, 110)
    size = rng.randint(19, 23)
    reg, bold = _font(reg_name, size), _font(bold_name, size)
    small, title = _font(reg_name, size - 4), _font(bold_name, size + rng.randint(8, 13))
    cell = _font(reg_name, size - 3)
    cell_b = _font(bold_name, size - 3)
    accent = rng.choice(ACCENTS)
    img = Image.new("RGB", (W, 5000), "white")
    d = ImageDraw.Draw(img)
    y = M
    gap = rng.randint(6, 12)
    kv_col = M + int((W - 2 * M) * rng.uniform(0.36, 0.46))
    for style, text in doc["lines"]:
        if style == "head":
            h = size * 2 + 20
            d.rectangle([M - 20, y, W - M + 20, y + h], fill=accent)
            d.text((M, y + (h - size - 8) // 2), text, fill="white", font=_font(bold_name, size + 8))
            y += h + gap * 2
        elif style == "title":
            for line in _wrap(d, text, title, W - 2 * M):
                _text(d, ((W - d.textlength(line, font=title)) / 2, y), line, title, "black")
                y += title.size + gap
            y += gap
        elif style == "hi":
            f = _hindi_font(size + 2)
            if f is not None:
                _text(d, ((W - d.textlength(text, font=f)) / 2, y), text, f, "black")
                y += f.size + gap
        elif style in ("sub", "text", "small"):
            f = {"sub": bold, "text": reg, "small": small}[style]
            colour = (90, 90, 90) if style == "small" else "black"
            for line in _wrap(d, text, f, W - 2 * M):
                _text(d, (M, y), line, f, colour)
                y += f.size + gap
            y += gap // 2
        elif style == "kv":
            label, _, value = text.partition("\t")
            lab_lines = _wrap(d, label, bold if rng.random() < 0.3 else reg, kv_col - M - 15)
            val_lines = _wrap(d, value, reg, W - M - kv_col)
            for i in range(max(len(lab_lines), len(val_lines))):
                if i < len(lab_lines):
                    _text(d, (M, y), lab_lines[i], reg, "black")
                if i < len(val_lines):
                    _text(d, (kv_col, y), (": " if i == 0 and rng.random() < 0.5 else "") + val_lines[i], reg, "black")
                y += size + gap
        elif style in ("row", "rowh"):
            cells = [c.strip() for c in text.split("|")]
            cw = (W - 2 * M) / len(cells)
            f = cell_b if style == "rowh" else cell
            wrapped = [_wrap(d, c, f, cw - 10) for c in cells]
            h = max(len(w) for w in wrapped) * (f.size + 4) + 10
            if style == "rowh":
                d.rectangle([M, y, W - M, y + h], fill=(225, 225, 225))
            for i, lines in enumerate(wrapped):
                x0 = M + i * cw
                d.rectangle([x0, y, x0 + cw, y + h], outline=(110, 110, 110))
                for j, line in enumerate(lines):
                    _text(d, (x0 + 5, y + 5 + j * (f.size + 4)), line, f, "black")
            y += h
        elif style == "rule":
            d.line([M, y + gap, W - M, y + gap], fill=(80, 80, 80), width=2)
            y += 2 * gap
        elif style == "sign":
            y += gap * 3
            x = W - M - d.textlength(text, font=reg)
            d.line([x, y, W - M, y], fill="black", width=1)
            _text(d, (x, y + 4), text, reg, "black")
            y += size + gap * 2
        elif style == "qr":
            _qr(d, W - M - 150, y, 150, rng)
            y += 160
        elif style == "photo":
            _photo(d, W - M - 160, y, 160, 200)
            y += 210
    height = max(int(W * 1.414), y + M)
    return img.crop((0, 0, W, height))


def _render_card(doc, rng, reg_name, bold_name) -> Image.Image:
    W, H = 1012, 638
    bg = rng.choice([(223, 233, 245), (250, 235, 215), (245, 245, 240), (232, 245, 233), (255, 255, 255)])
    img = Image.new("RGB", (W, 1400), bg)
    d = ImageDraw.Draw(img)
    size = rng.randint(24, 28)
    reg, bold, small = _font(reg_name, size), _font(bold_name, size), _font(reg_name, size - 6)
    title = _font(bold_name, size + 8)
    has_photo = any(s == "photo" for s, _ in doc["lines"])
    has_qr = any(s == "qr" for s, _ in doc["lines"])
    photo_left = rng.random() < 0.5
    x0 = 270 if has_photo and photo_left else 40
    right = W - (260 if (has_photo and not photo_left) or has_qr else 40)
    y = 30
    for style, text in doc["lines"]:
        if style == "photo":
            _photo(d, 40 if photo_left else W - 240, 150, 200, 240)
            continue
        if style == "qr":
            _qr(d, W - 220, 380, 180, rng)
            continue
        if style == "hi":
            f = _hindi_font(size)
            if f is not None:
                _text(d, (x0, y), text, f, "black")
                y += f.size + 6
            continue
        f = {"title": title, "sub": bold, "small": small}.get(style, reg)
        if style == "kv":
            text = text.replace("\t", ": ")
        for line in _wrap(d, text, f, right - x0):
            _text(d, (x0, y), line, f, "black")
            y += f.size + 6
    return img.crop((0, 0, W, max(H, y + 30)))


# ---------------------------------------------------------------- make it look like an upload

def _perspective(img: Image.Image, rng: random.Random, strength: float) -> Image.Image:
    w, h = img.size
    jitter = lambda: rng.uniform(0, strength)  # noqa: E731
    src = [(w * jitter(), h * jitter()), (w * (1 - jitter()), h * jitter()),
           (w * (1 - jitter()), h * (1 - jitter())), (w * jitter(), h * (1 - jitter()))]
    dst = [(0, 0), (w, 0), (w, h), (0, h)]
    A, B = [], []
    for (x, y), (u, v) in zip(dst, src):
        A += [[x, y, 1, 0, 0, 0, -u * x, -u * y], [0, 0, 0, x, y, 1, -v * x, -v * y]]
        B += [u, v]
    coeffs = np.linalg.solve(np.array(A, float), np.array(B, float))
    return img.transform((w, h), Image.PERSPECTIVE, tuple(coeffs), Image.BICUBIC, fillcolor=(255, 255, 255))


def _jpeg(img: Image.Image, quality: int) -> Image.Image:
    buf = io.BytesIO()
    img.save(buf, "JPEG", quality=quality)
    buf.seek(0)
    return Image.open(buf).convert("RGB")


def degrade(img: Image.Image, rng: random.Random, level: str = "normal") -> Image.Image:
    """Make a clean render look like a phone photo or scan. level: 'normal' or 'hard'."""
    img = img.convert("RGB")
    hard = set()
    if level == "hard":
        hard = set(rng.sample(["crop", "blur", "lowres", "tilt", "dark"], k=rng.choice([1, 2])))
    if "crop" in hard:  # only part of the page in the photo
        w, h = img.size
        keep = rng.uniform(0.3, 0.5)
        top = 0 if rng.random() < 0.6 else rng.uniform(0, 1 - keep)
        img = img.crop((0, int(h * top), w, int(h * (top + keep))))
    scale = rng.uniform(0.42, 0.55) if "lowres" in hard else rng.uniform(0.75, 1.0)
    img = img.resize((int(img.width * scale), int(img.height * scale)), Image.LANCZOS)
    angle = rng.uniform(6, 12) * rng.choice([-1, 1]) if "tilt" in hard else rng.uniform(-2.5, 2.5)
    img = img.rotate(angle, expand=True, fillcolor=(255, 255, 255), resample=Image.BICUBIC)
    if rng.random() < 0.3:  # photographed on a table
        img = _perspective(img, rng, 0.04)
        pad = int(min(img.size) * rng.uniform(0.03, 0.08))
        table = Image.new("RGB", (img.width + 2 * pad, img.height + 2 * pad),
                          rng.choice([(110, 80, 60), (60, 60, 70), (150, 140, 120), (30, 30, 30)]))
        table.paste(img, (pad, pad))
        img = table
    img = ImageEnhance.Brightness(img).enhance(rng.uniform(0.45, 0.7) if "dark" in hard else rng.uniform(0.85, 1.1))
    img = ImageEnhance.Contrast(img).enhance(rng.uniform(0.75, 1.2))
    blur = rng.uniform(1.4, 2.2) if "blur" in hard else rng.uniform(0, 0.8)
    if blur > 0.1:
        img = img.filter(ImageFilter.GaussianBlur(blur))
    arr = np.asarray(img).astype(np.float32)
    arr += np.random.default_rng(rng.randint(0, 2**31)).normal(0, rng.uniform(0, 8), arr.shape)
    img = Image.fromarray(np.clip(arr, 0, 255).astype(np.uint8))
    return _jpeg(img, rng.randint(15, 35) if hard else rng.randint(40, 90))
