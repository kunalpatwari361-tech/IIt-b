# Nirnay customer app (Flutter)

The customer's side of Nirnay: apply for a **Home Loan** or a **Loan Against Property** on the phone and get a decision in minutes, with reasons, in **English and all 22 languages of the Eighth Schedule**. It follows the report's app design (section "One engine, two front doors") and its three demo cases.

**Status:** all screens are built. The app runs on its built-in **sample engine** (`lib/services/mock_api.dart`), or on the **real decision engine** ([backend/](../backend/README.md), all 12 models) through `lib/services/http_api.dart`, behind the same interface (`lib/services/api.dart`). The engine still uses sandbox data sources, so the "Demo mode" banner stays.

## The flow

| Step | Screen | What happens |
|---|---|---|
| – | Welcome | Dark "Aurora" home: a 3D loan card you can tilt, every language to pick from, EMI and eligibility calculators, and (once signed in) the live checks and a Resume card. In demo mode, tap a demo customer to fill in their mobile number. |
| 1 | Sign in | Mobile OTP. The phone gets a random device id, kept on the phone, which the engine binds to the account. |
| 2 | Consent | Plain-language consent for each data pull, plus the DPDP privacy notice (what, why, how long, your rights). Nothing is fetched before this. Each needed consent shows when it was given and when it ends, and has its own options: months of bank statements (6, 12 or 24) and which accounts to share, the KYC method (Aadhaar OTP, DigiLocker or video KYC), using an existing CKYC record, and one more credit check before payout. Optional consents (offers by SMS, email or WhatsApp; loan updates on WhatsApp; an insurance quote) start off. **Manage consents** (here and on the decision screen) switches optional ones off, withdraws a needed one (which stops the application and deletes what was fetched), and shows the consent history. |
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

### Run it on the real engine

Start the engine first (see [backend/README.md](../backend/README.md)), then:
```bash
flutter run -d chrome --dart-define=NIRNAY_API_URL=http://127.0.0.1:8000
```
Without `NIRNAY_API_URL` the app uses the sample engine. With it:
- The consent choices go to the engine before anything is fetched (`PUT /consents`), and later changes in **Manage consents** are sent too.
- The document **Sample** buttons fetch the signed-in person's sandbox documents from the engine, so real OCR and model 6 read real-looking papers. The property **Sample** buttons get a stand-in photo that differs per application, so the reuse check doesn't fire.
- **Take a real selfie** (the laptop camera is fine). The sample selfie is a drawing, and the engine's face detector rightly finds no face in it.
- Property photos need their location: allow location in the browser, or the final sanction refers for a valuer visit (`R-PRP-03`).
- The selfie screen shows "Photo match: done when you upload your Aadhaar or PAN card" until the engine has an ID photo with a face. The sandbox's sample cards have no face, so in demos the match stays pending.

On an Android emulator the engine is at `http://10.0.2.2:8000`.

**On a real phone over USB** (tested on a Galaxy Z Flip3, Android 15):
```bash
adb reverse tcp:8000 tcp:8000
```
```bash
flutter build apk --release --dart-define=NIRNAY_API_URL=http://127.0.0.1:8000
```
```bash
adb install -r build/app/outputs/flutter-apk/app-release.apk
```
`adb reverse` makes the phone's own `127.0.0.1:8000` reach the engine on the laptop. Android blocks plain `http://`, so `android/app/src/main/res/xml/network_security_config.xml` allows it only for `127.0.0.1`, `localhost` and `10.0.2.2`; every other host still needs HTTPS. Run `adb reverse` again whenever the phone is reconnected.

**Tests:** 26 tests, run with `flutter test`.
- **Policy maths:** the report's worked example to the rupee: ₹45.26 lakh by income, ₹48 lakh by property, EMI ₹39,767, FOIR 49.8%, LTV 75%. Also the FOIR and LTV tiers, and the KFS APR.
- **Photo checks:** blur, glare (but not a white scan background), darkness, and unreadable files.
- **Full flows:** Ravi (approved, then sanctioned), Meena (referred) and Arjun (rejected), tapped through every screen, including the document AI view after each upload. Ravi also shapes a smaller offer, which the final sanction then uses. Plus the EMI calculator, resuming from Home, the switch to Hindi, picking each of the 23 languages (Urdu and Kashmiri switch to right to left), choosing consent options and seeing them in the history, and withdrawing a needed consent from the decision screen.
- **HTTP client:** the engine's JSON for sign-in, consent, profile, selfie, documents, both decisions and samples, parsed into the app's models; headers and multipart uploads checked; engine errors become `ApiException` codes.

## Languages

English plus the 22 languages of the Eighth Schedule, each named in its own script on the welcome screen and in the language button on every other screen. Flutter's own widgets (date pickers, back-button labels) don't cover Bodo, Dogri, Kashmiri, Konkani, Maithili, Manipuri, Sanskrit, Santali or Sindhi, so those borrow the nearest covered language (`lib/languages.dart`); Kashmiri and Sindhi borrow Urdu, which also makes them right to left. **Only English and Hindi have been reviewed.** The rest need a native speaker's check before launch.

## Files

| Path | What |
|---|---|
| `lib/main.dart` | App, routes, languages |
| `lib/theme.dart` | Colours, fonts and the Aurora palette of the welcome screen |
| `lib/languages.dart` | The 23 languages, their fonts, and the stand-ins for the 9 Flutter doesn't cover |
| `lib/state.dart` | Everything the customer has entered so far |
| `lib/policy.dart` | Eligibility maths (FOIR, LTV tiers, EMI) |
| `lib/services/api.dart` | The calls to the engine; the sample engine and the HTTP client both implement it |
| `lib/services/http_api.dart` | Calls the real decision engine (`--dart-define=NIRNAY_API_URL=...`) |
| `lib/services/mock_api.dart` | Sample engine with the three demo cases |
| `lib/services/image_checks.dart` | On-phone blur, glare and darkness checks (pure Dart) |
| `lib/services/capture.dart` | Camera, gallery, location, and the demo sample images |
| `lib/l10n/app_*.arb` | Every string, in each of the 23 languages |
| `assets/fonts/` | Noto fonts for every script (SIL Open Font License, `OFL.txt`) |
| `lib/screens/` | The screens, plus the offer builder (`offer_screen.dart`) and the document AI view (`doc_read_screen.dart`) |
| `test/` | Policy, photo-check and full-flow tests |

**Windows note:** `android/gradle.properties` turns off Kotlin's incremental compiling. Flutter's package cache defaults to C:, and the Kotlin compiler fails when that cache and the project are on different drives. To keep everything on one drive, set the `PUB_CACHE` environment variable to a folder on the project's drive. On the build PC it's `K:\tools\pub-cache`.

## Next steps

- **Real data sources.** The app now talks to the real engine, but the engine's OTP, eKYC, bureau and AA steps are still sandbox stand-ins until licensed sandboxes are in place.
- **Live camera:** a guided document frame with live blur and glare hints (the `camera` package), and an on-device face check before upload.
- **Payments and signing:** eSign, eNACH or UPI AutoPay, and the KFS PDF.
- **Get the translations checked.** English and Hindi are reviewed; the other 21 were written for this demo and need a native speaker before real customers see them, above all Bodo, Kashmiri, Manipuri (in Bengali script; Meitei Mayek is also official) and Santali (Ol Chiki). Bhashini can cover dynamic text.
