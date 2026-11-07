# Nirnay decision engine, real mode. Build from the repo root:
#   docker build -f backend/Dockerfile -t nirnay-engine .
# Run (every setting comes from the environment; see backend/DEPLOY.md):
#   docker run -p 8000:8000 -e DATABASE_URL=... -e NIRNAY_SMS_PROVIDER=twilio -e TWILIO_... nirnay-engine
# Needs about 1 GB of memory with every model loaded; give it 2 GB.
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 PIP_NO_CACHE_DIR=1 PIP_DISABLE_PIP_VERSION_CHECK=1
# OpenCV needs libGL and GLib; LightGBM needs OpenMP.
RUN apt-get update && apt-get install -y --no-install-recommends libgl1 libglib2.0-0 libgomp1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv
# Requirements first, so code changes don't reinstall everything.
COPY backend/requirements.txt backend/requirements.txt
COPY models/property_avm/requirements.txt models/property_avm/requirements.txt
COPY models/transaction_tagger/requirements.txt models/transaction_tagger/requirements.txt
COPY models/fraud_classifier/requirements.txt models/fraud_classifier/requirements.txt
COPY models/ocr/requirements.txt models/ocr/requirements.txt
COPY models/face_match/requirements.txt models/face_match/requirements.txt
COPY models/llm/requirements.txt models/llm/requirements.txt
COPY models/document_classifier/requirements.txt models/document_classifier/requirements.txt
COPY models/anomaly_detector/requirements.txt models/anomaly_detector/requirements.txt
COPY models/credit_challenger/requirements.txt models/credit_challenger/requirements.txt
COPY models/credit_scorecard/requirements.txt models/credit_scorecard/requirements.txt
RUN pip install -r backend/requirements.txt

COPY models models
COPY backend backend
# The translation phrasebook reads the app's reviewed sentences.
COPY app/lib/l10n app/lib/l10n
# Face-match and Hindi OCR weights (SHA-256 checked) and a fresh UN sanctions list.
RUN python -m backend.fetch

RUN useradd --create-home --uid 10001 nirnay && mkdir -p /srv/backend/var && chown -R nirnay /srv/backend/var
USER nirnay

ENV NIRNAY_SANDBOX=0 PORT=8000
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=5s --start-period=90s CMD python -c "import urllib.request,os; urllib.request.urlopen(f'http://127.0.0.1:{os.environ[\"PORT\"]}/v1/health', timeout=4)"
# One worker: the engine keeps applications in memory alongside the database.
CMD ["sh", "-c", "uvicorn backend.app:app --host 0.0.0.0 --port ${PORT} --workers 1 --proxy-headers"]
