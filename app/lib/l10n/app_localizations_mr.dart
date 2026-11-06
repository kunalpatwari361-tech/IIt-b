// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appTitle => 'निर्णय';

  @override
  String get sandboxBanner => 'डेमो मोड: नमुना माहिती, खरी तपासणी नाही';

  @override
  String get continueLabel => 'पुढे चला';

  @override
  String stepOf(String step, String total) {
    return 'पायरी $step / $total';
  }

  @override
  String get pleaseWait => 'कृपया थांबा…';

  @override
  String get errorGeneric => 'काहीतरी चुकले. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get close => 'बंद करा';

  @override
  String get welcomeHeadline => 'काही मिनिटांत तुमच्या गृहकर्जाचा निर्णय';

  @override
  String get welcomeBody =>
      'गृहकर्ज किंवा मालमत्तेवर कर्जासाठी अर्ज करा. आम्ही सर्व काही ऑनलाइन तपासतो आणि नेहमी निर्णयाचे कारण सांगतो.';

  @override
  String get chooseProduct => 'तुम्हाला काय हवे आहे?';

  @override
  String get productHomeLoan => 'गृहकर्ज';

  @override
  String get productHomeLoanSub => 'घर खरेदी, बांधकाम किंवा दुरुस्ती';

  @override
  String get productLap => 'मालमत्तेवर कर्ज';

  @override
  String get productLapSub => 'तुमच्या मालमत्तेवर कर्ज घ्या';

  @override
  String get startApplication => 'अर्ज सुरू करा';

  @override
  String get demoCustomers => 'डेमो ग्राहक';

  @override
  String get demoCustomersBody => 'नमुना मोबाइल नंबर भरण्यासाठी एकावर टॅप करा.';

  @override
  String get personaRavi => 'रवी, ३२, नोकरदार, फ्लॅट घेत आहे';

  @override
  String get personaMeena => 'मीना, ४५, कपड्यांचे दुकान चालवते (LAP)';

  @override
  String get personaArjun => 'अर्जुन, २९, नोकरदार, बदललेली पगार स्लिप';

  @override
  String get signInTitle => 'साइन इन';

  @override
  String get mobileLabel => 'मोबाइल नंबर';

  @override
  String get mobileHint => '१० अंकी मोबाइल नंबर';

  @override
  String get invalidMobile => 'योग्य १० अंकी मोबाइल नंबर टाका.';

  @override
  String get sendOtp => 'OTP पाठवा';

  @override
  String otpSentTo(String phone) {
    return '$phone वर ६ अंकी कोड पाठवला आहे.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'पडताळा';

  @override
  String get demoOtp => 'डेमो कोड: 123456';

  @override
  String get wrongOtp => 'कोड चुकीचा आहे. पुन्हा प्रयत्न करा.';

  @override
  String get deviceBound =>
      'हा फोन आता तुमच्या खात्याशी जोडला गेला आहे. दुसऱ्या फोनवर साइन इन करण्यासाठी नवीन OTP लागेल.';

  @override
  String get consentTitle => 'तुमची संमती';

  @override
  String get consentIntro =>
      'आम्ही तुमची माहिती फक्त या कर्जाचा निर्णय आणि व्यवस्थापनासाठी वापरतो. तुम्ही कधीही संमती मागे घेऊ शकता.';

  @override
  String get consentBureauTitle => 'क्रेडिट रिपोर्ट';

  @override
  String get consentBureauBody =>
      'क्रेडिट ब्युरो (CIBIL, Experian, Equifax किंवा CRIF) कडून तुमचा क्रेडिट इतिहास तपासला जाईल. यामुळे तुमचा स्कोर कमी होत नाही.';

  @override
  String get consentAaTitle => 'अकाउंट ॲग्रिगेटरमार्फत बँक स्टेटमेंट';

  @override
  String get consentAaBody =>
      'RBI परवानाधारक अकाउंट ॲग्रिगेटरमार्फत तुमच्या बँकेचे १२ महिन्यांचे स्टेटमेंट आणले जाईल. विनंती तुम्ही तुमच्या AA ॲपमध्ये मंजूर करता.';

  @override
  String get consentKycTitle => 'आधार eKYC आणि PAN';

  @override
  String get consentKycBody =>
      'UIDAI आणि आयकर विभागाकडे तुमची ओळख पडताळली जाईल. आम्ही फक्त लपवलेला आधार क्रमांक ठेवतो.';

  @override
  String get consentPrivacyTitle => 'गोपनीयता सूचना (DPDP कायदा २०२३)';

  @override
  String get consentPrivacyBody =>
      'आम्ही काय गोळा करतो: ओळख, उत्पन्न, बँक आणि मालमत्तेची माहिती. का: तुमच्या कर्जाचा निर्णय आणि व्यवस्थापनासाठी. किती काळ: कायद्याने आवश्यक तितकाच. तुमचे हक्क: माहिती पाहणे, दुरुस्त करणे किंवा हटवणे, आणि आमच्या तक्रार अधिकाऱ्याकडे किंवा डेटा संरक्षण मंडळाकडे तक्रार करणे.';

  @override
  String get consentRequired => 'आवश्यक';

  @override
  String get consentNeeded => 'पुढे जाण्यासाठी सर्व बाबींना संमती द्या.';

  @override
  String get agreeAndContinue => 'संमती देऊन पुढे चला';

  @override
  String get detailsTitle => 'तुमची माहिती';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'योग्य PAN टाका, उदा. ABCDE1234F.';

  @override
  String get fetchDetails => 'माझी माहिती आणा';

  @override
  String get fetchedFrom =>
      'PAN, आधार eKYC आणि बँक स्टेटमेंटमधून भरले आहे. दुरुस्तीसाठी आकड्यावर टॅप करा.';

  @override
  String get nameLabel => 'नाव';

  @override
  String get dobLabel => 'जन्मतारीख';

  @override
  String get employmentLabel => 'काम';

  @override
  String get salaried => 'नोकरदार';

  @override
  String get selfEmployed => 'स्वयंरोजगार';

  @override
  String get incomeLabel => 'मासिक निव्वळ उत्पन्न';

  @override
  String get existingEmiLabel => 'सध्याचे मासिक EMI';

  @override
  String get propertyValueLabel => 'मालमत्तेची किंमत';

  @override
  String get loanAmountLabel => 'कर्जाची रक्कम';

  @override
  String get tenureLabel => 'मुदत';

  @override
  String yearsLabel(String n) {
    return '$n वर्षे';
  }

  @override
  String get eligibleTitle => 'तुम्हाला जास्तीत जास्त मिळू शकते';

  @override
  String emiPerMonth(String amount) {
    return 'मासिक EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'वार्षिक $rate%, बदलता दर (उदाहरण)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'उत्पन्नानुसार मर्यादा: सर्व EMI मिळून उत्पन्नाच्या $pct पर्यंत असू शकतात.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'मालमत्तेनुसार मर्यादा: इतक्या कर्जासाठी किंमतीच्या $pct पर्यंत कर्ज मिळू शकते.';
  }

  @override
  String get limitedByAsked => 'ही तुम्ही मागितलेली रक्कम आहे.';

  @override
  String get eligibilityNote =>
      'तुमच्या माहितीची झटपट तपासणी. आमच्या तपासणीनंतर ऑफर मिळेल.';

  @override
  String get selfieTitle => 'सेल्फी घ्या';

  @override
  String get selfieBody =>
      'आम्ही तुमचा चेहरा आधार फोटोशी जुळवतो आणि खात्री करतो की ते खरोखर तुम्ही आहात, फोटोचा फोटो नाही.';

  @override
  String get selfieTips =>
      'चांगला प्रकाश, कॅमेऱ्याकडे पाहा, टोपी किंवा गॉगल नको.';

  @override
  String get takeSelfie => 'सेल्फी घ्या';

  @override
  String get retake => 'पुन्हा घ्या';

  @override
  String get checkFace => 'चेहरा सापडला';

  @override
  String get checkLive => 'जिवंत व्यक्ती';

  @override
  String get checkMatch => 'आधार फोटोशी जुळते';

  @override
  String get selfieFailed =>
      'तुमचा चेहरा निश्चित करता आला नाही. चांगल्या प्रकाशात पुन्हा प्रयत्न करा, किंवा व्हिडिओ KYC कॉल बुक करा.';

  @override
  String get videoKyc => 'व्हिडिओ KYC कॉल बुक करा';

  @override
  String get docsTitle => 'तुमची कागदपत्रे';

  @override
  String get docsBody =>
      'प्रत्येक कागदपत्राचा स्पष्ट फोटो घ्या, किंवा गॅलरीतून निवडा.';

  @override
  String get docPan => 'PAN कार्ड';

  @override
  String get docAadhaar => 'आधार कार्ड (लपवलेले)';

  @override
  String get docSalarySlip => 'अलीकडची पगार स्लिप';

  @override
  String get docForm16 => 'फॉर्म 16';

  @override
  String get docItr => 'आयकर विवरणपत्र (ITR)';

  @override
  String get docGst => 'GST प्रमाणपत्र';

  @override
  String get docBankStatement => 'बँक स्टेटमेंट';

  @override
  String get bankViaAa => 'तुमच्या अकाउंट ॲग्रिगेटरमार्फत आणले';

  @override
  String get camera => 'कॅमेरा';

  @override
  String get gallery => 'गॅलरी';

  @override
  String get checking => 'तपासत आहे…';

  @override
  String get tooBlurry => 'खूप अस्पष्ट. फोन स्थिर धरून पुन्हा प्रयत्न करा.';

  @override
  String get tooMuchGlare =>
      'खूप चमक. प्रकाशापासून दूर होऊन पुन्हा प्रयत्न करा.';

  @override
  String get tooDark => 'खूप अंधार. जास्त प्रकाशात पुन्हा प्रयत्न करा.';

  @override
  String docAccepted(String type) {
    return 'ओळखले: $type';
  }

  @override
  String docWrong(String expected) {
    return 'हे $expected दिसत नाही. तपासून योग्य कागदपत्र अपलोड करा.';
  }

  @override
  String get docUnreadable =>
      'हे कागदपत्र वाचता आले नाही. अधिक स्पष्ट फोटो घ्या, किंवा मूळ PDF अपलोड करा.';

  @override
  String docsMissing(String n) {
    return 'अजून $n हवे';
  }

  @override
  String get getOffer => 'माझी तत्त्वतः ऑफर पाहा';

  @override
  String get approvedInPrinciple => 'तत्त्वतः मंजूर';

  @override
  String get sanctioned => 'कर्ज मंजूर';

  @override
  String get referredTitle => 'आम्हाला थोडा अधिक वेळ हवा आहे';

  @override
  String get rejectedTitle => 'सध्या आम्ही हे कर्ज देऊ शकत नाही';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years वर्षे · वार्षिक $rate% बदलता दर';
  }

  @override
  String get whyOffer => 'तुम्हाला ही ऑफर का मिळाली';

  @override
  String get whyReferred => 'पुढे काय होईल';

  @override
  String get whyRejected => 'आम्ही हा निर्णय का घेतला';

  @override
  String get referBody =>
      'एक अधिकारी एका कामकाजाच्या दिवसात तुमचा अर्ज पाहील. आत्ता तुम्हाला काहीही करण्याची गरज नाही.';

  @override
  String get rejectBody =>
      'तुम्ही कधीही एखाद्या व्यक्तीला या निर्णयाचा फेरविचार करण्यास सांगू शकता.';

  @override
  String get addProperty => 'मालमत्तेची माहिती जोडा';

  @override
  String get viewKfs => 'मुख्य तथ्य विवरण पाहा';

  @override
  String get grievance => 'फेरविचार मागा किंवा तक्रार करा';

  @override
  String officerLine(String name, String email) {
    return 'तक्रार अधिकारी: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'अर्ज $id';
  }

  @override
  String get startOver => 'नवीन अर्ज सुरू करा';

  @override
  String okScore(String score) {
    return 'परतफेडीचा चांगला इतिहास (स्कोर $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI उत्पन्नाच्या $pct आहेत; आमची मर्यादा $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'कर्ज मालमत्तेच्या किंमतीच्या $pct आहे; मर्यादा $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'मालमत्तेचे आमचे मूल्यांकन: $low ते $high';
  }

  @override
  String get okTitle => 'मालमत्तेचा मालकी हक्क आणि कागदपत्रे तपासली';

  @override
  String get reasonKyc01 =>
      'फोटोवरून तुमची ओळख निश्चित करता आली नाही. कृपया एक छोटा व्हिडिओ KYC कॉल पूर्ण करा.';

  @override
  String get reasonFrd02 =>
      'पगार स्लिपवरील उत्पन्न बँकेतील जमांशी जुळत नाही. तुमचा अलीकडचा फॉर्म 16 द्या, किंवा संमतीने आम्हाला तो आणू द्या.';

  @override
  String get reasonFrd03 =>
      'तुमचे एक कागदपत्र जारी करणाऱ्या प्राधिकरणाच्या पडताळणीत अयशस्वी झाले.';

  @override
  String get reasonPol01 => 'अर्जदाराचे वय किमान २१ वर्षे असावे.';

  @override
  String get reasonPol02 =>
      'कर्ज आमच्या कमाल वयोमर्यादेपलीकडे जाईल. कमी वयाचा सह-अर्जदार जोडल्यास मदत होऊ शकते.';

  @override
  String get reasonBur01 =>
      'तुमचा क्रेडिट स्कोर आमच्या किमान ६५० पेक्षा कमी आहे.';

  @override
  String get reasonBur04 =>
      'तुमचा अजून क्रेडिट इतिहास नाही, म्हणून एक अधिकारी तुमच्या बँक नोंदी पाहील.';

  @override
  String get reasonBur05 =>
      'तुमचा क्रेडिट स्कोर अधिकाऱ्याने नीट पाहणे आवश्यक आहे.';

  @override
  String get reasonPrp01 =>
      'आमच्या वकिलाने मालमत्तेचा मालकी हक्क तपासणे आवश्यक आहे.';

  @override
  String get reasonPrp03 =>
      'किंमत निश्चित करण्यासाठी आमच्या मूल्यांकनकाराने मालमत्तेला भेट द्यावी लागेल.';

  @override
  String get reasonPrp04 =>
      'करारमूल्य या मालमत्तेच्या शासकीय रेडी रेकनर दरापेक्षा कमी आहे. कृपया विक्री करार तपासा.';

  @override
  String get reasonAff01 =>
      'तुमचे सध्याचे EMI आधीच उत्पन्नाचा कमाल हिस्सा वापरतात.';

  @override
  String get reasonAut01 =>
      'इतक्या मोठ्या कर्जाची अंतिम तपासणी वरिष्ठ अधिकारी करतात.';

  @override
  String get reasonRsk01 => 'ऑफर अंतिम करण्यासाठी एक अधिकारी तुमचा अर्ज पाहील.';

  @override
  String get reasonRsk02 =>
      'तुमच्या क्रेडिट प्रोफाइलनुसार सध्या आम्ही हे कर्ज देऊ शकत नाही.';

  @override
  String get propertyTitle => 'तुमची मालमत्ता';

  @override
  String get cityLabel => 'शहर';

  @override
  String get localityLabel => 'परिसर';

  @override
  String get societyLabel => 'प्रकल्प किंवा सोसायटी (असल्यास)';

  @override
  String get areaLabel => 'क्षेत्रफळ (चौ. फूट)';

  @override
  String get bhkLabel => 'बेडरूम';

  @override
  String get newProperty => 'नवीन';

  @override
  String get resale => 'पुनर्विक्री';

  @override
  String get declaredPriceLabel => 'करारमूल्य';

  @override
  String get photosTitle => 'मालमत्तेचे फोटो';

  @override
  String get photosBody =>
      'मालमत्तेच्या ठिकाणी फोटो घ्या. आम्ही ठिकाण आणि वेळ जोडतो, जेणेकरून मूल्यांकनकार भेटीचे नियोजन करू शकेल.';

  @override
  String get photoFront => 'समोरून';

  @override
  String get photoInside => 'आतून';

  @override
  String get photoView => 'मालमत्तेतून दिसणारे दृश्य';

  @override
  String geoTagged(String lat, String lng) {
    return 'ठिकाण जोडले ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'ठिकाणाशिवाय फोटो जतन झाला. जिओ-टॅगसाठी लोकेशन सुरू करा.';

  @override
  String get submitProperty => 'अंतिम मंजुरी मिळवा';

  @override
  String get fillAll => 'कृपया सर्व रकाने भरा.';

  @override
  String get kfsTitle => 'मुख्य तथ्य विवरण';

  @override
  String get kfsLoan => 'कर्जाची रक्कम';

  @override
  String get kfsTenure => 'मुदत';

  @override
  String get kfsRate => 'व्याजदर';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI ची संख्या';

  @override
  String get kfsFee => 'प्रक्रिया शुल्क (GST सह)';

  @override
  String get kfsTotalInterest => 'एकूण व्याज';

  @override
  String get kfsTotalPayable => 'एकूण देय रक्कम';

  @override
  String get kfsApr => 'वार्षिक टक्केवारी दर (APR)';

  @override
  String get kfsCoolingOff =>
      'कूलिंग-ऑफ कालावधी: सही केल्यापासून ३ दिवसांत फक्त मुद्दल आणि त्या दिवसांचे व्याज परत करून विनादंड बाहेर पडू शकता.';

  @override
  String get kfsNote =>
      'डेमोसाठी नमुना आकडे. खरे KFS तुमच्या मंजुरी पत्रासोबत येईल.';

  @override
  String get useSample => 'नमुना';

  @override
  String get videoKycDemo =>
      'डेमो: यामुळे अधिकाऱ्यासोबत व्हिडिओ KYC कॉल बुक झाला असता.';

  @override
  String get raiseComplaint => 'तक्रार करा';

  @override
  String complaintSent(String ref) {
    return 'तुमची तक्रार नोंदवली गेली. संदर्भ $ref.';
  }

  @override
  String get stageSignIn => 'साइन इन';

  @override
  String get stageDetails => 'माहिती';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'ऑफर';

  @override
  String get stageProperty => 'मालमत्ता';

  @override
  String get homeSubtitle => 'गृहकर्ज · मालमत्तेवर कर्ज';

  @override
  String get heroPill => 'मिनिटांत निर्णय';

  @override
  String heroFacts(String rate, String years) {
    return 'वार्षिक $rate% पासून · $years वर्षांपर्यंत';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% पूर्ण · जिथे थांबलात तिथून सुरू करा';
  }

  @override
  String get resume => 'पुन्हा सुरू';

  @override
  String get calculators => 'कॅल्क्युलेटर';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'मासिक हप्ता';

  @override
  String get calcEligibility => 'पात्रता';

  @override
  String get calcEligibilitySub => 'किती मिळू शकते';

  @override
  String get emiCalcTitle => 'EMI कॅल्क्युलेटर';

  @override
  String get eligibilityCalcTitle => 'पात्रता कॅल्क्युलेटर';

  @override
  String totalInterest(String amount) {
    return 'एकूण व्याज $amount';
  }

  @override
  String get calcIncomeOnly =>
      'फक्त उत्पन्नावर आधारित. मालमत्तेच्या किंमतीमुळे हे कमी होऊ शकते.';

  @override
  String get verified => 'पडताळलेले';

  @override
  String get yourLoan => 'तुमचे कर्ज';

  @override
  String docsProgress(String done, String total) {
    return '$total पैकी $done पडताळले';
  }

  @override
  String get docNeeded => 'हवे';

  @override
  String get docTryAgain => 'पुन्हा करा';

  @override
  String get fetched => 'आणले';

  @override
  String get statusApproved => 'मंजूर';

  @override
  String get statusSanctioned => 'मंजूर झाले';

  @override
  String get statusInReview => 'तपासणीत';

  @override
  String get statusDeclined => 'नाकारले';

  @override
  String get trackTitle => 'तुमचा अर्ज ट्रॅक करा';

  @override
  String get tlSubmitted => 'अर्ज सादर झाला';

  @override
  String get tlVerified => 'KYC आणि कागदपत्रे पडताळली';

  @override
  String get tlInPrinciple => 'तत्त्वतः मंजुरी';

  @override
  String get tlProperty => 'मालमत्तेची माहिती आणि मूल्यांकन';

  @override
  String get tlPropertyNext => 'तुमच्या मालमत्तेची माहिती आणि फोटो जोडा';

  @override
  String get tlOfficer => 'अधिकाऱ्याची तपासणी';

  @override
  String get tlOfficerNext => 'एका कामकाजाच्या दिवसात';

  @override
  String get tlLegal => 'कायदेशीर आणि मालकी तपासणी';

  @override
  String get tlSanction => 'अंतिम मंजुरी आणि ई-सही';

  @override
  String get tlSanctionNext => 'मंजुरी पत्रावर ऑनलाइन सही करा';

  @override
  String get tlDisbursement => 'रक्कम वितरण';

  @override
  String get helpTitle => 'मदत हवी आहे?';

  @override
  String get propertyType => 'नवीन की पुनर्विक्री';

  @override
  String get greetMorning => 'सुप्रभात';

  @override
  String get greetAfternoon => 'नमस्कार';

  @override
  String get greetEvening => 'शुभ संध्याकाळ';

  @override
  String nearlyThere(String name) {
    return '$name, तुम्ही जवळजवळ पोहोचलात';
  }

  @override
  String get chooseLanguage => 'तुमची भाषा निवडा';

  @override
  String get languageNote => 'तुम्ही हे कधीही बदलू शकता.';

  @override
  String get liveChecks => 'थेट तपासण्या';

  @override
  String get checkBureau => 'क्रेडिट ब्युरो';

  @override
  String checkScore(String score) {
    return 'स्कोर $score';
  }

  @override
  String get checkNoHistory => 'अजून इतिहास नाही';

  @override
  String get checkBank => 'AA मार्फत बँक';

  @override
  String get checkBankRead => '१२ महिने वाचले';

  @override
  String get checkKyc => 'eKYC आणि सेल्फी';

  @override
  String get checkPending => 'बाकी';

  @override
  String get checkDocs => 'कागदपत्रे';

  @override
  String countOf(String done, String total) {
    return '$total पैकी $done';
  }

  @override
  String minutesLeft(String n) {
    return 'सुमारे $n मिनिटे बाकी';
  }

  @override
  String ratePa(String rate) {
    return 'वार्षिक $rate%';
  }

  @override
  String get continueApplication => 'तुमचा अर्ज पुढे सुरू ठेवा';

  @override
  String get shapeOffer => 'तुमची ऑफर ठरवा';

  @override
  String get shapeOfferSub => 'तत्त्वतः मंजूर · बदलण्यासाठी सरकवा';

  @override
  String get withinLimits => 'तुमच्या मर्यादेत';

  @override
  String get aboveLimits =>
      'मर्यादेपेक्षा जास्त: रक्कम कमी करा किंवा वर्षे वाढवा';

  @override
  String mostYouCan(String amount) {
    return 'जास्तीत जास्त घेऊ शकता: $amount';
  }

  @override
  String get useMax => 'जास्तीत जास्त घ्या';

  @override
  String get principal => 'मुद्दल';

  @override
  String get interest => 'व्याज';

  @override
  String get totalRepaid => 'एकूण परतफेड';

  @override
  String get emiShareIncome => 'उत्पन्नातील EMI चा वाटा';

  @override
  String loanShareProperty(String value) {
    return '$value मालमत्तेतील कर्जाचा वाटा';
  }

  @override
  String get lockOffer => 'ही ऑफर पक्की करा';

  @override
  String get offerLocked => 'तुमची ऑफर पक्की झाली.';

  @override
  String approvedUpTo(String amount) {
    return '$amount पर्यंत मंजूर';
  }

  @override
  String readingDoc(String doc) {
    return 'तुमचे $doc वाचत आहोत';
  }

  @override
  String get documentAi => 'कागदपत्र AI';

  @override
  String sure(String pct) {
    return '$pct% खात्री';
  }

  @override
  String get readMatches => 'हेच कागदपत्र आम्ही मागितले होते';

  @override
  String get readClear => 'स्पष्ट फोटो, धूसरपणा किंवा चमक नाही';

  @override
  String get whatWeRead => 'आम्ही काय वाचले';

  @override
  String get looksRight => 'बरोबर आहे';

  @override
  String get fieldName => 'नाव';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'आधार';

  @override
  String get fieldEmployer => 'नियोक्ता';

  @override
  String get fieldNetPay => 'निव्वळ पगार';

  @override
  String get fieldPeriod => 'पगाराचा कालावधी';

  @override
  String get fieldYear => 'वर्ष';

  @override
  String get fieldIncome => 'उत्पन्न';

  @override
  String get fieldBusiness => 'व्यवसाय';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'तुमच्या कर्जासाठी आवश्यक';

  @override
  String get consentSectionOptional => 'ऐच्छिक: तुम्ही सुरू करेपर्यंत बंद';

  @override
  String get advancedOptions => 'पर्याय';

  @override
  String consentValidUntil(String given, String until) {
    return '$given रोजी दिली · $until पर्यंत वैध';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given रोजी दिली · मागे घेईपर्यंत';
  }

  @override
  String get recheckTitle => 'रक्कम देण्याआधी आणखी एक तपासणी';

  @override
  String get recheckBody =>
      'रक्कम देण्याआधी आम्ही तुमचा क्रेडिट रिपोर्ट पुन्हा पाहतो. नाही म्हटल्यास अधिकारी तेव्हा विचारू शकतात.';

  @override
  String get aaMonthsLabel => 'किती महिन्यांचे स्टेटमेंट द्यायचे';

  @override
  String monthsN(String n) {
    return '$n महिने';
  }

  @override
  String get aaAccountsLabel => 'द्यायची खाती';

  @override
  String get accountSavingsSalary => 'बचत खाते ·· 0912 · पगार जमा';

  @override
  String get accountSavings => 'बचत खाते ·· 4821';

  @override
  String get accountFd => 'मुदत ठेव ·· 3307';

  @override
  String get aaAccountNeeded => 'किमान एक खाते निवडा.';

  @override
  String get kycMethodLabel => 'ओळख कशी पडताळायची';

  @override
  String get kycAadhaarOtp => 'आधार OTP';

  @override
  String get kycDigilocker => 'डिजीलॉकर';

  @override
  String get kycVideo => 'व्हिडिओ KYC कॉल';

  @override
  String get useCkycTitle => 'माझा सध्याचा CKYC रेकॉर्ड वापरा';

  @override
  String get useCkycBody =>
      'दुसऱ्या बँकेत किंवा फंडात KYC केले असल्यास, पुन्हा न विचारता आम्ही तो रेकॉर्ड आणतो.';

  @override
  String get optOffersTitle => 'ऑफर आणि नवीन उत्पादने';

  @override
  String get optOffersBody =>
      'ऑफरबद्दल कसे कळवायचे ते निवडा. हे कधीही बंद करू शकता.';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ईमेल';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp वर कर्जाचे अपडेट';

  @override
  String get optUpdatesBody =>
      'SMS सोबत WhatsApp वर स्टेटस अपडेट आणि EMI स्मरणपत्रे.';

  @override
  String get optInsuranceTitle => 'गृहकर्ज संरक्षणाचे कोटेशन';

  @override
  String get optInsuranceBody =>
      'कोटेशनसाठी तुमचे नाव, वय आणि कर्जाची रक्कम आमच्या विमा भागीदाराला द्या. खरेदी कधीही बंधनकारक नाही.';

  @override
  String get getQuote => 'कोटेशन घ्या';

  @override
  String get manageConsents => 'संमती व्यवस्थापित करा';

  @override
  String get manageConsentsBody =>
      'ऐच्छिक संमती कधीही बंद करा. आवश्यक संमती मागे घेतल्यास अर्ज थांबतो, आणि तिच्यासाठी आणलेली माहिती आम्ही हटवतो.';

  @override
  String get withdraw => 'मागे घ्या';

  @override
  String get consentHistory => 'संमतीचा इतिहास';

  @override
  String historyGiven(String item) {
    return '$item दिली';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item मागे घेतली';
  }

  @override
  String get historyEmpty => 'अजून काही नाही.';

  @override
  String get consentOn => 'सुरू';

  @override
  String get consentOff => 'बंद';

  @override
  String get withdrawnRequired =>
      'तुम्ही आवश्यक संमती मागे घेतली, म्हणून अर्ज थांबला आहे.';

  @override
  String get checkMatchPending =>
      'फोटो जुळवणी: आधार किंवा पॅन कार्ड अपलोड केल्यावर होईल';
}
