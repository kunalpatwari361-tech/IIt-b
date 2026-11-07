# Deploying Nirnay for real users

Three accounts are yours to create: **Supabase** (the database), **Twilio** (SMS codes) and **Render** (the server). Each gives you keys. Paste them only into Render's environment settings, never into code, chat or git. Then build the shareable APK with the server's address.

Real mode means:
- **Sign-in:** real phone numbers get a real SMS code. There's no demo code.
- **Applicant's details:** the applicant types their own details. Every typed fact is marked *self-declared* in the decision record.
- **Documents:** real documents prove what was typed. OCR and model 6 read every upload. The selfie is matched to the face on the PAN or Aadhaar card. Model 5 reads the bank statement, and the deed reader reads the sale deed.
- **Storage:** every step is saved to Supabase as it happens. Aadhaar images are never stored; only the masked number (XXXX XXXX 1234) and the checks are kept.

## 1. Database: Supabase

1. Create a project at supabase.com. Pick the **Mumbai (ap-south-1)** region and set a strong database password.
2. Open **Connect**, then **Session pooler**, and copy the connection string. It looks like `postgresql://postgres.<project-ref>:<password>@aws-1-ap-south-1.pooler.supabase.com:5432/postgres`. Use the session pooler: Render can reach only IPv4 addresses, and Supabase's direct connection is IPv6.
3. That string is `DATABASE_URL`. Percent-encode any `@ # ? &` or spaces in the password.

On its first start, the engine creates its tables in a schema called `nirnay`:
- `applications`, `sessions`, `otps`, `consent_events`, `documents` and `decision_records`;
- RLS is turned on for every table, and Supabase's `anon` and `authenticated` roles get no access;
- the schema isn't served by the Data API, so the publishable key can't read applicants' data.

To watch applications arrive, open **Table Editor**, pick the `nirnay` schema, and open `applications`. Each row updates as the applicant moves through the app.

## 2. SMS codes: Twilio Verify (or MSG91)

**Twilio Verify:**
1. Create a Twilio account.
2. Under **Verify**, then **Services**, create a service and note its SID (`VA...`).
3. Note your **Account SID** (`AC...`) and **Auth Token**.
4. On a trial account, Twilio sends only to numbers you've verified in the console. Add your testers' numbers there, or upgrade.
5. Check Twilio's India SMS rules when you sign up (DLT).

Set `NIRNAY_SMS_PROVIDER=twilio`, `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN` and `TWILIO_VERIFY_SERVICE_SID`.

**MSG91** (India): needs a DLT-registered OTP template. Set `NIRNAY_SMS_PROVIDER=msg91`, `MSG91_AUTH_KEY` and `MSG91_TEMPLATE_ID`.

**Limits:** the engine allows 3 codes per number every 15 minutes and 5 tries per code. Codes are checked by the provider, so the engine never sees them.

## 3. The server: Render

The engine needs about **1 GB of memory**, so use the **Standard** plan (2 GB). The free and Starter plans have 512 MB, which is too small.

1. Push this repo to GitHub (already done for `main`).
2. In Render, choose **New**, then **Blueprint**, and pick the repo. `render.yaml` sets up the service: a Docker image from `backend/Dockerfile` in Singapore, with health checks on `/v1/health`.
3. Fill in the secrets Render asks for: `DATABASE_URL`, the Twilio keys, and optionally `ANTHROPIC_API_KEY`. `NIRNAY_STAFF_KEY` is generated for you; copy it from the dashboard for staff calls.
4. Deploy. The first build takes about 10 minutes, because it installs the models and downloads the face-match and Hindi OCR weights.
5. Open `https://<your-service>.onrender.com/v1/health`. You should see `"mode": "real"`, `"database": "postgresql"` and `"sms": "twilio"`.

**Other hosts:** the same image runs anywhere that runs Docker with 2 GB of memory, such as Railway, Fly.io or a VPS. Set the same variables. Run a single instance, because the engine also keeps applications in memory.

**Free option:** a Hugging Face Space with the Docker SDK has 16 GB of memory. Set `app_port: 8000` in the Space's README, add the variables as Space secrets, and push `backend/`, `models/` and `app/lib/l10n/` with the Dockerfile at the Space's root. It sleeps after 48 hours without visits and takes about a minute to wake.

## 4. The shareable APK

Once the health check shows real mode, build the app against that address:

```bash
cd app
```
```bash
flutter build apk --release --dart-define=NIRNAY_API_URL=https://<your-service>.onrender.com --dart-define=NIRNAY_REAL=true
```

- **Output:** `build/app/outputs/flutter-apk/app-release.apk`, about 60 MB. It works on any Android 7+ phone, on arm64, arm32 or x86_64.
- **Signing:** the APK is signed with the release key in `K:\tools\nirnay-signing\`. **Back up that folder.** A later APK installs over the old one only if it's signed with the same key.
- **Installing:** testers open the APK file and allow "Install unknown apps" for their file manager or browser.
- **Demo extras:** a real-mode build has none: no demo people, sample buttons, demo code or demo banner.

## 5. Before inviting testers

- **Real personal data:** you are now holding PAN, income, bank statements and selfies, which is sensitive personal data under the DPDP Act 2023.
  - Tell testers what is collected and why. The app's consent screen covers this.
  - Keep the Supabase project's access to yourselves.
  - Delete the data when testing ends: in Supabase, run `drop schema nirnay cascade;`.
- **Not yet built:** document files are kept so officers can review referred cases (`NIRNAY_STORE_FILES=0` turns that off), but there is no officer screen to view them yet. Use the staff API with `X-Staff-Key`:
  - `GET /v1/staff/applications`
  - `/records`
  - `/file-note`
- **Unverified facts:** with no bureau or Account Aggregator connection, credit scores are self-declared.
  - Without a credit history, the scorecard approves only at lower LTVs (about 66% or less).
  - Higher LTVs come out as Refer.
  - Decisions are for testing, not real lending.
