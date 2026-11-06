// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'निर्णय';

  @override
  String get sandboxBanner => 'डेमो मोड: नमूना डेटा, कोई असली जाँच नहीं';

  @override
  String get continueLabel => 'आगे बढ़ें';

  @override
  String stepOf(String step, String total) {
    return 'चरण $step / $total';
  }

  @override
  String get pleaseWait => 'कृपया प्रतीक्षा करें…';

  @override
  String get errorGeneric => 'कुछ गड़बड़ हो गई। कृपया फिर से कोशिश करें।';

  @override
  String get close => 'बंद करें';

  @override
  String get welcomeHeadline => 'होम लोन पर फ़ैसला, कुछ ही मिनटों में';

  @override
  String get welcomeBody =>
      'होम लोन या प्रॉपर्टी पर लोन के लिए आवेदन करें। हम सारी जाँच ऑनलाइन करते हैं और हमेशा बताते हैं कि फ़ैसला क्यों लिया।';

  @override
  String get chooseProduct => 'आपको क्या चाहिए?';

  @override
  String get productHomeLoan => 'होम लोन';

  @override
  String get productHomeLoanSub => 'घर ख़रीदने, बनाने या सुधारने के लिए';

  @override
  String get productLap => 'प्रॉपर्टी पर लोन';

  @override
  String get productLapSub => 'अपनी प्रॉपर्टी गिरवी रखकर लोन';

  @override
  String get startApplication => 'आवेदन शुरू करें';

  @override
  String get demoCustomers => 'डेमो ग्राहक';

  @override
  String get demoCustomersBody =>
      'किसी एक पर टैप करें, उसका नमूना मोबाइल नंबर भर जाएगा।';

  @override
  String get personaRavi => 'रवि, 32, नौकरीपेशा, फ़्लैट ख़रीद रहे हैं';

  @override
  String get personaMeena =>
      'मीना, 45, कपड़ों की दुकान चलाती हैं (प्रॉपर्टी पर लोन)';

  @override
  String get personaArjun => 'अर्जुन, 29, नौकरीपेशा, सैलरी स्लिप में बदलाव';

  @override
  String get signInTitle => 'साइन इन करें';

  @override
  String get mobileLabel => 'मोबाइल नंबर';

  @override
  String get mobileHint => '10 अंकों का मोबाइल नंबर';

  @override
  String get invalidMobile => 'सही 10 अंकों का मोबाइल नंबर डालें।';

  @override
  String get sendOtp => 'OTP भेजें';

  @override
  String otpSentTo(String phone) {
    return 'हमने $phone पर 6 अंकों का कोड भेजा है।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'पुष्टि करें';

  @override
  String get demoOtp => 'डेमो कोड: 123456';

  @override
  String get wrongOtp => 'यह कोड गलत है। कृपया फिर से कोशिश करें।';

  @override
  String get deviceBound =>
      'यह फ़ोन अब आपके खाते से जुड़ गया है। किसी दूसरे फ़ोन पर साइन इन करने के लिए नया OTP लगेगा।';

  @override
  String get consentTitle => 'आपकी सहमति';

  @override
  String get consentIntro =>
      'हम आपके डेटा का इस्तेमाल सिर्फ़ इस लोन के फ़ैसले और संचालन के लिए करते हैं। आप कभी भी अपनी सहमति वापस ले सकते हैं।';

  @override
  String get consentBureauTitle => 'क्रेडिट रिपोर्ट';

  @override
  String get consentBureauBody =>
      'क्रेडिट ब्यूरो (CIBIL, Experian, Equifax या CRIF) से आपका क्रेडिट इतिहास देखना। इस जाँच से आपका स्कोर कम नहीं होता।';

  @override
  String get consentAaTitle => 'अकाउंट एग्रीगेटर से बैंक स्टेटमेंट';

  @override
  String get consentAaBody =>
      'RBI से लाइसेंस प्राप्त अकाउंट एग्रीगेटर के ज़रिए आपके बैंक से 12 महीने के स्टेटमेंट लेना। आप अपने AA ऐप में यह अनुरोध मंज़ूर करेंगे।';

  @override
  String get consentKycTitle => 'आधार eKYC और PAN';

  @override
  String get consentKycBody =>
      'UIDAI और आयकर विभाग से आपकी पहचान की पुष्टि करना। हम आधार नंबर सिर्फ़ छिपे (मास्क किए) रूप में रखते हैं।';

  @override
  String get consentPrivacyTitle => 'गोपनीयता सूचना (DPDP अधिनियम 2023)';

  @override
  String get consentPrivacyBody =>
      'हम क्या लेते हैं: पहचान, आय, बैंक और प्रॉपर्टी की जानकारी। क्यों: आपके लोन का फ़ैसला और संचालन करने के लिए। कब तक: सिर्फ़ उतने समय तक जितना क़ानून कहता है। आपके अधिकार: अपना डेटा देखना, सुधारना या मिटवाना, और हमारे शिकायत अधिकारी या डेटा संरक्षण बोर्ड से शिकायत करना।';

  @override
  String get consentRequired => 'ज़रूरी';

  @override
  String get consentNeeded => 'आगे बढ़ने के लिए कृपया सभी पर सहमति दें।';

  @override
  String get agreeAndContinue => 'सहमत हूँ, आगे बढ़ें';

  @override
  String get detailsTitle => 'आपकी जानकारी';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'सही PAN डालें, जैसे ABCDE1234F।';

  @override
  String get fetchDetails => 'मेरी जानकारी लाएँ';

  @override
  String get fetchedFrom =>
      'PAN, आधार eKYC और आपके बैंक स्टेटमेंट से भरी गई। किसी आँकड़े को सुधारने के लिए उस पर टैप करें।';

  @override
  String get nameLabel => 'नाम';

  @override
  String get dobLabel => 'जन्म तिथि';

  @override
  String get employmentLabel => 'काम';

  @override
  String get salaried => 'नौकरीपेशा';

  @override
  String get selfEmployed => 'स्वरोज़गार';

  @override
  String get incomeLabel => 'हर महीने की शुद्ध आय';

  @override
  String get existingEmiLabel => 'मौजूदा EMI हर महीने';

  @override
  String get propertyValueLabel => 'प्रॉपर्टी की क़ीमत';

  @override
  String get loanAmountLabel => 'लोन की राशि';

  @override
  String get tenureLabel => 'अवधि';

  @override
  String yearsLabel(String n) {
    return '$n साल';
  }

  @override
  String get eligibleTitle => 'आपको मिल सकता है अधिकतम';

  @override
  String emiPerMonth(String amount) {
    return 'EMI $amount हर महीने';
  }

  @override
  String rateNote(String rate) {
    return '$rate% सालाना, फ़्लोटिंग (उदाहरण के लिए)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'आय की सीमा: आपकी सभी EMI आपकी आय का अधिकतम $pct हो सकती हैं।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'प्रॉपर्टी की सीमा: इतना बड़ा लोन प्रॉपर्टी की क़ीमत का अधिकतम $pct हो सकता है।';
  }

  @override
  String get limitedByAsked => 'यह वही राशि है जो आपने माँगी है।';

  @override
  String get eligibilityNote =>
      'आपकी जानकारी पर एक त्वरित जाँच। आपका ऑफ़र हमारी जाँच के बाद आएगा।';

  @override
  String get selfieTitle => 'सेल्फ़ी लें';

  @override
  String get selfieBody =>
      'हम आपके चेहरे का मिलान आपके आधार फ़ोटो से करते हैं और देखते हैं कि सामने सच में आप हैं, किसी फ़ोटो की फ़ोटो नहीं।';

  @override
  String get selfieTips =>
      'अच्छी रोशनी, कैमरे की ओर देखें, टोपी या धूप का चश्मा नहीं।';

  @override
  String get takeSelfie => 'सेल्फ़ी लें';

  @override
  String get retake => 'फिर से लें';

  @override
  String get checkFace => 'चेहरा मिला';

  @override
  String get checkLive => 'असली व्यक्ति';

  @override
  String get checkMatch => 'आधार फ़ोटो से मेल खाता है';

  @override
  String get selfieFailed =>
      'हम आपके चेहरे की पुष्टि नहीं कर पाए। अच्छी रोशनी में फिर से कोशिश करें, या वीडियो KYC कॉल बुक करें।';

  @override
  String get videoKyc => 'वीडियो KYC कॉल बुक करें';

  @override
  String get docsTitle => 'आपके दस्तावेज़';

  @override
  String get docsBody => 'हर दस्तावेज़ की साफ़ फ़ोटो लें, या गैलरी से चुनें।';

  @override
  String get docPan => 'PAN कार्ड';

  @override
  String get docAadhaar => 'आधार कार्ड (मास्क किया हुआ)';

  @override
  String get docSalarySlip => 'ताज़ा सैलरी स्लिप';

  @override
  String get docForm16 => 'फ़ॉर्म 16';

  @override
  String get docItr => 'आयकर रिटर्न (ITR)';

  @override
  String get docGst => 'GST प्रमाणपत्र';

  @override
  String get docBankStatement => 'बैंक स्टेटमेंट';

  @override
  String get bankViaAa => 'आपके अकाउंट एग्रीगेटर से मिल गया';

  @override
  String get camera => 'कैमरा';

  @override
  String get gallery => 'गैलरी';

  @override
  String get checking => 'जाँच हो रही है…';

  @override
  String get tooBlurry => 'फ़ोटो धुंधली है। फ़ोन स्थिर रखकर फिर से लें।';

  @override
  String get tooMuchGlare => 'फ़ोटो पर बहुत चमक है। रोशनी से हटकर फिर से लें।';

  @override
  String get tooDark => 'फ़ोटो बहुत अँधेरी है। ज़्यादा रोशनी में फिर से लें।';

  @override
  String docAccepted(String type) {
    return 'पहचाना गया: $type';
  }

  @override
  String docWrong(String expected) {
    return 'यह $expected नहीं लगता। कृपया जाँचें और सही दस्तावेज़ अपलोड करें।';
  }

  @override
  String get docUnreadable =>
      'हम यह दस्तावेज़ पढ़ नहीं पाए। कृपया साफ़ फ़ोटो लें, या असली PDF अपलोड करें।';

  @override
  String docsMissing(String n) {
    return '$n अभी बाक़ी';
  }

  @override
  String get getOffer => 'मेरा सैद्धांतिक ऑफ़र देखें';

  @override
  String get approvedInPrinciple => 'सैद्धांतिक रूप से स्वीकृत';

  @override
  String get sanctioned => 'लोन मंज़ूर';

  @override
  String get referredTitle => 'हमें थोड़ा और समय चाहिए';

  @override
  String get rejectedTitle => 'हम अभी यह लोन नहीं दे सकते';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years साल · $rate% सालाना फ़्लोटिंग';
  }

  @override
  String get whyOffer => 'आपको यह ऑफ़र क्यों मिला';

  @override
  String get whyReferred => 'आगे क्या होगा';

  @override
  String get whyRejected => 'हमने यह फ़ैसला क्यों लिया';

  @override
  String get referBody =>
      'एक अधिकारी एक कार्यदिवस के भीतर आपका आवेदन देखेंगे। आपको अभी कुछ करने की ज़रूरत नहीं है।';

  @override
  String get rejectBody =>
      'आप कभी भी किसी व्यक्ति से इस फ़ैसले की समीक्षा करवा सकते हैं।';

  @override
  String get addProperty => 'प्रॉपर्टी की जानकारी जोड़ें';

  @override
  String get viewKfs => 'मुख्य तथ्य विवरण (KFS) देखें';

  @override
  String get grievance => 'समीक्षा माँगें या शिकायत दर्ज करें';

  @override
  String officerLine(String name, String email) {
    return 'शिकायत अधिकारी: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'आवेदन $id';
  }

  @override
  String get startOver => 'नया आवेदन शुरू करें';

  @override
  String okScore(String score) {
    return 'भुगतान का अच्छा रिकॉर्ड (स्कोर $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI आपकी आय का $pct है; हमारी सीमा $cap है';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'लोन प्रॉपर्टी की क़ीमत का $pct है; सीमा $cap है';
  }

  @override
  String okValue(String low, String high) {
    return 'प्रॉपर्टी का हमारा मूल्यांकन: $low से $high';
  }

  @override
  String get okTitle => 'प्रॉपर्टी का मालिकाना हक़ और काग़ज़ जाँच लिए गए';

  @override
  String get reasonKyc01 =>
      'हम फ़ोटो से आपकी पहचान की पुष्टि नहीं कर पाए। कृपया एक छोटी वीडियो KYC कॉल पूरी करें।';

  @override
  String get reasonFrd02 =>
      'आपकी सैलरी स्लिप की आय आपके बैंक में आई रक़म से मेल नहीं खाती। कृपया अपना ताज़ा फ़ॉर्म 16 दें, या अपनी सहमति से हमें उसे लेने दें।';

  @override
  String get reasonFrd03 =>
      'आपका एक दस्तावेज़ जारी करने वाली संस्था की जाँच में सही नहीं पाया गया।';

  @override
  String get reasonPol01 => 'आवेदक की उम्र कम से कम 21 साल होनी चाहिए।';

  @override
  String get reasonPol02 =>
      'लोन हमारी अधिकतम उम्र-सीमा के बाद तक चलेगा। कम उम्र का सह-आवेदक जोड़ने से मदद मिल सकती है।';

  @override
  String get reasonBur01 =>
      'आपका क्रेडिट स्कोर हमारी न्यूनतम सीमा 650 से कम है।';

  @override
  String get reasonBur04 =>
      'आपका अभी कोई क्रेडिट इतिहास नहीं है, इसलिए एक अधिकारी आपके बैंक रिकॉर्ड देखेंगे।';

  @override
  String get reasonBur05 =>
      'आपके क्रेडिट स्कोर को एक अधिकारी ध्यान से देखेंगे।';

  @override
  String get reasonPrp01 =>
      'हमारे वकील को प्रॉपर्टी के मालिकाना हक़ की जाँच करनी है।';

  @override
  String get reasonPrp03 =>
      'प्रॉपर्टी की क़ीमत की पुष्टि के लिए हमारे मूल्यांकनकर्ता को वहाँ जाना होगा।';

  @override
  String get reasonPrp04 =>
      'समझौते की राशि इस प्रॉपर्टी के सरकारी सर्कल रेट से कम है। कृपया बिक्री समझौता जाँचें।';

  @override
  String get reasonAff01 =>
      'आपकी मौजूदा EMI पहले से ही आय के उस अधिकतम हिस्से तक पहुँच चुकी हैं जिस पर हम लोन दे सकते हैं।';

  @override
  String get reasonAut01 =>
      'इतनी बड़ी राशि के लोन की अंतिम जाँच एक वरिष्ठ अधिकारी करते हैं।';

  @override
  String get reasonRsk01 =>
      'ऑफ़र तय करने के लिए एक अधिकारी आपका आवेदन देखेंगे।';

  @override
  String get reasonRsk02 =>
      'आपकी क्रेडिट प्रोफ़ाइल के आधार पर हम अभी यह लोन नहीं दे सकते।';

  @override
  String get propertyTitle => 'आपकी प्रॉपर्टी';

  @override
  String get cityLabel => 'शहर';

  @override
  String get localityLabel => 'इलाक़ा';

  @override
  String get societyLabel => 'प्रोजेक्ट या सोसाइटी (अगर हो)';

  @override
  String get areaLabel => 'क्षेत्रफल (वर्ग फ़ुट)';

  @override
  String get bhkLabel => 'बेडरूम';

  @override
  String get newProperty => 'नई';

  @override
  String get resale => 'पुरानी (रीसेल)';

  @override
  String get declaredPriceLabel => 'समझौते की राशि';

  @override
  String get photosTitle => 'प्रॉपर्टी की फ़ोटो';

  @override
  String get photosBody =>
      'फ़ोटो प्रॉपर्टी पर ही लें। हम जगह और समय जोड़ देते हैं, ताकि हमारे मूल्यांकनकर्ता दौरे की योजना बना सकें।';

  @override
  String get photoFront => 'सामने से';

  @override
  String get photoInside => 'अंदर से';

  @override
  String get photoView => 'प्रॉपर्टी से दिखने वाला नज़ारा';

  @override
  String geoTagged(String lat, String lng) {
    return 'जगह जोड़ी गई ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'फ़ोटो बिना जगह के सहेजी गई। जगह जोड़ने के लिए लोकेशन चालू करें।';

  @override
  String get submitProperty => 'अंतिम मंज़ूरी पाएँ';

  @override
  String get fillAll => 'कृपया हर जानकारी भरें।';

  @override
  String get kfsTitle => 'मुख्य तथ्य विवरण (KFS)';

  @override
  String get kfsLoan => 'लोन की राशि';

  @override
  String get kfsTenure => 'अवधि';

  @override
  String get kfsRate => 'ब्याज दर';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI की संख्या';

  @override
  String get kfsFee => 'प्रोसेसिंग शुल्क (GST सहित)';

  @override
  String get kfsTotalInterest => 'कुल ब्याज';

  @override
  String get kfsTotalPayable => 'कुल चुकाई जाने वाली राशि';

  @override
  String get kfsApr => 'वार्षिक प्रतिशत दर (APR)';

  @override
  String get kfsCoolingOff =>
      'कूलिंग-ऑफ़ अवधि: हस्ताक्षर के 3 दिन के भीतर आप सिर्फ़ मूलधन और उन दिनों का ब्याज चुकाकर, बिना किसी जुर्माने के लोन से बाहर निकल सकते हैं।';

  @override
  String get kfsNote =>
      'डेमो के लिए नमूना आँकड़े। आपका असली KFS आपके मंज़ूरी पत्र के साथ आएगा।';

  @override
  String get useSample => 'नमूना';

  @override
  String get videoKycDemo =>
      'डेमो: यहाँ किसी अधिकारी के साथ वीडियो KYC कॉल बुक होगी।';

  @override
  String get raiseComplaint => 'शिकायत दर्ज करें';

  @override
  String complaintSent(String ref) {
    return 'आपकी शिकायत दर्ज हो गई है। संदर्भ $ref।';
  }

  @override
  String get stageSignIn => 'साइन इन';

  @override
  String get stageDetails => 'विवरण';

  @override
  String get stageKyc => 'केवाईसी';

  @override
  String get stageOffer => 'ऑफ़र';

  @override
  String get stageProperty => 'प्रॉपर्टी';

  @override
  String get homeSubtitle => 'होम लोन · प्रॉपर्टी पर लोन';

  @override
  String get heroPill => 'मिनटों में फ़ैसला';

  @override
  String heroFacts(String rate, String years) {
    return '$rate% सालाना से · $years साल तक';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% पूरा · जहाँ छोड़ा था, वहीं से शुरू करें';
  }

  @override
  String get resume => 'जारी रखें';

  @override
  String get calculators => 'कैलकुलेटर';

  @override
  String get calcEmi => 'ईएमआई';

  @override
  String get calcEmiSub => 'मासिक किस्त';

  @override
  String get calcEligibility => 'पात्रता';

  @override
  String get calcEligibilitySub => 'कितना लोन मिल सकता है';

  @override
  String get emiCalcTitle => 'ईएमआई कैलकुलेटर';

  @override
  String get eligibilityCalcTitle => 'पात्रता कैलकुलेटर';

  @override
  String totalInterest(String amount) {
    return 'कुल ब्याज $amount';
  }

  @override
  String get calcIncomeOnly =>
      'सिर्फ़ आय के आधार पर। प्रॉपर्टी की क़ीमत से यह कम हो सकता है।';

  @override
  String get verified => 'सत्यापित';

  @override
  String get yourLoan => 'आपका लोन';

  @override
  String docsProgress(String done, String total) {
    return '$total में से $done सत्यापित';
  }

  @override
  String get docNeeded => 'ज़रूरी';

  @override
  String get docTryAgain => 'फिर से करें';

  @override
  String get fetched => 'मिल गया';

  @override
  String get statusApproved => 'मंज़ूर';

  @override
  String get statusSanctioned => 'स्वीकृत';

  @override
  String get statusInReview => 'समीक्षा में';

  @override
  String get statusDeclined => 'अस्वीकृत';

  @override
  String get trackTitle => 'अपना आवेदन ट्रैक करें';

  @override
  String get tlSubmitted => 'आवेदन जमा हुआ';

  @override
  String get tlVerified => 'केवाईसी और दस्तावेज़ सत्यापित';

  @override
  String get tlInPrinciple => 'सैद्धांतिक मंज़ूरी';

  @override
  String get tlProperty => 'प्रॉपर्टी विवरण और मूल्यांकन';

  @override
  String get tlPropertyNext => 'अपनी प्रॉपर्टी का विवरण और फ़ोटो जोड़ें';

  @override
  String get tlOfficer => 'अधिकारी समीक्षा';

  @override
  String get tlOfficerNext => 'एक कामकाजी दिन के अंदर';

  @override
  String get tlLegal => 'क़ानूनी और टाइटल जाँच';

  @override
  String get tlSanction => 'अंतिम मंज़ूरी और ई-साइन';

  @override
  String get tlSanctionNext => 'मंज़ूरी पत्र ऑनलाइन साइन करें';

  @override
  String get tlDisbursement => 'राशि जारी';

  @override
  String get helpTitle => 'मदद चाहिए?';

  @override
  String get propertyType => 'नई या रीसेल';

  @override
  String get greetMorning => 'सुप्रभात';

  @override
  String get greetAfternoon => 'नमस्कार';

  @override
  String get greetEvening => 'शुभ संध्या';

  @override
  String nearlyThere(String name) {
    return '$name, बस थोड़ा और';
  }

  @override
  String get chooseLanguage => 'अपनी भाषा चुनें';

  @override
  String get languageNote => 'आप इसे कभी भी बदल सकते हैं।';

  @override
  String get liveChecks => 'लाइव जाँच';

  @override
  String get checkBureau => 'क्रेडिट ब्यूरो';

  @override
  String checkScore(String score) {
    return 'स्कोर $score';
  }

  @override
  String get checkNoHistory => 'अभी कोई हिस्ट्री नहीं';

  @override
  String get checkBank => 'AA से बैंक';

  @override
  String get checkBankRead => '12 महीने पढ़े गए';

  @override
  String get checkKyc => 'ई-केवाईसी और सेल्फ़ी';

  @override
  String get checkPending => 'बाकी';

  @override
  String get checkDocs => 'दस्तावेज़';

  @override
  String countOf(String done, String total) {
    return '$total में से $done';
  }

  @override
  String minutesLeft(String n) {
    return 'लगभग $n मिनट बाकी';
  }

  @override
  String ratePa(String rate) {
    return '$rate% सालाना';
  }

  @override
  String get continueApplication => 'अपना आवेदन जारी रखें';

  @override
  String get shapeOffer => 'अपना ऑफ़र तय करें';

  @override
  String get shapeOfferSub => 'सैद्धांतिक रूप से मंज़ूर · बदलने के लिए खिसकाएँ';

  @override
  String get withinLimits => 'आपकी सीमा के अंदर';

  @override
  String get aboveLimits => 'सीमा से ज़्यादा: राशि घटाएँ या साल बढ़ाएँ';

  @override
  String mostYouCan(String amount) {
    return 'आप ज़्यादा से ज़्यादा ले सकते हैं: $amount';
  }

  @override
  String get useMax => 'पूरा लें';

  @override
  String get principal => 'मूलधन';

  @override
  String get interest => 'ब्याज';

  @override
  String get totalRepaid => 'कुल भुगतान';

  @override
  String get emiShareIncome => 'आय में ईएमआई का हिस्सा';

  @override
  String loanShareProperty(String value) {
    return '$value की प्रॉपर्टी में लोन का हिस्सा';
  }

  @override
  String get lockOffer => 'यह ऑफ़र पक्का करें';

  @override
  String get offerLocked => 'आपका ऑफ़र पक्का हो गया।';

  @override
  String approvedUpTo(String amount) {
    return '$amount तक मंज़ूर';
  }

  @override
  String readingDoc(String doc) {
    return 'आपका $doc पढ़ा जा रहा है';
  }

  @override
  String get documentAi => 'दस्तावेज़ AI';

  @override
  String sure(String pct) {
    return '$pct% पक्का';
  }

  @override
  String get readMatches => 'यह वही दस्तावेज़ है जो हमने माँगा था';

  @override
  String get readClear => 'साफ़ फ़ोटो, धुंधलापन या चमक नहीं';

  @override
  String get whatWeRead => 'हमने क्या पढ़ा';

  @override
  String get looksRight => 'सही है';

  @override
  String get fieldName => 'नाम';

  @override
  String get fieldPan => 'पैन';

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
  String get fieldGstin => 'जीएसटीआईएन';

  @override
  String get consentSectionRequired => 'आपके लोन के लिए ज़रूरी';

  @override
  String get consentSectionOptional => 'वैकल्पिक: जब तक आप चालू न करें, बंद';

  @override
  String get advancedOptions => 'विकल्प';

  @override
  String consentValidUntil(String given, String until) {
    return '$given को दी गई · $until तक मान्य';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given को दी गई · वापस लेने तक';
  }

  @override
  String get recheckTitle => 'राशि जारी होने से ठीक पहले एक और जाँच';

  @override
  String get recheckBody =>
      'राशि जारी करने से ठीक पहले हम आपकी क्रेडिट रिपोर्ट फिर देखते हैं। मना करने पर अधिकारी तब आपसे पूछ सकते हैं।';

  @override
  String get aaMonthsLabel => 'कितने महीनों की स्टेटमेंट साझा करें';

  @override
  String monthsN(String n) {
    return '$n महीने';
  }

  @override
  String get aaAccountsLabel => 'साझा करने वाले खाते';

  @override
  String get accountSavingsSalary => 'बचत खाता ·· 0912 · वेतन जमा';

  @override
  String get accountSavings => 'बचत खाता ·· 4821';

  @override
  String get accountFd => 'सावधि जमा ·· 3307';

  @override
  String get aaAccountNeeded => 'साझा करने के लिए कम से कम एक खाता चुनें।';

  @override
  String get kycMethodLabel => 'अपनी पहचान कैसे पक्की करें';

  @override
  String get kycAadhaarOtp => 'आधार OTP';

  @override
  String get kycDigilocker => 'डिजिलॉकर';

  @override
  String get kycVideo => 'वीडियो KYC कॉल';

  @override
  String get useCkycTitle => 'मेरा मौजूदा CKYC रिकॉर्ड इस्तेमाल करें';

  @override
  String get useCkycBody =>
      'अगर आपने किसी और बैंक या फ़ंड के साथ KYC किया है, तो हम दोबारा पूछने के बजाय वही रिकॉर्ड ले लेते हैं।';

  @override
  String get optOffersTitle => 'ऑफ़र और नए प्रोडक्ट';

  @override
  String get optOffersBody =>
      'चुनें कि आप ऑफ़र के बारे में कैसे जानना चाहते हैं। इन्हें कभी भी बंद कर सकते हैं।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ईमेल';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp पर लोन अपडेट';

  @override
  String get optUpdatesBody =>
      'SMS के साथ-साथ WhatsApp पर स्टेटस अपडेट और EMI रिमाइंडर।';

  @override
  String get optInsuranceTitle => 'होम लोन सुरक्षा कोटेशन';

  @override
  String get optInsuranceBody =>
      'कोटेशन के लिए अपना नाम, उम्र और लोन राशि हमारे बीमा साझेदार से साझा करें। ख़रीदना कभी ज़रूरी नहीं।';

  @override
  String get getQuote => 'कोटेशन लें';

  @override
  String get manageConsents => 'सहमतियाँ संभालें';

  @override
  String get manageConsentsBody =>
      'वैकल्पिक सहमतियाँ कभी भी बंद करें। ज़रूरी सहमति वापस लेने पर आपका आवेदन रुक जाता है, और उसके लिए लाया गया डेटा हम मिटा देते हैं।';

  @override
  String get withdraw => 'वापस लें';

  @override
  String get consentHistory => 'सहमति का इतिहास';

  @override
  String historyGiven(String item) {
    return '$item दी गई';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item वापस ली गई';
  }

  @override
  String get historyEmpty => 'अभी कुछ नहीं।';

  @override
  String get consentOn => 'चालू';

  @override
  String get consentOff => 'बंद';

  @override
  String get withdrawnRequired =>
      'आपने एक ज़रूरी सहमति वापस ली, इसलिए आपका आवेदन रुका हुआ है।';

  @override
  String get checkMatchPending =>
      'फ़ोटो मिलान: आधार या पैन कार्ड अपलोड करने पर होगा';
}
