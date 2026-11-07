// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appTitle => 'ਨਿਰਣੈ';

  @override
  String get sandboxBanner => 'ਡੈਮੋ ਮੋਡ: ਨਮੂਨਾ ਡਾਟਾ, ਅਸਲ ਜਾਂਚ ਨਹੀਂ';

  @override
  String get continueLabel => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String stepOf(String step, String total) {
    return 'ਕਦਮ $step / $total';
  }

  @override
  String get pleaseWait => 'ਕਿਰਪਾ ਕਰਕੇ ਉਡੀਕ ਕਰੋ…';

  @override
  String get errorGeneric => 'ਕੁਝ ਗਲਤ ਹੋ ਗਿਆ। ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get close => 'ਬੰਦ ਕਰੋ';

  @override
  String get welcomeHeadline => 'ਕੁਝ ਮਿੰਟਾਂ ਵਿੱਚ ਤੁਹਾਡੇ ਹੋਮ ਲੋਨ ਦਾ ਫ਼ੈਸਲਾ';

  @override
  String get welcomeBody =>
      'ਹੋਮ ਲੋਨ ਜਾਂ ਜਾਇਦਾਦ ਬਦਲੇ ਲੋਨ ਲਈ ਅਰਜ਼ੀ ਦਿਓ। ਅਸੀਂ ਸਭ ਕੁਝ ਔਨਲਾਈਨ ਜਾਂਚਦੇ ਹਾਂ ਅਤੇ ਹਮੇਸ਼ਾ ਫ਼ੈਸਲੇ ਦਾ ਕਾਰਨ ਦੱਸਦੇ ਹਾਂ।';

  @override
  String get chooseProduct => 'ਤੁਹਾਨੂੰ ਕੀ ਚਾਹੀਦਾ ਹੈ?';

  @override
  String get productHomeLoan => 'ਹੋਮ ਲੋਨ';

  @override
  String get productHomeLoanSub => 'ਘਰ ਖਰੀਦਣਾ, ਬਣਾਉਣਾ ਜਾਂ ਸੁਧਾਰਨਾ';

  @override
  String get productLap => 'ਜਾਇਦਾਦ ਬਦਲੇ ਲੋਨ';

  @override
  String get productLapSub => 'ਆਪਣੀ ਜਾਇਦਾਦ ਬਦਲੇ ਕਰਜ਼ਾ ਲਓ';

  @override
  String get startApplication => 'ਅਰਜ਼ੀ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String get demoCustomers => 'ਡੈਮੋ ਗਾਹਕ';

  @override
  String get demoCustomersBody =>
      'ਨਮੂਨਾ ਮੋਬਾਈਲ ਨੰਬਰ ਭਰਨ ਲਈ ਕਿਸੇ ਇੱਕ ਉੱਤੇ ਟੈਪ ਕਰੋ।';

  @override
  String get personaRavi => 'ਰਵੀ, 32, ਨੌਕਰੀਪੇਸ਼ਾ, ਫਲੈਟ ਖਰੀਦ ਰਹੇ ਹਨ';

  @override
  String get personaMeena => 'ਮੀਨਾ, 45, ਕੱਪੜਿਆਂ ਦੀ ਦੁਕਾਨ ਚਲਾਉਂਦੀ ਹੈ (LAP)';

  @override
  String get personaArjun => 'ਅਰਜੁਨ, 29, ਨੌਕਰੀਪੇਸ਼ਾ, ਬਦਲੀ ਹੋਈ ਤਨਖਾਹ ਸਲਿੱਪ';

  @override
  String get signInTitle => 'ਸਾਈਨ ਇਨ';

  @override
  String get mobileLabel => 'ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String get mobileHint => '10 ਅੰਕਾਂ ਦਾ ਮੋਬਾਈਲ ਨੰਬਰ';

  @override
  String get invalidMobile => 'ਸਹੀ 10 ਅੰਕਾਂ ਦਾ ਮੋਬਾਈਲ ਨੰਬਰ ਦਿਓ।';

  @override
  String get sendOtp => 'OTP ਭੇਜੋ';

  @override
  String otpSentTo(String phone) {
    return 'ਅਸੀਂ $phone ਉੱਤੇ 6 ਅੰਕਾਂ ਦਾ ਕੋਡ ਭੇਜਿਆ ਹੈ।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'ਪੁਸ਼ਟੀ ਕਰੋ';

  @override
  String get demoOtp => 'ਡੈਮੋ ਕੋਡ: 123456';

  @override
  String get wrongOtp => 'ਕੋਡ ਗਲਤ ਹੈ। ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get deviceBound =>
      'ਇਹ ਫ਼ੋਨ ਹੁਣ ਤੁਹਾਡੇ ਖਾਤੇ ਨਾਲ ਜੁੜ ਗਿਆ ਹੈ। ਕਿਸੇ ਹੋਰ ਫ਼ੋਨ ਉੱਤੇ ਸਾਈਨ ਇਨ ਲਈ ਨਵਾਂ OTP ਚਾਹੀਦਾ ਹੋਵੇਗਾ।';

  @override
  String get consentTitle => 'ਤੁਹਾਡੀ ਸਹਿਮਤੀ';

  @override
  String get consentIntro =>
      'ਅਸੀਂ ਤੁਹਾਡਾ ਡਾਟਾ ਸਿਰਫ਼ ਇਸ ਲੋਨ ਦੇ ਫ਼ੈਸਲੇ ਅਤੇ ਪ੍ਰਬੰਧ ਲਈ ਵਰਤਦੇ ਹਾਂ। ਤੁਸੀਂ ਕਦੇ ਵੀ ਸਹਿਮਤੀ ਵਾਪਸ ਲੈ ਸਕਦੇ ਹੋ।';

  @override
  String get consentBureauTitle => 'ਕ੍ਰੈਡਿਟ ਰਿਪੋਰਟ';

  @override
  String get consentBureauBody =>
      'ਕ੍ਰੈਡਿਟ ਬਿਊਰੋ (CIBIL, Experian, Equifax ਜਾਂ CRIF) ਤੋਂ ਤੁਹਾਡਾ ਕ੍ਰੈਡਿਟ ਇਤਿਹਾਸ ਵੇਖਿਆ ਜਾਵੇਗਾ। ਇਸ ਨਾਲ ਤੁਹਾਡਾ ਸਕੋਰ ਘੱਟ ਨਹੀਂ ਹੁੰਦਾ।';

  @override
  String get consentAaTitle => 'ਅਕਾਊਂਟ ਐਗਰੀਗੇਟਰ ਰਾਹੀਂ ਬੈਂਕ ਸਟੇਟਮੈਂਟ';

  @override
  String get consentAaBody =>
      'RBI ਲਾਇਸੈਂਸਸ਼ੁਦਾ ਅਕਾਊਂਟ ਐਗਰੀਗੇਟਰ ਰਾਹੀਂ ਤੁਹਾਡੇ ਬੈਂਕ ਤੋਂ 12 ਮਹੀਨਿਆਂ ਦੀ ਸਟੇਟਮੈਂਟ ਲਈ ਜਾਵੇਗੀ। ਬੇਨਤੀ ਤੁਸੀਂ ਆਪਣੀ AA ਐਪ ਵਿੱਚ ਮਨਜ਼ੂਰ ਕਰਦੇ ਹੋ।';

  @override
  String get consentKycTitle => 'ਆਧਾਰ eKYC ਅਤੇ PAN';

  @override
  String get consentKycBody =>
      'UIDAI ਅਤੇ ਆਮਦਨ ਕਰ ਵਿਭਾਗ ਨਾਲ ਤੁਹਾਡੀ ਪਛਾਣ ਦੀ ਪੁਸ਼ਟੀ ਹੋਵੇਗੀ। ਅਸੀਂ ਸਿਰਫ਼ ਲੁਕਿਆ ਹੋਇਆ ਆਧਾਰ ਨੰਬਰ ਰੱਖਦੇ ਹਾਂ।';

  @override
  String get consentPrivacyTitle => 'ਪਰਦੇਦਾਰੀ ਨੋਟਿਸ (DPDP ਐਕਟ 2023)';

  @override
  String get consentPrivacyBody =>
      'ਅਸੀਂ ਕੀ ਇਕੱਠਾ ਕਰਦੇ ਹਾਂ: ਪਛਾਣ, ਆਮਦਨ, ਬੈਂਕ ਅਤੇ ਜਾਇਦਾਦ ਦੇ ਵੇਰਵੇ। ਕਿਉਂ: ਤੁਹਾਡੇ ਲੋਨ ਦੇ ਫ਼ੈਸਲੇ ਅਤੇ ਪ੍ਰਬੰਧ ਲਈ। ਕਿੰਨੀ ਦੇਰ: ਸਿਰਫ਼ ਜਿੰਨਾ ਕਾਨੂੰਨ ਕਹੇ। ਤੁਹਾਡੇ ਹੱਕ: ਆਪਣਾ ਡਾਟਾ ਵੇਖਣਾ, ਠੀਕ ਕਰਨਾ ਜਾਂ ਮਿਟਾਉਣਾ, ਅਤੇ ਸਾਡੇ ਸ਼ਿਕਾਇਤ ਅਧਿਕਾਰੀ ਜਾਂ ਡਾਟਾ ਸੁਰੱਖਿਆ ਬੋਰਡ ਕੋਲ ਸ਼ਿਕਾਇਤ ਕਰਨਾ।';

  @override
  String get consentRequired => 'ਲਾਜ਼ਮੀ';

  @override
  String get consentNeeded => 'ਅੱਗੇ ਵਧਣ ਲਈ ਸਾਰਿਆਂ ਨਾਲ ਸਹਿਮਤੀ ਦਿਓ।';

  @override
  String get agreeAndContinue => 'ਸਹਿਮਤੀ ਦੇ ਕੇ ਅੱਗੇ ਵਧੋ';

  @override
  String get detailsTitle => 'ਤੁਹਾਡੇ ਵੇਰਵੇ';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'ਸਹੀ PAN ਦਿਓ, ਜਿਵੇਂ ABCDE1234F।';

  @override
  String get fetchDetails => 'ਮੇਰੇ ਵੇਰਵੇ ਲਿਆਓ';

  @override
  String get fetchedFrom =>
      'PAN, ਆਧਾਰ eKYC ਅਤੇ ਤੁਹਾਡੀ ਬੈਂਕ ਸਟੇਟਮੈਂਟ ਤੋਂ ਭਰਿਆ ਗਿਆ। ਠੀਕ ਕਰਨ ਲਈ ਅੰਕ ਉੱਤੇ ਟੈਪ ਕਰੋ।';

  @override
  String get nameLabel => 'ਨਾਮ';

  @override
  String get dobLabel => 'ਜਨਮ ਮਿਤੀ';

  @override
  String get employmentLabel => 'ਕੰਮ';

  @override
  String get salaried => 'ਨੌਕਰੀਪੇਸ਼ਾ';

  @override
  String get selfEmployed => 'ਸਵੈ-ਰੁਜ਼ਗਾਰ';

  @override
  String get incomeLabel => 'ਮਹੀਨਾਵਾਰ ਸ਼ੁੱਧ ਆਮਦਨ';

  @override
  String get existingEmiLabel => 'ਮੌਜੂਦਾ ਮਹੀਨਾਵਾਰ EMI';

  @override
  String get propertyValueLabel => 'ਜਾਇਦਾਦ ਦੀ ਕੀਮਤ';

  @override
  String get loanAmountLabel => 'ਲੋਨ ਦੀ ਰਕਮ';

  @override
  String get tenureLabel => 'ਮਿਆਦ';

  @override
  String yearsLabel(String n) {
    return '$n ਸਾਲ';
  }

  @override
  String get eligibleTitle => 'ਤੁਸੀਂ ਵੱਧ ਤੋਂ ਵੱਧ ਲੈ ਸਕਦੇ ਹੋ';

  @override
  String emiPerMonth(String amount) {
    return 'ਮਹੀਨਾਵਾਰ EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'ਸਾਲਾਨਾ $rate%, ਬਦਲਵੀਂ ਦਰ (ਉਦਾਹਰਣ)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'ਆਮਦਨ ਦੀ ਹੱਦ: ਤੁਹਾਡੀਆਂ ਸਾਰੀਆਂ EMI ਮਿਲ ਕੇ ਆਮਦਨ ਦਾ $pct ਤੱਕ ਹੋ ਸਕਦੀਆਂ ਹਨ।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'ਜਾਇਦਾਦ ਦੀ ਹੱਦ: ਇੰਨਾ ਲੋਨ ਕੀਮਤ ਦਾ $pct ਤੱਕ ਹੋ ਸਕਦਾ ਹੈ।';
  }

  @override
  String get limitedByAsked => 'ਇਹ ਤੁਹਾਡੀ ਮੰਗੀ ਹੋਈ ਰਕਮ ਹੈ।';

  @override
  String get eligibilityNote =>
      'ਤੁਹਾਡੇ ਵੇਰਵਿਆਂ ਦੀ ਤੁਰੰਤ ਜਾਂਚ। ਸਾਡੀ ਜਾਂਚ ਤੋਂ ਬਾਅਦ ਪੇਸ਼ਕਸ਼ ਆਵੇਗੀ।';

  @override
  String get selfieTitle => 'ਸੈਲਫ਼ੀ ਲਓ';

  @override
  String get selfieBody =>
      'ਅਸੀਂ ਤੁਹਾਡਾ ਚਿਹਰਾ ਆਧਾਰ ਫ਼ੋਟੋ ਨਾਲ ਮਿਲਾਉਂਦੇ ਹਾਂ ਅਤੇ ਵੇਖਦੇ ਹਾਂ ਕਿ ਇਹ ਸੱਚਮੁੱਚ ਤੁਸੀਂ ਹੋ, ਫ਼ੋਟੋ ਦੀ ਫ਼ੋਟੋ ਨਹੀਂ।';

  @override
  String get selfieTips => 'ਚੰਗੀ ਰੋਸ਼ਨੀ, ਕੈਮਰੇ ਵੱਲ ਵੇਖੋ, ਟੋਪੀ ਜਾਂ ਐਨਕ ਨਹੀਂ।';

  @override
  String get takeSelfie => 'ਸੈਲਫ਼ੀ ਲਓ';

  @override
  String get retake => 'ਦੁਬਾਰਾ ਲਓ';

  @override
  String get checkFace => 'ਚਿਹਰਾ ਮਿਲਿਆ';

  @override
  String get checkLive => 'ਜੀਉਂਦਾ ਵਿਅਕਤੀ';

  @override
  String get checkMatch => 'ਆਧਾਰ ਫ਼ੋਟੋ ਨਾਲ ਮਿਲਦਾ ਹੈ';

  @override
  String get selfieFailed =>
      'ਅਸੀਂ ਤੁਹਾਡੇ ਚਿਹਰੇ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਕਰ ਸਕੇ। ਚੰਗੀ ਰੋਸ਼ਨੀ ਵਿੱਚ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ, ਜਾਂ ਵੀਡੀਓ KYC ਕਾਲ ਬੁੱਕ ਕਰੋ।';

  @override
  String get videoKyc => 'ਵੀਡੀਓ KYC ਕਾਲ ਬੁੱਕ ਕਰੋ';

  @override
  String get docsTitle => 'ਤੁਹਾਡੇ ਦਸਤਾਵੇਜ਼';

  @override
  String get docsBody => 'ਹਰ ਦਸਤਾਵੇਜ਼ ਦੀ ਸਾਫ਼ ਫ਼ੋਟੋ ਲਓ, ਜਾਂ ਗੈਲਰੀ ਵਿੱਚੋਂ ਚੁਣੋ।';

  @override
  String get docPan => 'PAN ਕਾਰਡ';

  @override
  String get docAadhaar => 'ਆਧਾਰ ਕਾਰਡ (ਲੁਕਿਆ ਹੋਇਆ)';

  @override
  String get docSalarySlip => 'ਤਾਜ਼ਾ ਤਨਖਾਹ ਸਲਿੱਪ';

  @override
  String get docForm16 => 'ਫ਼ਾਰਮ 16';

  @override
  String get docItr => 'ਆਮਦਨ ਕਰ ਰਿਟਰਨ (ITR)';

  @override
  String get docGst => 'GST ਸਰਟੀਫ਼ਿਕੇਟ';

  @override
  String get docBankStatement => 'ਬੈਂਕ ਸਟੇਟਮੈਂਟ';

  @override
  String get bankViaAa => 'ਤੁਹਾਡੇ ਅਕਾਊਂਟ ਐਗਰੀਗੇਟਰ ਰਾਹੀਂ ਲਿਆ ਗਿਆ';

  @override
  String get camera => 'ਕੈਮਰਾ';

  @override
  String get gallery => 'ਗੈਲਰੀ';

  @override
  String get checking => 'ਜਾਂਚ ਹੋ ਰਹੀ ਹੈ…';

  @override
  String get tooBlurry => 'ਬਹੁਤ ਧੁੰਦਲਾ। ਫ਼ੋਨ ਸਥਿਰ ਰੱਖ ਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get tooMuchGlare => 'ਬਹੁਤ ਚਮਕ। ਰੋਸ਼ਨੀ ਤੋਂ ਹਟ ਕੇ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String get tooDark => 'ਬਹੁਤ ਹਨੇਰਾ। ਵੱਧ ਰੋਸ਼ਨੀ ਵਿੱਚ ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';

  @override
  String docAccepted(String type) {
    return 'ਪਛਾਣਿਆ ਗਿਆ: $type';
  }

  @override
  String docWrong(String expected) {
    return 'ਇਹ $expected ਨਹੀਂ ਲੱਗਦਾ। ਜਾਂਚ ਕੇ ਸਹੀ ਦਸਤਾਵੇਜ਼ ਅੱਪਲੋਡ ਕਰੋ।';
  }

  @override
  String get docUnreadable =>
      'ਅਸੀਂ ਇਹ ਦਸਤਾਵੇਜ਼ ਨਹੀਂ ਪੜ੍ਹ ਸਕੇ। ਹੋਰ ਸਾਫ਼ ਫ਼ੋਟੋ ਲਓ, ਜਾਂ ਅਸਲ PDF ਅੱਪਲੋਡ ਕਰੋ।';

  @override
  String docsMissing(String n) {
    return 'ਅਜੇ $n ਚਾਹੀਦੇ';
  }

  @override
  String get getOffer => 'ਮੇਰੀ ਸਿਧਾਂਤਕ ਪੇਸ਼ਕਸ਼ ਵਿਖਾਓ';

  @override
  String get approvedInPrinciple => 'ਸਿਧਾਂਤਕ ਤੌਰ ਤੇ ਮਨਜ਼ੂਰ';

  @override
  String get sanctioned => 'ਲੋਨ ਮਨਜ਼ੂਰ';

  @override
  String get referredTitle => 'ਸਾਨੂੰ ਥੋੜ੍ਹਾ ਹੋਰ ਸਮਾਂ ਚਾਹੀਦਾ ਹੈ';

  @override
  String get rejectedTitle => 'ਅਸੀਂ ਹੁਣ ਇਹ ਲੋਨ ਨਹੀਂ ਦੇ ਸਕਦੇ';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years ਸਾਲ · ਸਾਲਾਨਾ $rate% ਬਦਲਵੀਂ ਦਰ';
  }

  @override
  String get whyOffer => 'ਤੁਹਾਨੂੰ ਇਹ ਪੇਸ਼ਕਸ਼ ਕਿਉਂ ਮਿਲੀ';

  @override
  String get whyReferred => 'ਅੱਗੇ ਕੀ ਹੋਵੇਗਾ';

  @override
  String get whyRejected => 'ਅਸੀਂ ਇਹ ਫ਼ੈਸਲਾ ਕਿਉਂ ਕੀਤਾ';

  @override
  String get referBody =>
      'ਇੱਕ ਅਧਿਕਾਰੀ ਇੱਕ ਕੰਮਕਾਜੀ ਦਿਨ ਵਿੱਚ ਤੁਹਾਡੀ ਅਰਜ਼ੀ ਵੇਖੇਗਾ। ਹੁਣ ਤੁਹਾਨੂੰ ਕੁਝ ਕਰਨ ਦੀ ਲੋੜ ਨਹੀਂ।';

  @override
  String get rejectBody =>
      'ਤੁਸੀਂ ਕਦੇ ਵੀ ਕਿਸੇ ਵਿਅਕਤੀ ਨੂੰ ਇਸ ਫ਼ੈਸਲੇ ਦੀ ਸਮੀਖਿਆ ਲਈ ਕਹਿ ਸਕਦੇ ਹੋ।';

  @override
  String get addProperty => 'ਜਾਇਦਾਦ ਦੇ ਵੇਰਵੇ ਜੋੜੋ';

  @override
  String get viewKfs => 'ਮੁੱਖ ਤੱਥ ਬਿਆਨ ਵੇਖੋ';

  @override
  String get grievance => 'ਸਮੀਖਿਆ ਮੰਗੋ ਜਾਂ ਸ਼ਿਕਾਇਤ ਕਰੋ';

  @override
  String officerLine(String name, String email) {
    return 'ਸ਼ਿਕਾਇਤ ਅਧਿਕਾਰੀ: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'ਅਰਜ਼ੀ $id';
  }

  @override
  String get startOver => 'ਨਵੀਂ ਅਰਜ਼ੀ ਸ਼ੁਰੂ ਕਰੋ';

  @override
  String okScore(String score) {
    return 'ਮਜ਼ਬੂਤ ਭੁਗਤਾਨ ਇਤਿਹਾਸ (ਸਕੋਰ $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI ਆਮਦਨ ਦਾ $pct ਹਨ; ਸਾਡੀ ਹੱਦ $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'ਲੋਨ ਜਾਇਦਾਦ ਦੀ ਕੀਮਤ ਦਾ $pct ਹੈ; ਹੱਦ $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'ਜਾਇਦਾਦ ਦਾ ਸਾਡਾ ਮੁੱਲਾਂਕਣ: $low ਤੋਂ $high';
  }

  @override
  String get okTitle => 'ਜਾਇਦਾਦ ਦੀ ਮਾਲਕੀ ਅਤੇ ਕਾਗਜ਼ ਜਾਂਚੇ ਗਏ';

  @override
  String get reasonKyc01 =>
      'ਫ਼ੋਟੋ ਤੋਂ ਤੁਹਾਡੀ ਪਛਾਣ ਦੀ ਪੁਸ਼ਟੀ ਨਹੀਂ ਹੋ ਸਕੀ। ਕਿਰਪਾ ਕਰਕੇ ਇੱਕ ਛੋਟੀ ਵੀਡੀਓ KYC ਕਾਲ ਪੂਰੀ ਕਰੋ।';

  @override
  String get reasonFrd02 =>
      'ਤਨਖਾਹ ਸਲਿੱਪ ਦੀ ਆਮਦਨ ਬੈਂਕ ਜਮ੍ਹਾਂ ਨਾਲ ਮੇਲ ਨਹੀਂ ਖਾਂਦੀ। ਆਪਣਾ ਤਾਜ਼ਾ ਫ਼ਾਰਮ 16 ਦਿਓ, ਜਾਂ ਸਹਿਮਤੀ ਨਾਲ ਸਾਨੂੰ ਲੈਣ ਦਿਓ।';

  @override
  String get reasonFrd03 =>
      'ਤੁਹਾਡਾ ਇੱਕ ਦਸਤਾਵੇਜ਼ ਜਾਰੀ ਕਰਨ ਵਾਲੀ ਅਥਾਰਟੀ ਦੀ ਪੁਸ਼ਟੀ ਵਿੱਚ ਫੇਲ੍ਹ ਹੋ ਗਿਆ।';

  @override
  String get reasonPol01 => 'ਅਰਜ਼ੀਕਾਰ ਦੀ ਉਮਰ ਘੱਟੋ-ਘੱਟ 21 ਸਾਲ ਹੋਣੀ ਚਾਹੀਦੀ ਹੈ।';

  @override
  String get reasonPol02 =>
      'ਲੋਨ ਸਾਡੀ ਮਨਜ਼ੂਰ ਵੱਧ ਤੋਂ ਵੱਧ ਉਮਰ ਤੋਂ ਅੱਗੇ ਚਲਾ ਜਾਵੇਗਾ। ਛੋਟੀ ਉਮਰ ਦਾ ਸਹਿ-ਅਰਜ਼ੀਕਾਰ ਜੋੜਨ ਨਾਲ ਮਦਦ ਮਿਲ ਸਕਦੀ ਹੈ।';

  @override
  String get reasonBur01 =>
      'ਤੁਹਾਡਾ ਕ੍ਰੈਡਿਟ ਸਕੋਰ ਸਾਡੇ ਘੱਟੋ-ਘੱਟ 650 ਤੋਂ ਹੇਠਾਂ ਹੈ।';

  @override
  String get reasonBur04 =>
      'ਤੁਹਾਡਾ ਅਜੇ ਕ੍ਰੈਡਿਟ ਇਤਿਹਾਸ ਨਹੀਂ ਹੈ, ਇਸ ਲਈ ਇੱਕ ਅਧਿਕਾਰੀ ਤੁਹਾਡੇ ਬੈਂਕ ਰਿਕਾਰਡ ਵੇਖੇਗਾ।';

  @override
  String get reasonBur05 =>
      'ਤੁਹਾਡੇ ਕ੍ਰੈਡਿਟ ਸਕੋਰ ਨੂੰ ਅਧਿਕਾਰੀ ਵੱਲੋਂ ਧਿਆਨ ਨਾਲ ਵੇਖਣ ਦੀ ਲੋੜ ਹੈ।';

  @override
  String get reasonPrp01 =>
      'ਸਾਡੇ ਵਕੀਲ ਨੂੰ ਜਾਇਦਾਦ ਦੀ ਮਾਲਕੀ ਦੀ ਸਮੀਖਿਆ ਕਰਨੀ ਪਵੇਗੀ।';

  @override
  String get reasonPrp03 =>
      'ਕੀਮਤ ਦੀ ਪੁਸ਼ਟੀ ਲਈ ਸਾਡੇ ਮੁੱਲਾਂਕਣਕਾਰ ਨੂੰ ਜਾਇਦਾਦ ਵੇਖਣੀ ਪਵੇਗੀ।';

  @override
  String get reasonPrp04 =>
      'ਇਕਰਾਰਨਾਮੇ ਦੀ ਕੀਮਤ ਇਸ ਜਾਇਦਾਦ ਦੇ ਸਰਕਾਰੀ ਕੁਲੈਕਟਰ ਰੇਟ ਤੋਂ ਘੱਟ ਹੈ। ਕਿਰਪਾ ਕਰਕੇ ਵਿਕਰੀ ਇਕਰਾਰਨਾਮਾ ਜਾਂਚੋ।';

  @override
  String get reasonAff01 =>
      'ਤੁਹਾਡੀਆਂ ਮੌਜੂਦਾ EMI ਪਹਿਲਾਂ ਹੀ ਆਮਦਨ ਦਾ ਵੱਧ ਤੋਂ ਵੱਧ ਹਿੱਸਾ ਲੈ ਰਹੀਆਂ ਹਨ।';

  @override
  String get reasonAut01 =>
      'ਇੰਨੇ ਵੱਡੇ ਲੋਨ ਦੀ ਆਖ਼ਰੀ ਜਾਂਚ ਇੱਕ ਸੀਨੀਅਰ ਅਧਿਕਾਰੀ ਕਰਦਾ ਹੈ।';

  @override
  String get reasonRsk01 =>
      'ਪੇਸ਼ਕਸ਼ ਪੱਕੀ ਕਰਨ ਲਈ ਇੱਕ ਅਧਿਕਾਰੀ ਤੁਹਾਡੀ ਅਰਜ਼ੀ ਵੇਖੇਗਾ।';

  @override
  String get reasonRsk02 =>
      'ਤੁਹਾਡੀ ਕ੍ਰੈਡਿਟ ਪ੍ਰੋਫ਼ਾਈਲ ਦੇ ਆਧਾਰ ਤੇ ਅਸੀਂ ਹੁਣ ਇਹ ਲੋਨ ਨਹੀਂ ਦੇ ਸਕਦੇ।';

  @override
  String get propertyTitle => 'ਤੁਹਾਡੀ ਜਾਇਦਾਦ';

  @override
  String get cityLabel => 'ਸ਼ਹਿਰ';

  @override
  String get localityLabel => 'ਇਲਾਕਾ';

  @override
  String get societyLabel => 'ਪ੍ਰੋਜੈਕਟ ਜਾਂ ਸੋਸਾਇਟੀ (ਜੇ ਹੈ)';

  @override
  String get areaLabel => 'ਖੇਤਰਫਲ (ਵਰਗ ਫੁੱਟ)';

  @override
  String get bhkLabel => 'ਬੈੱਡਰੂਮ';

  @override
  String get newProperty => 'ਨਵੀਂ';

  @override
  String get resale => 'ਰੀਸੇਲ';

  @override
  String get declaredPriceLabel => 'ਇਕਰਾਰਨਾਮੇ ਦੀ ਕੀਮਤ';

  @override
  String get photosTitle => 'ਜਾਇਦਾਦ ਦੀਆਂ ਫ਼ੋਟੋਆਂ';

  @override
  String get photosBody =>
      'ਜਾਇਦਾਦ ਉੱਤੇ ਜਾ ਕੇ ਫ਼ੋਟੋਆਂ ਲਓ। ਅਸੀਂ ਥਾਂ ਅਤੇ ਸਮਾਂ ਜੋੜਦੇ ਹਾਂ, ਤਾਂ ਜੋ ਮੁੱਲਾਂਕਣਕਾਰ ਦੌਰੇ ਦੀ ਯੋਜਨਾ ਬਣਾ ਸਕੇ।';

  @override
  String get photoFront => 'ਅੱਗਾ';

  @override
  String get photoInside => 'ਅੰਦਰ';

  @override
  String get photoView => 'ਜਾਇਦਾਦ ਤੋਂ ਨਜ਼ਾਰਾ';

  @override
  String geoTagged(String lat, String lng) {
    return 'ਥਾਂ ਜੋੜੀ ਗਈ ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'ਥਾਂ ਤੋਂ ਬਿਨਾਂ ਫ਼ੋਟੋ ਸੰਭਾਲੀ ਗਈ। ਜੀਓ-ਟੈਗ ਲਈ ਲੋਕੇਸ਼ਨ ਚਾਲੂ ਕਰੋ।';

  @override
  String get submitProperty => 'ਅੰਤਿਮ ਮਨਜ਼ੂਰੀ ਲਓ';

  @override
  String get fillAll => 'ਕਿਰਪਾ ਕਰਕੇ ਹਰ ਖਾਨਾ ਭਰੋ।';

  @override
  String get kfsTitle => 'ਮੁੱਖ ਤੱਥ ਬਿਆਨ';

  @override
  String get kfsLoan => 'ਲੋਨ ਦੀ ਰਕਮ';

  @override
  String get kfsTenure => 'ਮਿਆਦ';

  @override
  String get kfsRate => 'ਵਿਆਜ ਦਰ';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI ਦੀ ਗਿਣਤੀ';

  @override
  String get kfsFee => 'ਪ੍ਰੋਸੈਸਿੰਗ ਫ਼ੀਸ (GST ਸਮੇਤ)';

  @override
  String get kfsTotalInterest => 'ਕੁੱਲ ਵਿਆਜ';

  @override
  String get kfsTotalPayable => 'ਕੁੱਲ ਦੇਣਯੋਗ ਰਕਮ';

  @override
  String get kfsApr => 'ਸਾਲਾਨਾ ਪ੍ਰਤੀਸ਼ਤ ਦਰ (APR)';

  @override
  String get kfsCoolingOff =>
      'ਕੂਲਿੰਗ-ਆਫ਼ ਮਿਆਦ: ਦਸਤਖ਼ਤ ਦੇ 3 ਦਿਨਾਂ ਅੰਦਰ ਸਿਰਫ਼ ਮੂਲ ਰਕਮ ਅਤੇ ਉਨ੍ਹਾਂ ਦਿਨਾਂ ਦਾ ਵਿਆਜ ਮੋੜ ਕੇ ਬਿਨਾਂ ਜੁਰਮਾਨੇ ਨਿਕਲ ਸਕਦੇ ਹੋ।';

  @override
  String get kfsNote =>
      'ਡੈਮੋ ਲਈ ਨਮੂਨਾ ਅੰਕੜੇ। ਤੁਹਾਡਾ ਅਸਲ KFS ਮਨਜ਼ੂਰੀ ਪੱਤਰ ਨਾਲ ਆਵੇਗਾ।';

  @override
  String get useSample => 'ਨਮੂਨਾ';

  @override
  String get videoKycDemo =>
      'ਡੈਮੋ: ਇਸ ਨਾਲ ਇੱਕ ਅਧਿਕਾਰੀ ਨਾਲ ਵੀਡੀਓ KYC ਕਾਲ ਬੁੱਕ ਹੁੰਦੀ।';

  @override
  String get raiseComplaint => 'ਸ਼ਿਕਾਇਤ ਕਰੋ';

  @override
  String complaintSent(String ref) {
    return 'ਤੁਹਾਡੀ ਸ਼ਿਕਾਇਤ ਦਰਜ ਹੋ ਗਈ। ਹਵਾਲਾ $ref।';
  }

  @override
  String get stageSignIn => 'ਸਾਈਨ ਇਨ';

  @override
  String get stageDetails => 'ਵੇਰਵੇ';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'ਪੇਸ਼ਕਸ਼';

  @override
  String get stageProperty => 'ਜਾਇਦਾਦ';

  @override
  String get homeSubtitle => 'ਹੋਮ ਲੋਨ · ਜਾਇਦਾਦ ਬਦਲੇ ਲੋਨ';

  @override
  String get heroPill => 'ਮਿੰਟਾਂ ਵਿੱਚ ਫ਼ੈਸਲਾ';

  @override
  String heroFacts(String rate, String years) {
    return 'ਸਾਲਾਨਾ $rate% ਤੋਂ · $years ਸਾਲ ਤੱਕ';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% ਪੂਰਾ · ਜਿੱਥੇ ਛੱਡਿਆ ਸੀ ਉੱਥੋਂ ਸ਼ੁਰੂ ਕਰੋ';
  }

  @override
  String get resume => 'ਜਾਰੀ ਰੱਖੋ';

  @override
  String get calculators => 'ਕੈਲਕੁਲੇਟਰ';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'ਮਹੀਨਾਵਾਰ ਕਿਸ਼ਤ';

  @override
  String get calcEligibility => 'ਯੋਗਤਾ';

  @override
  String get calcEligibilitySub => 'ਤੁਸੀਂ ਕਿੰਨਾ ਲੈ ਸਕਦੇ ਹੋ';

  @override
  String get emiCalcTitle => 'EMI ਕੈਲਕੁਲੇਟਰ';

  @override
  String get eligibilityCalcTitle => 'ਯੋਗਤਾ ਕੈਲਕੁਲੇਟਰ';

  @override
  String totalInterest(String amount) {
    return 'ਕੁੱਲ ਵਿਆਜ $amount';
  }

  @override
  String get calcIncomeOnly =>
      'ਸਿਰਫ਼ ਆਮਦਨ ਦੇ ਆਧਾਰ ਤੇ। ਜਾਇਦਾਦ ਦੀ ਕੀਮਤ ਇਸ ਨੂੰ ਘਟਾ ਸਕਦੀ ਹੈ।';

  @override
  String get verified => 'ਪੁਸ਼ਟੀ ਹੋਈ';

  @override
  String get yourLoan => 'ਤੁਹਾਡਾ ਲੋਨ';

  @override
  String docsProgress(String done, String total) {
    return '$total ਵਿੱਚੋਂ $done ਦੀ ਪੁਸ਼ਟੀ ਹੋਈ';
  }

  @override
  String get docNeeded => 'ਚਾਹੀਦਾ';

  @override
  String get docTryAgain => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼';

  @override
  String get fetched => 'ਲਿਆ ਗਿਆ';

  @override
  String get statusApproved => 'ਮਨਜ਼ੂਰ';

  @override
  String get statusSanctioned => 'ਮਨਜ਼ੂਰਸ਼ੁਦਾ';

  @override
  String get statusInReview => 'ਸਮੀਖਿਆ ਵਿੱਚ';

  @override
  String get statusDeclined => 'ਨਾਮਨਜ਼ੂਰ';

  @override
  String get trackTitle => 'ਆਪਣੀ ਅਰਜ਼ੀ ਟ੍ਰੈਕ ਕਰੋ';

  @override
  String get tlSubmitted => 'ਅਰਜ਼ੀ ਜਮ੍ਹਾਂ ਹੋਈ';

  @override
  String get tlVerified => 'KYC ਅਤੇ ਦਸਤਾਵੇਜ਼ਾਂ ਦੀ ਪੁਸ਼ਟੀ ਹੋਈ';

  @override
  String get tlInPrinciple => 'ਸਿਧਾਂਤਕ ਮਨਜ਼ੂਰੀ';

  @override
  String get tlProperty => 'ਜਾਇਦਾਦ ਦੇ ਵੇਰਵੇ ਅਤੇ ਮੁੱਲਾਂਕਣ';

  @override
  String get tlPropertyNext => 'ਆਪਣੀ ਜਾਇਦਾਦ ਦੇ ਵੇਰਵੇ ਅਤੇ ਫ਼ੋਟੋਆਂ ਜੋੜੋ';

  @override
  String get tlOfficer => 'ਅਧਿਕਾਰੀ ਦੀ ਸਮੀਖਿਆ';

  @override
  String get tlOfficerNext => 'ਇੱਕ ਕੰਮਕਾਜੀ ਦਿਨ ਵਿੱਚ';

  @override
  String get tlLegal => 'ਕਾਨੂੰਨੀ ਅਤੇ ਮਾਲਕੀ ਜਾਂਚ';

  @override
  String get tlSanction => 'ਅੰਤਿਮ ਮਨਜ਼ੂਰੀ ਅਤੇ ਈ-ਦਸਤਖ਼ਤ';

  @override
  String get tlSanctionNext => 'ਆਪਣੇ ਮਨਜ਼ੂਰੀ ਪੱਤਰ ਤੇ ਔਨਲਾਈਨ ਦਸਤਖ਼ਤ ਕਰੋ';

  @override
  String get tlDisbursement => 'ਰਕਮ ਜਾਰੀ';

  @override
  String get helpTitle => 'ਮਦਦ ਚਾਹੀਦੀ ਹੈ?';

  @override
  String get propertyType => 'ਨਵੀਂ ਜਾਂ ਰੀਸੇਲ';

  @override
  String get greetMorning => 'ਸ਼ੁਭ ਸਵੇਰ';

  @override
  String get greetAfternoon => 'ਸ਼ੁਭ ਦੁਪਹਿਰ';

  @override
  String get greetEvening => 'ਸ਼ੁਭ ਸ਼ਾਮ';

  @override
  String nearlyThere(String name) {
    return '$name, ਤੁਸੀਂ ਲਗਭਗ ਪਹੁੰਚ ਗਏ ਹੋ';
  }

  @override
  String get chooseLanguage => 'ਆਪਣੀ ਭਾਸ਼ਾ ਚੁਣੋ';

  @override
  String get languageNote => 'ਤੁਸੀਂ ਇਸ ਨੂੰ ਕਦੇ ਵੀ ਬਦਲ ਸਕਦੇ ਹੋ।';

  @override
  String get liveChecks => 'ਲਾਈਵ ਜਾਂਚਾਂ';

  @override
  String get checkBureau => 'ਕ੍ਰੈਡਿਟ ਬਿਊਰੋ';

  @override
  String checkScore(String score) {
    return 'ਸਕੋਰ $score';
  }

  @override
  String get checkNoHistory => 'ਅਜੇ ਕੋਈ ਇਤਿਹਾਸ ਨਹੀਂ';

  @override
  String get checkBank => 'AA ਰਾਹੀਂ ਬੈਂਕ';

  @override
  String get checkBankRead => '12 ਮਹੀਨੇ ਪੜ੍ਹੇ ਗਏ';

  @override
  String get checkKyc => 'eKYC ਅਤੇ ਸੈਲਫ਼ੀ';

  @override
  String get checkPending => 'ਬਾਕੀ';

  @override
  String get checkDocs => 'ਦਸਤਾਵੇਜ਼';

  @override
  String countOf(String done, String total) {
    return '$total ਵਿੱਚੋਂ $done';
  }

  @override
  String minutesLeft(String n) {
    return 'ਲਗਭਗ $n ਮਿੰਟ ਬਾਕੀ';
  }

  @override
  String ratePa(String rate) {
    return 'ਸਾਲਾਨਾ $rate%';
  }

  @override
  String get continueApplication => 'ਆਪਣੀ ਅਰਜ਼ੀ ਜਾਰੀ ਰੱਖੋ';

  @override
  String get shapeOffer => 'ਆਪਣੀ ਪੇਸ਼ਕਸ਼ ਤੈਅ ਕਰੋ';

  @override
  String get shapeOfferSub => 'ਸਿਧਾਂਤਕ ਤੌਰ ਤੇ ਮਨਜ਼ੂਰ · ਬਦਲਣ ਲਈ ਖਿੱਚੋ';

  @override
  String get withinLimits => 'ਤੁਹਾਡੀ ਹੱਦ ਅੰਦਰ';

  @override
  String get aboveLimits => 'ਹੱਦ ਤੋਂ ਵੱਧ: ਰਕਮ ਘਟਾਓ ਜਾਂ ਸਾਲ ਵਧਾਓ';

  @override
  String mostYouCan(String amount) {
    return 'ਵੱਧ ਤੋਂ ਵੱਧ ਲੈ ਸਕਦੇ ਹੋ: $amount';
  }

  @override
  String get useMax => 'ਵੱਧ ਤੋਂ ਵੱਧ ਲਓ';

  @override
  String get principal => 'ਮੂਲ ਰਕਮ';

  @override
  String get interest => 'ਵਿਆਜ';

  @override
  String get totalRepaid => 'ਕੁੱਲ ਭੁਗਤਾਨ';

  @override
  String get emiShareIncome => 'ਆਮਦਨ ਵਿੱਚ EMI ਦਾ ਹਿੱਸਾ';

  @override
  String loanShareProperty(String value) {
    return '$value ਦੀ ਜਾਇਦਾਦ ਵਿੱਚ ਲੋਨ ਦਾ ਹਿੱਸਾ';
  }

  @override
  String get lockOffer => 'ਇਹ ਪੇਸ਼ਕਸ਼ ਪੱਕੀ ਕਰੋ';

  @override
  String get offerLocked => 'ਤੁਹਾਡੀ ਪੇਸ਼ਕਸ਼ ਪੱਕੀ ਹੋ ਗਈ।';

  @override
  String approvedUpTo(String amount) {
    return '$amount ਤੱਕ ਮਨਜ਼ੂਰ';
  }

  @override
  String readingDoc(String doc) {
    return 'ਤੁਹਾਡਾ $doc ਪੜ੍ਹਿਆ ਜਾ ਰਿਹਾ ਹੈ';
  }

  @override
  String get documentAi => 'ਦਸਤਾਵੇਜ਼ AI';

  @override
  String sure(String pct) {
    return '$pct% ਪੱਕਾ';
  }

  @override
  String get readMatches => 'ਇਹ ਉਹੀ ਦਸਤਾਵੇਜ਼ ਹੈ ਜੋ ਅਸੀਂ ਮੰਗਿਆ ਸੀ';

  @override
  String get readClear => 'ਸਾਫ਼ ਫ਼ੋਟੋ, ਧੁੰਦਲਾਪਨ ਜਾਂ ਚਮਕ ਨਹੀਂ';

  @override
  String get whatWeRead => 'ਅਸੀਂ ਕੀ ਪੜ੍ਹਿਆ';

  @override
  String get looksRight => 'ਠੀਕ ਹੈ';

  @override
  String get fieldName => 'ਨਾਮ';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'ਆਧਾਰ';

  @override
  String get fieldEmployer => 'ਮਾਲਕ';

  @override
  String get fieldNetPay => 'ਸ਼ੁੱਧ ਤਨਖਾਹ';

  @override
  String get fieldPeriod => 'ਤਨਖਾਹ ਦੀ ਮਿਆਦ';

  @override
  String get fieldYear => 'ਸਾਲ';

  @override
  String get fieldIncome => 'ਆਮਦਨ';

  @override
  String get fieldBusiness => 'ਕਾਰੋਬਾਰ';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'ਤੁਹਾਡੇ ਲੋਨ ਲਈ ਲਾਜ਼ਮੀ';

  @override
  String get consentSectionOptional =>
      'ਵਿਕਲਪਿਕ: ਜਦੋਂ ਤੱਕ ਤੁਸੀਂ ਚਾਲੂ ਨਾ ਕਰੋ, ਬੰਦ';

  @override
  String get advancedOptions => 'ਵਿਕਲਪ';

  @override
  String consentValidUntil(String given, String until) {
    return '$given ਨੂੰ ਦਿੱਤੀ · $until ਤੱਕ ਵੈਧ';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given ਨੂੰ ਦਿੱਤੀ · ਵਾਪਸ ਲੈਣ ਤੱਕ';
  }

  @override
  String get recheckTitle => 'ਰਕਮ ਦੇਣ ਤੋਂ ਠੀਕ ਪਹਿਲਾਂ ਇੱਕ ਹੋਰ ਜਾਂਚ';

  @override
  String get recheckBody =>
      'ਰਕਮ ਦੇਣ ਤੋਂ ਠੀਕ ਪਹਿਲਾਂ ਅਸੀਂ ਤੁਹਾਡੀ ਕ੍ਰੈਡਿਟ ਰਿਪੋਰਟ ਫਿਰ ਵੇਖਦੇ ਹਾਂ। ਨਾਂਹ ਕਹਿਣ ਤੇ ਅਧਿਕਾਰੀ ਉਦੋਂ ਪੁੱਛ ਸਕਦਾ ਹੈ।';

  @override
  String get aaMonthsLabel => 'ਕਿੰਨੇ ਮਹੀਨਿਆਂ ਦੀ ਸਟੇਟਮੈਂਟ ਦੇਣੀ ਹੈ';

  @override
  String monthsN(String n) {
    return '$n ਮਹੀਨੇ';
  }

  @override
  String get aaAccountsLabel => 'ਦੇਣ ਵਾਲੇ ਖਾਤੇ';

  @override
  String get accountSavingsSalary => 'ਬੱਚਤ ਖਾਤਾ ·· 0912 · ਤਨਖਾਹ ਜਮ੍ਹਾਂ';

  @override
  String get accountSavings => 'ਬੱਚਤ ਖਾਤਾ ·· 4821';

  @override
  String get accountFd => 'ਫਿਕਸਡ ਡਿਪਾਜ਼ਿਟ ·· 3307';

  @override
  String get aaAccountNeeded => 'ਘੱਟੋ-ਘੱਟ ਇੱਕ ਖਾਤਾ ਚੁਣੋ।';

  @override
  String get kycMethodLabel => 'ਆਪਣੀ ਪਛਾਣ ਕਿਵੇਂ ਪੁਸ਼ਟ ਕਰੋ';

  @override
  String get kycAadhaarOtp => 'ਆਧਾਰ OTP';

  @override
  String get kycDigilocker => 'ਡਿਜੀਲਾਕਰ';

  @override
  String get kycVideo => 'ਵੀਡੀਓ KYC ਕਾਲ';

  @override
  String get useCkycTitle => 'ਮੇਰਾ ਮੌਜੂਦਾ CKYC ਰਿਕਾਰਡ ਵਰਤੋ';

  @override
  String get useCkycBody =>
      'ਜੇ ਤੁਸੀਂ ਕਿਸੇ ਹੋਰ ਬੈਂਕ ਜਾਂ ਫ਼ੰਡ ਨਾਲ KYC ਕੀਤਾ ਹੈ, ਤਾਂ ਦੁਬਾਰਾ ਪੁੱਛਣ ਦੀ ਥਾਂ ਅਸੀਂ ਉਹੀ ਰਿਕਾਰਡ ਲੈਂਦੇ ਹਾਂ।';

  @override
  String get optOffersTitle => 'ਪੇਸ਼ਕਸ਼ਾਂ ਅਤੇ ਨਵੇਂ ਉਤਪਾਦ';

  @override
  String get optOffersBody =>
      'ਚੁਣੋ ਕਿ ਪੇਸ਼ਕਸ਼ਾਂ ਬਾਰੇ ਕਿਵੇਂ ਜਾਣਨਾ ਹੈ। ਇਨ੍ਹਾਂ ਨੂੰ ਕਦੇ ਵੀ ਬੰਦ ਕਰ ਸਕਦੇ ਹੋ।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ਈਮੇਲ';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp ਤੇ ਲੋਨ ਅੱਪਡੇਟ';

  @override
  String get optUpdatesBody =>
      'SMS ਦੇ ਨਾਲ WhatsApp ਤੇ ਸਥਿਤੀ ਅੱਪਡੇਟ ਅਤੇ EMI ਯਾਦ-ਪੱਤਰ।';

  @override
  String get optInsuranceTitle => 'ਹੋਮ ਲੋਨ ਸੁਰੱਖਿਆ ਕੋਟੇਸ਼ਨ';

  @override
  String get optInsuranceBody =>
      'ਕੋਟੇਸ਼ਨ ਲਈ ਆਪਣਾ ਨਾਮ, ਉਮਰ ਅਤੇ ਲੋਨ ਦੀ ਰਕਮ ਸਾਡੇ ਬੀਮਾ ਭਾਈਵਾਲ ਨੂੰ ਦਿਓ। ਖਰੀਦਣਾ ਕਦੇ ਲਾਜ਼ਮੀ ਨਹੀਂ।';

  @override
  String get getQuote => 'ਕੋਟੇਸ਼ਨ ਲਓ';

  @override
  String get manageConsents => 'ਸਹਿਮਤੀਆਂ ਸੰਭਾਲੋ';

  @override
  String get manageConsentsBody =>
      'ਵਿਕਲਪਿਕ ਸਹਿਮਤੀਆਂ ਕਦੇ ਵੀ ਬੰਦ ਕਰੋ। ਲਾਜ਼ਮੀ ਸਹਿਮਤੀ ਵਾਪਸ ਲੈਣ ਤੇ ਅਰਜ਼ੀ ਰੁਕ ਜਾਂਦੀ ਹੈ, ਅਤੇ ਉਸ ਲਈ ਲਿਆ ਡਾਟਾ ਅਸੀਂ ਮਿਟਾ ਦਿੰਦੇ ਹਾਂ।';

  @override
  String get withdraw => 'ਵਾਪਸ ਲਓ';

  @override
  String get consentHistory => 'ਸਹਿਮਤੀ ਦਾ ਇਤਿਹਾਸ';

  @override
  String historyGiven(String item) {
    return '$item ਦਿੱਤੀ';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item ਵਾਪਸ ਲਈ';
  }

  @override
  String get historyEmpty => 'ਅਜੇ ਕੁਝ ਨਹੀਂ।';

  @override
  String get consentOn => 'ਚਾਲੂ';

  @override
  String get consentOff => 'ਬੰਦ';

  @override
  String get withdrawnRequired =>
      'ਤੁਸੀਂ ਇੱਕ ਲਾਜ਼ਮੀ ਸਹਿਮਤੀ ਵਾਪਸ ਲਈ, ਇਸ ਲਈ ਅਰਜ਼ੀ ਰੁਕੀ ਹੋਈ ਹੈ।';

  @override
  String get checkMatchPending =>
      'ਫੋਟੋ ਮਿਲਾਨ: ਆਧਾਰ ਜਾਂ ਪੈਨ ਕਾਰਡ ਅੱਪਲੋਡ ਕਰਨ \'ਤੇ ਹੋਵੇਗਾ';

  @override
  String get realDetailsIntro =>
      'ਆਪਣੇ ਬਾਰੇ ਦੱਸੋ। ਹਰ ਜਾਣਕਾਰੀ ਅਸੀਂ ਤੁਹਾਡੇ ਦਸਤਾਵੇਜ਼ਾਂ ਨਾਲ ਜਾਂਚਦੇ ਹਾਂ।';

  @override
  String get fullNameLabel => 'ਪੂਰਾ ਨਾਮ (ਜਿਵੇਂ ਪੈਨ ਕਾਰਡ \'ਤੇ ਹੈ)';

  @override
  String get emailLabel => 'ਈਮੇਲ';

  @override
  String get employerLabel => 'ਨੌਕਰੀਦਾਤਾ ਜਾਂ ਕਾਰੋਬਾਰ ਦਾ ਨਾਮ';

  @override
  String get creditScoreLabel => 'ਕ੍ਰੈਡਿਟ ਸਕੋਰ (ਵਿਕਲਪਿਕ)';

  @override
  String get creditScoreHint =>
      'ਤੁਹਾਡੀ CIBIL ਜਾਂ Experian ਰਿਪੋਰਟ ਤੋਂ, ਜੇ ਪਤਾ ਹੋਵੇ';

  @override
  String get addressLabel => 'ਪਤਾ';

  @override
  String get saveDetails => 'ਮੇਰੀ ਜਾਣਕਾਰੀ ਸੰਭਾਲੋ';

  @override
  String get selfDeclaredNote =>
      'ਇਹ ਜਾਣਕਾਰੀ ਤੁਸੀਂ ਭਰੀ ਹੈ। ਅੱਗੇ ਤੁਸੀਂ ਜੋ ਦਸਤਾਵੇਜ਼ ਅੱਪਲੋਡ ਕਰੋਗੇ, ਉਨ੍ਹਾਂ ਨਾਲ ਅਸੀਂ ਇਸਨੂੰ ਜਾਂਚਾਂਗੇ।';

  @override
  String get pickDob => 'ਆਪਣੀ ਜਨਮ ਮਿਤੀ ਚੁਣੋ';

  @override
  String get fillDetails =>
      'ਕਿਰਪਾ ਕਰਕੇ ਨਾਮ, ਜਨਮ ਮਿਤੀ, ਕੰਮ, ਨੌਕਰੀਦਾਤਾ ਅਤੇ ਆਮਦਨ ਭਰੋ।';

  @override
  String get docSaleDeed => 'ਵਿਕਰੀ ਡੀਡ ਜਾਂ ਅਲਾਟਮੈਂਟ ਪੱਤਰ';

  @override
  String get saleDeedBody =>
      'ਰਜਿਸਟਰਡ ਵਿਕਰੀ ਦਸਤਾਵੇਜ਼ ਦੀ ਫ਼ੋਟੋ ਜਾਂ PDF ਅੱਪਲੋਡ ਕਰੋ (ਜਿਸ ਪੰਨੇ ਉੱਤੇ ਜਾਇਦਾਦ ਅਤੇ ਖ਼ਰੀਦਦਾਰ ਹੋਵੇ)। ਮਾਲਕੀ ਜਾਂਚਣ ਲਈ ਅਸੀਂ ਇਸਨੂੰ ਪੜ੍ਹਦੇ ਹਾਂ।';

  @override
  String get statusPending => 'ਸਮੀਖਿਆ ਬਾਕੀ';

  @override
  String decisionRef(String ref) {
    return 'ਫ਼ੈਸਲਾ ਰਿਕਾਰਡ $ref';
  }

  @override
  String get scoreTitle => 'ਅਸੀਂ ਤੁਹਾਡਾ ਸਕੋਰ ਕਿਵੇਂ ਕੱਢਿਆ';

  @override
  String get scoreOutOf => '900 ਵਿੱਚੋਂ';

  @override
  String gradeLabel(String grade) {
    return 'ਗ੍ਰੇਡ $grade';
  }

  @override
  String scoreStart(String base) {
    return 'ਹਰ ਕੋਈ $base ਅੰਕਾਂ ਤੋਂ ਸ਼ੁਰੂ ਕਰਦਾ ਹੈ। ਹੇਠਾਂ ਹਰ ਲਾਈਨ ਅੰਕ ਜੋੜਦੀ ਜਾਂ ਘਟਾਉਂਦੀ ਹੈ।';
  }

  @override
  String get scoreNote =>
      'ਇਹ ਫ਼ੈਸਲੇ ਦਾ ਕ੍ਰੈਡਿਟ ਸਕੋਰ ਵਾਲਾ ਹਿੱਸਾ ਹੈ। ਤੁਹਾਡੀ ਆਮਦਨ, ਪਛਾਣ, ਦਸਤਾਵੇਜ਼ ਅਤੇ ਜਾਇਦਾਦ ਦੀ ਵੀ ਜਾਂਚ ਹੁੰਦੀ ਹੈ।';

  @override
  String get factorBureau => 'ਕ੍ਰੈਡਿਟ ਬਿਊਰੋ ਸਕੋਰ';

  @override
  String get factorHistory => 'ਕ੍ਰੈਡਿਟ ਇਤਿਹਾਸ ਦੇ ਸਾਲ';

  @override
  String get factorLtv => 'ਜਾਇਦਾਦ ਦੀ ਕੀਮਤ ਮੁਕਾਬਲੇ ਲੋਨ ਦਾ ਹਿੱਸਾ';

  @override
  String get factorLoanAmount => 'ਲੋਨ ਦੀ ਰਕਮ';

  @override
  String get factorMissing => 'ਉਪਲਬਧ ਨਹੀਂ';

  @override
  String rangeBelow(String x) {
    return '$x ਤੋਂ ਘੱਟ';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$a ਤੋਂ $b';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x ਜਾਂ ਵੱਧ';
  }

  @override
  String get viewLetter => 'ਫ਼ੈਸਲਾ ਪੱਤਰ';

  @override
  String get letterTitle => 'ਤੁਹਾਡਾ ਫ਼ੈਸਲਾ ਪੱਤਰ';

  @override
  String get letterPartlyEnglish =>
      'ਕੁਝ ਲਾਈਨਾਂ ਦਾ ਅਨੁਵਾਦ ਨਹੀਂ ਹੋ ਸਕਿਆ, ਇਸ ਲਈ ਉਹ ਅੰਗਰੇਜ਼ੀ ਵਿੱਚ ਹਨ।';

  @override
  String get copyText => 'ਟੈਕਸਟ ਕਾਪੀ ਕਰੋ';

  @override
  String get copied => 'ਕਾਪੀ ਹੋ ਗਿਆ';

  @override
  String get askTitle => 'ਸਵਾਲ ਪੁੱਛੋ';

  @override
  String get askHint => 'ਜਿਵੇਂ: ਅੱਗੇ ਕੀ ਹੋਵੇਗਾ?';

  @override
  String get askSend => 'ਭੇਜੋ';

  @override
  String get askHuman =>
      'ਸਾਡੀ ਟੀਮ ਦਾ ਕੋਈ ਵਿਅਕਤੀ ਇਸ ਬਾਰੇ ਤੁਹਾਡੇ ਨਾਲ ਸੰਪਰਕ ਕਰੇਗਾ।';

  @override
  String get uploadPdf => 'PDF ਅੱਪਲੋਡ ਕਰੋ';

  @override
  String get kfsFeeBase => 'ਪ੍ਰੋਸੈਸਿੰਗ ਫ਼ੀਸ (0.5%)';

  @override
  String get kfsGst => 'ਫ਼ੀਸ ਉੱਤੇ GST (18%)';

  @override
  String get kfsNoteEngine =>
      'ਇਸ ਪੇਸ਼ਕਸ਼ ਲਈ ਕੱਢਿਆ ਗਿਆ। ਦਸਤਖ਼ਤ ਕੀਤਾ ਮੁੱਖ ਤੱਥ ਬਿਆਨ ਤੁਹਾਡੇ ਮਨਜ਼ੂਰੀ ਪੱਤਰ ਨਾਲ ਆਵੇਗਾ।';

  @override
  String otpOnServer(String phone) {
    return 'ਇਹ ਟੈਸਟ ਸਰਵਰ SMS ਨਹੀਂ ਭੇਜਦਾ। $phone ਦਾ 6 ਅੰਕਾਂ ਦਾ ਕੋਡ ਕੰਪਿਊਟਰ ਦੀ ਸਰਵਰ ਵਿੰਡੋ ਵਿੱਚ ਦਿਖਦਾ ਹੈ।';
  }

  @override
  String get resendOtp => 'ਨਵਾਂ ਕੋਡ ਭੇਜੋ';

  @override
  String get newOtpSent => 'ਨਵਾਂ ਕੋਡ ਭੇਜਿਆ ਗਿਆ।';

  @override
  String get otpExpired => 'ਇਸ ਕੋਡ ਦੀ ਮਿਆਦ ਖ਼ਤਮ ਹੋ ਗਈ। ਨਵਾਂ ਕੋਡ ਭੇਜੋ ਦਬਾਓ।';

  @override
  String get otpTooManyTries => 'ਬਹੁਤ ਵਾਰ ਗ਼ਲਤ ਕੋਡ। ਨਵਾਂ ਕੋਡ ਭੇਜੋ ਦਬਾਓ।';

  @override
  String get otpTooManySends =>
      'ਬਹੁਤ ਜ਼ਿਆਦਾ ਕੋਡ ਮੰਗੇ ਗਏ। 15 ਮਿੰਟ ਰੁਕ ਕੇ ਫਿਰ ਕੋਸ਼ਿਸ਼ ਕਰੋ।';
}
