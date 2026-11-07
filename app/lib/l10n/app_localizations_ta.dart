// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'நிர்ணய்';

  @override
  String get sandboxBanner =>
      'டெமோ பயன்முறை: மாதிரித் தரவு, உண்மையான சரிபார்ப்பு இல்லை';

  @override
  String get continueLabel => 'தொடரவும்';

  @override
  String stepOf(String step, String total) {
    return 'படி $step / $total';
  }

  @override
  String get pleaseWait => 'காத்திருக்கவும்…';

  @override
  String get errorGeneric => 'ஏதோ தவறு நடந்தது. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get close => 'மூடு';

  @override
  String get welcomeHeadline => 'சில நிமிடங்களில் உங்கள் வீட்டுக் கடன் முடிவு';

  @override
  String get welcomeBody =>
      'வீட்டுக் கடன் அல்லது சொத்தின் மீதான கடனுக்கு விண்ணப்பிக்கவும். அனைத்தையும் ஆன்லைனில் சரிபார்த்து, முடிவின் காரணத்தை எப்போதும் சொல்வோம்.';

  @override
  String get chooseProduct => 'உங்களுக்கு என்ன வேண்டும்?';

  @override
  String get productHomeLoan => 'வீட்டுக் கடன்';

  @override
  String get productHomeLoanSub => 'வீடு வாங்க, கட்ட அல்லது புதுப்பிக்க';

  @override
  String get productLap => 'சொத்தின் மீதான கடன்';

  @override
  String get productLapSub => 'உங்கள் சொத்தின் மீது கடன் பெறுங்கள்';

  @override
  String get startApplication => 'விண்ணப்பத்தைத் தொடங்கு';

  @override
  String get demoCustomers => 'டெமோ வாடிக்கையாளர்கள்';

  @override
  String get demoCustomersBody =>
      'மாதிரி மொபைல் எண்ணை நிரப்ப ஒன்றைத் தட்டவும்.';

  @override
  String get personaRavi => 'ரவி, 32, சம்பளதாரர், ஃபிளாட் வாங்குகிறார்';

  @override
  String get personaMeena => 'மீனா, 45, துணிக்கடை நடத்துகிறார் (LAP)';

  @override
  String get personaArjun =>
      'அர்ஜுன், 29, சம்பளதாரர், மாற்றப்பட்ட சம்பளச் சீட்டு';

  @override
  String get signInTitle => 'உள்நுழைக';

  @override
  String get mobileLabel => 'மொபைல் எண்';

  @override
  String get mobileHint => '10 இலக்க மொபைல் எண்';

  @override
  String get invalidMobile => 'சரியான 10 இலக்க மொபைல் எண்ணை உள்ளிடவும்.';

  @override
  String get sendOtp => 'OTP அனுப்பு';

  @override
  String otpSentTo(String phone) {
    return '$phone க்கு 6 இலக்கக் குறியீட்டை அனுப்பியுள்ளோம்.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'சரிபார்';

  @override
  String get demoOtp => 'டெமோ குறியீடு: 123456';

  @override
  String get wrongOtp => 'குறியீடு தவறு. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get deviceBound =>
      'இந்த ஃபோன் இப்போது உங்கள் கணக்குடன் இணைக்கப்பட்டது. வேறு ஃபோனில் உள்நுழைய புதிய OTP தேவை.';

  @override
  String get consentTitle => 'உங்கள் ஒப்புதல்';

  @override
  String get consentIntro =>
      'உங்கள் தரவை இந்தக் கடனின் முடிவுக்கும் நிர்வாகத்துக்கும் மட்டுமே பயன்படுத்துகிறோம். எப்போது வேண்டுமானாலும் ஒப்புதலைத் திரும்பப் பெறலாம்.';

  @override
  String get consentBureauTitle => 'கடன் அறிக்கை';

  @override
  String get consentBureauBody =>
      'கடன் பணியகத்திடம் (CIBIL, Experian, Equifax அல்லது CRIF) உங்கள் கடன் வரலாற்றைச் சரிபார்ப்போம். இதனால் உங்கள் மதிப்பெண் குறையாது.';

  @override
  String get consentAaTitle =>
      'கணக்கு ஒருங்கிணைப்பாளர் வழியாக வங்கி அறிக்கைகள்';

  @override
  String get consentAaBody =>
      'RBI உரிமம் பெற்ற கணக்கு ஒருங்கிணைப்பாளர் வழியாக உங்கள் வங்கியின் 12 மாத அறிக்கைகளைப் பெறுவோம். கோரிக்கையை உங்கள் AA செயலியில் நீங்கள் அங்கீகரிப்பீர்கள்.';

  @override
  String get consentKycTitle => 'ஆதார் eKYC மற்றும் PAN';

  @override
  String get consentKycBody =>
      'UIDAI மற்றும் வருமான வரித் துறையுடன் உங்கள் அடையாளத்தை உறுதிசெய்வோம். மறைக்கப்பட்ட ஆதார் எண்ணை மட்டுமே வைத்திருப்போம்.';

  @override
  String get consentPrivacyTitle => 'தனியுரிமை அறிவிப்பு (DPDP சட்டம் 2023)';

  @override
  String get consentPrivacyBody =>
      'எதைச் சேகரிக்கிறோம்: அடையாளம், வருமானம், வங்கி மற்றும் சொத்து விவரங்கள். ஏன்: உங்கள் கடனின் முடிவுக்கும் நிர்வாகத்துக்கும். எவ்வளவு காலம்: சட்டம் கோரும் காலம் மட்டுமே. உங்கள் உரிமைகள்: தரவைப் பார்க்க, திருத்த அல்லது அழிக்க, எங்கள் குறைதீர்ப்பு அலுவலர் அல்லது தரவுப் பாதுகாப்பு வாரியத்திடம் புகார் செய்ய.';

  @override
  String get consentRequired => 'கட்டாயம்';

  @override
  String get consentNeeded => 'தொடர அனைத்துக்கும் ஒப்புக்கொள்ளவும்.';

  @override
  String get agreeAndContinue => 'ஒப்புக்கொண்டு தொடரவும்';

  @override
  String get detailsTitle => 'உங்கள் விவரங்கள்';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'சரியான PAN ஐ உள்ளிடவும், எ.கா. ABCDE1234F.';

  @override
  String get fetchDetails => 'என் விவரங்களைப் பெறு';

  @override
  String get fetchedFrom =>
      'PAN, ஆதார் eKYC மற்றும் வங்கி அறிக்கைகளிலிருந்து நிரப்பப்பட்டது. திருத்த ஒரு எண்ணைத் தட்டவும்.';

  @override
  String get nameLabel => 'பெயர்';

  @override
  String get dobLabel => 'பிறந்த தேதி';

  @override
  String get employmentLabel => 'வேலை';

  @override
  String get salaried => 'சம்பளதாரர்';

  @override
  String get selfEmployed => 'சுயதொழில்';

  @override
  String get incomeLabel => 'மாத நிகர வருமானம்';

  @override
  String get existingEmiLabel => 'தற்போதைய மாத EMI';

  @override
  String get propertyValueLabel => 'சொத்து மதிப்பு';

  @override
  String get loanAmountLabel => 'கடன் தொகை';

  @override
  String get tenureLabel => 'காலம்';

  @override
  String yearsLabel(String n) {
    return '$n ஆண்டுகள்';
  }

  @override
  String get eligibleTitle => 'நீங்கள் பெறக்கூடிய அதிகபட்சம்';

  @override
  String emiPerMonth(String amount) {
    return 'மாதம் EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'ஆண்டுக்கு $rate%, மாறும் வட்டி (உதாரணம்)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'வருமானத்தால் வரம்பு: உங்கள் எல்லா EMI யும் சேர்ந்து வருமானத்தில் $pct வரை இருக்கலாம்.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'சொத்தால் வரம்பு: இந்த அளவுக் கடன் மதிப்பில் $pct வரை இருக்கலாம்.';
  }

  @override
  String get limitedByAsked => 'இது நீங்கள் கேட்ட தொகை.';

  @override
  String get eligibilityNote =>
      'உங்கள் விவரங்களின் விரைவுச் சரிபார்ப்பு. எங்கள் சரிபார்ப்புக்குப் பிறகு சலுகை வரும்.';

  @override
  String get selfieTitle => 'செல்ஃபி எடுக்கவும்';

  @override
  String get selfieBody =>
      'உங்கள் முகத்தை ஆதார் புகைப்படத்துடன் ஒப்பிட்டு, உண்மையில் நீங்கள்தானா, புகைப்படத்தின் புகைப்படம் இல்லையா என்று பார்ப்போம்.';

  @override
  String get selfieTips =>
      'நல்ல வெளிச்சம், கேமராவைப் பாருங்கள், தொப்பி அல்லது கண்ணாடி வேண்டாம்.';

  @override
  String get takeSelfie => 'செல்ஃபி எடு';

  @override
  String get retake => 'மீண்டும் எடு';

  @override
  String get checkFace => 'முகம் கண்டறியப்பட்டது';

  @override
  String get checkLive => 'உயிருள்ள நபர்';

  @override
  String get checkMatch => 'ஆதார் புகைப்படத்துடன் பொருந்துகிறது';

  @override
  String get selfieFailed =>
      'உங்கள் முகத்தை உறுதிசெய்ய முடியவில்லை. நல்ல வெளிச்சத்தில் மீண்டும் முயற்சிக்கவும், அல்லது வீடியோ KYC அழைப்பை முன்பதிவு செய்யவும்.';

  @override
  String get videoKyc => 'வீடியோ KYC அழைப்பை முன்பதிவு செய்';

  @override
  String get docsTitle => 'உங்கள் ஆவணங்கள்';

  @override
  String get docsBody =>
      'ஒவ்வொரு ஆவணத்தையும் தெளிவாகப் புகைப்படம் எடுக்கவும், அல்லது கேலரியிலிருந்து தேர்வு செய்யவும்.';

  @override
  String get docPan => 'PAN அட்டை';

  @override
  String get docAadhaar => 'ஆதார் அட்டை (மறைக்கப்பட்டது)';

  @override
  String get docSalarySlip => 'சமீபத்திய சம்பளச் சீட்டு';

  @override
  String get docForm16 => 'படிவம் 16';

  @override
  String get docItr => 'வருமான வரி அறிக்கை (ITR)';

  @override
  String get docGst => 'GST சான்றிதழ்';

  @override
  String get docBankStatement => 'வங்கி அறிக்கை';

  @override
  String get bankViaAa => 'உங்கள் கணக்கு ஒருங்கிணைப்பாளர் வழியாகப் பெறப்பட்டது';

  @override
  String get camera => 'கேமரா';

  @override
  String get gallery => 'கேலரி';

  @override
  String get checking => 'சரிபார்க்கிறது…';

  @override
  String get tooBlurry =>
      'மிகவும் மங்கலாக உள்ளது. ஃபோனை அசையாமல் பிடித்து மீண்டும் முயற்சிக்கவும்.';

  @override
  String get tooMuchGlare =>
      'மிகுந்த ஒளிர்வு. வெளிச்சத்திலிருந்து விலகி மீண்டும் முயற்சிக்கவும்.';

  @override
  String get tooDark =>
      'மிகவும் இருட்டாக உள்ளது. அதிக வெளிச்சத்தில் மீண்டும் முயற்சிக்கவும்.';

  @override
  String docAccepted(String type) {
    return 'அடையாளம் காணப்பட்டது: $type';
  }

  @override
  String docWrong(String expected) {
    return 'இது $expected போலத் தெரியவில்லை. சரிபார்த்து சரியான ஆவணத்தைப் பதிவேற்றவும்.';
  }

  @override
  String get docUnreadable =>
      'இந்த ஆவணத்தைப் படிக்க முடியவில்லை. தெளிவான புகைப்படம் எடுக்கவும், அல்லது அசல் PDF ஐப் பதிவேற்றவும்.';

  @override
  String docsMissing(String n) {
    return 'இன்னும் $n தேவை';
  }

  @override
  String get getOffer => 'என் கொள்கை அளவிலான சலுகையைக் காட்டு';

  @override
  String get approvedInPrinciple => 'கொள்கை அளவில் ஒப்புதல்';

  @override
  String get sanctioned => 'கடன் அனுமதிக்கப்பட்டது';

  @override
  String get referredTitle => 'எங்களுக்குச் சற்று அதிக நேரம் தேவை';

  @override
  String get rejectedTitle => 'இப்போது இந்தக் கடனை வழங்க முடியாது';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years ஆண்டுகள் · ஆண்டுக்கு $rate% மாறும் வட்டி';
  }

  @override
  String get whyOffer => 'இந்தச் சலுகை ஏன் கிடைத்தது';

  @override
  String get whyReferred => 'அடுத்து என்ன நடக்கும்';

  @override
  String get whyRejected => 'ஏன் இந்த முடிவு';

  @override
  String get referBody =>
      'ஒரு அலுவலர் ஒரு வேலை நாளுக்குள் உங்கள் விண்ணப்பத்தைப் பார்ப்பார். இப்போது நீங்கள் எதுவும் செய்ய வேண்டியதில்லை.';

  @override
  String get rejectBody =>
      'இந்த முடிவை ஒருவர் மறுபரிசீலனை செய்யுமாறு எப்போது வேண்டுமானாலும் கேட்கலாம்.';

  @override
  String get addProperty => 'சொத்து விவரங்களைச் சேர்';

  @override
  String get viewKfs => 'முக்கிய உண்மைகள் அறிக்கையைப் பார்';

  @override
  String get grievance => 'மறுபரிசீலனை கேளுங்கள் அல்லது புகார் செய்யுங்கள்';

  @override
  String officerLine(String name, String email) {
    return 'குறைதீர்ப்பு அலுவலர்: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'விண்ணப்பம் $id';
  }

  @override
  String get startOver => 'புதிய விண்ணப்பத்தைத் தொடங்கு';

  @override
  String okScore(String score) {
    return 'வலுவான திருப்பிச் செலுத்தும் வரலாறு (மதிப்பெண் $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI வருமானத்தில் $pct; எங்கள் வரம்பு $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'கடன் சொத்து மதிப்பில் $pct; வரம்பு $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'சொத்தின் எங்கள் மதிப்பீடு: $low முதல் $high';
  }

  @override
  String get okTitle => 'சொத்து உரிமை மற்றும் ஆவணங்கள் சரிபார்க்கப்பட்டன';

  @override
  String get reasonKyc01 =>
      'புகைப்படத்திலிருந்து உங்கள் அடையாளத்தை உறுதிசெய்ய முடியவில்லை. சிறிய வீடியோ KYC அழைப்பை முடிக்கவும்.';

  @override
  String get reasonFrd02 =>
      'சம்பளச் சீட்டில் உள்ள வருமானம் வங்கி வரவுகளுடன் பொருந்தவில்லை. சமீபத்திய படிவம் 16 ஐக் கொடுங்கள், அல்லது ஒப்புதலுடன் எங்களைப் பெற விடுங்கள்.';

  @override
  String get reasonFrd03 =>
      'உங்கள் ஆவணங்களில் ஒன்று வழங்கிய அதிகாரியின் சரிபார்ப்பில் தோல்வியடைந்தது.';

  @override
  String get reasonPol01 =>
      'விண்ணப்பதாரர்களுக்குக் குறைந்தது 21 வயது இருக்க வேண்டும்.';

  @override
  String get reasonPol02 =>
      'கடன் நாங்கள் அனுமதிக்கும் அதிகபட்ச வயதைத் தாண்டிவிடும். இளைய இணை விண்ணப்பதாரரைச் சேர்ப்பது உதவலாம்.';

  @override
  String get reasonBur01 =>
      'உங்கள் கடன் மதிப்பெண் எங்கள் குறைந்தபட்சமான 650 க்குக் கீழ் உள்ளது.';

  @override
  String get reasonBur04 =>
      'உங்களுக்கு இன்னும் கடன் வரலாறு இல்லை, எனவே ஒரு அலுவலர் உங்கள் வங்கிப் பதிவுகளைப் பார்ப்பார்.';

  @override
  String get reasonBur05 =>
      'உங்கள் கடன் மதிப்பெண்ணை ஒரு அலுவலர் கவனமாகப் பார்க்க வேண்டும்.';

  @override
  String get reasonPrp01 =>
      'எங்கள் வழக்கறிஞர் சொத்து உரிமையை மறுபரிசீலனை செய்ய வேண்டும்.';

  @override
  String get reasonPrp03 =>
      'மதிப்பை உறுதிசெய்ய எங்கள் மதிப்பீட்டாளர் சொத்தைப் பார்வையிட வேண்டும்.';

  @override
  String get reasonPrp04 =>
      'ஒப்பந்த மதிப்பு இந்தச் சொத்தின் அரசு வழிகாட்டி மதிப்பை விடக் குறைவாக உள்ளது. விற்பனை ஒப்பந்தத்தைச் சரிபார்க்கவும்.';

  @override
  String get reasonAff01 =>
      'உங்கள் தற்போதைய EMI ஏற்கனவே நாங்கள் கடன் தரக்கூடிய அதிகபட்ச வருமானப் பங்கைப் பயன்படுத்துகிறது.';

  @override
  String get reasonAut01 =>
      'இந்த அளவுக் கடன்களை ஒரு மூத்த அலுவலர் இறுதியாகச் சரிபார்ப்பார்.';

  @override
  String get reasonRsk01 =>
      'சலுகையை இறுதிசெய்ய ஒரு அலுவலர் உங்கள் விண்ணப்பத்தைப் பார்ப்பார்.';

  @override
  String get reasonRsk02 =>
      'உங்கள் கடன் விவரத்தின் அடிப்படையில், இப்போது இந்தக் கடனை வழங்க முடியாது.';

  @override
  String get propertyTitle => 'உங்கள் சொத்து';

  @override
  String get cityLabel => 'நகரம்';

  @override
  String get localityLabel => 'பகுதி';

  @override
  String get societyLabel => 'திட்டம் அல்லது சொசைட்டி (இருந்தால்)';

  @override
  String get areaLabel => 'பரப்பளவு (ச. அடி)';

  @override
  String get bhkLabel => 'படுக்கையறைகள்';

  @override
  String get newProperty => 'புதியது';

  @override
  String get resale => 'மறுவிற்பனை';

  @override
  String get declaredPriceLabel => 'ஒப்பந்த மதிப்பு';

  @override
  String get photosTitle => 'சொத்துப் புகைப்படங்கள்';

  @override
  String get photosBody =>
      'சொத்து இருக்கும் இடத்திலேயே புகைப்படம் எடுக்கவும். மதிப்பீட்டாளர் வருகையைத் திட்டமிட இடத்தையும் நேரத்தையும் சேர்ப்போம்.';

  @override
  String get photoFront => 'முன்பக்கம்';

  @override
  String get photoInside => 'உள்ளே';

  @override
  String get photoView => 'சொத்திலிருந்து காட்சி';

  @override
  String geoTagged(String lat, String lng) {
    return 'இருப்பிடம் சேர்க்கப்பட்டது ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'இருப்பிடம் இல்லாமல் புகைப்படம் சேமிக்கப்பட்டது. ஜியோ-டேக்கிற்கு இருப்பிடத்தை இயக்கவும்.';

  @override
  String get submitProperty => 'இறுதி அனுமதியைப் பெறு';

  @override
  String get fillAll => 'அனைத்துப் புலங்களையும் நிரப்பவும்.';

  @override
  String get kfsTitle => 'முக்கிய உண்மைகள் அறிக்கை';

  @override
  String get kfsLoan => 'கடன் தொகை';

  @override
  String get kfsTenure => 'காலம்';

  @override
  String get kfsRate => 'வட்டி விகிதம்';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI களின் எண்ணிக்கை';

  @override
  String get kfsFee => 'செயலாக்கக் கட்டணம் (GST உடன்)';

  @override
  String get kfsTotalInterest => 'மொத்த வட்டி';

  @override
  String get kfsTotalPayable => 'செலுத்த வேண்டிய மொத்தத் தொகை';

  @override
  String get kfsApr => 'ஆண்டு சதவீத விகிதம் (APR)';

  @override
  String get kfsCoolingOff =>
      'கூலிங்-ஆஃப் காலம்: கையெழுத்திட்ட 3 நாட்களுக்குள் அசலையும் அந்த நாட்களின் வட்டியையும் மட்டும் திருப்பிச் செலுத்தி அபராதமின்றி வெளியேறலாம்.';

  @override
  String get kfsNote =>
      'டெமோவுக்கான மாதிரி எண்கள். உண்மையான KFS உங்கள் அனுமதிக் கடிதத்துடன் வரும்.';

  @override
  String get useSample => 'மாதிரி';

  @override
  String get videoKycDemo =>
      'டெமோ: இது ஒரு அலுவலருடன் வீடியோ KYC அழைப்பை முன்பதிவு செய்யும்.';

  @override
  String get raiseComplaint => 'புகார் செய்';

  @override
  String complaintSent(String ref) {
    return 'உங்கள் புகார் பதிவு செய்யப்பட்டது. குறிப்பு $ref.';
  }

  @override
  String get stageSignIn => 'உள்நுழைவு';

  @override
  String get stageDetails => 'விவரங்கள்';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'சலுகை';

  @override
  String get stageProperty => 'சொத்து';

  @override
  String get homeSubtitle => 'வீட்டுக் கடன் · சொத்தின் மீதான கடன்';

  @override
  String get heroPill => 'நிமிடங்களில் முடிவு';

  @override
  String heroFacts(String rate, String years) {
    return 'ஆண்டுக்கு $rate% முதல் · $years ஆண்டுகள் வரை';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% முடிந்தது · நிறுத்திய இடத்திலிருந்து தொடருங்கள்';
  }

  @override
  String get resume => 'தொடர்';

  @override
  String get calculators => 'கணிப்பான்கள்';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'மாதத் தவணை';

  @override
  String get calcEligibility => 'தகுதி';

  @override
  String get calcEligibilitySub => 'எவ்வளவு பெறலாம்';

  @override
  String get emiCalcTitle => 'EMI கணிப்பான்';

  @override
  String get eligibilityCalcTitle => 'தகுதி கணிப்பான்';

  @override
  String totalInterest(String amount) {
    return 'மொத்த வட்டி $amount';
  }

  @override
  String get calcIncomeOnly =>
      'வருமானத்தை மட்டும் வைத்து. சொத்தின் மதிப்பு இதைக் குறைக்கலாம்.';

  @override
  String get verified => 'சரிபார்க்கப்பட்டது';

  @override
  String get yourLoan => 'உங்கள் கடன்';

  @override
  String docsProgress(String done, String total) {
    return '$total இல் $done சரிபார்க்கப்பட்டன';
  }

  @override
  String get docNeeded => 'தேவை';

  @override
  String get docTryAgain => 'மீண்டும் முயல்';

  @override
  String get fetched => 'பெறப்பட்டது';

  @override
  String get statusApproved => 'ஒப்புதல்';

  @override
  String get statusSanctioned => 'அனுமதிக்கப்பட்டது';

  @override
  String get statusInReview => 'பரிசீலனையில்';

  @override
  String get statusDeclined => 'நிராகரிக்கப்பட்டது';

  @override
  String get trackTitle => 'உங்கள் விண்ணப்பத்தைக் கண்காணிக்கவும்';

  @override
  String get tlSubmitted => 'விண்ணப்பம் சமர்ப்பிக்கப்பட்டது';

  @override
  String get tlVerified => 'KYC மற்றும் ஆவணங்கள் சரிபார்க்கப்பட்டன';

  @override
  String get tlInPrinciple => 'கொள்கை அளவிலான ஒப்புதல்';

  @override
  String get tlProperty => 'சொத்து விவரங்கள் மற்றும் மதிப்பீடு';

  @override
  String get tlPropertyNext =>
      'உங்கள் சொத்தின் விவரங்களையும் புகைப்படங்களையும் சேர்க்கவும்';

  @override
  String get tlOfficer => 'அலுவலர் பரிசீலனை';

  @override
  String get tlOfficerNext => 'ஒரு வேலை நாளுக்குள்';

  @override
  String get tlLegal => 'சட்ட மற்றும் உரிமைச் சரிபார்ப்பு';

  @override
  String get tlSanction => 'இறுதி அனுமதி மற்றும் மின்-கையெழுத்து';

  @override
  String get tlSanctionNext =>
      'அனுமதிக் கடிதத்தில் ஆன்லைனில் கையெழுத்திடுங்கள்';

  @override
  String get tlDisbursement => 'தொகை வழங்கல்';

  @override
  String get helpTitle => 'உதவி வேண்டுமா?';

  @override
  String get propertyType => 'புதியதா மறுவிற்பனையா';

  @override
  String get greetMorning => 'காலை வணக்கம்';

  @override
  String get greetAfternoon => 'மதிய வணக்கம்';

  @override
  String get greetEvening => 'மாலை வணக்கம்';

  @override
  String nearlyThere(String name) {
    return '$name, கிட்டத்தட்ட முடிந்துவிட்டது';
  }

  @override
  String get chooseLanguage => 'உங்கள் மொழியைத் தேர்வு செய்யவும்';

  @override
  String get languageNote => 'இதை எப்போது வேண்டுமானாலும் மாற்றலாம்.';

  @override
  String get liveChecks => 'நேரடிச் சரிபார்ப்புகள்';

  @override
  String get checkBureau => 'கடன் பணியகம்';

  @override
  String checkScore(String score) {
    return 'மதிப்பெண் $score';
  }

  @override
  String get checkNoHistory => 'இன்னும் வரலாறு இல்லை';

  @override
  String get checkBank => 'AA வழியாக வங்கி';

  @override
  String get checkBankRead => '12 மாதங்கள் படிக்கப்பட்டன';

  @override
  String get checkKyc => 'eKYC மற்றும் செல்ஃபி';

  @override
  String get checkPending => 'நிலுவையில்';

  @override
  String get checkDocs => 'ஆவணங்கள்';

  @override
  String countOf(String done, String total) {
    return '$total இல் $done';
  }

  @override
  String minutesLeft(String n) {
    return 'சுமார் $n நிமிடங்கள் உள்ளன';
  }

  @override
  String ratePa(String rate) {
    return 'ஆண்டுக்கு $rate%';
  }

  @override
  String get continueApplication => 'உங்கள் விண்ணப்பத்தைத் தொடருங்கள்';

  @override
  String get shapeOffer => 'உங்கள் சலுகையை வடிவமையுங்கள்';

  @override
  String get shapeOfferSub => 'கொள்கை அளவில் ஒப்புதல் · மாற்ற இழுக்கவும்';

  @override
  String get withinLimits => 'உங்கள் வரம்புகளுக்குள்';

  @override
  String get aboveLimits =>
      'வரம்பை மீறியது: தொகையைக் குறைக்கவும் அல்லது ஆண்டுகளைக் கூட்டவும்';

  @override
  String mostYouCan(String amount) {
    return 'அதிகபட்சம் பெறலாம்: $amount';
  }

  @override
  String get useMax => 'அதிகபட்சம் எடு';

  @override
  String get principal => 'அசல்';

  @override
  String get interest => 'வட்டி';

  @override
  String get totalRepaid => 'மொத்தம் திருப்பிச் செலுத்துவது';

  @override
  String get emiShareIncome => 'வருமானத்தில் EMI பங்கு';

  @override
  String loanShareProperty(String value) {
    return '$value சொத்தில் கடன் பங்கு';
  }

  @override
  String get lockOffer => 'இந்தச் சலுகையை உறுதிசெய்';

  @override
  String get offerLocked => 'உங்கள் சலுகை உறுதிசெய்யப்பட்டது.';

  @override
  String approvedUpTo(String amount) {
    return '$amount வரை ஒப்புதல்';
  }

  @override
  String readingDoc(String doc) {
    return 'உங்கள் $doc படிக்கப்படுகிறது';
  }

  @override
  String get documentAi => 'ஆவண AI';

  @override
  String sure(String pct) {
    return '$pct% உறுதி';
  }

  @override
  String get readMatches => 'நாங்கள் கேட்ட ஆவணம்தான் இது';

  @override
  String get readClear => 'தெளிவான புகைப்படம், மங்கல் அல்லது ஒளிர்வு இல்லை';

  @override
  String get whatWeRead => 'நாங்கள் படித்தவை';

  @override
  String get looksRight => 'சரியாக உள்ளது';

  @override
  String get fieldName => 'பெயர்';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'ஆதார்';

  @override
  String get fieldEmployer => 'முதலாளி';

  @override
  String get fieldNetPay => 'நிகரச் சம்பளம்';

  @override
  String get fieldPeriod => 'சம்பளக் காலம்';

  @override
  String get fieldYear => 'ஆண்டு';

  @override
  String get fieldIncome => 'வருமானம்';

  @override
  String get fieldBusiness => 'தொழில்';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'உங்கள் கடனுக்குத் தேவை';

  @override
  String get consentSectionOptional =>
      'விருப்பத்தேர்வு: நீங்கள் இயக்கும் வரை அணைப்பு';

  @override
  String get advancedOptions => 'விருப்பங்கள்';

  @override
  String consentValidUntil(String given, String until) {
    return '$given அன்று வழங்கப்பட்டது · $until வரை செல்லும்';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given அன்று வழங்கப்பட்டது · திரும்பப் பெறும் வரை';
  }

  @override
  String get recheckTitle => 'பணம் வழங்கும் முன் இன்னொரு சரிபார்ப்பு';

  @override
  String get recheckBody =>
      'பணம் வழங்கும் முன் உங்கள் கடன் அறிக்கையை மீண்டும் பார்ப்போம். வேண்டாம் என்றால் அப்போது ஒரு அலுவலர் கேட்கலாம்.';

  @override
  String get aaMonthsLabel => 'எத்தனை மாத அறிக்கைகளைப் பகிர வேண்டும்';

  @override
  String monthsN(String n) {
    return '$n மாதங்கள்';
  }

  @override
  String get aaAccountsLabel => 'பகிர வேண்டிய கணக்குகள்';

  @override
  String get accountSavingsSalary => 'சேமிப்பு ·· 0912 · சம்பள வரவுகள்';

  @override
  String get accountSavings => 'சேமிப்பு ·· 4821';

  @override
  String get accountFd => 'நிலை வைப்பு ·· 3307';

  @override
  String get aaAccountNeeded => 'குறைந்தது ஒரு கணக்கைத் தேர்வு செய்யவும்.';

  @override
  String get kycMethodLabel => 'அடையாளத்தை எப்படி உறுதிசெய்வது';

  @override
  String get kycAadhaarOtp => 'ஆதார் OTP';

  @override
  String get kycDigilocker => 'டிஜிலாக்கர்';

  @override
  String get kycVideo => 'வீடியோ KYC அழைப்பு';

  @override
  String get useCkycTitle => 'என் தற்போதைய CKYC பதிவைப் பயன்படுத்து';

  @override
  String get useCkycBody =>
      'வேறு வங்கி அல்லது நிதியில் KYC செய்திருந்தால், மீண்டும் கேட்காமல் அந்தப் பதிவைப் பெறுவோம்.';

  @override
  String get optOffersTitle => 'சலுகைகளும் புதிய தயாரிப்புகளும்';

  @override
  String get optOffersBody =>
      'சலுகைகளைப் பற்றி எப்படி அறிய விரும்புகிறீர்கள் என்று தேர்வு செய்யவும். எப்போது வேண்டுமானாலும் அணைக்கலாம்.';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'மின்னஞ்சல்';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp இல் கடன் தகவல்கள்';

  @override
  String get optUpdatesBody =>
      'SMS உடன் WhatsApp இலும் நிலைத் தகவல்கள், EMI நினைவூட்டல்கள்.';

  @override
  String get optInsuranceTitle => 'வீட்டுக் கடன் பாதுகாப்பு மதிப்பீடு';

  @override
  String get optInsuranceBody =>
      'மதிப்பீட்டுக்காக உங்கள் பெயர், வயது, கடன் தொகையை எங்கள் காப்பீட்டுக் கூட்டாளருடன் பகிருங்கள். வாங்குவது ஒருபோதும் கட்டாயமில்லை.';

  @override
  String get getQuote => 'மதிப்பீடு பெறு';

  @override
  String get manageConsents => 'ஒப்புதல்களை நிர்வகி';

  @override
  String get manageConsentsBody =>
      'விருப்ப ஒப்புதல்களை எப்போது வேண்டுமானாலும் அணைக்கலாம். தேவையான ஒன்றைத் திரும்பப் பெற்றால் விண்ணப்பம் நிற்கும், அதற்காகப் பெற்ற தரவை அழிப்போம்.';

  @override
  String get withdraw => 'திரும்பப் பெறு';

  @override
  String get consentHistory => 'ஒப்புதல் வரலாறு';

  @override
  String historyGiven(String item) {
    return '$item வழங்கப்பட்டது';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item திரும்பப் பெறப்பட்டது';
  }

  @override
  String get historyEmpty => 'இன்னும் எதுவும் இல்லை.';

  @override
  String get consentOn => 'இயக்கம்';

  @override
  String get consentOff => 'அணைப்பு';

  @override
  String get withdrawnRequired =>
      'தேவையான ஒப்புதலைத் திரும்பப் பெற்றதால், விண்ணப்பம் நிறுத்தப்பட்டுள்ளது.';

  @override
  String get checkMatchPending =>
      'புகைப்பட ஒப்பீடு: ஆதார் அல்லது பான் அட்டையைப் பதிவேற்றும்போது நடக்கும்';

  @override
  String get realDetailsIntro =>
      'உங்களைப் பற்றிச் சொல்லுங்கள். ஒவ்வொரு விவரத்தையும் உங்கள் ஆவணங்களுடன் சரிபார்க்கிறோம்.';

  @override
  String get fullNameLabel => 'முழுப் பெயர் (பான் அட்டையில் உள்ளபடி)';

  @override
  String get emailLabel => 'மின்னஞ்சல்';

  @override
  String get employerLabel => 'வேலை வழங்குநர் அல்லது தொழில் பெயர்';

  @override
  String get creditScoreLabel => 'கடன் மதிப்பெண் (விருப்பம்)';

  @override
  String get creditScoreHint =>
      'உங்கள் CIBIL அல்லது Experian அறிக்கையிலிருந்து, தெரிந்தால்';

  @override
  String get addressLabel => 'முகவரி';

  @override
  String get saveDetails => 'என் விவரங்களைச் சேமி';

  @override
  String get selfDeclaredNote =>
      'இந்த விவரங்களை நீங்கள் உள்ளிட்டீர்கள். அடுத்து பதிவேற்றும் ஆவணங்களுடன் இவற்றைச் சரிபார்ப்போம்.';

  @override
  String get pickDob => 'உங்கள் பிறந்த தேதியைத் தேர்வுசெய்க';

  @override
  String get fillDetails =>
      'பெயர், பிறந்த தேதி, வேலை, வேலை வழங்குநர், வருமானம் ஆகியவற்றை நிரப்புங்கள்.';

  @override
  String get docSaleDeed => 'விற்பனைப் பத்திரம் அல்லது ஒதுக்கீட்டுக் கடிதம்';

  @override
  String get saleDeedBody =>
      'பதிவுசெய்த விற்பனைப் பத்திரத்தின் புகைப்படம் அல்லது PDF-ஐப் பதிவேற்றுங்கள் (சொத்தும் வாங்குபவரும் உள்ள பக்கம்). உரிமையைச் சரிபார்க்க இதைப் படிக்கிறோம்.';

  @override
  String get statusPending => 'பரிசீலனை நிலுவையில்';

  @override
  String decisionRef(String ref) {
    return 'முடிவுப் பதிவு $ref';
  }

  @override
  String get scoreTitle => 'உங்கள் மதிப்பெண்ணை எப்படிக் கணக்கிட்டோம்';

  @override
  String get scoreOutOf => '900-க்கு';

  @override
  String gradeLabel(String grade) {
    return 'தரம் $grade';
  }

  @override
  String scoreStart(String base) {
    return 'எல்லோரும் $base புள்ளிகளில் தொடங்குகிறார்கள். கீழே உள்ள ஒவ்வொரு வரியும் புள்ளிகளைக் கூட்டும் அல்லது குறைக்கும்.';
  }

  @override
  String get scoreNote =>
      'இது முடிவின் கடன் மதிப்பெண் பகுதி. உங்கள் வருமானம், அடையாளம், ஆவணங்கள், சொத்தும் சரிபார்க்கப்படும்.';

  @override
  String get factorBureau => 'கடன் பணியக மதிப்பெண்';

  @override
  String get factorHistory => 'கடன் வரலாற்றின் ஆண்டுகள்';

  @override
  String get factorLtv => 'சொத்து மதிப்பில் கடனின் பங்கு';

  @override
  String get factorLoanAmount => 'கடன் தொகை';

  @override
  String get factorMissing => 'கிடைக்கவில்லை';

  @override
  String rangeBelow(String x) {
    return '$x-க்குக் குறைவு';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$a முதல் $b வரை';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x அல்லது அதற்கு மேல்';
  }

  @override
  String get viewLetter => 'முடிவுக் கடிதம்';

  @override
  String get letterTitle => 'உங்கள் முடிவுக் கடிதம்';

  @override
  String get letterPartlyEnglish =>
      'சில வரிகளை மொழிபெயர்க்க முடியவில்லை, அவை ஆங்கிலத்தில் உள்ளன.';

  @override
  String get copyText => 'உரையை நகலெடு';

  @override
  String get copied => 'நகலெடுக்கப்பட்டது';

  @override
  String get askTitle => 'கேள்வி கேளுங்கள்';

  @override
  String get askHint => 'எ.கா: அடுத்து என்ன நடக்கும்?';

  @override
  String get askSend => 'அனுப்பு';

  @override
  String get askHuman =>
      'எங்கள் குழுவில் ஒருவர் இதுகுறித்து உங்களைத் தொடர்புகொள்வார்.';

  @override
  String get uploadPdf => 'PDF பதிவேற்று';

  @override
  String get kfsFeeBase => 'செயலாக்கக் கட்டணம் (0.5%)';

  @override
  String get kfsGst => 'கட்டணத்தின் மீது GST (18%)';

  @override
  String get kfsNoteEngine =>
      'இந்தச் சலுகைக்காகக் கணக்கிடப்பட்டது. கையொப்பமிட்ட முக்கிய உண்மைகள் அறிக்கை உங்கள் ஒப்புதல் கடிதத்துடன் வரும்.';

  @override
  String otpOnServer(String phone) {
    return 'இந்தச் சோதனைச் சேவையகம் SMS அனுப்பாது. $phone-க்கான 6 இலக்கக் குறியீடு கணினியின் சேவையகச் சாளரத்தில் தெரியும்.';
  }

  @override
  String get resendOtp => 'புதிய குறியீட்டை அனுப்பு';

  @override
  String get newOtpSent => 'புதிய குறியீடு அனுப்பப்பட்டது.';

  @override
  String get otpExpired =>
      'இந்தக் குறியீடு காலாவதியானது. புதிய குறியீட்டை அனுப்பு என்பதைத் தட்டுங்கள்.';

  @override
  String get otpTooManyTries =>
      'பலமுறை தவறான குறியீடு. புதிய குறியீட்டை அனுப்பு என்பதைத் தட்டுங்கள்.';

  @override
  String get otpTooManySends =>
      'மிக அதிகமான குறியீடுகள் கேட்கப்பட்டன. 15 நிமிடம் காத்திருந்து மீண்டும் முயலுங்கள்.';
}
