# Model 11: LLM, one model with four jobs (model card)

| | |
|---|---|
| **Jobs** | **Deed reader** (facts and title issues from a sale deed), **file-note writer** (for officers on referred cases), **letter filler** (the plain-language paragraphs of customer letters), **customer assistant** (answers about the customer's own application) |
| **Model** | Claude Sonnet 5.5 through the Anthropic API (`claude-sonnet-5-5`; change with `NIRNAY_LLM_MODEL`) |
| **Calls** | `client.beta.messages.create` with **structured outputs** (`output_config.format` JSON schema), `effort` per job, and the API's server-side refusal fallback (`fallbacks="default"`, beta `server-side-fallback-2026-07-01`) |
| **Version** | `claude-sonnet-5-5+prompts-v1` |
| **Owner** | Compliance lead (prompts and test answers), backend member (code) |

## AI is never the final judge

Rules and validated models set every outcome. The LLM only reads and drafts, and code checks what it returns:

| Job | Effort | What code checks |
|---|---|---|
| Deed reader | high | Every fact and issue must **quote the deed word for word**. Each quote is searched for in the deed text (ignoring case, spacing and curly quotes). A fact that isn't found goes to `unverified`, and the deed is not clear. Any issue or unverified fact → **refer** to a lawyer (`R-PRP-01`). It can never reject. |
| File note | medium | Every fact must name an `evidence_key` that exists in the case; others are dropped (`dropped_facts`). It may not recommend an outcome. |
| Letter | low | The template holds the amounts, rate, Key Facts and legal lines. The LLM writes three paragraphs. A draft that mentions **any number not in the decision** is thrown away. |
| Assistant | low | Answers only from the application's facts and an approved FAQ, in at most 90 words. It can't change a decision, discuss fraud or screening checks, or promise approval. It hands over to a person when unsure. |

Document text, case JSON and customer questions go inside tags (`<deed>`, `<case>`, `<question>`), and the system prompts say to treat them as data, not instructions.

## Without an API key

Each job falls back to deterministic offline rules, and the result says `engine: "offline"` with the reason:
- **Deed reader:** keyword rules find a few facts (document number, consideration, survey number) and red-flag phrases ("Late Shri", "legal heirs", "power of attorney", an active mortgage), each with its sentence as the quote. It cannot confirm a title chain; the property gate also checks land records.
- **File note:** built from the gate results and the reason catalogue.
- **Letter:** fixed sentences per letter type, plus the reviewed reason sentences.
- **Assistant:** FAQ matching with rapidfuzz.

A refusal, a rate limit or a network error also falls back offline for that call.

## Credentials

The SDK reads `ANTHROPIC_API_KEY` (or `ANTHROPIC_AUTH_TOKEN`). To use an `ant auth login` profile instead, set `NIRNAY_LLM=on`. `NIRNAY_LLM=off` forces offline mode. **Never commit a key**: `.gitignore` already ignores `.env` files.

## Checks (`tests/test_llm.py`)

- A fake client returns a deed reading with one invented quote: it lands in `unverified` and the deed is referred.
- A grounded, clean deed passes; deed text is fenced in `<deed>` tags.
- The offline reader finds the deceased co-owner in Meena's sample deed, and nothing in a clean deed.
- A letter draft with a new number is thrown away; one without is kept.
- File-note facts without evidence are dropped.
- **SDK wiring:** the real Anthropic SDK builds the request against a mock HTTP transport (no network, no key). The test checks the model id, `fallbacks: "default"`, the beta header, the JSON schema format and the effort level, and that a `refusal` stop falls back offline.

**Not yet done:** a run against the live API. The model table's check (answers compared by hand on 3–5 sample deeds) needs a key with a small budget. Run the engine with `ANTHROPIC_API_KEY` set and upload the sample sale deeds from `/v1/sandbox/personas/{ravi|meena}/documents/saleDeed`.
