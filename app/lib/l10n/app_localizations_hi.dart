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
}
