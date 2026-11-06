// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Maithili (`mai`).
class AppLocalizationsMai extends AppLocalizations {
  AppLocalizationsMai([String locale = 'mai']) : super(locale);

  @override
  String get appTitle => 'निर्णय';

  @override
  String get sandboxBanner => 'डेमो मोड: नमूना डेटा, असली जाँच नहि';

  @override
  String get continueLabel => 'आगू बढ़ू';

  @override
  String stepOf(String step, String total) {
    return 'चरण $step / $total';
  }

  @override
  String get pleaseWait => 'कृपया प्रतीक्षा करू…';

  @override
  String get errorGeneric => 'किछु गड़बड़ भेल। फेर सँ प्रयास करू।';

  @override
  String get close => 'बंद करू';

  @override
  String get welcomeHeadline => 'किछु मिनट मे अहाँक होम लोनक निर्णय';

  @override
  String get welcomeBody =>
      'होम लोन वा संपत्ति पर लोनक लेल आवेदन करू। हम सभ किछु ऑनलाइन जाँचैत छी आ सदिखन निर्णयक कारण बतबैत छी।';

  @override
  String get chooseProduct => 'अहाँ केँ की चाही?';

  @override
  String get productHomeLoan => 'होम लोन';

  @override
  String get productHomeLoanSub => 'घर कीनब, बनाएब वा सुधारब';

  @override
  String get productLap => 'संपत्ति पर लोन';

  @override
  String get productLapSub => 'अपन संपत्ति पर कर्ज लिअ';

  @override
  String get startApplication => 'आवेदन शुरू करू';

  @override
  String get demoCustomers => 'डेमो ग्राहक';

  @override
  String get demoCustomersBody =>
      'नमूना मोबाइल नंबर भरबाक लेल एकटा पर टैप करू।';

  @override
  String get personaRavi => 'रवि, 32, नोकरीपेशा, फ्लैट कीनि रहल छथि';

  @override
  String get personaMeena => 'मीना, 45, कपड़ाक दोकान चलबैत छथि (LAP)';

  @override
  String get personaArjun => 'अर्जुन, 29, नोकरीपेशा, बदलल वेतन पर्ची';

  @override
  String get signInTitle => 'साइन इन';

  @override
  String get mobileLabel => 'मोबाइल नंबर';

  @override
  String get mobileHint => '10 अंकक मोबाइल नंबर';

  @override
  String get invalidMobile => 'सही 10 अंकक मोबाइल नंबर भरू।';

  @override
  String get sendOtp => 'OTP पठाउ';

  @override
  String otpSentTo(String phone) {
    return 'हम $phone पर 6 अंकक कोड पठेलहुँ अछि।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'सत्यापित करू';

  @override
  String get demoOtp => 'डेमो कोड: 123456';

  @override
  String get wrongOtp => 'कोड गलत अछि। फेर सँ प्रयास करू।';

  @override
  String get deviceBound =>
      'ई फोन आब अहाँक खाता सँ जुड़ि गेल अछि। दोसर फोन पर साइन इन करबाक लेल नव OTP लागत।';

  @override
  String get consentTitle => 'अहाँक सहमति';

  @override
  String get consentIntro =>
      'हम अहाँक डेटा केवल एहि लोनक निर्णय आ प्रबंधनक लेल उपयोग करैत छी। अहाँ कखनो सहमति वापस लऽ सकैत छी।';

  @override
  String get consentBureauTitle => 'क्रेडिट रिपोर्ट';

  @override
  String get consentBureauBody =>
      'क्रेडिट ब्यूरो (CIBIL, Experian, Equifax वा CRIF) सँ अहाँक क्रेडिट इतिहास देखल जाएत। एहि सँ अहाँक स्कोर कम नहि होइत अछि।';

  @override
  String get consentAaTitle => 'अकाउंट एग्रीगेटरक माध्यम सँ बैंक स्टेटमेंट';

  @override
  String get consentAaBody =>
      'RBI सँ लाइसेंस प्राप्त अकाउंट एग्रीगेटरक माध्यम सँ अहाँक बैंकक 12 महीनाक स्टेटमेंट आनल जाएत। अनुरोध अहाँ अपन AA ऐप मे स्वीकृत करब।';

  @override
  String get consentKycTitle => 'आधार eKYC आ PAN';

  @override
  String get consentKycBody =>
      'UIDAI आ आयकर विभाग सँ अहाँक पहिचानक पुष्टि होएत। हम केवल नुकाएल आधार नंबर रखैत छी।';

  @override
  String get consentPrivacyTitle => 'गोपनीयता सूचना (DPDP अधिनियम 2023)';

  @override
  String get consentPrivacyBody =>
      'हम की जमा करैत छी: पहिचान, आय, बैंक आ संपत्तिक विवरण। किएक: अहाँक लोनक निर्णय आ प्रबंधनक लेल। कतेक दिन: जतेक कानून कहैत अछि। अहाँक अधिकार: अपन डेटा देखब, सुधारब वा मेटाएब, आ हमर शिकायत अधिकारी वा डेटा संरक्षण बोर्ड लग शिकायत करब।';

  @override
  String get consentRequired => 'जरूरी';

  @override
  String get consentNeeded => 'आगू बढ़बाक लेल सभ पर सहमति दिअ।';

  @override
  String get agreeAndContinue => 'सहमति दऽ आगू बढ़ू';

  @override
  String get detailsTitle => 'अहाँक विवरण';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'सही PAN भरू, जेना ABCDE1234F।';

  @override
  String get fetchDetails => 'हमर विवरण आनू';

  @override
  String get fetchedFrom =>
      'PAN, आधार eKYC आ बैंक स्टेटमेंट सँ भरल गेल। सुधारबाक लेल अंक पर टैप करू।';

  @override
  String get nameLabel => 'नाम';

  @override
  String get dobLabel => 'जन्म तिथि';

  @override
  String get employmentLabel => 'काज';

  @override
  String get salaried => 'नोकरीपेशा';

  @override
  String get selfEmployed => 'स्वरोजगार';

  @override
  String get incomeLabel => 'मासिक शुद्ध आय';

  @override
  String get existingEmiLabel => 'वर्तमान मासिक EMI';

  @override
  String get propertyValueLabel => 'संपत्तिक मूल्य';

  @override
  String get loanAmountLabel => 'लोनक राशि';

  @override
  String get tenureLabel => 'अवधि';

  @override
  String yearsLabel(String n) {
    return '$n वर्ष';
  }

  @override
  String get eligibleTitle => 'अहाँ बेसी सँ बेसी पाबि सकैत छी';

  @override
  String emiPerMonth(String amount) {
    return 'मासिक EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'सालाना $rate%, बदलैत दर (उदाहरण)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'आयक सीमा: अहाँक सभ EMI मिलि कऽ आयक $pct धरि भऽ सकैत अछि।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'संपत्तिक सीमा: एतेक लोन मूल्यक $pct धरि भऽ सकैत अछि।';
  }

  @override
  String get limitedByAsked => 'ई अहाँक माँगल राशि अछि।';

  @override
  String get eligibilityNote =>
      'अहाँक विवरणक तुरंत जाँच। हमर जाँचक बाद प्रस्ताव आओत।';

  @override
  String get selfieTitle => 'सेल्फी लिअ';

  @override
  String get selfieBody =>
      'हम अहाँक चेहरा आधारक फोटो सँ मिलबैत छी आ देखैत छी जे ई सत्ते अहाँ छी, फोटोक फोटो नहि।';

  @override
  String get selfieTips => 'नीक रोशनी, कैमरा दिस देखू, टोपी वा चश्मा नहि।';

  @override
  String get takeSelfie => 'सेल्फी लिअ';

  @override
  String get retake => 'फेर लिअ';

  @override
  String get checkFace => 'चेहरा भेटल';

  @override
  String get checkLive => 'जीवित व्यक्ति';

  @override
  String get checkMatch => 'आधारक फोटो सँ मिलैत अछि';

  @override
  String get selfieFailed =>
      'अहाँक चेहराक पुष्टि नहि भऽ सकल। नीक रोशनी मे फेर प्रयास करू, वा वीडियो KYC कॉल बुक करू।';

  @override
  String get videoKyc => 'वीडियो KYC कॉल बुक करू';

  @override
  String get docsTitle => 'अहाँक दस्तावेज';

  @override
  String get docsBody => 'प्रत्येक दस्तावेजक साफ फोटो लिअ, वा गैलरी सँ चुनू।';

  @override
  String get docPan => 'PAN कार्ड';

  @override
  String get docAadhaar => 'आधार कार्ड (नुकाएल)';

  @override
  String get docSalarySlip => 'हालक वेतन पर्ची';

  @override
  String get docForm16 => 'फॉर्म 16';

  @override
  String get docItr => 'आयकर रिटर्न (ITR)';

  @override
  String get docGst => 'GST प्रमाणपत्र';

  @override
  String get docBankStatement => 'बैंक स्टेटमेंट';

  @override
  String get bankViaAa => 'अहाँक अकाउंट एग्रीगेटरक माध्यम सँ आनल गेल';

  @override
  String get camera => 'कैमरा';

  @override
  String get gallery => 'गैलरी';

  @override
  String get checking => 'जाँच भऽ रहल अछि…';

  @override
  String get tooBlurry => 'बहुत धुंधला। फोन स्थिर राखि फेर प्रयास करू।';

  @override
  String get tooMuchGlare => 'बहुत चमक। रोशनी सँ हटि कऽ फेर प्रयास करू।';

  @override
  String get tooDark => 'बहुत अन्हार। बेसी रोशनी मे फेर प्रयास करू।';

  @override
  String docAccepted(String type) {
    return 'पहिचानल गेल: $type';
  }

  @override
  String docWrong(String expected) {
    return 'ई $expected जकाँ नहि लगैत अछि। जाँचि कऽ सही दस्तावेज अपलोड करू।';
  }

  @override
  String get docUnreadable =>
      'ई दस्तावेज पढ़ल नहि जा सकल। बेसी साफ फोटो लिअ, वा मूल PDF अपलोड करू।';

  @override
  String docsMissing(String n) {
    return 'एखन $n चाही';
  }

  @override
  String get getOffer => 'हमर सैद्धांतिक प्रस्ताव देखाउ';

  @override
  String get approvedInPrinciple => 'सैद्धांतिक रूप सँ स्वीकृत';

  @override
  String get sanctioned => 'लोन स्वीकृत';

  @override
  String get referredTitle => 'हमरा किछु आर समय चाही';

  @override
  String get rejectedTitle => 'हम एखन ई लोन नहि दऽ सकैत छी';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years वर्ष · सालाना $rate% बदलैत दर';
  }

  @override
  String get whyOffer => 'अहाँ केँ ई प्रस्ताव किएक भेटल';

  @override
  String get whyReferred => 'आगू की होएत';

  @override
  String get whyRejected => 'हम ई निर्णय किएक लेलहुँ';

  @override
  String get referBody =>
      'एकटा अधिकारी एक कार्यदिवस मे अहाँक आवेदन देखताह। एखन अहाँ केँ किछु करबाक जरूरत नहि।';

  @override
  String get rejectBody =>
      'अहाँ कखनो कोनो व्यक्ति सँ एहि निर्णयक समीक्षा करबाक लेल कहि सकैत छी।';

  @override
  String get addProperty => 'संपत्तिक विवरण जोड़ू';

  @override
  String get viewKfs => 'मुख्य तथ्य विवरण देखू';

  @override
  String get grievance => 'समीक्षा माँगू वा शिकायत करू';

  @override
  String officerLine(String name, String email) {
    return 'शिकायत अधिकारी: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'आवेदन $id';
  }

  @override
  String get startOver => 'नव आवेदन शुरू करू';

  @override
  String okScore(String score) {
    return 'भुगतानक मजबूत इतिहास (स्कोर $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI आयक $pct अछि; हमर सीमा $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'लोन संपत्तिक मूल्यक $pct अछि; सीमा $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'संपत्तिक हमर मूल्यांकन: $low सँ $high';
  }

  @override
  String get okTitle => 'संपत्तिक मालिकाना आ कागजात जाँचल गेल';

  @override
  String get reasonKyc01 =>
      'फोटो सँ अहाँक पहिचानक पुष्टि नहि भऽ सकल। कृपया एकटा छोट वीडियो KYC कॉल पूरा करू।';

  @override
  String get reasonFrd02 =>
      'वेतन पर्चीक आय बैंक मे जमा राशि सँ नहि मिलैत अछि। अपन हालक फॉर्म 16 दिअ, वा सहमति दऽ हमरा आनऽ दिअ।';

  @override
  String get reasonFrd03 =>
      'अहाँक एकटा दस्तावेज जारी करयवला प्राधिकरणक सत्यापन मे असफल भेल।';

  @override
  String get reasonPol01 => 'आवेदकक उमेर कम सँ कम 21 वर्ष होएबाक चाही।';

  @override
  String get reasonPol02 =>
      'लोन हमर अनुमत अधिकतम उमेर सँ आगू चलि जाएत। कम उमेरक सह-आवेदक जोड़ला सँ मदद भेटि सकैत अछि।';

  @override
  String get reasonBur01 => 'अहाँक क्रेडिट स्कोर हमर न्यूनतम 650 सँ कम अछि।';

  @override
  String get reasonBur04 =>
      'अहाँक एखन धरि क्रेडिट इतिहास नहि अछि, तेँ एकटा अधिकारी अहाँक बैंक रिकॉर्ड देखताह।';

  @override
  String get reasonBur05 =>
      'अहाँक क्रेडिट स्कोर केँ अधिकारी द्वारा ध्यान सँ देखबाक जरूरत अछि।';

  @override
  String get reasonPrp01 =>
      'हमर वकील केँ संपत्तिक मालिकानाक समीक्षा करबाक अछि।';

  @override
  String get reasonPrp03 =>
      'मूल्यक पुष्टिक लेल हमर मूल्यांकनकर्ता केँ संपत्ति देखबाक अछि।';

  @override
  String get reasonPrp04 =>
      'समझौता मूल्य एहि संपत्तिक सरकारी सर्किल रेट सँ कम अछि। कृपया बिक्री समझौता जाँचू।';

  @override
  String get reasonAff01 =>
      'अहाँक वर्तमान EMI पहिनहि सँ आयक अधिकतम हिस्सा लऽ रहल अछि।';

  @override
  String get reasonAut01 =>
      'एतेक पैघ लोनक अंतिम जाँच एकटा वरिष्ठ अधिकारी करैत छथि।';

  @override
  String get reasonRsk01 =>
      'प्रस्ताव तय करबाक लेल एकटा अधिकारी अहाँक आवेदन देखताह।';

  @override
  String get reasonRsk02 =>
      'अहाँक क्रेडिट प्रोफाइलक आधार पर हम एखन ई लोन नहि दऽ सकैत छी।';

  @override
  String get propertyTitle => 'अहाँक संपत्ति';

  @override
  String get cityLabel => 'शहर';

  @override
  String get localityLabel => 'इलाका';

  @override
  String get societyLabel => 'परियोजना वा सोसाइटी (जँ हो)';

  @override
  String get areaLabel => 'क्षेत्रफल (वर्ग फीट)';

  @override
  String get bhkLabel => 'सुतबाक कोठरी';

  @override
  String get newProperty => 'नव';

  @override
  String get resale => 'रीसेल';

  @override
  String get declaredPriceLabel => 'समझौता मूल्य';

  @override
  String get photosTitle => 'संपत्तिक फोटो';

  @override
  String get photosBody =>
      'संपत्ति पर जा कऽ फोटो लिअ। हम जगह आ समय जोड़ैत छी, जाहि सँ मूल्यांकनकर्ता दौराक योजना बना सकथि।';

  @override
  String get photoFront => 'आगाँ';

  @override
  String get photoInside => 'भीतर';

  @override
  String get photoView => 'संपत्ति सँ दृश्य';

  @override
  String geoTagged(String lat, String lng) {
    return 'स्थान जोड़ल गेल ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'स्थानक बिना फोटो सहेजल गेल। जियो-टैगक लेल लोकेशन चालू करू।';

  @override
  String get submitProperty => 'अंतिम स्वीकृति लिअ';

  @override
  String get fillAll => 'कृपया सभ खाना भरू।';

  @override
  String get kfsTitle => 'मुख्य तथ्य विवरण';

  @override
  String get kfsLoan => 'लोनक राशि';

  @override
  String get kfsTenure => 'अवधि';

  @override
  String get kfsRate => 'ब्याज दर';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI क संख्या';

  @override
  String get kfsFee => 'प्रोसेसिंग शुल्क (GST सहित)';

  @override
  String get kfsTotalInterest => 'कुल ब्याज';

  @override
  String get kfsTotalPayable => 'कुल देय राशि';

  @override
  String get kfsApr => 'वार्षिक प्रतिशत दर (APR)';

  @override
  String get kfsCoolingOff =>
      'कूलिंग-ऑफ अवधि: हस्ताक्षरक 3 दिनक भीतर केवल मूलधन आ ओहि दिनक ब्याज लौटा कऽ बिना जुर्माना बाहर भऽ सकैत छी।';

  @override
  String get kfsNote =>
      'डेमोक लेल नमूना अंक। अहाँक असली KFS स्वीकृति पत्रक संग आओत।';

  @override
  String get useSample => 'नमूना';

  @override
  String get videoKycDemo =>
      'डेमो: एहि सँ एकटा अधिकारीक संग वीडियो KYC कॉल बुक होइत।';

  @override
  String get raiseComplaint => 'शिकायत करू';

  @override
  String complaintSent(String ref) {
    return 'अहाँक शिकायत दर्ज भऽ गेल। संदर्भ $ref।';
  }

  @override
  String get stageSignIn => 'साइन इन';

  @override
  String get stageDetails => 'विवरण';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'प्रस्ताव';

  @override
  String get stageProperty => 'संपत्ति';

  @override
  String get homeSubtitle => 'होम लोन · संपत्ति पर लोन';

  @override
  String get heroPill => 'मिनट मे निर्णय';

  @override
  String heroFacts(String rate, String years) {
    return 'सालाना $rate% सँ · $years वर्ष धरि';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% पूरा · जतय छोड़लहुँ ओतहि सँ शुरू करू';
  }

  @override
  String get resume => 'जारी राखू';

  @override
  String get calculators => 'कैलकुलेटर';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'मासिक किस्त';

  @override
  String get calcEligibility => 'पात्रता';

  @override
  String get calcEligibilitySub => 'अहाँ कतेक पाबि सकैत छी';

  @override
  String get emiCalcTitle => 'EMI कैलकुलेटर';

  @override
  String get eligibilityCalcTitle => 'पात्रता कैलकुलेटर';

  @override
  String totalInterest(String amount) {
    return 'कुल ब्याज $amount';
  }

  @override
  String get calcIncomeOnly =>
      'केवल आयक आधार पर। संपत्तिक मूल्य एकरा घटा सकैत अछि।';

  @override
  String get verified => 'सत्यापित';

  @override
  String get yourLoan => 'अहाँक लोन';

  @override
  String docsProgress(String done, String total) {
    return '$total मे सँ $done सत्यापित';
  }

  @override
  String get docNeeded => 'चाही';

  @override
  String get docTryAgain => 'फेर प्रयास';

  @override
  String get fetched => 'आनल गेल';

  @override
  String get statusApproved => 'स्वीकृत';

  @override
  String get statusSanctioned => 'मंजूर';

  @override
  String get statusInReview => 'समीक्षा मे';

  @override
  String get statusDeclined => 'अस्वीकृत';

  @override
  String get trackTitle => 'अपन आवेदन ट्रैक करू';

  @override
  String get tlSubmitted => 'आवेदन जमा भेल';

  @override
  String get tlVerified => 'KYC आ दस्तावेज सत्यापित';

  @override
  String get tlInPrinciple => 'सैद्धांतिक स्वीकृति';

  @override
  String get tlProperty => 'संपत्तिक विवरण आ मूल्यांकन';

  @override
  String get tlPropertyNext => 'अपन संपत्तिक विवरण आ फोटो जोड़ू';

  @override
  String get tlOfficer => 'अधिकारीक समीक्षा';

  @override
  String get tlOfficerNext => 'एक कार्यदिवसक भीतर';

  @override
  String get tlLegal => 'कानूनी आ मालिकाना जाँच';

  @override
  String get tlSanction => 'अंतिम स्वीकृति आ ई-हस्ताक्षर';

  @override
  String get tlSanctionNext => 'स्वीकृति पत्र पर ऑनलाइन हस्ताक्षर करू';

  @override
  String get tlDisbursement => 'राशि जारी';

  @override
  String get helpTitle => 'मदद चाही?';

  @override
  String get propertyType => 'नव वा रीसेल';

  @override
  String get greetMorning => 'सुप्रभात';

  @override
  String get greetAfternoon => 'नमस्कार';

  @override
  String get greetEvening => 'शुभ संध्या';

  @override
  String nearlyThere(String name) {
    return '$name, अहाँ करीब-करीब पहुँचि गेलहुँ';
  }

  @override
  String get chooseLanguage => 'अपन भाषा चुनू';

  @override
  String get languageNote => 'अहाँ एकरा कखनो बदलि सकैत छी।';

  @override
  String get liveChecks => 'लाइव जाँच';

  @override
  String get checkBureau => 'क्रेडिट ब्यूरो';

  @override
  String checkScore(String score) {
    return 'स्कोर $score';
  }

  @override
  String get checkNoHistory => 'एखन धरि इतिहास नहि';

  @override
  String get checkBank => 'AA सँ बैंक';

  @override
  String get checkBankRead => '12 महीना पढ़ल गेल';

  @override
  String get checkKyc => 'eKYC आ सेल्फी';

  @override
  String get checkPending => 'बाकी';

  @override
  String get checkDocs => 'दस्तावेज';

  @override
  String countOf(String done, String total) {
    return '$total मे सँ $done';
  }

  @override
  String minutesLeft(String n) {
    return 'लगभग $n मिनट बाकी';
  }

  @override
  String ratePa(String rate) {
    return 'सालाना $rate%';
  }

  @override
  String get continueApplication => 'अपन आवेदन जारी राखू';

  @override
  String get shapeOffer => 'अपन प्रस्ताव तय करू';

  @override
  String get shapeOfferSub => 'सैद्धांतिक रूप सँ स्वीकृत · बदलबाक लेल खिसकाउ';

  @override
  String get withinLimits => 'अहाँक सीमाक भीतर';

  @override
  String get aboveLimits => 'सीमा सँ बेसी: राशि घटाउ वा वर्ष बढ़ाउ';

  @override
  String mostYouCan(String amount) {
    return 'बेसी सँ बेसी लऽ सकैत छी: $amount';
  }

  @override
  String get useMax => 'पूरा लिअ';

  @override
  String get principal => 'मूलधन';

  @override
  String get interest => 'ब्याज';

  @override
  String get totalRepaid => 'कुल भुगतान';

  @override
  String get emiShareIncome => 'आय मे EMI क हिस्सा';

  @override
  String loanShareProperty(String value) {
    return '$value क संपत्ति मे लोनक हिस्सा';
  }

  @override
  String get lockOffer => 'ई प्रस्ताव पक्का करू';

  @override
  String get offerLocked => 'अहाँक प्रस्ताव पक्का भऽ गेल।';

  @override
  String approvedUpTo(String amount) {
    return '$amount धरि स्वीकृत';
  }

  @override
  String readingDoc(String doc) {
    return 'अहाँक $doc पढ़ल जा रहल अछि';
  }

  @override
  String get documentAi => 'दस्तावेज AI';

  @override
  String sure(String pct) {
    return '$pct% पक्का';
  }

  @override
  String get readMatches => 'ई वैह दस्तावेज अछि जे हम माँगने रही';

  @override
  String get readClear => 'साफ फोटो, धुंधलापन वा चमक नहि';

  @override
  String get whatWeRead => 'हम की पढ़लहुँ';

  @override
  String get looksRight => 'सही अछि';

  @override
  String get fieldName => 'नाम';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'आधार';

  @override
  String get fieldEmployer => 'नियोक्ता';

  @override
  String get fieldNetPay => 'शुद्ध वेतन';

  @override
  String get fieldPeriod => 'वेतन अवधि';

  @override
  String get fieldYear => 'वर्ष';

  @override
  String get fieldIncome => 'आय';

  @override
  String get fieldBusiness => 'व्यवसाय';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'अहाँक लोनक लेल जरूरी';

  @override
  String get consentSectionOptional =>
      'वैकल्पिक: जा धरि अहाँ चालू नहि करी, बंद';

  @override
  String get advancedOptions => 'विकल्प';

  @override
  String consentValidUntil(String given, String until) {
    return '$given केँ देल गेल · $until धरि मान्य';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given केँ देल गेल · वापस लेबा धरि';
  }

  @override
  String get recheckTitle => 'राशि देबा सँ ठीक पहिने एकटा आर जाँच';

  @override
  String get recheckBody =>
      'राशि देबा सँ ठीक पहिने हम अहाँक क्रेडिट रिपोर्ट फेर देखैत छी। मना कएला पर अधिकारी तखन पूछि सकैत छथि।';

  @override
  String get aaMonthsLabel => 'कतेक महीनाक स्टेटमेंट देब';

  @override
  String monthsN(String n) {
    return '$n महीना';
  }

  @override
  String get aaAccountsLabel => 'देबऽ वला खाता';

  @override
  String get accountSavingsSalary => 'बचत खाता ·· 0912 · वेतन जमा';

  @override
  String get accountSavings => 'बचत खाता ·· 4821';

  @override
  String get accountFd => 'सावधि जमा ·· 3307';

  @override
  String get aaAccountNeeded => 'कम सँ कम एकटा खाता चुनू।';

  @override
  String get kycMethodLabel => 'अपन पहिचान कोना पक्का करब';

  @override
  String get kycAadhaarOtp => 'आधार OTP';

  @override
  String get kycDigilocker => 'डिजिलॉकर';

  @override
  String get kycVideo => 'वीडियो KYC कॉल';

  @override
  String get useCkycTitle => 'हमर मौजूदा CKYC रिकॉर्ड उपयोग करू';

  @override
  String get useCkycBody =>
      'जँ अहाँ दोसर बैंक वा फंड सँ KYC कएने छी, तँ फेर पूछबाक बदला हम वैह रिकॉर्ड लऽ लैत छी।';

  @override
  String get optOffersTitle => 'ऑफर आ नव प्रोडक्ट';

  @override
  String get optOffersBody =>
      'चुनू जे ऑफरक बारे मे कोना जानऽ चाहैत छी। एकरा कखनो बंद कऽ सकैत छी।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ईमेल';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp पर लोन अपडेट';

  @override
  String get optUpdatesBody => 'SMS क संग WhatsApp पर स्टेटस अपडेट आ EMI याद।';

  @override
  String get optInsuranceTitle => 'होम लोन सुरक्षा कोटेशन';

  @override
  String get optInsuranceBody =>
      'कोटेशनक लेल अपन नाम, उमेर आ लोन राशि हमर बीमा साझेदार केँ दिअ। कीनब कहियो जरूरी नहि।';

  @override
  String get getQuote => 'कोटेशन लिअ';

  @override
  String get manageConsents => 'सहमति सम्हारू';

  @override
  String get manageConsentsBody =>
      'वैकल्पिक सहमति कखनो बंद करू। जरूरी सहमति वापस लेला पर आवेदन रुकि जाइत अछि, आ ओकरा लेल आनल डेटा हम मेटा दैत छी।';

  @override
  String get withdraw => 'वापस लिअ';

  @override
  String get consentHistory => 'सहमतिक इतिहास';

  @override
  String historyGiven(String item) {
    return '$item देल गेल';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item वापस लेल गेल';
  }

  @override
  String get historyEmpty => 'एखन धरि किछु नहि।';

  @override
  String get consentOn => 'चालू';

  @override
  String get consentOff => 'बंद';

  @override
  String get withdrawnRequired =>
      'अहाँ एकटा जरूरी सहमति वापस लेलहुँ, तेँ आवेदन रुकल अछि।';

  @override
  String get checkMatchPending =>
      'फोटो मिलान: आधार वा पैन कार्ड अपलोड केलापर होएत';
}
