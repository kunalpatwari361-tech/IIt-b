// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sanskrit (`sa`).
class AppLocalizationsSa extends AppLocalizations {
  AppLocalizationsSa([String locale = 'sa']) : super(locale);

  @override
  String get appTitle => 'निर्णयः';

  @override
  String get sandboxBanner =>
      'प्रदर्शन-विधिः: नमूना-दत्तांशः, वास्तविकं परीक्षणं न';

  @override
  String get continueLabel => 'अग्रे गच्छतु';

  @override
  String stepOf(String step, String total) {
    return 'सोपानम् $step / $total';
  }

  @override
  String get pleaseWait => 'कृपया प्रतीक्षताम्…';

  @override
  String get errorGeneric => 'किञ्चित् दोषः जातः। पुनः प्रयततु।';

  @override
  String get close => 'पिदधातु';

  @override
  String get welcomeHeadline => 'कतिपयेषु निमेषेषु भवतः गृहऋणस्य निर्णयः';

  @override
  String get welcomeBody =>
      'गृहऋणाय अथवा सम्पत्ति-आधारित-ऋणाय आवेदनं करोतु। वयं सर्वं जालद्वारा परीक्षामहे, निर्णयस्य कारणं च सर्वदा वदामः।';

  @override
  String get chooseProduct => 'भवतः किम् आवश्यकम्?';

  @override
  String get productHomeLoan => 'गृहऋणम्';

  @override
  String get productHomeLoanSub => 'गृहस्य क्रयः, निर्माणं वा सुधारः';

  @override
  String get productLap => 'सम्पत्ति-आधारितम् ऋणम्';

  @override
  String get productLapSub => 'स्वसम्पत्तेः आधारेण ऋणं गृह्णातु';

  @override
  String get startApplication => 'आवेदनम् आरभताम्';

  @override
  String get demoCustomers => 'प्रदर्शन-ग्राहकाः';

  @override
  String get demoCustomersBody =>
      'नमूना-दूरवाणी-सङ्ख्यां पूरयितुम् एकं स्पृशतु।';

  @override
  String get personaRavi => 'रविः, 32, वेतनभोगी, आवासं क्रीणाति';

  @override
  String get personaMeena => 'मीना, 45, वस्त्र-आपणं चालयति (LAP)';

  @override
  String get personaArjun => 'अर्जुनः, 29, वेतनभोगी, परिवर्तितं वेतन-पत्रम्';

  @override
  String get signInTitle => 'प्रवेशः';

  @override
  String get mobileLabel => 'दूरवाणी-सङ्ख्या';

  @override
  String get mobileHint => '10 अङ्कानां दूरवाणी-सङ्ख्या';

  @override
  String get invalidMobile => 'शुद्धां 10 अङ्कानां दूरवाणी-सङ्ख्यां लिखतु।';

  @override
  String get sendOtp => 'OTP प्रेषयतु';

  @override
  String otpSentTo(String phone) {
    return 'वयं $phone इत्यत्र 6 अङ्कानां सङ्केतं प्रेषितवन्तः।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'सत्यापयतु';

  @override
  String get demoOtp => 'प्रदर्शन-सङ्केतः: 123456';

  @override
  String get wrongOtp => 'सङ्केतः अशुद्धः। पुनः प्रयततु।';

  @override
  String get deviceBound =>
      'इदं दूरवाणी-यन्त्रम् इदानीं भवतः खातेन सह युक्तम्। अन्यस्मिन् यन्त्रे प्रवेशाय नूतनः OTP आवश्यकः।';

  @override
  String get consentTitle => 'भवतः सम्मतिः';

  @override
  String get consentIntro =>
      'वयं भवतः दत्तांशम् अस्य ऋणस्य निर्णयाय व्यवस्थायै च एव उपयुञ्ज्महे। भवान् कदापि सम्मतिं प्रत्याहर्तुं शक्नोति।';

  @override
  String get consentBureauTitle => 'ऋण-प्रतिवेदनम्';

  @override
  String get consentBureauBody =>
      'ऋण-कार्यालयात् (CIBIL, Experian, Equifax अथवा CRIF) भवतः ऋण-इतिहासः परीक्ष्यते। अनेन भवतः अङ्कः न न्यूनीभवति।';

  @override
  String get consentAaTitle => 'खाता-सङ्ग्राहक-द्वारा वित्तकोश-विवरणम्';

  @override
  String get consentAaBody =>
      'RBI-अनुज्ञापित-खाता-सङ्ग्राहक-द्वारा भवतः वित्तकोशात् 12 मासानां विवरणम् आनीयते। अनुरोधं भवान् स्वस्य AA अनुप्रयोगे अनुमोदयति।';

  @override
  String get consentKycTitle => 'आधार eKYC तथा PAN';

  @override
  String get consentKycBody =>
      'UIDAI तथा आयकर-विभागेन सह भवतः परिचयः सत्याप्यते। वयं केवलं गुप्तम् आधार-सङ्ख्यां रक्षामः।';

  @override
  String get consentPrivacyTitle => 'गोपनीयता-सूचना (DPDP अधिनियमः 2023)';

  @override
  String get consentPrivacyBody =>
      'वयं किं सङ्गृह्णीमः: परिचयः, आयः, वित्तकोशः सम्पत्तिः च। किमर्थम्: भवतः ऋणस्य निर्णयाय व्यवस्थायै च। कियत्कालम्: यावत् विधिः वदति तावत् एव। भवतः अधिकाराः: दत्तांशस्य दर्शनं, संशोधनं, निष्कासनं च, अस्माकं शिकायत-अधिकारिणः दत्तांश-संरक्षण-मण्डलस्य वा समीपे परिवादः च।';

  @override
  String get consentRequired => 'अनिवार्यम्';

  @override
  String get consentNeeded => 'अग्रे गन्तुं सर्वेषु सम्मतिं ददातु।';

  @override
  String get agreeAndContinue => 'सम्मतिं दत्त्वा अग्रे गच्छतु';

  @override
  String get detailsTitle => 'भवतः विवरणम्';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'शुद्धं PAN लिखतु, यथा ABCDE1234F।';

  @override
  String get fetchDetails => 'मम विवरणम् आनयतु';

  @override
  String get fetchedFrom =>
      'PAN, आधार eKYC, वित्तकोश-विवरणेभ्यः च पूरितम्। संशोधनाय अङ्कं स्पृशतु।';

  @override
  String get nameLabel => 'नाम';

  @override
  String get dobLabel => 'जन्मतिथिः';

  @override
  String get employmentLabel => 'कार्यम्';

  @override
  String get salaried => 'वेतनभोगी';

  @override
  String get selfEmployed => 'स्वरोजगारी';

  @override
  String get incomeLabel => 'मासिकः शुद्धः आयः';

  @override
  String get existingEmiLabel => 'वर्तमाना मासिकी EMI';

  @override
  String get propertyValueLabel => 'सम्पत्तेः मूल्यम्';

  @override
  String get loanAmountLabel => 'ऋण-राशिः';

  @override
  String get tenureLabel => 'अवधिः';

  @override
  String yearsLabel(String n) {
    return '$n वर्षाणि';
  }

  @override
  String get eligibleTitle => 'भवान् अधिकतमं प्राप्तुं शक्नोति';

  @override
  String emiPerMonth(String amount) {
    return 'मासिकी EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'वार्षिकं $rate%, परिवर्तनशीलम् (उदाहरणम्)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'आयस्य सीमा: भवतः सर्वाः EMI मिलित्वा आयस्य $pct पर्यन्तं भवितुम् अर्हन्ति।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'सम्पत्तेः सीमा: एतावत् ऋणं मूल्यस्य $pct पर्यन्तं भवितुम् अर्हति।';
  }

  @override
  String get limitedByAsked => 'एषा भवता याचिता राशिः।';

  @override
  String get eligibilityNote =>
      'भवतः विवरणस्य शीघ्रं परीक्षणम्। अस्माकं परीक्षणानन्तरं प्रस्तावः आगमिष्यति।';

  @override
  String get selfieTitle => 'स्वचित्रं गृह्णातु';

  @override
  String get selfieBody =>
      'वयं भवतः मुखम् आधार-चित्रेण सह मेलयामः, एतत् वस्तुतः भवान् एव, न तु चित्रस्य चित्रम् इति च परीक्षामहे।';

  @override
  String get selfieTips =>
      'उत्तमः प्रकाशः, छायाग्राहकं पश्यतु, शिरस्त्राणम् उपनेत्रं वा न।';

  @override
  String get takeSelfie => 'स्वचित्रं गृह्णातु';

  @override
  String get retake => 'पुनः गृह्णातु';

  @override
  String get checkFace => 'मुखं प्राप्तम्';

  @override
  String get checkLive => 'जीवितः जनः';

  @override
  String get checkMatch => 'आधार-चित्रेण सह मेलति';

  @override
  String get selfieFailed =>
      'भवतः मुखस्य पुष्टिः न अभवत्। उत्तमे प्रकाशे पुनः प्रयततु, अथवा दृश्य-KYC आह्वानं निश्चिनोतु।';

  @override
  String get videoKyc => 'दृश्य-KYC आह्वानं निश्चिनोतु';

  @override
  String get docsTitle => 'भवतः प्रलेखाः';

  @override
  String get docsBody =>
      'प्रत्येकस्य प्रलेखस्य स्पष्टं चित्रं गृह्णातु, अथवा चित्रशालायाः चिनोतु।';

  @override
  String get docPan => 'PAN पत्रम्';

  @override
  String get docAadhaar => 'आधार पत्रम् (गुप्तम्)';

  @override
  String get docSalarySlip => 'नूतनं वेतन-पत्रम्';

  @override
  String get docForm16 => 'प्रपत्रम् 16';

  @override
  String get docItr => 'आयकर-विवरणी (ITR)';

  @override
  String get docGst => 'GST प्रमाणपत्रम्';

  @override
  String get docBankStatement => 'वित्तकोश-विवरणम्';

  @override
  String get bankViaAa => 'भवतः खाता-सङ्ग्राहक-द्वारा आनीतम्';

  @override
  String get camera => 'छायाग्राहकः';

  @override
  String get gallery => 'चित्रशाला';

  @override
  String get checking => 'परीक्ष्यते…';

  @override
  String get tooBlurry => 'अतीव अस्पष्टम्। यन्त्रं स्थिरं धृत्वा पुनः प्रयततु।';

  @override
  String get tooMuchGlare => 'अतीव दीप्तिः। प्रकाशात् दूरं गत्वा पुनः प्रयततु।';

  @override
  String get tooDark => 'अतीव अन्धकारः। अधिके प्रकाशे पुनः प्रयततु।';

  @override
  String docAccepted(String type) {
    return 'अभिज्ञातम्: $type';
  }

  @override
  String docWrong(String expected) {
    return 'इदं $expected इव न दृश्यते। परीक्ष्य शुद्धं प्रलेखम् आरोपयतु।';
  }

  @override
  String get docUnreadable =>
      'अयं प्रलेखः पठितुं न शक्यः। स्पष्टतरं चित्रं गृह्णातु, अथवा मूलं PDF आरोपयतु।';

  @override
  String docsMissing(String n) {
    return 'अद्यापि $n आवश्यकाः';
  }

  @override
  String get getOffer => 'मम सैद्धान्तिकं प्रस्तावं दर्शयतु';

  @override
  String get approvedInPrinciple => 'सिद्धान्ततः अनुमोदितम्';

  @override
  String get sanctioned => 'ऋणं स्वीकृतम्';

  @override
  String get referredTitle => 'अस्माकं किञ्चित् अधिकः समयः आवश्यकः';

  @override
  String get rejectedTitle => 'इदानीम् इदम् ऋणं दातुं न शक्नुमः';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years वर्षाणि · वार्षिकं $rate% परिवर्तनशीलम्';
  }

  @override
  String get whyOffer => 'अयं प्रस्तावः किमर्थं प्राप्तः';

  @override
  String get whyReferred => 'अनन्तरं किं भविष्यति';

  @override
  String get whyRejected => 'वयम् इमं निर्णयं किमर्थं कृतवन्तः';

  @override
  String get referBody =>
      'एकः अधिकारी एकस्मिन् कार्यदिवसे भवतः आवेदनं द्रक्ष्यति। इदानीं भवता किमपि कर्तव्यं नास्ति।';

  @override
  String get rejectBody =>
      'भवान् कदापि कञ्चित् जनम् अस्य निर्णयस्य पुनरवलोकनाय वक्तुं शक्नोति।';

  @override
  String get addProperty => 'सम्पत्ति-विवरणं योजयतु';

  @override
  String get viewKfs => 'मुख्य-तथ्य-विवरणं पश्यतु';

  @override
  String get grievance => 'पुनरवलोकनं याचताम् अथवा परिवादं करोतु';

  @override
  String officerLine(String name, String email) {
    return 'शिकायत-अधिकारी: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'आवेदनम् $id';
  }

  @override
  String get startOver => 'नूतनम् आवेदनम् आरभताम्';

  @override
  String okScore(String score) {
    return 'दृढः प्रतिदान-इतिहासः (अङ्कः $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI आयस्य $pct; अस्माकं सीमा $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'ऋणं सम्पत्ति-मूल्यस्य $pct; सीमा $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'सम्पत्तेः अस्माकं मूल्याङ्कनम्: $low तः $high पर्यन्तम्';
  }

  @override
  String get okTitle => 'सम्पत्तेः स्वामित्वं पत्राणि च परीक्षितानि';

  @override
  String get reasonKyc01 =>
      'चित्रात् भवतः परिचयस्य पुष्टिः न अभवत्। कृपया लघु दृश्य-KYC आह्वानं पूरयतु।';

  @override
  String get reasonFrd02 =>
      'वेतन-पत्रस्य आयः वित्तकोशे जमाराशिभिः सह न मेलति। नूतनं प्रपत्रम् 16 ददातु, अथवा सम्मत्या अस्मान् आनेतुम् अनुमन्यताम्।';

  @override
  String get reasonFrd03 =>
      'भवतः एकः प्रलेखः प्रदातृ-प्राधिकरणस्य सत्यापने विफलः अभवत्।';

  @override
  String get reasonPol01 => 'आवेदकस्य वयः न्यूनातिन्यूनं 21 वर्षाणि भवेत्।';

  @override
  String get reasonPol02 =>
      'ऋणम् अस्माभिः अनुमतम् अधिकतमं वयः अतिक्रमिष्यति। अल्पवयस्कः सह-आवेदकः योजितः चेत् साहाय्यं भवेत्।';

  @override
  String get reasonBur01 =>
      'भवतः ऋण-अङ्कः अस्माकं न्यूनतमात् 650 तः न्यूनः अस्ति।';

  @override
  String get reasonBur04 =>
      'भवतः ऋण-इतिहासः अद्यापि नास्ति, अतः एकः अधिकारी भवतः वित्तकोश-अभिलेखान् द्रक्ष्यति।';

  @override
  String get reasonBur05 => 'भवतः ऋण-अङ्कः अधिकारिणा सावधानतया द्रष्टव्यः।';

  @override
  String get reasonPrp01 =>
      'अस्माकं अधिवक्त्रा सम्पत्तेः स्वामित्वस्य पुनरवलोकनं कर्तव्यम्।';

  @override
  String get reasonPrp03 =>
      'मूल्यस्य पुष्टये अस्माकं मूल्याङ्ककेन सम्पत्तिः द्रष्टव्या।';

  @override
  String get reasonPrp04 =>
      'अनुबन्ध-मूल्यम् अस्याः सम्पत्तेः शासकीय-वृत्त-दरात् न्यूनम् अस्ति। कृपया विक्रय-अनुबन्धं परीक्षताम्।';

  @override
  String get reasonAff01 =>
      'भवतः वर्तमानाः EMI पूर्वमेव आयस्य अधिकतमं भागं गृह्णन्ति।';

  @override
  String get reasonAut01 =>
      'एतादृशस्य बृहतः ऋणस्य अन्तिमं परीक्षणं वरिष्ठः अधिकारी करोति।';

  @override
  String get reasonRsk01 =>
      'प्रस्तावं निश्चेतुम् एकः अधिकारी भवतः आवेदनं द्रक्ष्यति।';

  @override
  String get reasonRsk02 =>
      'भवतः ऋण-परिचयस्य आधारेण इदानीम् इदम् ऋणं दातुं न शक्नुमः।';

  @override
  String get propertyTitle => 'भवतः सम्पत्तिः';

  @override
  String get cityLabel => 'नगरम्';

  @override
  String get localityLabel => 'क्षेत्रम्';

  @override
  String get societyLabel => 'परियोजना सङ्घः वा (यदि अस्ति)';

  @override
  String get areaLabel => 'क्षेत्रफलम् (वर्ग-पादाः)';

  @override
  String get bhkLabel => 'शयन-कक्षाः';

  @override
  String get newProperty => 'नूतनम्';

  @override
  String get resale => 'पुनर्विक्रयः';

  @override
  String get declaredPriceLabel => 'अनुबन्ध-मूल्यम्';

  @override
  String get photosTitle => 'सम्पत्तेः चित्राणि';

  @override
  String get photosBody =>
      'सम्पत्ति-स्थाने एव चित्राणि गृह्णातु। वयं स्थानं समयं च योजयामः, येन मूल्याङ्ककः दर्शनस्य योजनां कर्तुं शक्नुयात्।';

  @override
  String get photoFront => 'अग्रभागः';

  @override
  String get photoInside => 'अन्तः';

  @override
  String get photoView => 'सम्पत्तितः दृश्यम्';

  @override
  String geoTagged(String lat, String lng) {
    return 'स्थानं योजितम् ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'स्थानं विना चित्रं रक्षितम्। भू-चिह्नाय स्थान-सेवां सक्रियां करोतु।';

  @override
  String get submitProperty => 'अन्तिमां स्वीकृतिं प्राप्नोतु';

  @override
  String get fillAll => 'कृपया सर्वाणि क्षेत्राणि पूरयतु।';

  @override
  String get kfsTitle => 'मुख्य-तथ्य-विवरणम्';

  @override
  String get kfsLoan => 'ऋण-राशिः';

  @override
  String get kfsTenure => 'अवधिः';

  @override
  String get kfsRate => 'व्याज-दरः';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI सङ्ख्या';

  @override
  String get kfsFee => 'प्रक्रिया-शुल्कम् (GST सहितम्)';

  @override
  String get kfsTotalInterest => 'सम्पूर्णं व्याजम्';

  @override
  String get kfsTotalPayable => 'सम्पूर्णा देय-राशिः';

  @override
  String get kfsApr => 'वार्षिक-प्रतिशत-दरः (APR)';

  @override
  String get kfsCoolingOff =>
      'शीतलन-कालः: हस्ताक्षरात् 3 दिवसेषु केवलं मूलधनं तेषां दिवसानां व्याजं च प्रत्यर्प्य दण्डं विना निर्गन्तुं शक्नोति।';

  @override
  String get kfsNote =>
      'प्रदर्शनाय नमूना-अङ्काः। भवतः वास्तविकं KFS स्वीकृति-पत्रेण सह आगमिष्यति।';

  @override
  String get useSample => 'नमूना';

  @override
  String get videoKycDemo =>
      'प्रदर्शनम्: अनेन अधिकारिणा सह दृश्य-KYC आह्वानं निश्चितं भवेत्।';

  @override
  String get raiseComplaint => 'परिवादं करोतु';

  @override
  String complaintSent(String ref) {
    return 'भवतः परिवादः पञ्जीकृतः। सन्दर्भः $ref।';
  }

  @override
  String get stageSignIn => 'प्रवेशः';

  @override
  String get stageDetails => 'विवरणम्';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'प्रस्तावः';

  @override
  String get stageProperty => 'सम्पत्तिः';

  @override
  String get homeSubtitle => 'गृहऋणम् · सम्पत्ति-आधारितम् ऋणम्';

  @override
  String get heroPill => 'निमेषेषु निर्णयः';

  @override
  String heroFacts(String rate, String years) {
    return 'वार्षिकं $rate% तः · $years वर्षपर्यन्तम्';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% पूर्णम् · यत्र त्यक्तं तत्रतः आरभताम्';
  }

  @override
  String get resume => 'अनुवर्तताम्';

  @override
  String get calculators => 'गणकाः';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'मासिकः किस्तः';

  @override
  String get calcEligibility => 'योग्यता';

  @override
  String get calcEligibilitySub => 'भवान् कियत् प्राप्तुं शक्नोति';

  @override
  String get emiCalcTitle => 'EMI गणकः';

  @override
  String get eligibilityCalcTitle => 'योग्यता-गणकः';

  @override
  String totalInterest(String amount) {
    return 'सम्पूर्णं व्याजम् $amount';
  }

  @override
  String get calcIncomeOnly =>
      'केवलम् आयस्य आधारेण। सम्पत्तेः मूल्यम् एतत् न्यूनीकर्तुं शक्नोति।';

  @override
  String get verified => 'सत्यापितम्';

  @override
  String get yourLoan => 'भवतः ऋणम्';

  @override
  String docsProgress(String done, String total) {
    return '$total मध्ये $done सत्यापिताः';
  }

  @override
  String get docNeeded => 'आवश्यकम्';

  @override
  String get docTryAgain => 'पुनः प्रयततु';

  @override
  String get fetched => 'आनीतम्';

  @override
  String get statusApproved => 'अनुमोदितम्';

  @override
  String get statusSanctioned => 'स्वीकृतम्';

  @override
  String get statusInReview => 'पुनरवलोकने';

  @override
  String get statusDeclined => 'अस्वीकृतम्';

  @override
  String get trackTitle => 'स्वस्य आवेदनस्य स्थितिं पश्यतु';

  @override
  String get tlSubmitted => 'आवेदनं समर्पितम्';

  @override
  String get tlVerified => 'KYC प्रलेखाः च सत्यापिताः';

  @override
  String get tlInPrinciple => 'सैद्धान्तिकी स्वीकृतिः';

  @override
  String get tlProperty => 'सम्पत्ति-विवरणं मूल्याङ्कनं च';

  @override
  String get tlPropertyNext => 'स्वसम्पत्तेः विवरणं चित्राणि च योजयतु';

  @override
  String get tlOfficer => 'अधिकारिणः पुनरवलोकनम्';

  @override
  String get tlOfficerNext => 'एकस्मिन् कार्यदिवसे';

  @override
  String get tlLegal => 'विधिक-स्वामित्व-परीक्षणम्';

  @override
  String get tlSanction => 'अन्तिमा स्वीकृतिः ई-हस्ताक्षरं च';

  @override
  String get tlSanctionNext => 'स्वीकृति-पत्रे जालद्वारा हस्ताक्षरं करोतु';

  @override
  String get tlDisbursement => 'राशि-प्रदानम्';

  @override
  String get helpTitle => 'साहाय्यम् आवश्यकम्?';

  @override
  String get propertyType => 'नूतनं पुनर्विक्रयः वा';

  @override
  String get greetMorning => 'सुप्रभातम्';

  @override
  String get greetAfternoon => 'नमस्कारः';

  @override
  String get greetEvening => 'शुभसन्ध्या';

  @override
  String nearlyThere(String name) {
    return '$name, भवान् प्रायः प्राप्तवान्';
  }

  @override
  String get chooseLanguage => 'स्वभाषां चिनोतु';

  @override
  String get languageNote => 'भवान् एतत् कदापि परिवर्तयितुं शक्नोति।';

  @override
  String get liveChecks => 'सद्यः परीक्षणानि';

  @override
  String get checkBureau => 'ऋण-कार्यालयः';

  @override
  String checkScore(String score) {
    return 'अङ्कः $score';
  }

  @override
  String get checkNoHistory => 'इतिहासः अद्यापि नास्ति';

  @override
  String get checkBank => 'AA द्वारा वित्तकोशः';

  @override
  String get checkBankRead => '12 मासाः पठिताः';

  @override
  String get checkKyc => 'eKYC स्वचित्रं च';

  @override
  String get checkPending => 'शेषम्';

  @override
  String get checkDocs => 'प्रलेखाः';

  @override
  String countOf(String done, String total) {
    return '$total मध्ये $done';
  }

  @override
  String minutesLeft(String n) {
    return 'प्रायः $n निमेषाः शेषाः';
  }

  @override
  String ratePa(String rate) {
    return 'वार्षिकं $rate%';
  }

  @override
  String get continueApplication => 'स्वस्य आवेदनम् अनुवर्तताम्';

  @override
  String get shapeOffer => 'स्वप्रस्तावं रचयतु';

  @override
  String get shapeOfferSub => 'सिद्धान्ततः अनुमोदितम् · परिवर्तनाय कर्षतु';

  @override
  String get withinLimits => 'भवतः सीमायाम्';

  @override
  String get aboveLimits =>
      'सीमायाः अधिकम्: राशिं न्यूनीकरोतु वर्षाणि वा वर्धयतु';

  @override
  String mostYouCan(String amount) {
    return 'अधिकतमं ग्रहीतुं शक्नोति: $amount';
  }

  @override
  String get useMax => 'अधिकतमं गृह्णातु';

  @override
  String get principal => 'मूलधनम्';

  @override
  String get interest => 'व्याजम्';

  @override
  String get totalRepaid => 'सम्पूर्णं प्रतिदानम्';

  @override
  String get emiShareIncome => 'आये EMI भागः';

  @override
  String loanShareProperty(String value) {
    return '$value सम्पत्तौ ऋणस्य भागः';
  }

  @override
  String get lockOffer => 'इमं प्रस्तावं निश्चिनोतु';

  @override
  String get offerLocked => 'भवतः प्रस्तावः निश्चितः।';

  @override
  String approvedUpTo(String amount) {
    return '$amount पर्यन्तम् अनुमोदितम्';
  }

  @override
  String readingDoc(String doc) {
    return 'भवतः $doc पठ्यते';
  }

  @override
  String get documentAi => 'प्रलेख AI';

  @override
  String sure(String pct) {
    return '$pct% निश्चितम्';
  }

  @override
  String get readMatches => 'अयम् एव अस्माभिः याचितः प्रलेखः';

  @override
  String get readClear => 'स्पष्टं चित्रम्, अस्पष्टता दीप्तिः वा नास्ति';

  @override
  String get whatWeRead => 'वयं किं पठितवन्तः';

  @override
  String get looksRight => 'समीचीनम्';

  @override
  String get fieldName => 'नाम';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'आधार';

  @override
  String get fieldEmployer => 'नियोक्ता';

  @override
  String get fieldNetPay => 'शुद्धं वेतनम्';

  @override
  String get fieldPeriod => 'वेतन-अवधिः';

  @override
  String get fieldYear => 'वर्षम्';

  @override
  String get fieldIncome => 'आयः';

  @override
  String get fieldBusiness => 'व्यवसायः';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'भवतः ऋणाय आवश्यकम्';

  @override
  String get consentSectionOptional =>
      'ऐच्छिकम्: यावत् भवान् न आरभते तावत् निष्क्रियम्';

  @override
  String get advancedOptions => 'विकल्पाः';

  @override
  String consentValidUntil(String given, String until) {
    return '$given दिनाङ्के दत्ता · $until पर्यन्तं मान्या';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given दिनाङ्के दत्ता · प्रत्याहरणपर्यन्तम्';
  }

  @override
  String get recheckTitle => 'राशि-प्रदानात् पूर्वम् एकं अधिकं परीक्षणम्';

  @override
  String get recheckBody =>
      'राशि-प्रदानात् पूर्वं वयं भवतः ऋण-प्रतिवेदनं पुनः पश्यामः। निषेधे तदा अधिकारी पृच्छेत्।';

  @override
  String get aaMonthsLabel => 'कति मासानां विवरणं दातव्यम्';

  @override
  String monthsN(String n) {
    return '$n मासाः';
  }

  @override
  String get aaAccountsLabel => 'दातव्यानि खातानि';

  @override
  String get accountSavingsSalary => 'सञ्चय-खाता ·· 0912 · वेतन-जमा';

  @override
  String get accountSavings => 'सञ्चय-खाता ·· 4821';

  @override
  String get accountFd => 'स्थिर-निक्षेपः ·· 3307';

  @override
  String get aaAccountNeeded => 'न्यूनातिन्यूनम् एकं खातां चिनोतु।';

  @override
  String get kycMethodLabel => 'परिचयं कथं सत्यापयेत्';

  @override
  String get kycAadhaarOtp => 'आधार OTP';

  @override
  String get kycDigilocker => 'डिजिलॉकर';

  @override
  String get kycVideo => 'दृश्य-KYC आह्वानम्';

  @override
  String get useCkycTitle => 'मम वर्तमानं CKYC अभिलेखम् उपयुङ्क्ताम्';

  @override
  String get useCkycBody =>
      'यदि अन्यस्मिन् वित्तकोशे निधौ वा KYC कृतम्, तर्हि पुनः अपृष्ट्वा वयं तम् अभिलेखम् आनयामः।';

  @override
  String get optOffersTitle => 'प्रस्तावाः नूतनानि उत्पादनानि च';

  @override
  String get optOffersBody =>
      'प्रस्तावानां विषये कथं ज्ञातुम् इच्छति इति चिनोतु। कदापि निष्क्रियं कर्तुं शक्नोति।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ई-पत्रम्';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp द्वारा ऋण-सूचनाः';

  @override
  String get optUpdatesBody =>
      'SMS सह WhatsApp द्वारा अपि स्थिति-सूचनाः EMI स्मारकाणि च।';

  @override
  String get optInsuranceTitle => 'गृहऋण-रक्षा-मूल्यपत्रम्';

  @override
  String get optInsuranceBody =>
      'मूल्यपत्राय स्वनाम, वयः, ऋण-राशिं च अस्माकं बीमा-सहयोगिने ददातु। क्रयः कदापि अनिवार्यः नास्ति।';

  @override
  String get getQuote => 'मूल्यपत्रं प्राप्नोतु';

  @override
  String get manageConsents => 'सम्मतीनां व्यवस्थापनम्';

  @override
  String get manageConsentsBody =>
      'ऐच्छिकाः सम्मतयः कदापि निष्क्रियाः कर्तुं शक्याः। आवश्यकायाः प्रत्याहरणे आवेदनं स्थगति, तदर्थम् आनीतं दत्तांशं वयं निष्कासयामः।';

  @override
  String get withdraw => 'प्रत्याहरतु';

  @override
  String get consentHistory => 'सम्मति-इतिहासः';

  @override
  String historyGiven(String item) {
    return '$item दत्ता';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item प्रत्याहृता';
  }

  @override
  String get historyEmpty => 'अद्यापि किमपि नास्ति।';

  @override
  String get consentOn => 'सक्रियम्';

  @override
  String get consentOff => 'निष्क्रियम्';

  @override
  String get withdrawnRequired =>
      'भवता आवश्यका सम्मतिः प्रत्याहृता, अतः आवेदनं स्थगितम्।';

  @override
  String get checkMatchPending =>
      'चित्र-मेलनम्: आधार-पत्रे पैन-पत्रे वा उपारोपिते भविष्यति';

  @override
  String get realDetailsIntro =>
      'स्वविषये कथयतु। वयं प्रत्येकं विवरणं भवतः पत्रैः सह परीक्षामहे।';

  @override
  String get fullNameLabel => 'पूर्णं नाम (पैन-पत्रे यथा अस्ति)';

  @override
  String get emailLabel => 'ईमेल';

  @override
  String get employerLabel => 'नियोक्तुः व्यवसायस्य वा नाम';

  @override
  String get creditScoreLabel => 'क्रेडिट-अङ्कः (ऐच्छिकः)';

  @override
  String get creditScoreHint =>
      'भवतः CIBIL अथवा Experian प्रतिवेदनात्, यदि ज्ञायते';

  @override
  String get addressLabel => 'सङ्केतः';

  @override
  String get saveDetails => 'मम विवरणं रक्षतु';

  @override
  String get selfDeclaredNote =>
      'एतत् विवरणं भवता पूरितम्। अनन्तरं उपारोप्यमाणैः पत्रैः सह वयम् एतत् परीक्षिष्यामहे।';

  @override
  String get pickDob => 'स्वजन्मतिथिं चिनोतु';

  @override
  String get fillDetails =>
      'कृपया नाम, जन्मतिथिः, कार्यं, नियोक्ता, आयः च पूरयतु।';

  @override
  String get docSaleDeed => 'विक्रयपत्रम् आवण्टनपत्रं वा';

  @override
  String get saleDeedBody =>
      'पञ्जीकृतविक्रयपत्रस्य चित्रं PDF वा उपारोपयतु (यस्मिन् पृष्ठे सम्पत्तिः क्रेता च स्तः)। स्वामित्वपरीक्षणाय वयम् एतत् पठामः।';

  @override
  String get statusPending => 'पुनरवलोकनम् अवशिष्टम्';

  @override
  String decisionRef(String ref) {
    return 'निर्णय-अभिलेखः $ref';
  }

  @override
  String get scoreTitle => 'वयं भवतः अङ्कं कथं गणितवन्तः';

  @override
  String get scoreOutOf => '900 मध्ये';

  @override
  String gradeLabel(String grade) {
    return 'श्रेणी $grade';
  }

  @override
  String scoreStart(String base) {
    return 'सर्वे $base अङ्केभ्यः आरभन्ते। अधः प्रत्येका पङ्क्तिः अङ्कान् योजयति वा न्यूनीकरोति।';
  }

  @override
  String get scoreNote =>
      'अयं निर्णयस्य क्रेडिट-अङ्क-भागः। भवतः आयः, परिचयः, प्रलेखाः सम्पत्तिः च अपि परीक्ष्यन्ते।';

  @override
  String get factorBureau => 'क्रेडिट-ब्यूरो-अङ्कः';

  @override
  String get factorHistory => 'क्रेडिट-इतिहासस्य वर्षाणि';

  @override
  String get factorLtv => 'सम्पत्ति-मूल्यस्य तुलनायां ऋणस्य भागः';

  @override
  String get factorLoanAmount => 'ऋण-राशिः';

  @override
  String get factorMissing => 'न उपलब्धम्';

  @override
  String rangeBelow(String x) {
    return '$x तः न्यूनम्';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$a तः $b पर्यन्तम्';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x अथवा अधिकम्';
  }

  @override
  String get viewLetter => 'निर्णय-पत्रम्';

  @override
  String get letterTitle => 'भवतः निर्णय-पत्रम्';

  @override
  String get letterPartlyEnglish =>
      'काश्चन पङ्क्तयः अनूदितुं न शक्ताः, अतः ताः आङ्ग्लभाषायाम् सन्ति।';

  @override
  String get copyText => 'पाठं प्रतिलिखतु';

  @override
  String get copied => 'प्रतिलिखितम्';

  @override
  String get askTitle => 'प्रश्नं पृच्छतु';

  @override
  String get askHint => 'यथा: अग्रे किं भविष्यति?';

  @override
  String get askSend => 'प्रेषयतु';

  @override
  String get askHuman =>
      'अस्माकं दलस्य कश्चन जनः अस्मिन् विषये भवता सह सम्पर्कं करिष्यति।';

  @override
  String get uploadPdf => 'PDF आरोपयतु';

  @override
  String get kfsFeeBase => 'प्रक्रिया-शुल्कम् (0.5%)';

  @override
  String get kfsGst => 'शुल्के GST (18%)';

  @override
  String get kfsNoteEngine =>
      'अस्य प्रस्तावस्य कृते गणितम्। हस्ताक्षरितं मुख्य-तथ्य-विवरणं भवतः स्वीकृति-पत्रेण सह आगमिष्यति।';

  @override
  String otpOnServer(String phone) {
    return 'अयं परीक्षण-सर्वरः SMS न प्रेषयति। $phone कृते 6 अङ्कानां कोडः सङ्गणकस्य सर्वर-गवाक्षे दृश्यते।';
  }

  @override
  String get resendOtp => 'नूतनं कोडं प्रेषयतु';

  @override
  String get newOtpSent => 'नूतनः कोडः प्रेषितः।';

  @override
  String get otpExpired =>
      'अस्य कोडस्य अवधिः समाप्ता। नूतनं कोडं प्रेषयतु इति नुदतु।';

  @override
  String get otpTooManyTries =>
      'बहुवारं अशुद्धः कोडः। नूतनं कोडं प्रेषयतु इति नुदतु।';

  @override
  String get otpTooManySends =>
      'अतीव बहवः कोडाः याचिताः। 15 निमेषान् प्रतीक्ष्य पुनः प्रयतताम्।';
}
