// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Konkani (`kok`).
class AppLocalizationsKok extends AppLocalizations {
  AppLocalizationsKok([String locale = 'kok']) : super(locale);

  @override
  String get appTitle => 'निर्णय';

  @override
  String get sandboxBanner => 'डेमो मोड: नमुनो डेटा, खरी तपासणी न्हय';

  @override
  String get continueLabel => 'फुडें वचात';

  @override
  String stepOf(String step, String total) {
    return 'पावल $step / $total';
  }

  @override
  String get pleaseWait => 'उलो थांबात…';

  @override
  String get errorGeneric => 'कितें तरी चुकलें. परत यत्न करात.';

  @override
  String get close => 'बंद करात';

  @override
  String get welcomeHeadline => 'थोड्या मिनटांनी तुमच्या घर कर्जाचो निर्णय';

  @override
  String get welcomeBody =>
      'घर कर्ज वा मालमत्तेचेर कर्जाखातीर अर्ज करात. आमी सगळें ऑनलायन तपासतात आनी सदांच निर्णयाचें कारण सांगतात.';

  @override
  String get chooseProduct => 'तुमकां कितें जाय?';

  @override
  String get productHomeLoan => 'घर कर्ज';

  @override
  String get productHomeLoanSub => 'घर विकतें घेवप, बांदप वा सुदारप';

  @override
  String get productLap => 'मालमत्तेचेर कर्ज';

  @override
  String get productLapSub => 'तुमच्या मालमत्तेचेर कर्ज घेयात';

  @override
  String get startApplication => 'अर्ज सुरू करात';

  @override
  String get demoCustomers => 'डेमो गिरायक';

  @override
  String get demoCustomersBody => 'नमुनो मोबायल नंबर भरपाक एकाचेर टॅप करात.';

  @override
  String get personaRavi => 'रवी, 32, नोकरदार, फ्लॅट विकतो घेता';

  @override
  String get personaMeena => 'मीना, 45, कपड्यांचें दुकान चलयता (LAP)';

  @override
  String get personaArjun => 'अर्जुन, 29, नोकरदार, बदल्लेली पगार स्लिप';

  @override
  String get signInTitle => 'साइन इन';

  @override
  String get mobileLabel => 'मोबायल नंबर';

  @override
  String get mobileHint => '10 आंकड्यांचो मोबायल नंबर';

  @override
  String get invalidMobile => 'योग्य 10 आंकड्यांचो मोबायल नंबर घालात.';

  @override
  String get sendOtp => 'OTP धाडात';

  @override
  String otpSentTo(String phone) {
    return 'आमी $phone चेर 6 आंकड्यांचो कोड धाडला.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'पडताळात';

  @override
  String get demoOtp => 'डेमो कोड: 123456';

  @override
  String get wrongOtp => 'कोड चुकीचो. परत यत्न करात.';

  @override
  String get deviceBound =>
      'हो फोन आतां तुमच्या खात्याक जोडला. दुसऱ्या फोनाचेर साइन इन करपाक नवो OTP जाय.';

  @override
  String get consentTitle => 'तुमची संमती';

  @override
  String get consentIntro =>
      'आमी तुमचो डेटा फकत ह्या कर्जाच्या निर्णयाखातीर आनी वेवस्थापनाखातीर वापरतात. तुमी केन्नाय संमती परत घेवंक शकतात.';

  @override
  String get consentBureauTitle => 'क्रेडिट रिपोर्ट';

  @override
  String get consentBureauBody =>
      'क्रेडिट ब्युरो (CIBIL, Experian, Equifax वा CRIF) कडल्यान तुमचो क्रेडिट इतिहास पळयतले. हाका लागून तुमचो स्कोर उणो जायना.';

  @override
  String get consentAaTitle => 'अकाउंट एग्रीगेटर वरवीं बँक स्टेटमेंट';

  @override
  String get consentAaBody =>
      'RBI परवानो आशिल्ल्या अकाउंट एग्रीगेटर वरवीं तुमच्या बँकेचे 12 म्हयन्यांचे स्टेटमेंट हाडटले. विनंती तुमी तुमच्या AA ॲपांत मान्य करतले.';

  @override
  String get consentKycTitle => 'आधार eKYC आनी PAN';

  @override
  String get consentKycBody =>
      'UIDAI आनी आयकर खात्या कडेन तुमची वळख पडताळटले. आमी फकत लिपयल्लो आधार नंबर दवरतात.';

  @override
  String get consentPrivacyTitle => 'खासगीपणाची सुचोवणी (DPDP कायदो 2023)';

  @override
  String get consentPrivacyBody =>
      'आमी कितें एकठांय करतात: वळख, उत्पन्न, बँक आनी मालमत्तेची म्हायती. कित्याक: तुमच्या कर्जाच्या निर्णयाखातीर आनी वेवस्थापनाखातीर. कितलो वेळ: कायदो सांगता तितलोच. तुमचे हक्क: म्हायती पळोवप, सुदारप वा पुसप, आनी आमच्या तक्रार अधिकाऱ्याकडेन वा डेटा राखण मंडळाकडेन तक्रार करप.';

  @override
  String get consentRequired => 'गरजेचें';

  @override
  String get consentNeeded => 'फुडें वचपाक सगळ्यांक संमती दियात.';

  @override
  String get agreeAndContinue => 'संमती दिवन फुडें वचात';

  @override
  String get detailsTitle => 'तुमची म्हायती';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'योग्य PAN घालात, देखीक ABCDE1234F.';

  @override
  String get fetchDetails => 'म्हजी म्हायती हाडात';

  @override
  String get fetchedFrom =>
      'PAN, आधार eKYC आनी बँक स्टेटमेंटांतल्यान भरला. सुदारपाक आंकड्याचेर टॅप करात.';

  @override
  String get nameLabel => 'नांव';

  @override
  String get dobLabel => 'जल्मतारीख';

  @override
  String get employmentLabel => 'काम';

  @override
  String get salaried => 'नोकरदार';

  @override
  String get selfEmployed => 'स्वयंरोजगार';

  @override
  String get incomeLabel => 'म्हयन्याचें निव्वळ उत्पन्न';

  @override
  String get existingEmiLabel => 'सद्याचे म्हयन्याचे EMI';

  @override
  String get propertyValueLabel => 'मालमत्तेचें मोल';

  @override
  String get loanAmountLabel => 'कर्जाची रक्कम';

  @override
  String get tenureLabel => 'मुदत';

  @override
  String yearsLabel(String n) {
    return '$n वर्सां';
  }

  @override
  String get eligibleTitle => 'तुमकां चडांत चड मेळूं शकता';

  @override
  String emiPerMonth(String amount) {
    return 'म्हयन्याक EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'वर्साक $rate%, बदलतो दर (देखीक)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'उत्पन्नाची मर्यादा: तुमचे सगळे EMI मेळून उत्पन्नाच्या $pct मेरेन आसूं येतात.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'मालमत्तेची मर्यादा: इतलें कर्ज मोलाच्या $pct मेरेन आसूं येता.';
  }

  @override
  String get limitedByAsked => 'ही तुमी मागिल्ली रक्कम.';

  @override
  String get eligibilityNote =>
      'तुमच्या म्हायतेची बेगीन तपासणी. आमच्या तपासणी उपरांत ऑफर येतली.';

  @override
  String get selfieTitle => 'सेल्फी काडात';

  @override
  String get selfieBody =>
      'आमी तुमचें तोंड आधार फोटोकडेन जुळयतात आनी तें खरेंच तुमी, फोटोचो फोटो न्हय, हें पळयतात.';

  @override
  String get selfieTips => 'बरो उजवाड, कॅमेऱ्याकडेन पळयात, टोपी वा गॉगल नाका.';

  @override
  String get takeSelfie => 'सेल्फी काडात';

  @override
  String get retake => 'परत काडात';

  @override
  String get checkFace => 'तोंड मेळ्ळें';

  @override
  String get checkLive => 'जिवो मनीस';

  @override
  String get checkMatch => 'आधार फोटोकडेन जुळटा';

  @override
  String get selfieFailed =>
      'तुमचें तोंड पुष्टी करूंक जालें ना. बऱ्या उजवाडांत परत यत्न करात, वा व्हिडियो KYC कॉल बुक करात.';

  @override
  String get videoKyc => 'व्हिडियो KYC कॉल बुक करात';

  @override
  String get docsTitle => 'तुमचीं कागदपत्रां';

  @override
  String get docsBody =>
      'दरेक कागदपत्राचो स्पश्ट फोटो काडात, वा गॅलरींतल्यान वेंचात.';

  @override
  String get docPan => 'PAN कार्ड';

  @override
  String get docAadhaar => 'आधार कार्ड (लिपयल्लें)';

  @override
  String get docSalarySlip => 'नवी पगार स्लिप';

  @override
  String get docForm16 => 'फॉर्म 16';

  @override
  String get docItr => 'आयकर रिटर्न (ITR)';

  @override
  String get docGst => 'GST प्रमाणपत्र';

  @override
  String get docBankStatement => 'बँक स्टेटमेंट';

  @override
  String get bankViaAa => 'तुमच्या अकाउंट एग्रीगेटर वरवीं हाडलें';

  @override
  String get camera => 'कॅमेरा';

  @override
  String get gallery => 'गॅलरी';

  @override
  String get checking => 'तपासता…';

  @override
  String get tooBlurry => 'खूब धुसर. फोन थीर धरून परत यत्न करात.';

  @override
  String get tooMuchGlare => 'खूब चकचकाट. उजवाडा सावन पयस सरून परत यत्न करात.';

  @override
  String get tooDark => 'खूब काळोख. चड उजवाडांत परत यत्न करात.';

  @override
  String docAccepted(String type) {
    return 'वळखलें: $type';
  }

  @override
  String docWrong(String expected) {
    return 'हें $expected भशेन दिसना. तपासून योग्य कागदपत्र अपलोड करात.';
  }

  @override
  String get docUnreadable =>
      'हें कागदपत्र वाचूंक जालें ना. चड स्पश्ट फोटो काडात, वा मूळ PDF अपलोड करात.';

  @override
  String docsMissing(String n) {
    return 'अजून $n जाय';
  }

  @override
  String get getOffer => 'म्हजी तत्वता ऑफर दाखयात';

  @override
  String get approvedInPrinciple => 'तत्वता मान्य';

  @override
  String get sanctioned => 'कर्ज मंजूर';

  @override
  String get referredTitle => 'आमकां उपरांत वेळ जाय';

  @override
  String get rejectedTitle => 'सद्या आमी हें कर्ज दिवंक शकनात';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years वर्सां · वर्साक $rate% बदलतो दर';
  }

  @override
  String get whyOffer => 'तुमकां ही ऑफर कित्याक मेळ्ळी';

  @override
  String get whyReferred => 'फुडें कितें जातलें';

  @override
  String get whyRejected => 'आमी हो निर्णय कित्याक घेतलो';

  @override
  String get referBody =>
      'एक अधिकारी एका कामाच्या दिसा भितर तुमचो अर्ज पळयतलो. आतां तुमी कांयच करपाची गरज ना.';

  @override
  String get rejectBody =>
      'तुमी केन्नाय एका मनशाक ह्या निर्णयाची परतून तपासणी करपाक सांगूंक शकतात.';

  @override
  String get addProperty => 'मालमत्तेची म्हायती जोडात';

  @override
  String get viewKfs => 'मुखेल तथ्यांचें निवेदन पळयात';

  @override
  String get grievance => 'परतून तपासणी मागात वा तक्रार करात';

  @override
  String officerLine(String name, String email) {
    return 'तक्रार अधिकारी: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'अर्ज $id';
  }

  @override
  String get startOver => 'नवो अर्ज सुरू करात';

  @override
  String okScore(String score) {
    return 'फारीकणेचो बळगें इतिहास (स्कोर $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI उत्पन्नाच्या $pct आसात; आमची मर्यादा $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'कर्ज मालमत्तेच्या मोलाच्या $pct आसा; मर्यादा $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'मालमत्तेचें आमचें मोलमापन: $low ते $high';
  }

  @override
  String get okTitle => 'मालमत्तेचो मालकी हक्क आनी कागदपत्रां तपासलीं';

  @override
  String get reasonKyc01 =>
      'फोटो वयल्यान तुमची वळख पुष्टी करूंक जाली ना. उलो एक ल्हान व्हिडियो KYC कॉल पुराय करात.';

  @override
  String get reasonFrd02 =>
      'पगार स्लिपेवयलें उत्पन्न बँकेंतल्या जमे कडेन जुळना. तुमचो नवो फॉर्म 16 दियात, वा संमती दिवन आमकां हाडूंक दियात.';

  @override
  String get reasonFrd03 =>
      'तुमचें एक कागदपत्र दिवपी प्राधिकरणाच्या पडताळणेंत अपेशी जालें.';

  @override
  String get reasonPol01 =>
      'अर्जदाराचें पिराय उण्यांत उणें 21 वर्सां आसूंक जाय.';

  @override
  String get reasonPol02 =>
      'कर्ज आमी मान्य केल्ल्या चडांत चड पिराये परस फुडें वतलें. ल्हान पिरायेचो सह-अर्जदार जोडल्यार आदार जावंक शकता.';

  @override
  String get reasonBur01 =>
      'तुमचो क्रेडिट स्कोर आमच्या उण्यांत उण्या 650 परस उणो आसा.';

  @override
  String get reasonBur04 =>
      'तुमचो अजून क्रेडिट इतिहास ना, म्हणून एक अधिकारी तुमचे बँक रेकॉर्ड पळयतलो.';

  @override
  String get reasonBur05 =>
      'तुमचो क्रेडिट स्कोर अधिकाऱ्यान लक्ष दिवन पळोवंक जाय.';

  @override
  String get reasonPrp01 =>
      'आमच्या वकिलान मालमत्तेच्या मालकी हक्काची तपासणी करपाक जाय.';

  @override
  String get reasonPrp03 =>
      'मोल पुष्टी करपाक आमच्या मोलमापकान मालमत्तेक भेट दिवंक जाय.';

  @override
  String get reasonPrp04 =>
      'करार मोल ह्या मालमत्तेच्या सरकारी सर्कल रेटा परस उणें आसा. उलो विक्री करार तपासात.';

  @override
  String get reasonAff01 =>
      'तुमचे सद्याचे EMI पयलींच उत्पन्नाचो चडांत चड वांटो वापरतात.';

  @override
  String get reasonAut01 =>
      'इतल्या व्हड कर्जाची निमणी तपासणी एक ज्येश्ठ अधिकारी करता.';

  @override
  String get reasonRsk01 => 'ऑफर निश्चित करपाक एक अधिकारी तुमचो अर्ज पळयतलो.';

  @override
  String get reasonRsk02 =>
      'तुमच्या क्रेडिट प्रोफायलाच्या आदारान सद्या आमी हें कर्ज दिवंक शकनात.';

  @override
  String get propertyTitle => 'तुमची मालमत्ता';

  @override
  String get cityLabel => 'शार';

  @override
  String get localityLabel => 'वाठार';

  @override
  String get societyLabel => 'प्रकल्प वा सोसायटी (आसल्यार)';

  @override
  String get areaLabel => 'क्षेत्रफळ (चौ. फूट)';

  @override
  String get bhkLabel => 'न्हिदपाचीं कुडां';

  @override
  String get newProperty => 'नवी';

  @override
  String get resale => 'परत विक्री';

  @override
  String get declaredPriceLabel => 'करार मोल';

  @override
  String get photosTitle => 'मालमत्तेचे फोटो';

  @override
  String get photosBody =>
      'मालमत्तेचेर वचून फोटो काडात. आमी जागो आनी वेळ जोडटात, जाका लागून मोलमापक भेटीची येवजण करूंक शकता.';

  @override
  String get photoFront => 'मुखार';

  @override
  String get photoInside => 'भितर';

  @override
  String get photoView => 'मालमत्तेवयल्यान दिसपी दृश्य';

  @override
  String geoTagged(String lat, String lng) {
    return 'जागो जोडलो ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'जाग्या बगर फोटो सांबाळ्ळो. जियो-टॅगाखातीर लोकेशन सुरू करात.';

  @override
  String get submitProperty => 'निमणी मंजुरी मेळयात';

  @override
  String get fillAll => 'उलो सगळे रकाने भरात.';

  @override
  String get kfsTitle => 'मुखेल तथ्यांचें निवेदन';

  @override
  String get kfsLoan => 'कर्जाची रक्कम';

  @override
  String get kfsTenure => 'मुदत';

  @override
  String get kfsRate => 'व्याज दर';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI ची संख्या';

  @override
  String get kfsFee => 'प्रक्रिया शुल्क (GST सयत)';

  @override
  String get kfsTotalInterest => 'एकूण व्याज';

  @override
  String get kfsTotalPayable => 'एकूण फारीक करपाची रक्कम';

  @override
  String get kfsApr => 'वर्सुकी टक्केवारी दर (APR)';

  @override
  String get kfsCoolingOff =>
      'कूलिंग-ऑफ काळ: सय केल्या उपरांत 3 दिसां भितर फकत मुद्दल आनी त्या दिसांचें व्याज परत दिवन दंडा बगर भायर सरूं येता.';

  @override
  String get kfsNote =>
      'डेमोखातीर नमुनो आंकडे. तुमचें खरें KFS मंजुरी पत्रा वांगडा येतलें.';

  @override
  String get useSample => 'नमुनो';

  @override
  String get videoKycDemo =>
      'डेमो: हाका लागून एका अधिकाऱ्या वांगडा व्हिडियो KYC कॉल बुक जातलो.';

  @override
  String get raiseComplaint => 'तक्रार करात';

  @override
  String complaintSent(String ref) {
    return 'तुमची तक्रार नोंद जाली. संदर्भ $ref.';
  }

  @override
  String get stageSignIn => 'साइन इन';

  @override
  String get stageDetails => 'म्हायती';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'ऑफर';

  @override
  String get stageProperty => 'मालमत्ता';

  @override
  String get homeSubtitle => 'घर कर्ज · मालमत्तेचेर कर्ज';

  @override
  String get heroPill => 'मिनटांनी निर्णय';

  @override
  String heroFacts(String rate, String years) {
    return 'वर्साक $rate% सावन · $years वर्सां मेरेन';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% पुराय · जंय थांबल्लात थंयच्यान सुरू करात';
  }

  @override
  String get resume => 'फुडें चालू';

  @override
  String get calculators => 'कॅल्क्युलेटर';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'म्हयन्याचो हप्तो';

  @override
  String get calcEligibility => 'पात्रताय';

  @override
  String get calcEligibilitySub => 'तुमकां कितलें मेळूं शकता';

  @override
  String get emiCalcTitle => 'EMI कॅल्क्युलेटर';

  @override
  String get eligibilityCalcTitle => 'पात्रताय कॅल्क्युलेटर';

  @override
  String totalInterest(String amount) {
    return 'एकूण व्याज $amount';
  }

  @override
  String get calcIncomeOnly =>
      'फकत उत्पन्नाच्या आदारान. मालमत्तेच्या मोलाक लागून हें उणें जावंक शकता.';

  @override
  String get verified => 'पडताळ्ळें';

  @override
  String get yourLoan => 'तुमचें कर्ज';

  @override
  String docsProgress(String done, String total) {
    return '$total भितर $done पडताळ्ळीं';
  }

  @override
  String get docNeeded => 'जाय';

  @override
  String get docTryAgain => 'परत यत्न';

  @override
  String get fetched => 'हाडलें';

  @override
  String get statusApproved => 'मान्य';

  @override
  String get statusSanctioned => 'मंजूर जालें';

  @override
  String get statusInReview => 'तपासणेंत';

  @override
  String get statusDeclined => 'नाकारलें';

  @override
  String get trackTitle => 'तुमचो अर्ज ट्रॅक करात';

  @override
  String get tlSubmitted => 'अर्ज सादर जालो';

  @override
  String get tlVerified => 'KYC आनी कागदपत्रां पडताळ्ळीं';

  @override
  String get tlInPrinciple => 'तत्वता मान्यताय';

  @override
  String get tlProperty => 'मालमत्तेची म्हायती आनी मोलमापन';

  @override
  String get tlPropertyNext => 'तुमच्या मालमत्तेची म्हायती आनी फोटो जोडात';

  @override
  String get tlOfficer => 'अधिकाऱ्याची तपासणी';

  @override
  String get tlOfficerNext => 'एका कामाच्या दिसा भितर';

  @override
  String get tlLegal => 'कायदेशीर आनी मालकी तपासणी';

  @override
  String get tlSanction => 'निमणी मंजुरी आनी ई-सय';

  @override
  String get tlSanctionNext => 'मंजुरी पत्राचेर ऑनलायन सय करात';

  @override
  String get tlDisbursement => 'रक्कम वाटप';

  @override
  String get helpTitle => 'आदार जाय?';

  @override
  String get propertyType => 'नवी वा परत विक्री';

  @override
  String get greetMorning => 'सुप्रभात';

  @override
  String get greetAfternoon => 'दनपारां बरें';

  @override
  String get greetEvening => 'सांजे बरें';

  @override
  String nearlyThere(String name) {
    return '$name, तुमी लागीं पावल्यात';
  }

  @override
  String get chooseLanguage => 'तुमची भास वेंचात';

  @override
  String get languageNote => 'तुमी हें केन्नाय बदलूंक शकतात.';

  @override
  String get liveChecks => 'थेट तपासण्यो';

  @override
  String get checkBureau => 'क्रेडिट ब्युरो';

  @override
  String checkScore(String score) {
    return 'स्कोर $score';
  }

  @override
  String get checkNoHistory => 'अजून इतिहास ना';

  @override
  String get checkBank => 'AA वरवीं बँक';

  @override
  String get checkBankRead => '12 म्हयने वाचले';

  @override
  String get checkKyc => 'eKYC आनी सेल्फी';

  @override
  String get checkPending => 'उरलां';

  @override
  String get checkDocs => 'कागदपत्रां';

  @override
  String countOf(String done, String total) {
    return '$total भितर $done';
  }

  @override
  String minutesLeft(String n) {
    return 'सुमार $n मिनटां उरल्यांत';
  }

  @override
  String ratePa(String rate) {
    return 'वर्साक $rate%';
  }

  @override
  String get continueApplication => 'तुमचो अर्ज फुडें चालू दवरात';

  @override
  String get shapeOffer => 'तुमची ऑफर थारायात';

  @override
  String get shapeOfferSub => 'तत्वता मान्य · बदलपाक ओडात';

  @override
  String get withinLimits => 'तुमच्या मर्यादे भितर';

  @override
  String get aboveLimits => 'मर्यादे परस चड: रक्कम उणी करात वा वर्सां वाडयात';

  @override
  String mostYouCan(String amount) {
    return 'चडांत चड घेवंक शकतात: $amount';
  }

  @override
  String get useMax => 'चडांत चड घेयात';

  @override
  String get principal => 'मुद्दल';

  @override
  String get interest => 'व्याज';

  @override
  String get totalRepaid => 'एकूण फारीकणी';

  @override
  String get emiShareIncome => 'उत्पन्नांत EMI चो वांटो';

  @override
  String loanShareProperty(String value) {
    return '$value मालमत्तेंत कर्जाचो वांटो';
  }

  @override
  String get lockOffer => 'ही ऑफर पक्की करात';

  @override
  String get offerLocked => 'तुमची ऑफर पक्की जाली.';

  @override
  String approvedUpTo(String amount) {
    return '$amount मेरेन मान्य';
  }

  @override
  String readingDoc(String doc) {
    return 'तुमचें $doc वाचतात';
  }

  @override
  String get documentAi => 'कागदपत्र AI';

  @override
  String sure(String pct) {
    return '$pct% खात्री';
  }

  @override
  String get readMatches => 'आमी मागिल्लें कागदपत्र हेंच';

  @override
  String get readClear => 'स्पश्ट फोटो, धुसरपण वा चकचकाट ना';

  @override
  String get whatWeRead => 'आमी कितें वाचलें';

  @override
  String get looksRight => 'बरोबर आसा';

  @override
  String get fieldName => 'नांव';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'आधार';

  @override
  String get fieldEmployer => 'मालक';

  @override
  String get fieldNetPay => 'निव्वळ पगार';

  @override
  String get fieldPeriod => 'पगाराचो काळ';

  @override
  String get fieldYear => 'वर्स';

  @override
  String get fieldIncome => 'उत्पन्न';

  @override
  String get fieldBusiness => 'वेवसाय';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'तुमच्या कर्जाखातीर गरजेचें';

  @override
  String get consentSectionOptional => 'पर्यायी: तुमी सुरू करिनासर बंद';

  @override
  String get advancedOptions => 'पर्याय';

  @override
  String consentValidUntil(String given, String until) {
    return '$given दिसा दिली · $until मेरेन वैध';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given दिसा दिली · परत घेयमेरेन';
  }

  @override
  String get recheckTitle => 'रक्कम दिवचे आदीं आनीक एक तपासणी';

  @override
  String get recheckBody =>
      'रक्कम दिवचे आदीं आमी तुमचो क्रेडिट रिपोर्ट परत पळयतात. ना म्हणल्यार तेन्ना अधिकारी विचारूं शकता.';

  @override
  String get aaMonthsLabel => 'कितल्या म्हयन्यांचे स्टेटमेंट दिवचे';

  @override
  String monthsN(String n) {
    return '$n म्हयने';
  }

  @override
  String get aaAccountsLabel => 'दिवचीं खातीं';

  @override
  String get accountSavingsSalary => 'बचत खातें ·· 0912 · पगार जमो';

  @override
  String get accountSavings => 'बचत खातें ·· 4821';

  @override
  String get accountFd => 'मुदत ठेव ·· 3307';

  @override
  String get aaAccountNeeded => 'उण्यांत उणें एक खातें वेंचात.';

  @override
  String get kycMethodLabel => 'वळख कशी पडताळची';

  @override
  String get kycAadhaarOtp => 'आधार OTP';

  @override
  String get kycDigilocker => 'डिजीलॉकर';

  @override
  String get kycVideo => 'व्हिडियो KYC कॉल';

  @override
  String get useCkycTitle => 'म्हजो सद्याचो CKYC रेकॉर्ड वापरात';

  @override
  String get useCkycBody =>
      'दुसऱ्या बँकेंत वा फंडांत KYC केल्लें आसल्यार, परत विचारिनासतना आमी तो रेकॉर्ड हाडटात.';

  @override
  String get optOffersTitle => 'ऑफर आनी नवीं उत्पादनां';

  @override
  String get optOffersBody =>
      'ऑफरां विशीं कशें कळोवंक जाय तें वेंचात. हें केन्नाय बंद करूं येता.';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ईमेल';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp चेर कर्जाचे अपडेट';

  @override
  String get optUpdatesBody =>
      'SMS वांगडा WhatsApp चेर स्थितीचे अपडेट आनी EMI याद.';

  @override
  String get optInsuranceTitle => 'घर कर्ज राखणेचें कोटेशन';

  @override
  String get optInsuranceBody =>
      'कोटेशनाखातीर तुमचें नांव, पिराय आनी कर्जाची रक्कम आमच्या विमा भागीदाराक दियात. विकतें घेवप केन्नाच बंधनकारक ना.';

  @override
  String get getQuote => 'कोटेशन घेयात';

  @override
  String get manageConsents => 'संमती सांबाळात';

  @override
  String get manageConsentsBody =>
      'पर्यायी संमती केन्नाय बंद करात. गरजेची संमती परत घेतल्यार अर्ज थांबता, आनी ताचेखातीर हाडिल्लो डेटा आमी पुसतात.';

  @override
  String get withdraw => 'परत घेयात';

  @override
  String get consentHistory => 'संमतीचो इतिहास';

  @override
  String historyGiven(String item) {
    return '$item दिली';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item परत घेतली';
  }

  @override
  String get historyEmpty => 'अजून कांयच ना.';

  @override
  String get consentOn => 'सुरू';

  @override
  String get consentOff => 'बंद';

  @override
  String get withdrawnRequired =>
      'तुमी गरजेची संमती परत घेतली, देखून अर्ज थांबला.';

  @override
  String get checkMatchPending =>
      'फोटो जुळोवप: आधार वा पॅन कार्ड अपलोड केल्यार जातलें';
}
