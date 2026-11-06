# Model 12: Translation (model card)

| | |
|---|---|
| **Job** | Turns customer-facing text from the engine (letters, help-assistant answers) into Hindi and the other 21 scheduled Indian languages the app offers |
| **Engines, in order** | 1. **IndicTrans2** (AI4Bharat, MIT) on this machine · 2. **Bhashini** (Government of India API) · 3. **Claude** (model 11) · 4. the **phrasebook** |
| **Languages** | The app's 22: `hi bn mr te ta gu ur kn or ml pa as mai sat ks ne kok sd doi mni brx sa`, mapped to IndicTrans2's FLORES codes (`hin_Deva`, `sat_Olck`, `mni_Beng`, ...) |
| **Owner** | Backend member; native speakers review |

## How it works

`translate(texts, lang)` tries each engine that is set up, in order. Texts an engine can't do go to the next one.

- **Numbers must survive.** Every translation's numbers are compared with the English, after turning Indian-script digits (०१२, ௧௨௩) into 0–9. An engine that changes an amount or a rate is skipped for that text (`skipped: numbers_changed`).
- **The phrasebook** is the app's reviewed sentences in `app/lib/l10n/app_*.arb`, matched exactly. Reason codes therefore read the same in the letter as on the decision screen, with no engine at all. Anything else stays in English and is counted in `untranslated`.
- The response always says which engines ran.

## Setting up each engine

**IndicTrans2** (`ai4bharat/indictrans2-en-indic-dist-200M`, about 1.2 GB): the weights are **gated** on Hugging Face, so a team member must accept the model's terms there once. Then:

```bash
.venv/Scripts/python -m pip install "transformers>=4.40,<5" sentencepiece IndicTransToolkit
huggingface-cli download ai4bharat/indictrans2-en-indic-dist-200M --local-dir models/translation/weights/indictrans2-en-indic-dist-200M
```

Keep `HF_HOME` on K:. The folder is git-ignored.

**Bhashini:** sign up at bhashini.gov.in, then set `BHASHINI_USER_ID` and `BHASHINI_ULCA_API_KEY`.

**Claude:** works whenever model 11 has credentials.

## Status

| Engine | Status |
|---|---|
| Phrasebook | **Working**, tested |
| IndicTrans2 | **Code written from the model card; not run.** It needs the gated weights. |
| Bhashini | **Code written from Bhashini's published pipeline API; not run.** It needs keys. |
| Claude | Works through model 11's tested client; not run live (no key here) |

`tests/test_translate.py` covers the phrasebook, every app language having a code, the Indian-digit check, skipping an engine that changes a number, and handing over when an engine fails.

## Limits

The model table's check is **native-speaker review**. That hasn't happened for any engine's output, nor for 21 of the app's 23 language files (only English and Hindi were reviewed). Bodo, Kashmiri, Manipuri and Santali are rough drafts.
