// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kannada (`kn`).
class AppLocalizationsKn extends AppLocalizations {
  AppLocalizationsKn([String locale = 'kn']) : super(locale);

  @override
  String get appTitle => 'ನಿರ್ಣಯ್';

  @override
  String get sandboxBanner => 'ಡೆಮೊ ಮೋಡ್: ಮಾದರಿ ಮಾಹಿತಿ, ನಿಜವಾದ ಪರಿಶೀಲನೆ ಅಲ್ಲ';

  @override
  String get continueLabel => 'ಮುಂದುವರಿಸಿ';

  @override
  String stepOf(String step, String total) {
    return 'ಹಂತ $step / $total';
  }

  @override
  String get pleaseWait => 'ದಯವಿಟ್ಟು ಕಾಯಿರಿ…';

  @override
  String get errorGeneric => 'ಏನೋ ತಪ್ಪಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get close => 'ಮುಚ್ಚಿ';

  @override
  String get welcomeHeadline => 'ಕೆಲವೇ ನಿಮಿಷಗಳಲ್ಲಿ ನಿಮ್ಮ ಗೃಹ ಸಾಲದ ನಿರ್ಧಾರ';

  @override
  String get welcomeBody =>
      'ಗೃಹ ಸಾಲ ಅಥವಾ ಆಸ್ತಿಯ ಮೇಲಿನ ಸಾಲಕ್ಕೆ ಅರ್ಜಿ ಸಲ್ಲಿಸಿ. ನಾವು ಎಲ್ಲವನ್ನೂ ಆನ್‌ಲೈನ್‌ನಲ್ಲಿ ಪರಿಶೀಲಿಸುತ್ತೇವೆ ಮತ್ತು ನಿರ್ಧಾರದ ಕಾರಣವನ್ನು ಯಾವಾಗಲೂ ತಿಳಿಸುತ್ತೇವೆ.';

  @override
  String get chooseProduct => 'ನಿಮಗೆ ಏನು ಬೇಕು?';

  @override
  String get productHomeLoan => 'ಗೃಹ ಸಾಲ';

  @override
  String get productHomeLoanSub => 'ಮನೆ ಖರೀದಿ, ನಿರ್ಮಾಣ ಅಥವಾ ನವೀಕರಣ';

  @override
  String get productLap => 'ಆಸ್ತಿಯ ಮೇಲಿನ ಸಾಲ';

  @override
  String get productLapSub => 'ನಿಮ್ಮ ಸ್ವಂತ ಆಸ್ತಿಯ ಮೇಲೆ ಸಾಲ ಪಡೆಯಿರಿ';

  @override
  String get startApplication => 'ಅರ್ಜಿ ಪ್ರಾರಂಭಿಸಿ';

  @override
  String get demoCustomers => 'ಡೆಮೊ ಗ್ರಾಹಕರು';

  @override
  String get demoCustomersBody =>
      'ಮಾದರಿ ಮೊಬೈಲ್ ಸಂಖ್ಯೆ ತುಂಬಲು ಒಂದನ್ನು ಟ್ಯಾಪ್ ಮಾಡಿ.';

  @override
  String get personaRavi => 'ರವಿ, 32, ಸಂಬಳದಾರ, ಫ್ಲಾಟ್ ಖರೀದಿಸುತ್ತಿದ್ದಾರೆ';

  @override
  String get personaMeena => 'ಮೀನಾ, 45, ಬಟ್ಟೆ ಅಂಗಡಿ ನಡೆಸುತ್ತಾರೆ (LAP)';

  @override
  String get personaArjun => 'ಅರ್ಜುನ್, 29, ಸಂಬಳದಾರ, ಬದಲಾಯಿಸಿದ ಸಂಬಳ ಚೀಟಿ';

  @override
  String get signInTitle => 'ಸೈನ್ ಇನ್';

  @override
  String get mobileLabel => 'ಮೊಬೈಲ್ ಸಂಖ್ಯೆ';

  @override
  String get mobileHint => '10 ಅಂಕಿಯ ಮೊಬೈಲ್ ಸಂಖ್ಯೆ';

  @override
  String get invalidMobile => 'ಸರಿಯಾದ 10 ಅಂಕಿಯ ಮೊಬೈಲ್ ಸಂಖ್ಯೆ ನಮೂದಿಸಿ.';

  @override
  String get sendOtp => 'OTP ಕಳುಹಿಸಿ';

  @override
  String otpSentTo(String phone) {
    return '$phone ಗೆ 6 ಅಂಕಿಯ ಕೋಡ್ ಕಳುಹಿಸಿದ್ದೇವೆ.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'ಪರಿಶೀಲಿಸಿ';

  @override
  String get demoOtp => 'ಡೆಮೊ ಕೋಡ್: 123456';

  @override
  String get wrongOtp => 'ಕೋಡ್ ತಪ್ಪಾಗಿದೆ. ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get deviceBound =>
      'ಈ ಫೋನ್ ಈಗ ನಿಮ್ಮ ಖಾತೆಗೆ ಜೋಡಣೆಯಾಗಿದೆ. ಬೇರೆ ಫೋನ್‌ನಲ್ಲಿ ಸೈನ್ ಇನ್ ಮಾಡಲು ಹೊಸ OTP ಬೇಕು.';

  @override
  String get consentTitle => 'ನಿಮ್ಮ ಸಮ್ಮತಿ';

  @override
  String get consentIntro =>
      'ನಿಮ್ಮ ಮಾಹಿತಿಯನ್ನು ಈ ಸಾಲದ ನಿರ್ಧಾರ ಮತ್ತು ನಿರ್ವಹಣೆಗೆ ಮಾತ್ರ ಬಳಸುತ್ತೇವೆ. ನೀವು ಯಾವಾಗ ಬೇಕಾದರೂ ಸಮ್ಮತಿ ಹಿಂಪಡೆಯಬಹುದು.';

  @override
  String get consentBureauTitle => 'ಕ್ರೆಡಿಟ್ ವರದಿ';

  @override
  String get consentBureauBody =>
      'ಕ್ರೆಡಿಟ್ ಬ್ಯೂರೋ (CIBIL, Experian, Equifax ಅಥವಾ CRIF) ನಲ್ಲಿ ನಿಮ್ಮ ಕ್ರೆಡಿಟ್ ಇತಿಹಾಸ ಪರಿಶೀಲಿಸುತ್ತೇವೆ. ಇದರಿಂದ ನಿಮ್ಮ ಸ್ಕೋರ್ ಕಡಿಮೆಯಾಗುವುದಿಲ್ಲ.';

  @override
  String get consentAaTitle => 'ಅಕೌಂಟ್ ಅಗ್ರಿಗೇಟರ್ ಮೂಲಕ ಬ್ಯಾಂಕ್ ಸ್ಟೇಟ್‌ಮೆಂಟ್';

  @override
  String get consentAaBody =>
      'RBI ಪರವಾನಗಿ ಪಡೆದ ಅಕೌಂಟ್ ಅಗ್ರಿಗೇಟರ್ ಮೂಲಕ ನಿಮ್ಮ ಬ್ಯಾಂಕಿನ 12 ತಿಂಗಳ ಸ್ಟೇಟ್‌ಮೆಂಟ್ ಪಡೆಯುತ್ತೇವೆ. ವಿನಂತಿಯನ್ನು ನೀವು ನಿಮ್ಮ AA ಆ್ಯಪ್‌ನಲ್ಲಿ ಅನುಮೋದಿಸುತ್ತೀರಿ.';

  @override
  String get consentKycTitle => 'ಆಧಾರ್ eKYC ಮತ್ತು PAN';

  @override
  String get consentKycBody =>
      'UIDAI ಮತ್ತು ಆದಾಯ ತೆರಿಗೆ ಇಲಾಖೆಯೊಂದಿಗೆ ನಿಮ್ಮ ಗುರುತನ್ನು ದೃಢೀಕರಿಸುತ್ತೇವೆ. ಮರೆಮಾಡಿದ ಆಧಾರ್ ಸಂಖ್ಯೆಯನ್ನು ಮಾತ್ರ ಇಡುತ್ತೇವೆ.';

  @override
  String get consentPrivacyTitle => 'ಗೌಪ್ಯತಾ ಸೂಚನೆ (DPDP ಕಾಯ್ದೆ 2023)';

  @override
  String get consentPrivacyBody =>
      'ಏನು ಸಂಗ್ರಹಿಸುತ್ತೇವೆ: ಗುರುತು, ಆದಾಯ, ಬ್ಯಾಂಕ್ ಮತ್ತು ಆಸ್ತಿ ವಿವರಗಳು. ಏಕೆ: ನಿಮ್ಮ ಸಾಲದ ನಿರ್ಧಾರ ಮತ್ತು ನಿರ್ವಹಣೆಗೆ. ಎಷ್ಟು ಕಾಲ: ಕಾನೂನು ಕೇಳುವಷ್ಟು ಕಾಲ ಮಾತ್ರ. ನಿಮ್ಮ ಹಕ್ಕುಗಳು: ಮಾಹಿತಿ ನೋಡುವುದು, ತಿದ್ದುವುದು ಅಥವಾ ಅಳಿಸುವುದು, ಮತ್ತು ನಮ್ಮ ಕುಂದುಕೊರತೆ ಅಧಿಕಾರಿ ಅಥವಾ ಡೇಟಾ ಸಂರಕ್ಷಣಾ ಮಂಡಳಿಗೆ ದೂರು ನೀಡುವುದು.';

  @override
  String get consentRequired => 'ಕಡ್ಡಾಯ';

  @override
  String get consentNeeded => 'ಮುಂದುವರಿಯಲು ಎಲ್ಲಕ್ಕೂ ಸಮ್ಮತಿಸಿ.';

  @override
  String get agreeAndContinue => 'ಸಮ್ಮತಿಸಿ ಮುಂದುವರಿಸಿ';

  @override
  String get detailsTitle => 'ನಿಮ್ಮ ವಿವರಗಳು';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'ಸರಿಯಾದ PAN ನಮೂದಿಸಿ, ಉದಾ. ABCDE1234F.';

  @override
  String get fetchDetails => 'ನನ್ನ ವಿವರಗಳನ್ನು ತನ್ನಿ';

  @override
  String get fetchedFrom =>
      'PAN, ಆಧಾರ್ eKYC ಮತ್ತು ಬ್ಯಾಂಕ್ ಸ್ಟೇಟ್‌ಮೆಂಟ್‌ನಿಂದ ತುಂಬಲಾಗಿದೆ. ತಿದ್ದಲು ಅಂಕಿಯ ಮೇಲೆ ಟ್ಯಾಪ್ ಮಾಡಿ.';

  @override
  String get nameLabel => 'ಹೆಸರು';

  @override
  String get dobLabel => 'ಹುಟ್ಟಿದ ದಿನಾಂಕ';

  @override
  String get employmentLabel => 'ಕೆಲಸ';

  @override
  String get salaried => 'ಸಂಬಳದಾರ';

  @override
  String get selfEmployed => 'ಸ್ವಉದ್ಯೋಗಿ';

  @override
  String get incomeLabel => 'ಮಾಸಿಕ ನಿವ್ವಳ ಆದಾಯ';

  @override
  String get existingEmiLabel => 'ಈಗಿನ ಮಾಸಿಕ EMI';

  @override
  String get propertyValueLabel => 'ಆಸ್ತಿ ಮೌಲ್ಯ';

  @override
  String get loanAmountLabel => 'ಸಾಲದ ಮೊತ್ತ';

  @override
  String get tenureLabel => 'ಅವಧಿ';

  @override
  String yearsLabel(String n) {
    return '$n ವರ್ಷಗಳು';
  }

  @override
  String get eligibleTitle => 'ನಿಮಗೆ ಗರಿಷ್ಠ ಸಿಗುವುದು';

  @override
  String emiPerMonth(String amount) {
    return 'ತಿಂಗಳಿಗೆ EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'ವರ್ಷಕ್ಕೆ $rate%, ಬದಲಾಗುವ ಬಡ್ಡಿ (ಉದಾಹರಣೆ)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'ಆದಾಯದ ಮಿತಿ: ನಿಮ್ಮ ಎಲ್ಲಾ EMI ಸೇರಿ ಆದಾಯದ $pct ವರೆಗೆ ಇರಬಹುದು.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'ಆಸ್ತಿಯ ಮಿತಿ: ಈ ಗಾತ್ರದ ಸಾಲ ಮೌಲ್ಯದ $pct ವರೆಗೆ ಇರಬಹುದು.';
  }

  @override
  String get limitedByAsked => 'ಇದು ನೀವು ಕೇಳಿದ ಮೊತ್ತ.';

  @override
  String get eligibilityNote =>
      'ನಿಮ್ಮ ವಿವರಗಳ ತ್ವರಿತ ಪರಿಶೀಲನೆ. ನಮ್ಮ ಪರಿಶೀಲನೆಯ ನಂತರ ಆಫರ್ ಬರುತ್ತದೆ.';

  @override
  String get selfieTitle => 'ಸೆಲ್ಫಿ ತೆಗೆಯಿರಿ';

  @override
  String get selfieBody =>
      'ನಿಮ್ಮ ಮುಖವನ್ನು ಆಧಾರ್ ಫೋಟೋದೊಂದಿಗೆ ಹೊಂದಿಸಿ, ಅದು ನಿಜವಾಗಿಯೂ ನೀವೇ, ಫೋಟೋದ ಫೋಟೋ ಅಲ್ಲ ಎಂದು ಪರಿಶೀಲಿಸುತ್ತೇವೆ.';

  @override
  String get selfieTips =>
      'ಉತ್ತಮ ಬೆಳಕು, ಕ್ಯಾಮೆರಾ ಕಡೆ ನೋಡಿ, ಟೋಪಿ ಅಥವಾ ಕನ್ನಡಕ ಬೇಡ.';

  @override
  String get takeSelfie => 'ಸೆಲ್ಫಿ ತೆಗೆಯಿರಿ';

  @override
  String get retake => 'ಮತ್ತೆ ತೆಗೆಯಿರಿ';

  @override
  String get checkFace => 'ಮುಖ ಕಂಡುಬಂದಿದೆ';

  @override
  String get checkLive => 'ಜೀವಂತ ವ್ಯಕ್ತಿ';

  @override
  String get checkMatch => 'ಆಧಾರ್ ಫೋಟೋಗೆ ಹೊಂದುತ್ತದೆ';

  @override
  String get selfieFailed =>
      'ನಿಮ್ಮ ಮುಖವನ್ನು ದೃಢೀಕರಿಸಲಾಗಲಿಲ್ಲ. ಉತ್ತಮ ಬೆಳಕಿನಲ್ಲಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ, ಅಥವಾ ವೀಡಿಯೊ KYC ಕರೆ ಬುಕ್ ಮಾಡಿ.';

  @override
  String get videoKyc => 'ವೀಡಿಯೊ KYC ಕರೆ ಬುಕ್ ಮಾಡಿ';

  @override
  String get docsTitle => 'ನಿಮ್ಮ ದಾಖಲೆಗಳು';

  @override
  String get docsBody =>
      'ಪ್ರತಿ ದಾಖಲೆಯ ಸ್ಪಷ್ಟ ಫೋಟೋ ತೆಗೆಯಿರಿ, ಅಥವಾ ಗ್ಯಾಲರಿಯಿಂದ ಆರಿಸಿ.';

  @override
  String get docPan => 'PAN ಕಾರ್ಡ್';

  @override
  String get docAadhaar => 'ಆಧಾರ್ ಕಾರ್ಡ್ (ಮರೆಮಾಡಿದ)';

  @override
  String get docSalarySlip => 'ಇತ್ತೀಚಿನ ಸಂಬಳ ಚೀಟಿ';

  @override
  String get docForm16 => 'ಫಾರ್ಮ್ 16';

  @override
  String get docItr => 'ಆದಾಯ ತೆರಿಗೆ ರಿಟರ್ನ್ (ITR)';

  @override
  String get docGst => 'GST ಪ್ರಮಾಣಪತ್ರ';

  @override
  String get docBankStatement => 'ಬ್ಯಾಂಕ್ ಸ್ಟೇಟ್‌ಮೆಂಟ್';

  @override
  String get bankViaAa => 'ನಿಮ್ಮ ಅಕೌಂಟ್ ಅಗ್ರಿಗೇಟರ್ ಮೂಲಕ ಪಡೆಯಲಾಗಿದೆ';

  @override
  String get camera => 'ಕ್ಯಾಮೆರಾ';

  @override
  String get gallery => 'ಗ್ಯಾಲರಿ';

  @override
  String get checking => 'ಪರಿಶೀಲಿಸಲಾಗುತ್ತಿದೆ…';

  @override
  String get tooBlurry =>
      'ತುಂಬಾ ಮಸುಕಾಗಿದೆ. ಫೋನ್ ಅಲುಗಾಡದಂತೆ ಹಿಡಿದು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get tooMuchGlare =>
      'ತುಂಬಾ ಹೊಳಪು. ಬೆಳಕಿನಿಂದ ದೂರ ಸರಿದು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String get tooDark => 'ತುಂಬಾ ಕತ್ತಲೆ. ಹೆಚ್ಚು ಬೆಳಕಿನಲ್ಲಿ ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';

  @override
  String docAccepted(String type) {
    return 'ಗುರುತಿಸಲಾಗಿದೆ: $type';
  }

  @override
  String docWrong(String expected) {
    return 'ಇದು $expected ತರಹ ಕಾಣುತ್ತಿಲ್ಲ. ಪರಿಶೀಲಿಸಿ ಸರಿಯಾದ ದಾಖಲೆ ಅಪ್‌ಲೋಡ್ ಮಾಡಿ.';
  }

  @override
  String get docUnreadable =>
      'ಈ ದಾಖಲೆಯನ್ನು ಓದಲಾಗಲಿಲ್ಲ. ಸ್ಪಷ್ಟ ಫೋಟೋ ತೆಗೆಯಿರಿ, ಅಥವಾ ಮೂಲ PDF ಅಪ್‌ಲೋಡ್ ಮಾಡಿ.';

  @override
  String docsMissing(String n) {
    return 'ಇನ್ನೂ $n ಬೇಕು';
  }

  @override
  String get getOffer => 'ನನ್ನ ತಾತ್ವಿಕ ಆಫರ್ ತೋರಿಸಿ';

  @override
  String get approvedInPrinciple => 'ತಾತ್ವಿಕವಾಗಿ ಅನುಮೋದಿಸಲಾಗಿದೆ';

  @override
  String get sanctioned => 'ಸಾಲ ಮಂಜೂರಾಗಿದೆ';

  @override
  String get referredTitle => 'ನಮಗೆ ಸ್ವಲ್ಪ ಹೆಚ್ಚು ಸಮಯ ಬೇಕು';

  @override
  String get rejectedTitle => 'ಈಗ ಈ ಸಾಲ ನೀಡಲು ಸಾಧ್ಯವಿಲ್ಲ';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years ವರ್ಷಗಳು · ವರ್ಷಕ್ಕೆ $rate% ಬದಲಾಗುವ ಬಡ್ಡಿ';
  }

  @override
  String get whyOffer => 'ನಿಮಗೆ ಈ ಆಫರ್ ಏಕೆ ಸಿಕ್ಕಿತು';

  @override
  String get whyReferred => 'ಮುಂದೆ ಏನಾಗುತ್ತದೆ';

  @override
  String get whyRejected => 'ನಾವು ಹೀಗೆ ಏಕೆ ನಿರ್ಧರಿಸಿದೆವು';

  @override
  String get referBody =>
      'ಒಬ್ಬ ಅಧಿಕಾರಿ ಒಂದು ಕೆಲಸದ ದಿನದೊಳಗೆ ನಿಮ್ಮ ಅರ್ಜಿ ನೋಡುತ್ತಾರೆ. ಈಗ ನೀವು ಏನೂ ಮಾಡಬೇಕಿಲ್ಲ.';

  @override
  String get rejectBody =>
      'ಈ ನಿರ್ಧಾರವನ್ನು ಒಬ್ಬ ವ್ಯಕ್ತಿ ಮರುಪರಿಶೀಲಿಸುವಂತೆ ನೀವು ಯಾವಾಗ ಬೇಕಾದರೂ ಕೇಳಬಹುದು.';

  @override
  String get addProperty => 'ಆಸ್ತಿ ವಿವರಗಳನ್ನು ಸೇರಿಸಿ';

  @override
  String get viewKfs => 'ಪ್ರಮುಖ ಅಂಶಗಳ ಹೇಳಿಕೆ ನೋಡಿ';

  @override
  String get grievance => 'ಮರುಪರಿಶೀಲನೆ ಕೇಳಿ ಅಥವಾ ದೂರು ನೀಡಿ';

  @override
  String officerLine(String name, String email) {
    return 'ಕುಂದುಕೊರತೆ ಅಧಿಕಾರಿ: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'ಅರ್ಜಿ $id';
  }

  @override
  String get startOver => 'ಹೊಸ ಅರ್ಜಿ ಪ್ರಾರಂಭಿಸಿ';

  @override
  String okScore(String score) {
    return 'ಉತ್ತಮ ಮರುಪಾವತಿ ಇತಿಹಾಸ (ಸ್ಕೋರ್ $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI ಆದಾಯದ $pct; ನಮ್ಮ ಮಿತಿ $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'ಸಾಲ ಆಸ್ತಿ ಮೌಲ್ಯದ $pct; ಮಿತಿ $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'ಆಸ್ತಿಯ ನಮ್ಮ ಮೌಲ್ಯಮಾಪನ: $low ರಿಂದ $high';
  }

  @override
  String get okTitle => 'ಆಸ್ತಿಯ ಹಕ್ಕು ಮತ್ತು ದಾಖಲೆಗಳನ್ನು ಪರಿಶೀಲಿಸಲಾಗಿದೆ';

  @override
  String get reasonKyc01 =>
      'ಫೋಟೋದಿಂದ ನಿಮ್ಮ ಗುರುತು ದೃಢೀಕರಿಸಲಾಗಲಿಲ್ಲ. ದಯವಿಟ್ಟು ಚಿಕ್ಕ ವೀಡಿಯೊ KYC ಕರೆ ಪೂರ್ಣಗೊಳಿಸಿ.';

  @override
  String get reasonFrd02 =>
      'ಸಂಬಳ ಚೀಟಿಯ ಆದಾಯ ಬ್ಯಾಂಕ್ ಜಮೆಗಳಿಗೆ ಹೊಂದುತ್ತಿಲ್ಲ. ಇತ್ತೀಚಿನ ಫಾರ್ಮ್ 16 ನೀಡಿ, ಅಥವಾ ಸಮ್ಮತಿಯೊಂದಿಗೆ ನಮಗೆ ಪಡೆಯಲು ಬಿಡಿ.';

  @override
  String get reasonFrd03 =>
      'ನಿಮ್ಮ ಒಂದು ದಾಖಲೆ ನೀಡಿದ ಪ್ರಾಧಿಕಾರದ ಪರಿಶೀಲನೆಯಲ್ಲಿ ವಿಫಲವಾಗಿದೆ.';

  @override
  String get reasonPol01 => 'ಅರ್ಜಿದಾರರಿಗೆ ಕನಿಷ್ಠ 21 ವರ್ಷ ವಯಸ್ಸಾಗಿರಬೇಕು.';

  @override
  String get reasonPol02 =>
      'ಸಾಲ ನಾವು ಅನುಮತಿಸುವ ಗರಿಷ್ಠ ವಯಸ್ಸನ್ನು ಮೀರುತ್ತದೆ. ಕಿರಿಯ ಸಹ-ಅರ್ಜಿದಾರರನ್ನು ಸೇರಿಸಿದರೆ ಸಹಾಯವಾಗಬಹುದು.';

  @override
  String get reasonBur01 =>
      'ನಿಮ್ಮ ಕ್ರೆಡಿಟ್ ಸ್ಕೋರ್ ನಮ್ಮ ಕನಿಷ್ಠ 650 ಕ್ಕಿಂತ ಕಡಿಮೆಯಿದೆ.';

  @override
  String get reasonBur04 =>
      'ನಿಮಗೆ ಇನ್ನೂ ಕ್ರೆಡಿಟ್ ಇತಿಹಾಸವಿಲ್ಲ, ಹಾಗಾಗಿ ಒಬ್ಬ ಅಧಿಕಾರಿ ನಿಮ್ಮ ಬ್ಯಾಂಕ್ ದಾಖಲೆಗಳನ್ನು ನೋಡುತ್ತಾರೆ.';

  @override
  String get reasonBur05 =>
      'ನಿಮ್ಮ ಕ್ರೆಡಿಟ್ ಸ್ಕೋರ್ ಅನ್ನು ಅಧಿಕಾರಿ ಗಮನವಿಟ್ಟು ನೋಡಬೇಕು.';

  @override
  String get reasonPrp01 => 'ನಮ್ಮ ವಕೀಲರು ಆಸ್ತಿಯ ಹಕ್ಕನ್ನು ಪರಿಶೀಲಿಸಬೇಕು.';

  @override
  String get reasonPrp03 =>
      'ಮೌಲ್ಯ ದೃಢೀಕರಿಸಲು ನಮ್ಮ ಮೌಲ್ಯಮಾಪಕರು ಆಸ್ತಿಗೆ ಭೇಟಿ ನೀಡಬೇಕು.';

  @override
  String get reasonPrp04 =>
      'ಒಪ್ಪಂದ ಮೌಲ್ಯ ಈ ಆಸ್ತಿಯ ಸರ್ಕಾರಿ ಮಾರ್ಗಸೂಚಿ ದರಕ್ಕಿಂತ ಕಡಿಮೆಯಿದೆ. ದಯವಿಟ್ಟು ಮಾರಾಟ ಒಪ್ಪಂದ ಪರಿಶೀಲಿಸಿ.';

  @override
  String get reasonAff01 =>
      'ನಿಮ್ಮ ಈಗಿನ EMI ಈಗಾಗಲೇ ಆದಾಯದ ಗರಿಷ್ಠ ಪಾಲನ್ನು ಬಳಸುತ್ತಿವೆ.';

  @override
  String get reasonAut01 =>
      'ಈ ಗಾತ್ರದ ಸಾಲಗಳನ್ನು ಹಿರಿಯ ಅಧಿಕಾರಿ ಅಂತಿಮವಾಗಿ ಪರಿಶೀಲಿಸುತ್ತಾರೆ.';

  @override
  String get reasonRsk01 =>
      'ಆಫರ್ ಅಂತಿಮಗೊಳಿಸಲು ಒಬ್ಬ ಅಧಿಕಾರಿ ನಿಮ್ಮ ಅರ್ಜಿ ನೋಡುತ್ತಾರೆ.';

  @override
  String get reasonRsk02 =>
      'ನಿಮ್ಮ ಕ್ರೆಡಿಟ್ ಪ್ರೊಫೈಲ್ ಆಧಾರದ ಮೇಲೆ, ಈಗ ಈ ಸಾಲ ನೀಡಲು ಸಾಧ್ಯವಿಲ್ಲ.';

  @override
  String get propertyTitle => 'ನಿಮ್ಮ ಆಸ್ತಿ';

  @override
  String get cityLabel => 'ನಗರ';

  @override
  String get localityLabel => 'ಪ್ರದೇಶ';

  @override
  String get societyLabel => 'ಯೋಜನೆ ಅಥವಾ ಸೊಸೈಟಿ (ಇದ್ದರೆ)';

  @override
  String get areaLabel => 'ವಿಸ್ತೀರ್ಣ (ಚ. ಅಡಿ)';

  @override
  String get bhkLabel => 'ಮಲಗುವ ಕೋಣೆಗಳು';

  @override
  String get newProperty => 'ಹೊಸದು';

  @override
  String get resale => 'ಮರುಮಾರಾಟ';

  @override
  String get declaredPriceLabel => 'ಒಪ್ಪಂದ ಮೌಲ್ಯ';

  @override
  String get photosTitle => 'ಆಸ್ತಿಯ ಫೋಟೋಗಳು';

  @override
  String get photosBody =>
      'ಆಸ್ತಿಯ ಸ್ಥಳದಲ್ಲೇ ಫೋಟೋ ತೆಗೆಯಿರಿ. ಮೌಲ್ಯಮಾಪಕರು ಭೇಟಿಯನ್ನು ಯೋಜಿಸಲು ನಾವು ಸ್ಥಳ ಮತ್ತು ಸಮಯ ಸೇರಿಸುತ್ತೇವೆ.';

  @override
  String get photoFront => 'ಮುಂಭಾಗ';

  @override
  String get photoInside => 'ಒಳಗೆ';

  @override
  String get photoView => 'ಆಸ್ತಿಯಿಂದ ನೋಟ';

  @override
  String geoTagged(String lat, String lng) {
    return 'ಸ್ಥಳ ಸೇರಿಸಲಾಗಿದೆ ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'ಸ್ಥಳವಿಲ್ಲದೆ ಫೋಟೋ ಉಳಿಸಲಾಗಿದೆ. ಜಿಯೋ-ಟ್ಯಾಗ್‌ಗಾಗಿ ಲೊಕೇಶನ್ ಆನ್ ಮಾಡಿ.';

  @override
  String get submitProperty => 'ಅಂತಿಮ ಮಂಜೂರಾತಿ ಪಡೆಯಿರಿ';

  @override
  String get fillAll => 'ದಯವಿಟ್ಟು ಎಲ್ಲಾ ಕ್ಷೇತ್ರಗಳನ್ನು ತುಂಬಿ.';

  @override
  String get kfsTitle => 'ಪ್ರಮುಖ ಅಂಶಗಳ ಹೇಳಿಕೆ';

  @override
  String get kfsLoan => 'ಸಾಲದ ಮೊತ್ತ';

  @override
  String get kfsTenure => 'ಅವಧಿ';

  @override
  String get kfsRate => 'ಬಡ್ಡಿ ದರ';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI ಗಳ ಸಂಖ್ಯೆ';

  @override
  String get kfsFee => 'ಪ್ರಕ್ರಿಯೆ ಶುಲ್ಕ (GST ಸಹಿತ)';

  @override
  String get kfsTotalInterest => 'ಒಟ್ಟು ಬಡ್ಡಿ';

  @override
  String get kfsTotalPayable => 'ಪಾವತಿಸಬೇಕಾದ ಒಟ್ಟು ಮೊತ್ತ';

  @override
  String get kfsApr => 'ವಾರ್ಷಿಕ ಶೇಕಡಾ ದರ (APR)';

  @override
  String get kfsCoolingOff =>
      'ಕೂಲಿಂಗ್-ಆಫ್ ಅವಧಿ: ಸಹಿ ಮಾಡಿದ 3 ದಿನಗಳೊಳಗೆ ಅಸಲು ಮತ್ತು ಆ ದಿನಗಳ ಬಡ್ಡಿ ಮಾತ್ರ ಮರಳಿಸಿ ದಂಡವಿಲ್ಲದೆ ಹೊರಬರಬಹುದು.';

  @override
  String get kfsNote =>
      'ಡೆಮೊಗಾಗಿ ಮಾದರಿ ಅಂಕಿಗಳು. ನಿಮ್ಮ ನಿಜವಾದ KFS ಮಂಜೂರಾತಿ ಪತ್ರದೊಂದಿಗೆ ಬರುತ್ತದೆ.';

  @override
  String get useSample => 'ಮಾದರಿ';

  @override
  String get videoKycDemo =>
      'ಡೆಮೊ: ಇದು ಅಧಿಕಾರಿಯೊಂದಿಗೆ ವೀಡಿಯೊ KYC ಕರೆ ಬುಕ್ ಮಾಡುತ್ತಿತ್ತು.';

  @override
  String get raiseComplaint => 'ದೂರು ನೀಡಿ';

  @override
  String complaintSent(String ref) {
    return 'ನಿಮ್ಮ ದೂರು ದಾಖಲಾಗಿದೆ. ಉಲ್ಲೇಖ $ref.';
  }

  @override
  String get stageSignIn => 'ಸೈನ್ ಇನ್';

  @override
  String get stageDetails => 'ವಿವರಗಳು';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'ಆಫರ್';

  @override
  String get stageProperty => 'ಆಸ್ತಿ';

  @override
  String get homeSubtitle => 'ಗೃಹ ಸಾಲ · ಆಸ್ತಿಯ ಮೇಲಿನ ಸಾಲ';

  @override
  String get heroPill => 'ನಿಮಿಷಗಳಲ್ಲಿ ನಿರ್ಧಾರ';

  @override
  String heroFacts(String rate, String years) {
    return 'ವರ್ಷಕ್ಕೆ $rate% ರಿಂದ · $years ವರ್ಷಗಳವರೆಗೆ';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% ಪೂರ್ಣ · ನಿಲ್ಲಿಸಿದಲ್ಲಿಂದ ಮುಂದುವರಿಸಿ';
  }

  @override
  String get resume => 'ಮುಂದುವರಿಸಿ';

  @override
  String get calculators => 'ಕ್ಯಾಲ್ಕುಲೇಟರ್‌ಗಳು';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'ಮಾಸಿಕ ಕಂತು';

  @override
  String get calcEligibility => 'ಅರ್ಹತೆ';

  @override
  String get calcEligibilitySub => 'ನಿಮಗೆ ಎಷ್ಟು ಸಿಗಬಹುದು';

  @override
  String get emiCalcTitle => 'EMI ಕ್ಯಾಲ್ಕುಲೇಟರ್';

  @override
  String get eligibilityCalcTitle => 'ಅರ್ಹತಾ ಕ್ಯಾಲ್ಕುಲೇಟರ್';

  @override
  String totalInterest(String amount) {
    return 'ಒಟ್ಟು ಬಡ್ಡಿ $amount';
  }

  @override
  String get calcIncomeOnly =>
      'ಆದಾಯದ ಆಧಾರದ ಮೇಲೆ ಮಾತ್ರ. ಆಸ್ತಿಯ ಮೌಲ್ಯ ಇದನ್ನು ಕಡಿಮೆ ಮಾಡಬಹುದು.';

  @override
  String get verified => 'ಪರಿಶೀಲಿಸಲಾಗಿದೆ';

  @override
  String get yourLoan => 'ನಿಮ್ಮ ಸಾಲ';

  @override
  String docsProgress(String done, String total) {
    return '$total ರಲ್ಲಿ $done ಪರಿಶೀಲಿಸಲಾಗಿದೆ';
  }

  @override
  String get docNeeded => 'ಬೇಕು';

  @override
  String get docTryAgain => 'ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ';

  @override
  String get fetched => 'ಪಡೆಯಲಾಗಿದೆ';

  @override
  String get statusApproved => 'ಅನುಮೋದಿತ';

  @override
  String get statusSanctioned => 'ಮಂಜೂರಾಗಿದೆ';

  @override
  String get statusInReview => 'ಪರಿಶೀಲನೆಯಲ್ಲಿ';

  @override
  String get statusDeclined => 'ನಿರಾಕರಿಸಲಾಗಿದೆ';

  @override
  String get trackTitle => 'ನಿಮ್ಮ ಅರ್ಜಿಯನ್ನು ಟ್ರ್ಯಾಕ್ ಮಾಡಿ';

  @override
  String get tlSubmitted => 'ಅರ್ಜಿ ಸಲ್ಲಿಸಲಾಗಿದೆ';

  @override
  String get tlVerified => 'KYC ಮತ್ತು ದಾಖಲೆಗಳು ಪರಿಶೀಲಿಸಲಾಗಿದೆ';

  @override
  String get tlInPrinciple => 'ತಾತ್ವಿಕ ಅನುಮೋದನೆ';

  @override
  String get tlProperty => 'ಆಸ್ತಿ ವಿವರ ಮತ್ತು ಮೌಲ್ಯಮಾಪನ';

  @override
  String get tlPropertyNext => 'ನಿಮ್ಮ ಆಸ್ತಿಯ ವಿವರ ಮತ್ತು ಫೋಟೋಗಳನ್ನು ಸೇರಿಸಿ';

  @override
  String get tlOfficer => 'ಅಧಿಕಾರಿಯ ಪರಿಶೀಲನೆ';

  @override
  String get tlOfficerNext => 'ಒಂದು ಕೆಲಸದ ದಿನದೊಳಗೆ';

  @override
  String get tlLegal => 'ಕಾನೂನು ಮತ್ತು ಹಕ್ಕು ಪರಿಶೀಲನೆ';

  @override
  String get tlSanction => 'ಅಂತಿಮ ಮಂಜೂರಾತಿ ಮತ್ತು ಇ-ಸಹಿ';

  @override
  String get tlSanctionNext => 'ಮಂಜೂರಾತಿ ಪತ್ರಕ್ಕೆ ಆನ್‌ಲೈನ್‌ನಲ್ಲಿ ಸಹಿ ಮಾಡಿ';

  @override
  String get tlDisbursement => 'ಹಣ ಬಿಡುಗಡೆ';

  @override
  String get helpTitle => 'ಸಹಾಯ ಬೇಕೇ?';

  @override
  String get propertyType => 'ಹೊಸದೇ ಅಥವಾ ಮರುಮಾರಾಟವೇ';

  @override
  String get greetMorning => 'ಶುಭೋದಯ';

  @override
  String get greetAfternoon => 'ಶುಭ ಮಧ್ಯಾಹ್ನ';

  @override
  String get greetEvening => 'ಶುಭ ಸಂಜೆ';

  @override
  String nearlyThere(String name) {
    return '$name, ನೀವು ಬಹುತೇಕ ತಲುಪಿದ್ದೀರಿ';
  }

  @override
  String get chooseLanguage => 'ನಿಮ್ಮ ಭಾಷೆಯನ್ನು ಆರಿಸಿ';

  @override
  String get languageNote => 'ಇದನ್ನು ನೀವು ಯಾವಾಗ ಬೇಕಾದರೂ ಬದಲಾಯಿಸಬಹುದು.';

  @override
  String get liveChecks => 'ನೇರ ಪರಿಶೀಲನೆಗಳು';

  @override
  String get checkBureau => 'ಕ್ರೆಡಿಟ್ ಬ್ಯೂರೋ';

  @override
  String checkScore(String score) {
    return 'ಸ್ಕೋರ್ $score';
  }

  @override
  String get checkNoHistory => 'ಇನ್ನೂ ಇತಿಹಾಸವಿಲ್ಲ';

  @override
  String get checkBank => 'AA ಮೂಲಕ ಬ್ಯಾಂಕ್';

  @override
  String get checkBankRead => '12 ತಿಂಗಳು ಓದಲಾಗಿದೆ';

  @override
  String get checkKyc => 'eKYC ಮತ್ತು ಸೆಲ್ಫಿ';

  @override
  String get checkPending => 'ಬಾಕಿ';

  @override
  String get checkDocs => 'ದಾಖಲೆಗಳು';

  @override
  String countOf(String done, String total) {
    return '$total ರಲ್ಲಿ $done';
  }

  @override
  String minutesLeft(String n) {
    return 'ಸುಮಾರು $n ನಿಮಿಷ ಉಳಿದಿದೆ';
  }

  @override
  String ratePa(String rate) {
    return 'ವರ್ಷಕ್ಕೆ $rate%';
  }

  @override
  String get continueApplication => 'ನಿಮ್ಮ ಅರ್ಜಿಯನ್ನು ಮುಂದುವರಿಸಿ';

  @override
  String get shapeOffer => 'ನಿಮ್ಮ ಆಫರ್ ರೂಪಿಸಿ';

  @override
  String get shapeOfferSub => 'ತಾತ್ವಿಕವಾಗಿ ಅನುಮೋದಿತ · ಬದಲಾಯಿಸಲು ಎಳೆಯಿರಿ';

  @override
  String get withinLimits => 'ನಿಮ್ಮ ಮಿತಿಯೊಳಗೆ';

  @override
  String get aboveLimits => 'ಮಿತಿ ಮೀರಿದೆ: ಮೊತ್ತ ಕಡಿಮೆ ಮಾಡಿ ಅಥವಾ ವರ್ಷ ಹೆಚ್ಚಿಸಿ';

  @override
  String mostYouCan(String amount) {
    return 'ಗರಿಷ್ಠ ಪಡೆಯಬಹುದು: $amount';
  }

  @override
  String get useMax => 'ಗರಿಷ್ಠ ಪಡೆಯಿರಿ';

  @override
  String get principal => 'ಅಸಲು';

  @override
  String get interest => 'ಬಡ್ಡಿ';

  @override
  String get totalRepaid => 'ಒಟ್ಟು ಮರುಪಾವತಿ';

  @override
  String get emiShareIncome => 'ಆದಾಯದಲ್ಲಿ EMI ಪಾಲು';

  @override
  String loanShareProperty(String value) {
    return '$value ಆಸ್ತಿಯಲ್ಲಿ ಸಾಲದ ಪಾಲು';
  }

  @override
  String get lockOffer => 'ಈ ಆಫರ್ ಖಚಿತಪಡಿಸಿ';

  @override
  String get offerLocked => 'ನಿಮ್ಮ ಆಫರ್ ಖಚಿತವಾಗಿದೆ.';

  @override
  String approvedUpTo(String amount) {
    return '$amount ವರೆಗೆ ಅನುಮೋದಿತ';
  }

  @override
  String readingDoc(String doc) {
    return 'ನಿಮ್ಮ $doc ಓದಲಾಗುತ್ತಿದೆ';
  }

  @override
  String get documentAi => 'ದಾಖಲೆ AI';

  @override
  String sure(String pct) {
    return '$pct% ಖಚಿತ';
  }

  @override
  String get readMatches => 'ನಾವು ಕೇಳಿದ ದಾಖಲೆಯೇ ಇದು';

  @override
  String get readClear => 'ಸ್ಪಷ್ಟ ಫೋಟೋ, ಮಸುಕು ಅಥವಾ ಹೊಳಪು ಇಲ್ಲ';

  @override
  String get whatWeRead => 'ನಾವು ಓದಿದ್ದು';

  @override
  String get looksRight => 'ಸರಿಯಾಗಿದೆ';

  @override
  String get fieldName => 'ಹೆಸರು';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'ಆಧಾರ್';

  @override
  String get fieldEmployer => 'ಉದ್ಯೋಗದಾತ';

  @override
  String get fieldNetPay => 'ನಿವ್ವಳ ಸಂಬಳ';

  @override
  String get fieldPeriod => 'ಸಂಬಳದ ಅವಧಿ';

  @override
  String get fieldYear => 'ವರ್ಷ';

  @override
  String get fieldIncome => 'ಆದಾಯ';

  @override
  String get fieldBusiness => 'ವ್ಯಾಪಾರ';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'ನಿಮ್ಮ ಸಾಲಕ್ಕೆ ಅಗತ್ಯ';

  @override
  String get consentSectionOptional => 'ಐಚ್ಛಿಕ: ನೀವು ಆನ್ ಮಾಡುವವರೆಗೆ ಆಫ್';

  @override
  String get advancedOptions => 'ಆಯ್ಕೆಗಳು';

  @override
  String consentValidUntil(String given, String until) {
    return '$given ರಂದು ನೀಡಲಾಗಿದೆ · $until ವರೆಗೆ ಮಾನ್ಯ';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given ರಂದು ನೀಡಲಾಗಿದೆ · ಹಿಂಪಡೆಯುವವರೆಗೆ';
  }

  @override
  String get recheckTitle => 'ಹಣ ನೀಡುವ ಮೊದಲು ಇನ್ನೊಂದು ಪರಿಶೀಲನೆ';

  @override
  String get recheckBody =>
      'ಹಣ ನೀಡುವ ಮೊದಲು ನಿಮ್ಮ ಕ್ರೆಡಿಟ್ ವರದಿಯನ್ನು ಮತ್ತೆ ನೋಡುತ್ತೇವೆ. ಬೇಡ ಎಂದರೆ ಆಗ ಅಧಿಕಾರಿ ಕೇಳಬಹುದು.';

  @override
  String get aaMonthsLabel => 'ಎಷ್ಟು ತಿಂಗಳ ಸ್ಟೇಟ್‌ಮೆಂಟ್ ಹಂಚಿಕೊಳ್ಳಬೇಕು';

  @override
  String monthsN(String n) {
    return '$n ತಿಂಗಳು';
  }

  @override
  String get aaAccountsLabel => 'ಹಂಚಿಕೊಳ್ಳುವ ಖಾತೆಗಳು';

  @override
  String get accountSavingsSalary => 'ಉಳಿತಾಯ ·· 0912 · ಸಂಬಳ ಜಮೆ';

  @override
  String get accountSavings => 'ಉಳಿತಾಯ ·· 4821';

  @override
  String get accountFd => 'ಸ್ಥಿರ ಠೇವಣಿ ·· 3307';

  @override
  String get aaAccountNeeded => 'ಕನಿಷ್ಠ ಒಂದು ಖಾತೆ ಆರಿಸಿ.';

  @override
  String get kycMethodLabel => 'ಗುರುತನ್ನು ಹೇಗೆ ದೃಢೀಕರಿಸುವುದು';

  @override
  String get kycAadhaarOtp => 'ಆಧಾರ್ OTP';

  @override
  String get kycDigilocker => 'ಡಿಜಿಲಾಕರ್';

  @override
  String get kycVideo => 'ವೀಡಿಯೊ KYC ಕರೆ';

  @override
  String get useCkycTitle => 'ನನ್ನ ಈಗಿನ CKYC ದಾಖಲೆ ಬಳಸಿ';

  @override
  String get useCkycBody =>
      'ಬೇರೆ ಬ್ಯಾಂಕ್ ಅಥವಾ ಫಂಡ್‌ನಲ್ಲಿ KYC ಮಾಡಿದ್ದರೆ, ಮತ್ತೆ ಕೇಳದೆ ಆ ದಾಖಲೆ ತರುತ್ತೇವೆ.';

  @override
  String get optOffersTitle => 'ಆಫರ್‌ಗಳು ಮತ್ತು ಹೊಸ ಉತ್ಪನ್ನಗಳು';

  @override
  String get optOffersBody =>
      'ಆಫರ್‌ಗಳ ಬಗ್ಗೆ ಹೇಗೆ ತಿಳಿಯಬೇಕು ಎಂದು ಆರಿಸಿ. ಯಾವಾಗ ಬೇಕಾದರೂ ಆಫ್ ಮಾಡಬಹುದು.';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ಇಮೇಲ್';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp ನಲ್ಲಿ ಸಾಲದ ಅಪ್‌ಡೇಟ್‌ಗಳು';

  @override
  String get optUpdatesBody =>
      'SMS ಜೊತೆಗೆ WhatsApp ನಲ್ಲಿ ಸ್ಥಿತಿ ಅಪ್‌ಡೇಟ್ ಮತ್ತು EMI ಜ್ಞಾಪನೆಗಳು.';

  @override
  String get optInsuranceTitle => 'ಗೃಹ ಸಾಲ ರಕ್ಷಣೆಯ ಉಲ್ಲೇಖ';

  @override
  String get optInsuranceBody =>
      'ಉಲ್ಲೇಖಕ್ಕಾಗಿ ನಿಮ್ಮ ಹೆಸರು, ವಯಸ್ಸು ಮತ್ತು ಸಾಲದ ಮೊತ್ತವನ್ನು ನಮ್ಮ ವಿಮಾ ಪಾಲುದಾರರೊಂದಿಗೆ ಹಂಚಿಕೊಳ್ಳಿ. ಖರೀದಿ ಎಂದೂ ಕಡ್ಡಾಯವಲ್ಲ.';

  @override
  String get getQuote => 'ಉಲ್ಲೇಖ ಪಡೆಯಿರಿ';

  @override
  String get manageConsents => 'ಸಮ್ಮತಿಗಳನ್ನು ನಿರ್ವಹಿಸಿ';

  @override
  String get manageConsentsBody =>
      'ಐಚ್ಛಿಕ ಸಮ್ಮತಿಗಳನ್ನು ಯಾವಾಗ ಬೇಕಾದರೂ ಆಫ್ ಮಾಡಿ. ಅಗತ್ಯವಾದದ್ದನ್ನು ಹಿಂಪಡೆದರೆ ಅರ್ಜಿ ನಿಲ್ಲುತ್ತದೆ, ಅದಕ್ಕಾಗಿ ತಂದ ಮಾಹಿತಿಯನ್ನು ಅಳಿಸುತ್ತೇವೆ.';

  @override
  String get withdraw => 'ಹಿಂಪಡೆಯಿರಿ';

  @override
  String get consentHistory => 'ಸಮ್ಮತಿಯ ಇತಿಹಾಸ';

  @override
  String historyGiven(String item) {
    return '$item ನೀಡಲಾಗಿದೆ';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item ಹಿಂಪಡೆಯಲಾಗಿದೆ';
  }

  @override
  String get historyEmpty => 'ಇನ್ನೂ ಏನೂ ಇಲ್ಲ.';

  @override
  String get consentOn => 'ಆನ್';

  @override
  String get consentOff => 'ಆಫ್';

  @override
  String get withdrawnRequired =>
      'ನೀವು ಅಗತ್ಯ ಸಮ್ಮತಿ ಹಿಂಪಡೆದಿದ್ದೀರಿ, ಹಾಗಾಗಿ ಅರ್ಜಿ ನಿಂತಿದೆ.';

  @override
  String get checkMatchPending =>
      'ಫೋಟೋ ಹೊಂದಾಣಿಕೆ: ಆಧಾರ್ ಅಥವಾ ಪ್ಯಾನ್ ಕಾರ್ಡ್ ಅಪ್‌ಲೋಡ್ ಮಾಡಿದಾಗ ಆಗುತ್ತದೆ';

  @override
  String get realDetailsIntro =>
      'ನಿಮ್ಮ ಬಗ್ಗೆ ತಿಳಿಸಿ. ಪ್ರತಿಯೊಂದು ವಿವರವನ್ನು ನಿಮ್ಮ ದಾಖಲೆಗಳೊಂದಿಗೆ ಪರಿಶೀಲಿಸುತ್ತೇವೆ.';

  @override
  String get fullNameLabel => 'ಪೂರ್ಣ ಹೆಸರು (ಪ್ಯಾನ್ ಕಾರ್ಡ್‌ನಲ್ಲಿರುವಂತೆ)';

  @override
  String get emailLabel => 'ಇಮೇಲ್';

  @override
  String get employerLabel => 'ಉದ್ಯೋಗದಾತ ಅಥವಾ ವ್ಯವಹಾರದ ಹೆಸರು';

  @override
  String get creditScoreLabel => 'ಕ್ರೆಡಿಟ್ ಸ್ಕೋರ್ (ಐಚ್ಛಿಕ)';

  @override
  String get creditScoreHint =>
      'ನಿಮ್ಮ CIBIL ಅಥವಾ Experian ವರದಿಯಿಂದ, ಗೊತ್ತಿದ್ದರೆ';

  @override
  String get addressLabel => 'ವಿಳಾಸ';

  @override
  String get saveDetails => 'ನನ್ನ ವಿವರಗಳನ್ನು ಉಳಿಸಿ';

  @override
  String get selfDeclaredNote =>
      'ಈ ವಿವರಗಳನ್ನು ನೀವು ನಮೂದಿಸಿದ್ದೀರಿ. ಮುಂದೆ ನೀವು ಅಪ್‌ಲೋಡ್ ಮಾಡುವ ದಾಖಲೆಗಳೊಂದಿಗೆ ಪರಿಶೀಲಿಸುತ್ತೇವೆ.';

  @override
  String get pickDob => 'ನಿಮ್ಮ ಜನ್ಮದಿನಾಂಕ ಆಯ್ಕೆಮಾಡಿ';

  @override
  String get fillDetails =>
      'ದಯವಿಟ್ಟು ಹೆಸರು, ಜನ್ಮದಿನಾಂಕ, ಕೆಲಸ, ಉದ್ಯೋಗದಾತ ಮತ್ತು ಆದಾಯ ತುಂಬಿ.';

  @override
  String get docSaleDeed => 'ಮಾರಾಟ ಪತ್ರ ಅಥವಾ ಹಂಚಿಕೆ ಪತ್ರ';

  @override
  String get saleDeedBody =>
      'ನೋಂದಾಯಿತ ಮಾರಾಟ ಪತ್ರದ ಫೋಟೋ ಅಥವಾ PDF ಅಪ್‌ಲೋಡ್ ಮಾಡಿ (ಆಸ್ತಿ ಮತ್ತು ಖರೀದಿದಾರರಿರುವ ಪುಟ). ಮಾಲೀಕತ್ವ ಪರಿಶೀಲಿಸಲು ನಾವು ಇದನ್ನು ಓದುತ್ತೇವೆ.';

  @override
  String get statusPending => 'ಪರಿಶೀಲನೆ ಬಾಕಿ ಇದೆ';

  @override
  String decisionRef(String ref) {
    return 'ನಿರ್ಧಾರ ದಾಖಲೆ $ref';
  }

  @override
  String get scoreTitle => 'ನಿಮ್ಮ ಸ್ಕೋರ್ ಅನ್ನು ನಾವು ಹೇಗೆ ಲೆಕ್ಕ ಹಾಕಿದೆವು';

  @override
  String get scoreOutOf => '900 ರಲ್ಲಿ';

  @override
  String gradeLabel(String grade) {
    return 'ಗ್ರೇಡ್ $grade';
  }

  @override
  String scoreStart(String base) {
    return 'ಎಲ್ಲರೂ $base ಅಂಕಗಳಿಂದ ಪ್ರಾರಂಭಿಸುತ್ತಾರೆ. ಕೆಳಗಿನ ಪ್ರತಿಯೊಂದು ಸಾಲು ಅಂಕಗಳನ್ನು ಸೇರಿಸುತ್ತದೆ ಅಥವಾ ಕಳೆಯುತ್ತದೆ.';
  }

  @override
  String get scoreNote =>
      'ಇದು ನಿರ್ಧಾರದ ಕ್ರೆಡಿಟ್ ಸ್ಕೋರ್ ಭಾಗ. ನಿಮ್ಮ ಆದಾಯ, ಗುರುತು, ದಾಖಲೆಗಳು ಮತ್ತು ಆಸ್ತಿಯನ್ನೂ ಪರಿಶೀಲಿಸಲಾಗುತ್ತದೆ.';

  @override
  String get factorBureau => 'ಕ್ರೆಡಿಟ್ ಬ್ಯೂರೋ ಸ್ಕೋರ್';

  @override
  String get factorHistory => 'ಕ್ರೆಡಿಟ್ ಇತಿಹಾಸದ ವರ್ಷಗಳು';

  @override
  String get factorLtv => 'ಆಸ್ತಿ ಮೌಲ್ಯದಲ್ಲಿ ಸಾಲದ ಪಾಲು';

  @override
  String get factorLoanAmount => 'ಸಾಲದ ಮೊತ್ತ';

  @override
  String get factorMissing => 'ಲಭ್ಯವಿಲ್ಲ';

  @override
  String rangeBelow(String x) {
    return '$x ಕ್ಕಿಂತ ಕಡಿಮೆ';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$a ರಿಂದ $b';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x ಅಥವಾ ಹೆಚ್ಚು';
  }

  @override
  String get viewLetter => 'ನಿರ್ಧಾರ ಪತ್ರ';

  @override
  String get letterTitle => 'ನಿಮ್ಮ ನಿರ್ಧಾರ ಪತ್ರ';

  @override
  String get letterPartlyEnglish =>
      'ಕೆಲವು ಸಾಲುಗಳನ್ನು ಅನುವಾದಿಸಲಾಗಲಿಲ್ಲ, ಅವು ಇಂಗ್ಲಿಷ್‌ನಲ್ಲಿವೆ.';

  @override
  String get copyText => 'ಪಠ್ಯ ನಕಲಿಸಿ';

  @override
  String get copied => 'ನಕಲಿಸಲಾಗಿದೆ';

  @override
  String get askTitle => 'ಪ್ರಶ್ನೆ ಕೇಳಿ';

  @override
  String get askHint => 'ಉದಾ: ಮುಂದೆ ಏನಾಗುತ್ತದೆ?';

  @override
  String get askSend => 'ಕಳುಹಿಸಿ';

  @override
  String get askHuman => 'ನಮ್ಮ ತಂಡದ ಒಬ್ಬರು ಈ ಬಗ್ಗೆ ನಿಮ್ಮನ್ನು ಸಂಪರ್ಕಿಸುತ್ತಾರೆ.';

  @override
  String get uploadPdf => 'PDF ಅಪ್‌ಲೋಡ್ ಮಾಡಿ';

  @override
  String get kfsFeeBase => 'ಪ್ರಕ್ರಿಯೆ ಶುಲ್ಕ (0.5%)';

  @override
  String get kfsGst => 'ಶುಲ್ಕದ ಮೇಲೆ GST (18%)';

  @override
  String get kfsNoteEngine =>
      'ಈ ಆಫರ್‌ಗಾಗಿ ಲೆಕ್ಕ ಹಾಕಲಾಗಿದೆ. ಸಹಿ ಮಾಡಿದ ಪ್ರಮುಖ ಅಂಶಗಳ ಹೇಳಿಕೆ ನಿಮ್ಮ ಮಂಜೂರಾತಿ ಪತ್ರದೊಂದಿಗೆ ಬರುತ್ತದೆ.';

  @override
  String otpOnServer(String phone) {
    return 'ಈ ಪರೀಕ್ಷಾ ಸರ್ವರ್ SMS ಕಳುಹಿಸುವುದಿಲ್ಲ. $phone ಗಾಗಿ 6 ಅಂಕಿಯ ಕೋಡ್ ಕಂಪ್ಯೂಟರ್‌ನ ಸರ್ವರ್ ವಿಂಡೋದಲ್ಲಿ ಕಾಣುತ್ತದೆ.';
  }

  @override
  String get resendOtp => 'ಹೊಸ ಕೋಡ್ ಕಳುಹಿಸಿ';

  @override
  String get newOtpSent => 'ಹೊಸ ಕೋಡ್ ಕಳುಹಿಸಲಾಗಿದೆ.';

  @override
  String get otpExpired => 'ಈ ಕೋಡ್‌ನ ಅವಧಿ ಮುಗಿದಿದೆ. ಹೊಸ ಕೋಡ್ ಕಳುಹಿಸಿ ಒತ್ತಿ.';

  @override
  String get otpTooManyTries => 'ಹಲವು ಬಾರಿ ತಪ್ಪು ಕೋಡ್. ಹೊಸ ಕೋಡ್ ಕಳುಹಿಸಿ ಒತ್ತಿ.';

  @override
  String get otpTooManySends =>
      'ತುಂಬಾ ಹೆಚ್ಚು ಕೋಡ್‌ಗಳನ್ನು ಕೇಳಲಾಗಿದೆ. 15 ನಿಮಿಷ ಕಾಯ್ದು ಮತ್ತೆ ಪ್ರಯತ್ನಿಸಿ.';
}
