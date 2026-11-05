# Nirnay customer app (Flutter)

The customer's side of Nirnay: apply for a **Home Loan** or a **Loan Against Property** on the phone and get a decision in minutes, with reasons, in **English and Hindi**. It follows the report's app design (section "One engine, two front doors") and its three demo cases.

**Status:** all screens are built and tested against a **sample engine** (`lib/services/mock_api.dart`). The real FastAPI engine plugs in behind the same interface (`lib/services/api.dart`) without changing any screen. The app shows a "Demo mode" banner until then.

## The flow

| Step | Screen | What happens |
|---|---|---|
| – | Welcome | Choose Home Loan or LAP. In demo mode, tap a demo customer to fill in their mobile number. |
| 1 | Sign in | Mobile OTP. The phone gets a random device id, kept on the phone, which the engine binds to the account. |
| 2 | Consent | Plain-language consent for each data pull, plus the DPDP privacy notice (what, why, how long, your rights). Nothing is fetched before this. See the list below. |
| 3 | Your details | Auto-filled from PAN, eKYC and the bank data, then a **quick eligibility check** that updates as you move the sliders. |
| 4 | Selfie | The engine checks passive liveness and a 1:1 match with the Aadhaar photo. If that fails, the customer is offered video KYC. |
| 5 | Documents | Camera or gallery. Each photo is checked **on the phone** for blur, glare and darkness, then the engine reads it: OCR plus the document classifier (model 6). |
| 6 | In-principle decision | Approve, Refer or Reject, the amount, the EMI, and the **reasons**, with the Key Facts Statement and a grievance link. |
| 7 | Property | Property details and **geo-tagged photos** (front, inside, view), then the final sanction: valuation (model 7) and title checks. |

The consent screen covers:
- the credit bureau check
- 12 months of bank statements through the Account Aggregator
- Aadhaar eKYC and PAN

The quick eligibility check (step 3) follows the report's policy (`lib/policy.dart`):
- **FOIR caps:** 45%, 50% or 60%, by income
- **Home Loan LTV:** RBI's 90%, 80% or 75% tiers
- **LAP LTV:** 60%
- **Rates:** 8.75% for Home Loans, 10.50% for LAP
- **Maximum tenure:** 30 years for Home Loans, 15 for LAP

The Key Facts Statement shows the APR including the fee, and the 3-day cooling-off period.

## The report's three demo cases

The people are fictional. Use OTP **123456**.

| Mobile | Customer | Result |
|---|---|---|
| 98765 00001 | Ravi, 32, salaried: ₹45 lakh Home Loan on a ₹60 lakh flat | **Approved in principle:** ₹45,00,000, EMI ₹39,767 for 20 years at 8.75%. Then **sanctioned** after the property step. Same numbers as the report's worked example. |
| 98765 00002 | Meena, 45, runs a garment shop: ₹60 lakh LAP on a ₹1.2 crore property | **Approved in principle**, then **referred**: "Our lawyer needs to review the property title." |
| 98765 00003 | Arjun, 29, salaried: edited salary slip | **Rejected:** "One of your documents failed verification with the issuing authority." The customer can still ask for a review. |

Every camera step has a **Sample** button, so you can try the whole flow on a laptop.

## Reasons the customer sees

Reasons use the report's reason codes, worded for the customer in both languages (`lib/reasons.dart`). **The code itself (such as `R-FRD-03`) is never shown to the customer**, so a fraud check isn't revealed. Staff see the codes in the portal.

## Run it

You need Flutter 3.47 (stable). On the build PC it's Flutter 3.47.8 at `K:\tools\flutter`, with `K:\tools\flutter\bin` on the PATH.

```bash
cd app
```
```bash
flutter pub get
```
In Chrome:
```bash
flutter run -d chrome
```
On an Android phone (USB debugging on) or the emulator:
```bash
flutter run
```
To build an Android app file:
```bash
flutter build apk --debug
```

**Tests:** 15 tests, run with `flutter test`.
- **Policy maths:** the report's worked example to the rupee: ₹45.26 lakh by income, ₹48 lakh by property, EMI ₹39,767, FOIR 49.8%, LTV 75%. Also the FOIR and LTV tiers, and the KFS APR.
- **Photo checks:** blur, glare (but not a white scan background), darkness, and unreadable files.
- **Full flows:** Ravi (approved, then sanctioned), Meena (referred) and Arjun (rejected), tapped through every screen. Plus the switch to Hindi.

## Files

| Path | What |
|---|---|
| `lib/main.dart` | App, theme, routes, English/Hindi |
| `lib/state.dart` | Everything the customer has entered so far |
| `lib/policy.dart` | Eligibility maths (FOIR, LTV tiers, EMI) |
| `lib/services/api.dart` | The calls to the engine; the mock and the future HTTP client both implement it |
| `lib/services/mock_api.dart` | Sample engine with the three demo cases |
| `lib/services/image_checks.dart` | On-phone blur, glare and darkness checks (pure Dart) |
| `lib/services/capture.dart` | Camera, gallery, location, and the demo sample images |
| `lib/l10n/app_en.arb`, `app_hi.arb` | Every string, in English and Hindi |
| `lib/screens/` | The eight screens |
| `test/` | Policy, photo-check and full-flow tests |

**Windows note:** `android/gradle.properties` turns off Kotlin's incremental compiling. Flutter's package cache defaults to C:, and the Kotlin compiler fails when that cache and the project are on different drives. To keep everything on one drive, set the `PUB_CACHE` environment variable to a folder on the project's drive. On the build PC it's `K:\tools\pub-cache`.

## Next steps

- **Connect the real engine.** Write `HttpNirnayApi` against the FastAPI service once it exists. The OTP, eKYC, bureau and AA steps stay mocked until licensed sandboxes are in place.
- **Live camera:** a guided document frame with live blur and glare hints (the `camera` package), and an on-device face check before upload.
- **Payments and signing:** eSign, eNACH or UPI AutoPay, and the KFS PDF.
- **More languages:** Bhashini for dynamic text, and more Indian languages.
