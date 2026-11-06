// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bodo (`brx`).
class AppLocalizationsBrx extends AppLocalizations {
  AppLocalizationsBrx([String locale = 'brx']) : super(locale);

  @override
  String get appTitle => 'निर्णय';

  @override
  String get sandboxBanner => 'डेमो मोड: बिदिन्थि डेटा, थार नायनाय नङा';

  @override
  String get continueLabel => 'सिगाङाव थां';

  @override
  String stepOf(String step, String total) {
    return 'खान्थि $step / $total';
  }

  @override
  String get pleaseWait => 'अननानै नेथ\'…';

  @override
  String get errorGeneric => 'माबा मोनसे गोरोन्थि जाबाय। फिन नाजाबदो।';

  @override
  String get close => 'बन्द खालाम';

  @override
  String get welcomeHeadline =>
      'मिनिट खथि सिमाव नोंथांनि न\'नि लोननि सिद्धान्त';

  @override
  String get welcomeBody =>
      'न\'नि लोन एबा सम्पत्तिनि सायाव लोननि थाखाय आबेदन खालाम। जों गासैबो अनलाइनाव नायस\'दों आरो सिद्धान्तनि जाहोनखौ सबसमाव बुङो।';

  @override
  String get chooseProduct => 'नोंथांनो मा नांगौ?';

  @override
  String get productHomeLoan => 'न\'नि लोन';

  @override
  String get productHomeLoanSub => 'न\' बायनो, बानायनो एबा गोजोन खालामनो';

  @override
  String get productLap => 'सम्पत्तिनि सायाव लोन';

  @override
  String get productLapSub => 'नोंथांनि सम्पत्तिनि सायाव धार ला';

  @override
  String get startApplication => 'आबेदन जागायहो';

  @override
  String get demoCustomers => 'डेमो ग्राहकफोर';

  @override
  String get demoCustomersBody =>
      'बिदिन्थि मोबाइल नम्बर हाबहोनो मोनसेयाव टेप खालाम।';

  @override
  String get personaRavi => 'रबि, 32, चाकरि खालामग्रा, फ्लेट बायदों';

  @override
  String get personaMeena => 'मीना, 45, सिनि दुकान लांदों (LAP)';

  @override
  String get personaArjun =>
      'अर्जुन, 29, चाकरि खालामग्रा, सोलायनाय दरमाहा स्लिप';

  @override
  String get signInTitle => 'साइन इन';

  @override
  String get mobileLabel => 'मोबाइल नम्बर';

  @override
  String get mobileHint => '10 अंकनि मोबाइल नम्बर';

  @override
  String get invalidMobile => 'थार 10 अंकनि मोबाइल नम्बर हाबहो।';

  @override
  String get sendOtp => 'OTP दैथाय';

  @override
  String otpSentTo(String phone) {
    return 'जों $phone आव 6 अंकनि कोड दैथायबाय।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'थार खालाम';

  @override
  String get demoOtp => 'डेमो कोड: 123456';

  @override
  String get wrongOtp => 'कोडआ गोरोन्थि। फिन नाजाबदो।';

  @override
  String get deviceBound =>
      'बे फोनआ दानो नोंथांनि एकाउन्टजों दाजाबबाय। गुबुन फोनाव साइन इन खालामनो गोदान OTP नांगोन।';

  @override
  String get consentTitle => 'नोंथांनि गनायथि';

  @override
  String get consentIntro =>
      'जों नोंथांनि डेटाखौ बे लोननि सिद्धान्त आरो फरायनायनि थाखायल\' बाहायो। नोंथांआ जायखिजाया समाव गनायथिखौ फिन लाफिननो हायो।';

  @override
  String get consentBureauTitle => 'क्रेडिट रिपोर्ट';

  @override
  String get consentBureauBody =>
      'क्रेडिट ब्युरो (CIBIL, Experian, Equifax एबा CRIF) निफ्राय नोंथांनि क्रेडिट जारिमिन नायगोन। बेनि थाखाय नोंथांनि स्कोरआ खमा जाया।';

  @override
  String get consentAaTitle => 'एकाउन्ट एग्रिगेटरनि गेजेरजों बैंक स्टेटमेन्ट';

  @override
  String get consentAaBody =>
      'RBI लाइसेन्स मोननाय एकाउन्ट एग्रिगेटरनि गेजेरजों नोंथांनि बैंकनिफ्राय 12 दाननि स्टेटमेन्ट लाबोगोन। आरजिखौ नोंथांआ नोंथांनि AA एपआव गनायथि होगोन।';

  @override
  String get consentKycTitle => 'आधार eKYC आरो PAN';

  @override
  String get consentKycBody =>
      'UIDAI आरो आयकर बिफानजों नोंथांनि सिनायथि थार खालामगोन। जों दोनथुमनाय आधार नम्बरखौल\' दोनो।';

  @override
  String get consentPrivacyTitle => 'गुप्त फोरमायनाय (DPDP आइन 2023)';

  @override
  String get consentPrivacyBody =>
      'जों मा सुबुथुमो: सिनायथि, आय, बैंक आरो सम्पत्तिनि बिबुंथि। मानो: नोंथांनि लोननि सिद्धान्त आरो फरायनायनि थाखाय। माब्लानि गाक्रा: आइनआ बुङाबादि। नोंथांनि मोनथायफोर: डेटा नायनो, सुजुनो एबा खोमोर नो, आरो जोंनि नालिस हाकिम एबा डेटा रैखाथि बर्डआव नालिस होनो।';

  @override
  String get consentRequired => 'नांगौ';

  @override
  String get consentNeeded => 'सिगाङाव थांनो गासैयाव गनायथि हो।';

  @override
  String get agreeAndContinue => 'गनायथि होनानै सिगाङाव थां';

  @override
  String get detailsTitle => 'नोंथांनि बिबुंथि';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'थार PAN हाबहो, जेरै ABCDE1234F।';

  @override
  String get fetchDetails => 'आंनि बिबुंथि लाबो';

  @override
  String get fetchedFrom =>
      'PAN, आधार eKYC आरो बैंक स्टेटमेन्टनिफ्राय हाबहोबाय। सुजुनो अंकआव टेप खालाम।';

  @override
  String get nameLabel => 'मुं';

  @override
  String get dobLabel => 'जोनोम अक्ट\'';

  @override
  String get employmentLabel => 'हाबा';

  @override
  String get salaried => 'चाकरि खालामग्रा';

  @override
  String get selfEmployed => 'गावनि हाबा';

  @override
  String get incomeLabel => 'दाननि नेट आय';

  @override
  String get existingEmiLabel => 'दानि दाननि EMI';

  @override
  String get propertyValueLabel => 'सम्पत्तिनि बेसेन';

  @override
  String get loanAmountLabel => 'लोननि रां';

  @override
  String get tenureLabel => 'सम';

  @override
  String yearsLabel(String n) {
    return '$n बोसोर';
  }

  @override
  String get eligibleTitle => 'नोंथांआ बांसिनै मोननो हायो';

  @override
  String emiPerMonth(String amount) {
    return 'दाननि EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'बोसोरै $rate%, सोलायग्रा (बिदिन्थि)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'आयनि सीमा: नोंथांनि गासै EMI आयनि $pct सिम जानो हायो।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'सम्पत्तिनि सीमा: बे लोनआ बेसेननि $pct सिम जानो हायो।';
  }

  @override
  String get limitedByAsked => 'बेयो नोंथांनि नागिरनाय रां।';

  @override
  String get eligibilityNote =>
      'नोंथांनि बिबुंथिनि गोख्रों नायनाय। जोंनि नायनाय उनाव अफार फैगोन।';

  @override
  String get selfieTitle => 'सेल्फि ला';

  @override
  String get selfieBody =>
      'जों नोंथांनि मुखांखौ आधारनि फटोजों गाहाय नायो आरो बेयो थारैनो नोंथांनो, फटोनि फटो नङा होनना नायो।';

  @override
  String get selfieTips =>
      'मोजां सोरां, केमेरानि फार्से नाय, टुपि एबा चसमा नङा।';

  @override
  String get takeSelfie => 'सेल्फि ला';

  @override
  String get retake => 'फिन ला';

  @override
  String get checkFace => 'मुखां मोनबाय';

  @override
  String get checkLive => 'थांनाय सुबुं';

  @override
  String get checkMatch => 'आधारनि फटोजों गाहाय जायो';

  @override
  String get selfieFailed =>
      'नोंथांनि मुखांखौ थार खालामनो हाया। मोजां सोरांआव फिन नाजाबदो, एबा भिडिअ\' KYC कल बुक खालाम।';

  @override
  String get videoKyc => 'भिडिअ\' KYC कल बुक खालाम';

  @override
  String get docsTitle => 'नोंथांनि कागजफोर';

  @override
  String get docsBody =>
      'फोरोबाय कागजनि गोसार फटो ला, एबा गेलेरिनिफ्राय सायख\'।';

  @override
  String get docPan => 'PAN कार्ड';

  @override
  String get docAadhaar => 'आधार कार्ड (दोनथुमनाय)';

  @override
  String get docSalarySlip => 'गोदान दरमाहा स्लिप';

  @override
  String get docForm16 => 'फर्म 16';

  @override
  String get docItr => 'आयकर रिटार्न (ITR)';

  @override
  String get docGst => 'GST सार्टिफिकेट';

  @override
  String get docBankStatement => 'बैंक स्टेटमेन्ट';

  @override
  String get bankViaAa => 'नोंथांनि एकाउन्ट एग्रिगेटरनि गेजेरजों लाबोबाय';

  @override
  String get camera => 'केमेरा';

  @override
  String get gallery => 'गेलेरि';

  @override
  String get checking => 'नायस\'गासिनो दं…';

  @override
  String get tooBlurry => 'जोबोद गोसार नङा। फोनखौ थिरै होनानै फिन नाजाबदो।';

  @override
  String get tooMuchGlare => 'जोबोद जोंख्लाय। सोरांनिफ्राय गोजानै फिन नाजाबदो।';

  @override
  String get tooDark => 'जोबोद आन्धार। बांसिन सोरांआव फिन नाजाबदो।';

  @override
  String docAccepted(String type) {
    return 'सिनायबाय: $type';
  }

  @override
  String docWrong(String expected) {
    return 'बेयो $expected बादि नुनाया। नायस\'नानै थार कागज आपल\'ड खालाम।';
  }

  @override
  String get docUnreadable =>
      'बे कागजखौ फरायनो हाया। बांसिन गोसार फटो ला, एबा गुबै PDF आपल\'ड खालाम।';

  @override
  String docsMissing(String n) {
    return 'दासिम $n नांगौ';
  }

  @override
  String get getOffer => 'आंनि नीतिगत अफारखौ दिन्थि';

  @override
  String get approvedInPrinciple => 'नीतियाव गनायथि होबाय';

  @override
  String get sanctioned => 'लोन गनायबाय';

  @override
  String get referredTitle => 'जोंनो खायसे बांसिन सम नांगौ';

  @override
  String get rejectedTitle => 'दानो बे लोनखौ होनो हाया';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years बोसोर · बोसोरै $rate% सोलायग्रा';
  }

  @override
  String get whyOffer => 'नोंथांआ बे अफारखौ मानो मोनदों';

  @override
  String get whyReferred => 'उनाव मा जागोन';

  @override
  String get whyRejected => 'जों बे सिद्धान्तखौ मानो लाखो';

  @override
  String get referBody =>
      'मोनसे हाकिमआ मोनसे हाबानि सानि गेजेराव नोंथांनि आबेदनखौ नायगोन। दानो नोंथांआ माबो खालामनो नाङा।';

  @override
  String get rejectBody =>
      'नोंथांआ जायखिजाया समाव मोनसे सुबुंनो बे सिद्धान्तखौ फिन नायनो बुङो हायो।';

  @override
  String get addProperty => 'सम्पत्तिनि बिबुंथि दाजाब';

  @override
  String get viewKfs => 'गुबै थार बिबुंथि नाय';

  @override
  String get grievance => 'फिन नायनो नागिर एबा नालिस हो';

  @override
  String officerLine(String name, String email) {
    return 'नालिस हाकिम: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'आबेदन $id';
  }

  @override
  String get startOver => 'गोदान आबेदन जागायहो';

  @override
  String okScore(String score) {
    return 'रां फिन होनायनि मोजां जारिमिन (स्कोर $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMIआ आयनि $pct; जोंनि सीमा $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'लोनआ सम्पत्तिनि बेसेननि $pct; सीमा $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'सम्पत्तिनि जोंनि बेसेन बिजिरनाय: $low निफ्राय $high सिम';
  }

  @override
  String get okTitle => 'सम्पत्तिनि मालिकानि आरो कागजफोर नायस\'बाय';

  @override
  String get reasonKyc01 =>
      'फटोनिफ्राय नोंथांनि सिनायथि थार खालामनो हाया। अननानै मोनसे गुसुं भिडिअ\' KYC कल जाफुहो।';

  @override
  String get reasonFrd02 =>
      'दरमाहा स्लिपनि आयआ बैंकाव जमा जानाय रांजों गाहाय जाया। गोदान फर्म 16 हो, एबा गनायथि होनानै जोंनो लाबोनो हो।';

  @override
  String get reasonFrd03 =>
      'नोंथांनि मोनसे कागजआ होग्रा अथरिटिनि थार खालामनायाव फेल जाबाय।';

  @override
  String get reasonPol01 => 'आबेदनगिरिनि बैसो खमाबो 21 बोसोर जानांगोन।';

  @override
  String get reasonPol02 =>
      'लोनआ जोंनि गनायनाय बांसिन बैसोखौ गोजानगोन। गुसुं बैसोनि लोगो आबेदनगिरि दाजाबब्ला मदद मोननो हायो।';

  @override
  String get reasonBur01 =>
      'नोंथांनि क्रेडिट स्कोरआ जोंनि खमाबो 650 निख्राय खमा।';

  @override
  String get reasonBur04 =>
      'नोंथांनि दासिम क्रेडिट जारिमिन गैया, बिनि थाखाय मोनसे हाकिमआ नोंथांनि बैंक रेकर्ड नायगोन।';

  @override
  String get reasonBur05 =>
      'नोंथांनि क्रेडिट स्कोरखौ मोनसे हाकिमआ मोजां महरै नायनांगोन।';

  @override
  String get reasonPrp01 => 'जोंनि उकिलआ सम्पत्तिनि मालिकानिखौ नायनांगोन।';

  @override
  String get reasonPrp03 =>
      'बेसेन थार खालामनो जोंनि बेसेन बिजिरग्राआ सम्पत्तिखौ नायनो थांनांगोन।';

  @override
  String get reasonPrp04 =>
      'गनायथि बेसेनआ बे सम्पत्तिनि सरकारि सार्कल रेटनिख्राय खमा। अननानै फान्नाय गनायथिखौ नायस\'।';

  @override
  String get reasonAff01 =>
      'नोंथांनि दानि EMIआ आगोलनिफ्रायनो आयनि बांसिन बाहागो लादों।';

  @override
  String get reasonAut01 =>
      'बे बायदि गेदेर लोननि जोबथा नायस\'नायखौ मोनसे गेदेर हाकिमआ खालामो।';

  @override
  String get reasonRsk01 =>
      'अफारखौ थाखो खालामनो मोनसे हाकिमआ नोंथांनि आबेदन नायगोन।';

  @override
  String get reasonRsk02 =>
      'नोंथांनि क्रेडिट प्रोफाइलनि सायाव दानो बे लोनखौ होनो हाया।';

  @override
  String get propertyTitle => 'नोंथांनि सम्पत्ति';

  @override
  String get cityLabel => 'नगर';

  @override
  String get localityLabel => 'थावनि';

  @override
  String get societyLabel => 'प्रोजेक्ट एबा सोसाइटि (दंब्ला)';

  @override
  String get areaLabel => 'गोलाव (बर्ग फुट)';

  @override
  String get bhkLabel => 'उन्दुनाय खथा';

  @override
  String get newProperty => 'गोदान';

  @override
  String get resale => 'फिन फान्नाय';

  @override
  String get declaredPriceLabel => 'गनायथि बेसेन';

  @override
  String get photosTitle => 'सम्पत्तिनि फटोफोर';

  @override
  String get photosBody =>
      'सम्पत्तिआव थांनानै फटो ला। जों जायगा आरो सम दाजाबो, जेरै बेसेन बिजिरग्राआ थांनायनि आनजाद खालामनो हायो।';

  @override
  String get photoFront => 'सिगाङ';

  @override
  String get photoInside => 'गेजेर';

  @override
  String get photoView => 'सम्पत्तिनिफ्राय नुथाय';

  @override
  String geoTagged(String lat, String lng) {
    return 'जायगा दाजाबबाय ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'जायगा गैयाबालानो फटो दोनबाय। जिअ\'-टेगनि थाखाय लोकेसन अन खालाम।';

  @override
  String get submitProperty => 'जोबथा गनायथि मोन';

  @override
  String get fillAll => 'अननानै गासै जायगायाव हाबहो।';

  @override
  String get kfsTitle => 'गुबै थार बिबुंथि';

  @override
  String get kfsLoan => 'लोननि रां';

  @override
  String get kfsTenure => 'सम';

  @override
  String get kfsRate => 'सुदनि रेट';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMIनि अनजिमा';

  @override
  String get kfsFee => 'प्रसेसिं फि (GST लोगो)';

  @override
  String get kfsTotalInterest => 'गासै सुद';

  @override
  String get kfsTotalPayable => 'गासै होनांगौ रां';

  @override
  String get kfsApr => 'बोसोरारि खौनाय रेट (APR)';

  @override
  String get kfsCoolingOff =>
      'कुलिं-अफ सम: सही खालामनाय उनाव 3 सानि गेजेराव गुबै रां आरो बे सानिफोरनि सुदल\' फिन होनानै जरिमाना गैयाबालानो ओंखारनो हायो।';

  @override
  String get kfsNote =>
      'डेमोनि थाखाय बिदिन्थि अंकफोर। नोंथांनि थार KFS आ गनायथि बिलाइजों फैगोन।';

  @override
  String get useSample => 'बिदिन्थि';

  @override
  String get videoKycDemo =>
      'डेमो: बेनि गेजेरजों मोनसे हाकिमजों भिडिअ\' KYC कल बुक जागोमोन।';

  @override
  String get raiseComplaint => 'नालिस हो';

  @override
  String complaintSent(String ref) {
    return 'नोंथांनि नालिस थाखो जाबाय। रेफारेन्स $ref।';
  }

  @override
  String get stageSignIn => 'साइन इन';

  @override
  String get stageDetails => 'बिबुंथि';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'अफार';

  @override
  String get stageProperty => 'सम्पत्ति';

  @override
  String get homeSubtitle => 'न\'नि लोन · सम्पत्तिनि सायाव लोन';

  @override
  String get heroPill => 'मिनिटाव सिद्धान्त';

  @override
  String heroFacts(String rate, String years) {
    return 'बोसोरै $rate% निफ्राय · $years बोसोर सिम';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% जाफुबाय · जेराव नागारदोंमोन बेनिफ्राय जागाय';
  }

  @override
  String get resume => 'सिगाङाव थां';

  @override
  String get calculators => 'केलकुलेटर';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'दाननि किस्ति';

  @override
  String get calcEligibility => 'जोग्यता';

  @override
  String get calcEligibilitySub => 'नोंथांआ बेसेबां मोननो हायो';

  @override
  String get emiCalcTitle => 'EMI केलकुलेटर';

  @override
  String get eligibilityCalcTitle => 'जोग्यता केलकुलेटर';

  @override
  String totalInterest(String amount) {
    return 'गासै सुद $amount';
  }

  @override
  String get calcIncomeOnly =>
      'आयनि सायावल\'। सम्पत्तिनि बेसेनआ बेखौ खमायनो हायो।';

  @override
  String get verified => 'थार खालामबाय';

  @override
  String get yourLoan => 'नोंथांनि लोन';

  @override
  String docsProgress(String done, String total) {
    return '$total नि गेजेराव $done थार खालामबाय';
  }

  @override
  String get docNeeded => 'नांगौ';

  @override
  String get docTryAgain => 'फिन नाजाब';

  @override
  String get fetched => 'लाबोबाय';

  @override
  String get statusApproved => 'गनायथि होबाय';

  @override
  String get statusSanctioned => 'गनायबाय';

  @override
  String get statusInReview => 'नायनायाव';

  @override
  String get statusDeclined => 'नेवसिबाय';

  @override
  String get trackTitle => 'नोंथांनि आबेदनखौ ट्रेक खालाम';

  @override
  String get tlSubmitted => 'आबेदन होबाय';

  @override
  String get tlVerified => 'KYC आरो कागजफोर थार खालामबाय';

  @override
  String get tlInPrinciple => 'नीतिगत गनायथि';

  @override
  String get tlProperty => 'सम्पत्तिनि बिबुंथि आरो बेसेन';

  @override
  String get tlPropertyNext => 'नोंथांनि सम्पत्तिनि बिबुंथि आरो फटो दाजाब';

  @override
  String get tlOfficer => 'हाकिमनि नायनाय';

  @override
  String get tlOfficerNext => 'मोनसे हाबानि सानि गेजेराव';

  @override
  String get tlLegal => 'आइनारि आरो मालिकानि नायस\'नाय';

  @override
  String get tlSanction => 'जोबथा गनायथि आरो इ-सही';

  @override
  String get tlSanctionNext => 'गनायथि बिलाइआव अनलाइनाव सही खालाम';

  @override
  String get tlDisbursement => 'रां होनाय';

  @override
  String get helpTitle => 'मदद नांगौ?';

  @override
  String get propertyType => 'गोदान एबा फिन फान्नाय';

  @override
  String get greetMorning => 'मोजां फुं';

  @override
  String get greetAfternoon => 'मोजां सान';

  @override
  String get greetEvening => 'मोजां बेलासि';

  @override
  String nearlyThere(String name) {
    return '$name, नोंथांआ खायसेनो सोग्लांबाय';
  }

  @override
  String get chooseLanguage => 'नोंथांनि रावखौ सायख\'';

  @override
  String get languageNote => 'नोंथांआ बेखौ जायखिजाया समाव सोलायनो हायो।';

  @override
  String get liveChecks => 'लाइभ नायस\'नाय';

  @override
  String get checkBureau => 'क्रेडिट ब्युरो';

  @override
  String checkScore(String score) {
    return 'स्कोर $score';
  }

  @override
  String get checkNoHistory => 'दासिम जारिमिन गैया';

  @override
  String get checkBank => 'AA नि गेजेरजों बैंक';

  @override
  String get checkBankRead => '12 दान फरायबाय';

  @override
  String get checkKyc => 'eKYC आरो सेल्फि';

  @override
  String get checkPending => 'थानो दं';

  @override
  String get checkDocs => 'कागजफोर';

  @override
  String countOf(String done, String total) {
    return '$total नि गेजेराव $done';
  }

  @override
  String minutesLeft(String n) {
    return 'जोबोद $n मिनिट थानो दं';
  }

  @override
  String ratePa(String rate) {
    return 'बोसोरै $rate%';
  }

  @override
  String get continueApplication => 'नोंथांनि आबेदनखौ सिगाङाव लां';

  @override
  String get shapeOffer => 'नोंथांनि अफारखौ बानाय';

  @override
  String get shapeOfferSub => 'नीतियाव गनायथि होबाय · सोलायनो बोनो';

  @override
  String get withinLimits => 'नोंथांनि सीमानि गेजेराव';

  @override
  String get aboveLimits => 'सीमा गोजानबाय: रां खमाय एबा बोसोर बांहो';

  @override
  String mostYouCan(String amount) {
    return 'बांसिनै लानो हायो: $amount';
  }

  @override
  String get useMax => 'बांसिनै ला';

  @override
  String get principal => 'गुबै रां';

  @override
  String get interest => 'सुद';

  @override
  String get totalRepaid => 'गासै फिन होनाय';

  @override
  String get emiShareIncome => 'आयाव EMI नि बाहागो';

  @override
  String loanShareProperty(String value) {
    return '$value नि सम्पत्तियाव लोननि बाहागो';
  }

  @override
  String get lockOffer => 'बे अफारखौ थाखो खालाम';

  @override
  String get offerLocked => 'नोंथांनि अफारआ थाखो जाबाय।';

  @override
  String approvedUpTo(String amount) {
    return '$amount सिम गनायथि होबाय';
  }

  @override
  String readingDoc(String doc) {
    return 'नोंथांनि $doc खौ फरायगासिनो दं';
  }

  @override
  String get documentAi => 'कागज AI';

  @override
  String sure(String pct) {
    return '$pct% थार';
  }

  @override
  String get readMatches => 'बेयो जोंनि नागिरनाय कागजनो';

  @override
  String get readClear => 'गोसार फटो, गोसार नङा एबा जोंख्लाय गैया';

  @override
  String get whatWeRead => 'जों मा फरायखो';

  @override
  String get looksRight => 'थार';

  @override
  String get fieldName => 'मुं';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'आधार';

  @override
  String get fieldEmployer => 'हाबा होग्रा';

  @override
  String get fieldNetPay => 'नेट दरमाहा';

  @override
  String get fieldPeriod => 'दरमाहानि सम';

  @override
  String get fieldYear => 'बोसोर';

  @override
  String get fieldIncome => 'आय';

  @override
  String get fieldBusiness => 'बेपार';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'नोंथांनि लोननि थाखाय नांगौ';

  @override
  String get consentSectionOptional =>
      'सायखनाय हायि: नोंथांआ अन खालामा सिम बन्द';

  @override
  String get advancedOptions => 'सायखनाय';

  @override
  String consentValidUntil(String given, String until) {
    return '$given आव होबाय · $until सिम थार';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given आव होबाय · फिन लाफिनाया सिम';
  }

  @override
  String get recheckTitle => 'रां होनायनि सिगां आरो मोनसे नायस\'नाय';

  @override
  String get recheckBody =>
      'रां होनायनि सिगां जों नोंथांनि क्रेडिट रिपोर्टखौ फिन नायो। नङा बुङोब्ला बे समाव मोनसे हाकिमआ सोंनो हायो।';

  @override
  String get aaMonthsLabel => 'बेसेबां दाननि स्टेटमेन्ट होनांगौ';

  @override
  String monthsN(String n) {
    return '$n दान';
  }

  @override
  String get aaAccountsLabel => 'होनांगौ एकाउन्टफोर';

  @override
  String get accountSavingsSalary => 'सञ्चय ·· 0912 · दरमाहा जमा';

  @override
  String get accountSavings => 'सञ्चय ·· 4821';

  @override
  String get accountFd => 'फिक्सड डिपजिट ·· 3307';

  @override
  String get aaAccountNeeded => 'खमाबो मोनसे एकाउन्ट सायख\'।';

  @override
  String get kycMethodLabel => 'सिनायथिखौ माबोरै थार खालामगोन';

  @override
  String get kycAadhaarOtp => 'आधार OTP';

  @override
  String get kycDigilocker => 'डिजिलकार';

  @override
  String get kycVideo => 'भिडिअ\' KYC कल';

  @override
  String get useCkycTitle => 'आंनि दानि CKYC रेकर्डखौ बाहाय';

  @override
  String get useCkycBody =>
      'गुबुन बैंक एबा फान्डआव KYC खालामनायमोनब्ला, फिन सोंनाय नङा जों बे रेकर्डखौ लाबो।';

  @override
  String get optOffersTitle => 'अफार आरो गोदान मुवाफोर';

  @override
  String get optOffersBody =>
      'अफारनि सोमोन्दै माबोरै मिथिनो सानो सायख\'। बेफोरखौ जायखिजाया समाव बन्द खालामनो हायो।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'इमेल';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp आव लोननि आपडेट';

  @override
  String get optUpdatesBody =>
      'SMS नि लोगोसे WhatsApp आव थासारि आपडेट आरो EMI गोसोखांहोनाय।';

  @override
  String get optInsuranceTitle => 'न\'नि लोन रैखाथिनि कोटेसन';

  @override
  String get optInsuranceBody =>
      'कोटेसननि थाखाय नोंथांनि मुं, बैसो आरो लोननि रांखौ जोंनि बीमा लोगोआव हो। बायनो जेब्लाबो नांगौ नङा।';

  @override
  String get getQuote => 'कोटेसन ला';

  @override
  String get manageConsents => 'गनायथिफोरखौ फरा';

  @override
  String get manageConsentsBody =>
      'सायखनाय हायि गनायथिफोरखौ जायखिजाया समाव बन्द खालाम। नांगौ गनायथिखौ फिन लाफिनब्ला आबेदनआ थादों, आरो बिनि थाखाय लाबोनाय डेटाखौ जों खोमोरो।';

  @override
  String get withdraw => 'फिन ला';

  @override
  String get consentHistory => 'गनायथिनि जारिमिन';

  @override
  String historyGiven(String item) {
    return '$item होबाय';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item फिन लाबाय';
  }

  @override
  String get historyEmpty => 'दासिम माबो गैया।';

  @override
  String get consentOn => 'अन';

  @override
  String get consentOff => 'बन्द';

  @override
  String get withdrawnRequired =>
      'नोंथांआ मोनसे नांगौ गनायथिखौ फिन लाबाय, बिनि थाखाय आबेदनआ थादों।';

  @override
  String get checkMatchPending =>
      'फट\' मिलाय: आधार एबा पेन कार्ड अपल\'ड खालामब्ला जागोन';
}
