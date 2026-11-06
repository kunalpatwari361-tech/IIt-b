// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Nepali (`ne`).
class AppLocalizationsNe extends AppLocalizations {
  AppLocalizationsNe([String locale = 'ne']) : super(locale);

  @override
  String get appTitle => 'निर्णय';

  @override
  String get sandboxBanner => 'डेमो मोड: नमुना डाटा, वास्तविक जाँच होइन';

  @override
  String get continueLabel => 'अगाडि बढ्नुहोस्';

  @override
  String stepOf(String step, String total) {
    return 'चरण $step / $total';
  }

  @override
  String get pleaseWait => 'कृपया पर्खनुहोस्…';

  @override
  String get errorGeneric => 'केही गलत भयो। फेरि प्रयास गर्नुहोस्।';

  @override
  String get close => 'बन्द गर्नुहोस्';

  @override
  String get welcomeHeadline => 'केही मिनेटमै तपाईंको घर ऋणको निर्णय';

  @override
  String get welcomeBody =>
      'घर ऋण वा सम्पत्ति धितो ऋणका लागि आवेदन दिनुहोस्। हामी सबै कुरा अनलाइन जाँच्छौं र सधैं निर्णयको कारण बताउँछौं।';

  @override
  String get chooseProduct => 'तपाईंलाई के चाहिन्छ?';

  @override
  String get productHomeLoan => 'घर ऋण';

  @override
  String get productHomeLoanSub => 'घर किन्न, बनाउन वा सुधार्न';

  @override
  String get productLap => 'सम्पत्ति धितो ऋण';

  @override
  String get productLapSub => 'आफ्नो सम्पत्ति धितो राखेर ऋण लिनुहोस्';

  @override
  String get startApplication => 'आवेदन सुरु गर्नुहोस्';

  @override
  String get demoCustomers => 'डेमो ग्राहकहरू';

  @override
  String get demoCustomersBody =>
      'नमुना मोबाइल नम्बर भर्न एउटामा ट्याप गर्नुहोस्।';

  @override
  String get personaRavi => 'रवि, ३२, जागिरे, फ्ल्याट किन्दै';

  @override
  String get personaMeena => 'मीना, ४५, कपडा पसल चलाउँछिन् (LAP)';

  @override
  String get personaArjun => 'अर्जुन, २९, जागिरे, बदलिएको तलब स्लिप';

  @override
  String get signInTitle => 'साइन इन';

  @override
  String get mobileLabel => 'मोबाइल नम्बर';

  @override
  String get mobileHint => '१० अङ्कको मोबाइल नम्बर';

  @override
  String get invalidMobile => 'सही १० अङ्कको मोबाइल नम्बर हाल्नुहोस्।';

  @override
  String get sendOtp => 'OTP पठाउनुहोस्';

  @override
  String otpSentTo(String phone) {
    return '$phone मा ६ अङ्कको कोड पठाइयो।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'प्रमाणित गर्नुहोस्';

  @override
  String get demoOtp => 'डेमो कोड: 123456';

  @override
  String get wrongOtp => 'कोड गलत छ। फेरि प्रयास गर्नुहोस्।';

  @override
  String get deviceBound =>
      'यो फोन अब तपाईंको खातासँग जोडियो। अर्को फोनमा साइन इन गर्न नयाँ OTP चाहिन्छ।';

  @override
  String get consentTitle => 'तपाईंको सहमति';

  @override
  String get consentIntro =>
      'हामी तपाईंको डाटा यो ऋणको निर्णय र व्यवस्थापनका लागि मात्र प्रयोग गर्छौं। तपाईं जुनसुकै बेला सहमति फिर्ता लिन सक्नुहुन्छ।';

  @override
  String get consentBureauTitle => 'क्रेडिट रिपोर्ट';

  @override
  String get consentBureauBody =>
      'क्रेडिट ब्युरो (CIBIL, Experian, Equifax वा CRIF) बाट तपाईंको क्रेडिट इतिहास हेरिनेछ। यसले तपाईंको स्कोर घटाउँदैन।';

  @override
  String get consentAaTitle => 'अकाउन्ट एग्रिगेटरमार्फत बैंक स्टेटमेन्ट';

  @override
  String get consentAaBody =>
      'RBI इजाजतप्राप्त अकाउन्ट एग्रिगेटरमार्फत तपाईंको बैंकबाट १२ महिनाको स्टेटमेन्ट ल्याइनेछ। अनुरोध तपाईं आफ्नो AA एपमा स्वीकृत गर्नुहुन्छ।';

  @override
  String get consentKycTitle => 'आधार eKYC र PAN';

  @override
  String get consentKycBody =>
      'UIDAI र आयकर विभागसँग तपाईंको पहिचान पुष्टि गरिनेछ। हामी लुकाइएको आधार नम्बर मात्र राख्छौं।';

  @override
  String get consentPrivacyTitle => 'गोपनीयता सूचना (DPDP ऐन २०२३)';

  @override
  String get consentPrivacyBody =>
      'हामी के सङ्कलन गर्छौं: पहिचान, आय, बैंक र सम्पत्तिको विवरण। किन: तपाईंको ऋणको निर्णय र व्यवस्थापनका लागि। कति समय: कानुनले भनेजति मात्र। तपाईंका अधिकार: डाटा हेर्ने, सच्याउने वा मेटाउने, र हाम्रो गुनासो अधिकारी वा डाटा संरक्षण बोर्डमा उजुरी गर्ने।';

  @override
  String get consentRequired => 'अनिवार्य';

  @override
  String get consentNeeded => 'अगाडि बढ्न सबैमा सहमति दिनुहोस्।';

  @override
  String get agreeAndContinue => 'सहमति दिएर अगाडि बढ्नुहोस्';

  @override
  String get detailsTitle => 'तपाईंको विवरण';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'सही PAN हाल्नुहोस्, जस्तै ABCDE1234F।';

  @override
  String get fetchDetails => 'मेरो विवरण ल्याउनुहोस्';

  @override
  String get fetchedFrom =>
      'PAN, आधार eKYC र बैंक स्टेटमेन्टबाट भरिएको। सच्याउन अङ्कमा ट्याप गर्नुहोस्।';

  @override
  String get nameLabel => 'नाम';

  @override
  String get dobLabel => 'जन्म मिति';

  @override
  String get employmentLabel => 'काम';

  @override
  String get salaried => 'जागिरे';

  @override
  String get selfEmployed => 'स्वरोजगार';

  @override
  String get incomeLabel => 'मासिक खुद आय';

  @override
  String get existingEmiLabel => 'हालका मासिक EMI';

  @override
  String get propertyValueLabel => 'सम्पत्तिको मूल्य';

  @override
  String get loanAmountLabel => 'ऋण रकम';

  @override
  String get tenureLabel => 'अवधि';

  @override
  String yearsLabel(String n) {
    return '$n वर्ष';
  }

  @override
  String get eligibleTitle => 'तपाईंले बढीमा पाउन सक्नुहुन्छ';

  @override
  String emiPerMonth(String amount) {
    return 'मासिक EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'वार्षिक $rate%, परिवर्तनशील (उदाहरण)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'आयको सीमा: तपाईंका सबै EMI मिलेर आयको $pct सम्म हुन सक्छन्।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'सम्पत्तिको सीमा: यति ठूलो ऋण मूल्यको $pct सम्म हुन सक्छ।';
  }

  @override
  String get limitedByAsked => 'यो तपाईंले मागेको रकम हो।';

  @override
  String get eligibilityNote =>
      'तपाईंको विवरणको छिटो जाँच। हाम्रो जाँचपछि प्रस्ताव आउनेछ।';

  @override
  String get selfieTitle => 'सेल्फी लिनुहोस्';

  @override
  String get selfieBody =>
      'हामी तपाईंको अनुहार आधारको फोटोसँग मिलाउँछौं र यो साँच्चै तपाईं हो, फोटोको फोटो होइन भनी जाँच्छौं।';

  @override
  String get selfieTips =>
      'राम्रो उज्यालो, क्यामेरातिर हेर्नुहोस्, टोपी वा चस्मा नलगाउनुहोस्।';

  @override
  String get takeSelfie => 'सेल्फी लिनुहोस्';

  @override
  String get retake => 'फेरि लिनुहोस्';

  @override
  String get checkFace => 'अनुहार भेटियो';

  @override
  String get checkLive => 'जीवित व्यक्ति';

  @override
  String get checkMatch => 'आधारको फोटोसँग मिल्छ';

  @override
  String get selfieFailed =>
      'तपाईंको अनुहार पुष्टि गर्न सकिएन। राम्रो उज्यालोमा फेरि प्रयास गर्नुहोस्, वा भिडियो KYC कल बुक गर्नुहोस्।';

  @override
  String get videoKyc => 'भिडियो KYC कल बुक गर्नुहोस्';

  @override
  String get docsTitle => 'तपाईंका कागजात';

  @override
  String get docsBody =>
      'हरेक कागजातको स्पष्ट फोटो लिनुहोस्, वा ग्यालरीबाट छान्नुहोस्।';

  @override
  String get docPan => 'PAN कार्ड';

  @override
  String get docAadhaar => 'आधार कार्ड (लुकाइएको)';

  @override
  String get docSalarySlip => 'पछिल्लो तलब स्लिप';

  @override
  String get docForm16 => 'फारम 16';

  @override
  String get docItr => 'आयकर विवरण (ITR)';

  @override
  String get docGst => 'GST प्रमाणपत्र';

  @override
  String get docBankStatement => 'बैंक स्टेटमेन्ट';

  @override
  String get bankViaAa => 'तपाईंको अकाउन्ट एग्रिगेटरमार्फत ल्याइएको';

  @override
  String get camera => 'क्यामेरा';

  @override
  String get gallery => 'ग्यालरी';

  @override
  String get checking => 'जाँच हुँदैछ…';

  @override
  String get tooBlurry => 'धेरै धमिलो। फोन स्थिर राखेर फेरि प्रयास गर्नुहोस्।';

  @override
  String get tooMuchGlare => 'धेरै चमक। उज्यालोबाट हटेर फेरि प्रयास गर्नुहोस्।';

  @override
  String get tooDark => 'धेरै अँध्यारो। बढी उज्यालोमा फेरि प्रयास गर्नुहोस्।';

  @override
  String docAccepted(String type) {
    return 'पहिचान भयो: $type';
  }

  @override
  String docWrong(String expected) {
    return 'यो $expected जस्तो देखिँदैन। जाँचेर सही कागजात अपलोड गर्नुहोस्।';
  }

  @override
  String get docUnreadable =>
      'यो कागजात पढ्न सकिएन। अझ स्पष्ट फोटो लिनुहोस्, वा मूल PDF अपलोड गर्नुहोस्।';

  @override
  String docsMissing(String n) {
    return 'अझै $n चाहिन्छ';
  }

  @override
  String get getOffer => 'मेरो सैद्धान्तिक प्रस्ताव देखाउनुहोस्';

  @override
  String get approvedInPrinciple => 'सैद्धान्तिक रूपमा स्वीकृत';

  @override
  String get sanctioned => 'ऋण स्वीकृत';

  @override
  String get referredTitle => 'हामीलाई अलि बढी समय चाहिन्छ';

  @override
  String get rejectedTitle => 'हामी अहिले यो ऋण दिन सक्दैनौं';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years वर्ष · वार्षिक $rate% परिवर्तनशील';
  }

  @override
  String get whyOffer => 'तपाईंले यो प्रस्ताव किन पाउनुभयो';

  @override
  String get whyReferred => 'अब के हुन्छ';

  @override
  String get whyRejected => 'हामीले यो निर्णय किन गर्यौं';

  @override
  String get referBody =>
      'एक अधिकारीले एक कार्यदिनभित्र तपाईंको आवेदन हेर्नुहुनेछ। अहिले तपाईंले केही गर्नुपर्दैन।';

  @override
  String get rejectBody =>
      'तपाईं जुनसुकै बेला कुनै व्यक्तिलाई यो निर्णयको पुनरावलोकन गर्न भन्न सक्नुहुन्छ।';

  @override
  String get addProperty => 'सम्पत्तिको विवरण थप्नुहोस्';

  @override
  String get viewKfs => 'मुख्य तथ्य विवरण हेर्नुहोस्';

  @override
  String get grievance => 'पुनरावलोकन माग्नुहोस् वा उजुरी गर्नुहोस्';

  @override
  String officerLine(String name, String email) {
    return 'गुनासो अधिकारी: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'आवेदन $id';
  }

  @override
  String get startOver => 'नयाँ आवेदन सुरु गर्नुहोस्';

  @override
  String okScore(String score) {
    return 'भुक्तानीको राम्रो इतिहास (स्कोर $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI आयको $pct हो; हाम्रो सीमा $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'ऋण सम्पत्ति मूल्यको $pct हो; सीमा $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'सम्पत्तिको हाम्रो मूल्याङ्कन: $low देखि $high';
  }

  @override
  String get okTitle => 'सम्पत्तिको स्वामित्व र कागजात जाँचियो';

  @override
  String get reasonKyc01 =>
      'फोटोबाट तपाईंको पहिचान पुष्टि गर्न सकिएन। कृपया छोटो भिडियो KYC कल पूरा गर्नुहोस्।';

  @override
  String get reasonFrd02 =>
      'तलब स्लिपको आय बैंकमा जम्मा भएको रकमसँग मिल्दैन। पछिल्लो फारम 16 दिनुहोस्, वा सहमति दिएर हामीलाई ल्याउन दिनुहोस्।';

  @override
  String get reasonFrd03 =>
      'तपाईंको एउटा कागजात जारी गर्ने निकायको प्रमाणीकरणमा असफल भयो।';

  @override
  String get reasonPol01 => 'आवेदकको उमेर कम्तीमा २१ वर्ष हुनुपर्छ।';

  @override
  String get reasonPol02 =>
      'ऋण हामीले अनुमति दिने अधिकतम उमेरभन्दा पर जान्छ। कम उमेरको सह-आवेदक थप्दा मद्दत हुन सक्छ।';

  @override
  String get reasonBur01 =>
      'तपाईंको क्रेडिट स्कोर हाम्रो न्यूनतम ६५० भन्दा कम छ।';

  @override
  String get reasonBur04 =>
      'तपाईंको अझै क्रेडिट इतिहास छैन, त्यसैले एक अधिकारीले तपाईंको बैंक रेकर्ड हेर्नुहुनेछ।';

  @override
  String get reasonBur05 =>
      'तपाईंको क्रेडिट स्कोर अधिकारीले ध्यानपूर्वक हेर्नुपर्छ।';

  @override
  String get reasonPrp01 =>
      'हाम्रा वकिलले सम्पत्तिको स्वामित्व पुनरावलोकन गर्नुपर्छ।';

  @override
  String get reasonPrp03 =>
      'मूल्य पुष्टि गर्न हाम्रा मूल्याङ्कनकर्ताले सम्पत्ति हेर्न जानुपर्छ।';

  @override
  String get reasonPrp04 =>
      'सम्झौता मूल्य यो सम्पत्तिको सरकारी सर्कल रेटभन्दा कम छ। कृपया बिक्री सम्झौता जाँच्नुहोस्।';

  @override
  String get reasonAff01 =>
      'तपाईंका हालका EMI ले पहिल्यै आयको अधिकतम हिस्सा लिइसकेका छन्।';

  @override
  String get reasonAut01 =>
      'यति ठूलो ऋणको अन्तिम जाँच एक वरिष्ठ अधिकारीले गर्नुहुन्छ।';

  @override
  String get reasonRsk01 =>
      'प्रस्ताव अन्तिम गर्न एक अधिकारीले तपाईंको आवेदन हेर्नुहुनेछ।';

  @override
  String get reasonRsk02 =>
      'तपाईंको क्रेडिट प्रोफाइलका आधारमा हामी अहिले यो ऋण दिन सक्दैनौं।';

  @override
  String get propertyTitle => 'तपाईंको सम्पत्ति';

  @override
  String get cityLabel => 'सहर';

  @override
  String get localityLabel => 'क्षेत्र';

  @override
  String get societyLabel => 'परियोजना वा सोसाइटी (भएमा)';

  @override
  String get areaLabel => 'क्षेत्रफल (वर्ग फिट)';

  @override
  String get bhkLabel => 'सुत्ने कोठा';

  @override
  String get newProperty => 'नयाँ';

  @override
  String get resale => 'पुनर्बिक्री';

  @override
  String get declaredPriceLabel => 'सम्झौता मूल्य';

  @override
  String get photosTitle => 'सम्पत्तिका फोटो';

  @override
  String get photosBody =>
      'सम्पत्तिमै गएर फोटो लिनुहोस्। हामी ठाउँ र समय थप्छौं, ताकि मूल्याङ्कनकर्ताले भ्रमणको योजना बनाउन सकून्।';

  @override
  String get photoFront => 'अगाडि';

  @override
  String get photoInside => 'भित्र';

  @override
  String get photoView => 'सम्पत्तिबाट दृश्य';

  @override
  String geoTagged(String lat, String lng) {
    return 'स्थान थपियो ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'स्थानबिना फोटो सुरक्षित भयो। जियो-ट्यागका लागि लोकेसन खोल्नुहोस्।';

  @override
  String get submitProperty => 'अन्तिम स्वीकृति लिनुहोस्';

  @override
  String get fillAll => 'कृपया सबै कोठा भर्नुहोस्।';

  @override
  String get kfsTitle => 'मुख्य तथ्य विवरण';

  @override
  String get kfsLoan => 'ऋण रकम';

  @override
  String get kfsTenure => 'अवधि';

  @override
  String get kfsRate => 'ब्याज दर';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI को सङ्ख्या';

  @override
  String get kfsFee => 'प्रोसेसिङ शुल्क (GST सहित)';

  @override
  String get kfsTotalInterest => 'कुल ब्याज';

  @override
  String get kfsTotalPayable => 'कुल तिर्नुपर्ने रकम';

  @override
  String get kfsApr => 'वार्षिक प्रतिशत दर (APR)';

  @override
  String get kfsCoolingOff =>
      'कुलिङ-अफ अवधि: हस्ताक्षर गरेको ३ दिनभित्र साँवा र ती दिनको ब्याज मात्र फिर्ता गरी जरिवानाबिना बाहिरिन सक्नुहुन्छ।';

  @override
  String get kfsNote =>
      'डेमोका लागि नमुना अङ्क। तपाईंको वास्तविक KFS स्वीकृति पत्रसँगै आउनेछ।';

  @override
  String get useSample => 'नमुना';

  @override
  String get videoKycDemo =>
      'डेमो: यसले एक अधिकारीसँग भिडियो KYC कल बुक गर्थ्यो।';

  @override
  String get raiseComplaint => 'उजुरी गर्नुहोस्';

  @override
  String complaintSent(String ref) {
    return 'तपाईंको उजुरी दर्ता भयो। सन्दर्भ $ref।';
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
  String get stageProperty => 'सम्पत्ति';

  @override
  String get homeSubtitle => 'घर ऋण · सम्पत्ति धितो ऋण';

  @override
  String get heroPill => 'मिनेटमै निर्णय';

  @override
  String heroFacts(String rate, String years) {
    return 'वार्षिक $rate% देखि · $years वर्षसम्म';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% पूरा · जहाँ छोड्नुभएको थियो त्यहीँबाट सुरु गर्नुहोस्';
  }

  @override
  String get resume => 'जारी राख्नुहोस्';

  @override
  String get calculators => 'क्याल्कुलेटर';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'मासिक किस्ता';

  @override
  String get calcEligibility => 'योग्यता';

  @override
  String get calcEligibilitySub => 'तपाईंले कति पाउन सक्नुहुन्छ';

  @override
  String get emiCalcTitle => 'EMI क्याल्कुलेटर';

  @override
  String get eligibilityCalcTitle => 'योग्यता क्याल्कुलेटर';

  @override
  String totalInterest(String amount) {
    return 'कुल ब्याज $amount';
  }

  @override
  String get calcIncomeOnly =>
      'आयको आधारमा मात्र। सम्पत्तिको मूल्यले यसलाई घटाउन सक्छ।';

  @override
  String get verified => 'प्रमाणित';

  @override
  String get yourLoan => 'तपाईंको ऋण';

  @override
  String docsProgress(String done, String total) {
    return '$total मध्ये $done प्रमाणित';
  }

  @override
  String get docNeeded => 'चाहिन्छ';

  @override
  String get docTryAgain => 'फेरि प्रयास';

  @override
  String get fetched => 'ल्याइयो';

  @override
  String get statusApproved => 'स्वीकृत';

  @override
  String get statusSanctioned => 'स्वीकृत भयो';

  @override
  String get statusInReview => 'पुनरावलोकनमा';

  @override
  String get statusDeclined => 'अस्वीकृत';

  @override
  String get trackTitle => 'आफ्नो आवेदन ट्र्याक गर्नुहोस्';

  @override
  String get tlSubmitted => 'आवेदन पेस भयो';

  @override
  String get tlVerified => 'KYC र कागजात प्रमाणित';

  @override
  String get tlInPrinciple => 'सैद्धान्तिक स्वीकृति';

  @override
  String get tlProperty => 'सम्पत्ति विवरण र मूल्याङ्कन';

  @override
  String get tlPropertyNext => 'आफ्नो सम्पत्तिको विवरण र फोटो थप्नुहोस्';

  @override
  String get tlOfficer => 'अधिकारीको पुनरावलोकन';

  @override
  String get tlOfficerNext => 'एक कार्यदिनभित्र';

  @override
  String get tlLegal => 'कानुनी र स्वामित्व जाँच';

  @override
  String get tlSanction => 'अन्तिम स्वीकृति र ई-हस्ताक्षर';

  @override
  String get tlSanctionNext => 'स्वीकृति पत्रमा अनलाइन हस्ताक्षर गर्नुहोस्';

  @override
  String get tlDisbursement => 'रकम भुक्तानी';

  @override
  String get helpTitle => 'मद्दत चाहिन्छ?';

  @override
  String get propertyType => 'नयाँ कि पुनर्बिक्री';

  @override
  String get greetMorning => 'शुभ प्रभात';

  @override
  String get greetAfternoon => 'शुभ दिउँसो';

  @override
  String get greetEvening => 'शुभ साँझ';

  @override
  String nearlyThere(String name) {
    return '$name, तपाईं लगभग पुग्नुभयो';
  }

  @override
  String get chooseLanguage => 'आफ्नो भाषा छान्नुहोस्';

  @override
  String get languageNote => 'तपाईं यसलाई जुनसुकै बेला बदल्न सक्नुहुन्छ।';

  @override
  String get liveChecks => 'लाइभ जाँच';

  @override
  String get checkBureau => 'क्रेडिट ब्युरो';

  @override
  String checkScore(String score) {
    return 'स्कोर $score';
  }

  @override
  String get checkNoHistory => 'अझै इतिहास छैन';

  @override
  String get checkBank => 'AA मार्फत बैंक';

  @override
  String get checkBankRead => '१२ महिना पढियो';

  @override
  String get checkKyc => 'eKYC र सेल्फी';

  @override
  String get checkPending => 'बाँकी';

  @override
  String get checkDocs => 'कागजात';

  @override
  String countOf(String done, String total) {
    return '$total मध्ये $done';
  }

  @override
  String minutesLeft(String n) {
    return 'लगभग $n मिनेट बाँकी';
  }

  @override
  String ratePa(String rate) {
    return 'वार्षिक $rate%';
  }

  @override
  String get continueApplication => 'आफ्नो आवेदन जारी राख्नुहोस्';

  @override
  String get shapeOffer => 'आफ्नो प्रस्ताव तय गर्नुहोस्';

  @override
  String get shapeOfferSub => 'सैद्धान्तिक रूपमा स्वीकृत · बदल्न तान्नुहोस्';

  @override
  String get withinLimits => 'तपाईंको सीमाभित्र';

  @override
  String get aboveLimits => 'सीमाभन्दा बढी: रकम घटाउनुहोस् वा वर्ष बढाउनुहोस्';

  @override
  String mostYouCan(String amount) {
    return 'बढीमा लिन सक्नुहुन्छ: $amount';
  }

  @override
  String get useMax => 'अधिकतम लिनुहोस्';

  @override
  String get principal => 'साँवा';

  @override
  String get interest => 'ब्याज';

  @override
  String get totalRepaid => 'कुल भुक्तानी';

  @override
  String get emiShareIncome => 'आयमा EMI को हिस्सा';

  @override
  String loanShareProperty(String value) {
    return '$value को सम्पत्तिमा ऋणको हिस्सा';
  }

  @override
  String get lockOffer => 'यो प्रस्ताव पक्का गर्नुहोस्';

  @override
  String get offerLocked => 'तपाईंको प्रस्ताव पक्का भयो।';

  @override
  String approvedUpTo(String amount) {
    return '$amount सम्म स्वीकृत';
  }

  @override
  String readingDoc(String doc) {
    return 'तपाईंको $doc पढिँदैछ';
  }

  @override
  String get documentAi => 'कागजात AI';

  @override
  String sure(String pct) {
    return '$pct% निश्चित';
  }

  @override
  String get readMatches => 'यो हामीले मागेकै कागजात हो';

  @override
  String get readClear => 'स्पष्ट फोटो, धमिलोपन वा चमक छैन';

  @override
  String get whatWeRead => 'हामीले के पढ्यौं';

  @override
  String get looksRight => 'ठीक छ';

  @override
  String get fieldName => 'नाम';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'आधार';

  @override
  String get fieldEmployer => 'रोजगारदाता';

  @override
  String get fieldNetPay => 'खुद तलब';

  @override
  String get fieldPeriod => 'तलबको अवधि';

  @override
  String get fieldYear => 'वर्ष';

  @override
  String get fieldIncome => 'आय';

  @override
  String get fieldBusiness => 'व्यवसाय';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'तपाईंको ऋणका लागि आवश्यक';

  @override
  String get consentSectionOptional => 'ऐच्छिक: तपाईंले नखोलेसम्म बन्द';

  @override
  String get advancedOptions => 'विकल्पहरू';

  @override
  String consentValidUntil(String given, String until) {
    return '$given मा दिइयो · $until सम्म मान्य';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given मा दिइयो · फिर्ता नलिएसम्म';
  }

  @override
  String get recheckTitle => 'रकम दिनुअघि अर्को एक जाँच';

  @override
  String get recheckBody =>
      'रकम दिनुअघि हामी तपाईंको क्रेडिट रिपोर्ट फेरि हेर्छौं। नाइँ भन्नुभयो भने त्यतिबेला अधिकारीले सोध्न सक्नुहुन्छ।';

  @override
  String get aaMonthsLabel => 'कति महिनाको स्टेटमेन्ट दिने';

  @override
  String monthsN(String n) {
    return '$n महिना';
  }

  @override
  String get aaAccountsLabel => 'दिने खाताहरू';

  @override
  String get accountSavingsSalary => 'बचत खाता ·· 0912 · तलब जम्मा';

  @override
  String get accountSavings => 'बचत खाता ·· 4821';

  @override
  String get accountFd => 'मुद्दती निक्षेप ·· 3307';

  @override
  String get aaAccountNeeded => 'कम्तीमा एउटा खाता छान्नुहोस्।';

  @override
  String get kycMethodLabel => 'पहिचान कसरी पुष्टि गर्ने';

  @override
  String get kycAadhaarOtp => 'आधार OTP';

  @override
  String get kycDigilocker => 'डिजिलकर';

  @override
  String get kycVideo => 'भिडियो KYC कल';

  @override
  String get useCkycTitle => 'मेरो हालको CKYC रेकर्ड प्रयोग गर्नुहोस्';

  @override
  String get useCkycBody =>
      'अर्को बैंक वा फन्डमा KYC गर्नुभएको छ भने, फेरि नसोधी हामी त्यही रेकर्ड ल्याउँछौं।';

  @override
  String get optOffersTitle => 'प्रस्ताव र नयाँ उत्पादन';

  @override
  String get optOffersBody =>
      'प्रस्तावबारे कसरी थाहा पाउने छान्नुहोस्। जुनसुकै बेला बन्द गर्न सक्नुहुन्छ।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'इमेल';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp मा ऋणका अपडेट';

  @override
  String get optUpdatesBody =>
      'SMS सँगै WhatsApp मा स्थिति अपडेट र EMI सम्झना।';

  @override
  String get optInsuranceTitle => 'घर ऋण सुरक्षा कोटेसन';

  @override
  String get optInsuranceBody =>
      'कोटेसनका लागि आफ्नो नाम, उमेर र ऋण रकम हाम्रो बीमा साझेदारलाई दिनुहोस्। किन्नु कहिल्यै अनिवार्य छैन।';

  @override
  String get getQuote => 'कोटेसन लिनुहोस्';

  @override
  String get manageConsents => 'सहमति व्यवस्थापन';

  @override
  String get manageConsentsBody =>
      'ऐच्छिक सहमति जुनसुकै बेला बन्द गर्नुहोस्। आवश्यक सहमति फिर्ता लिँदा आवेदन रोकिन्छ, र त्यसका लागि ल्याइएको डाटा हामी मेटाउँछौं।';

  @override
  String get withdraw => 'फिर्ता लिनुहोस्';

  @override
  String get consentHistory => 'सहमतिको इतिहास';

  @override
  String historyGiven(String item) {
    return '$item दिइयो';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item फिर्ता लिइयो';
  }

  @override
  String get historyEmpty => 'अहिलेसम्म केही छैन।';

  @override
  String get consentOn => 'खुला';

  @override
  String get consentOff => 'बन्द';

  @override
  String get withdrawnRequired =>
      'तपाईंले आवश्यक सहमति फिर्ता लिनुभयो, त्यसैले आवेदन रोकिएको छ।';

  @override
  String get checkMatchPending =>
      'फोटो मिलान: आधार वा प्यान कार्ड अपलोड गर्दा हुन्छ';
}
