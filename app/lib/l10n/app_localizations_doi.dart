// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dogri (`doi`).
class AppLocalizationsDoi extends AppLocalizations {
  AppLocalizationsDoi([String locale = 'doi']) : super(locale);

  @override
  String get appTitle => 'निर्णय';

  @override
  String get sandboxBanner => 'डेमो मोड: नमूना डेटा, असली जांच नेईं';

  @override
  String get continueLabel => 'अग्गें बधो';

  @override
  String stepOf(String step, String total) {
    return 'कदम $step / $total';
  }

  @override
  String get pleaseWait => 'मेहरबानी करियै इंतजार करो…';

  @override
  String get errorGeneric => 'किश गलत होई गेआ। फ्ही कोशश करो।';

  @override
  String get close => 'बंद करो';

  @override
  String get welcomeHeadline => 'किश मिंटें च तुंदे होम लोन दा फैसला';

  @override
  String get welcomeBody =>
      'होम लोन जां जायदाद पर लोन आस्तै अर्जी देओ। अस सब किश ऑनलाइन जांचने आं ते हमेशां फैसले दी बजह दसने आं।';

  @override
  String get chooseProduct => 'तुसेंगी के चाहिदा ऐ?';

  @override
  String get productHomeLoan => 'होम लोन';

  @override
  String get productHomeLoanSub => 'घर खरीदना, बनाना जां सुधारना';

  @override
  String get productLap => 'जायदाद पर लोन';

  @override
  String get productLapSub => 'अपनी जायदाद पर कर्ज लैओ';

  @override
  String get startApplication => 'अर्जी शुरू करो';

  @override
  String get demoCustomers => 'डेमो ग्राहक';

  @override
  String get demoCustomersBody => 'नमूना मोबाइल नंबर भरने आस्तै इक पर टैप करो।';

  @override
  String get personaRavi => 'रवि, 32, नौकरीपेशा, फ्लैट खरीदा करदे न';

  @override
  String get personaMeena => 'मीना, 45, कपड़ें दी दुकान चलांदियां न (LAP)';

  @override
  String get personaArjun => 'अर्जुन, 29, नौकरीपेशा, बदलोई दी तनखाह पर्ची';

  @override
  String get signInTitle => 'साइन इन';

  @override
  String get mobileLabel => 'मोबाइल नंबर';

  @override
  String get mobileHint => '10 अंकें दा मोबाइल नंबर';

  @override
  String get invalidMobile => 'सेही 10 अंकें दा मोबाइल नंबर पाओ।';

  @override
  String get sendOtp => 'OTP भेजो';

  @override
  String otpSentTo(String phone) {
    return 'असें $phone पर 6 अंकें दा कोड भेजेआ ऐ।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'पुश्टी करो';

  @override
  String get demoOtp => 'डेमो कोड: 123456';

  @override
  String get wrongOtp => 'कोड गलत ऐ। फ्ही कोशश करो।';

  @override
  String get deviceBound =>
      'एह फोन हुन तुंदे खाते कन्नै जुड़ी गेआ ऐ। दूए फोन पर साइन इन आस्तै नमां OTP लगग।';

  @override
  String get consentTitle => 'तुंदी सैह्‌मती';

  @override
  String get consentIntro =>
      'अस तुंदा डेटा सिर्फ इस लोन दे फैसले ते प्रबंध आस्तै बरतने आं। तुस कदें बी सैह्‌मती वापस लेई सकदे ओ।';

  @override
  String get consentBureauTitle => 'क्रेडिट रिपोर्ट';

  @override
  String get consentBureauBody =>
      'क्रेडिट ब्यूरो (CIBIL, Experian, Equifax जां CRIF) थमां तुंदा क्रेडिट इतिहास दिक्खेआ जाग। इस कन्नै तुंदा स्कोर घट्ट नेईं होंदा।';

  @override
  String get consentAaTitle => 'अकाउंट एग्रीगेटर राहें बैंक स्टेटमेंट';

  @override
  String get consentAaBody =>
      'RBI लाइसेंसशुदा अकाउंट एग्रीगेटर राहें तुंदे बैंक थमां 12 म्हीनें दी स्टेटमेंट लैती जाग। बेनती तुस अपनी AA ऐप च मंजूर करदे ओ।';

  @override
  String get consentKycTitle => 'आधार eKYC ते PAN';

  @override
  String get consentKycBody =>
      'UIDAI ते आयकर विभाग कन्नै तुंदी पन्छान दी पुश्टी होग। अस सिर्फ लुकाए दा आधार नंबर रखने आं।';

  @override
  String get consentPrivacyTitle => 'गोपनीयता सूचना (DPDP एक्ट 2023)';

  @override
  String get consentPrivacyBody =>
      'अस के इकट्ठा करने आं: पन्छान, आमदन, बैंक ते जायदाद दा ब्यौरा। कीऽ: तुंदे लोन दे फैसले ते प्रबंध आस्तै। कदूं तगर: जिन्ना कनून आखै। तुंदे हक: अपना डेटा दिक्खना, ठीक करना जां मटाना, ते साढ़े शकायत अधिकारी जां डेटा सुरक्षा बोर्ड कोल शकायत करना।';

  @override
  String get consentRequired => 'जरूरी';

  @override
  String get consentNeeded => 'अग्गें बधने आस्तै सारें पर सैह्‌मती देओ।';

  @override
  String get agreeAndContinue => 'सैह्‌मती देइयै अग्गें बधो';

  @override
  String get detailsTitle => 'तुंदा ब्यौरा';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'सेही PAN पाओ, जि\'यां ABCDE1234F।';

  @override
  String get fetchDetails => 'मेरा ब्यौरा लेई आओ';

  @override
  String get fetchedFrom =>
      'PAN, आधार eKYC ते बैंक स्टेटमेंट थमां भरेआ गेआ। ठीक करने आस्तै अंक पर टैप करो।';

  @override
  String get nameLabel => 'नां';

  @override
  String get dobLabel => 'जन्म तरीक';

  @override
  String get employmentLabel => 'कम्म';

  @override
  String get salaried => 'नौकरीपेशा';

  @override
  String get selfEmployed => 'अपना रोजगार';

  @override
  String get incomeLabel => 'म्हीनेवार शुद्ध आमदन';

  @override
  String get existingEmiLabel => 'मजूदा म्हीनेवार EMI';

  @override
  String get propertyValueLabel => 'जायदाद दी कीमत';

  @override
  String get loanAmountLabel => 'लोन दी रकम';

  @override
  String get tenureLabel => 'मुद्दत';

  @override
  String yearsLabel(String n) {
    return '$n साल';
  }

  @override
  String get eligibleTitle => 'तुस बद्ध शा बद्ध लेई सकदे ओ';

  @override
  String emiPerMonth(String amount) {
    return 'म्हीनेवार EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'सलाना $rate%, बदलदी दर (मसाल)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'आमदन दी हद: तुंदियां सारियां EMI मिलियै आमदन दे $pct तगर होई सकदियां न।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'जायदाद दी हद: इन्ना लोन कीमत दे $pct तगर होई सकदा ऐ।';
  }

  @override
  String get limitedByAsked => 'एह तुंदी मंगी दी रकम ऐ।';

  @override
  String get eligibilityNote =>
      'तुंदे ब्यौरे दी झट जांच। साढ़ी जांच परैंत पेशकश औग।';

  @override
  String get selfieTitle => 'सेल्फी लैओ';

  @override
  String get selfieBody =>
      'अस तुंदा चेहरा आधार दी फोटो कन्नै मलाने आं ते दिखने आं जे एह सच्चें तुस ओ, फोटो दी फोटो नेईं।';

  @override
  String get selfieTips => 'चंगी लोई, कैमरे पास्सै दिक्खो, टोपी जां ऐनक नेईं।';

  @override
  String get takeSelfie => 'सेल्फी लैओ';

  @override
  String get retake => 'फ्ही लैओ';

  @override
  String get checkFace => 'चेहरा मिलेआ';

  @override
  String get checkLive => 'जींदा माह्‌नू';

  @override
  String get checkMatch => 'आधार दी फोटो कन्नै मिलदा ऐ';

  @override
  String get selfieFailed =>
      'अस तुंदे चेहरे दी पुश्टी नेईं करी सके। चंगी लोई च फ्ही कोशश करो, जां वीडियो KYC कॉल बुक करो।';

  @override
  String get videoKyc => 'वीडियो KYC कॉल बुक करो';

  @override
  String get docsTitle => 'तुंदे दस्तावेज';

  @override
  String get docsBody => 'हर दस्तावेज दी साफ फोटो लैओ, जां गैलरी चा चुनो।';

  @override
  String get docPan => 'PAN कार्ड';

  @override
  String get docAadhaar => 'आधार कार्ड (लुकाए दा)';

  @override
  String get docSalarySlip => 'ताजा तनखाह पर्ची';

  @override
  String get docForm16 => 'फॉर्म 16';

  @override
  String get docItr => 'आयकर रिटर्न (ITR)';

  @override
  String get docGst => 'GST सर्टिफिकेट';

  @override
  String get docBankStatement => 'बैंक स्टेटमेंट';

  @override
  String get bankViaAa => 'तुंदे अकाउंट एग्रीगेटर राहें लैता गेआ';

  @override
  String get camera => 'कैमरा';

  @override
  String get gallery => 'गैलरी';

  @override
  String get checking => 'जांच होआ करदी ऐ…';

  @override
  String get tooBlurry => 'बड़ा धुंधला। फोन टिकाइयै फ्ही कोशश करो।';

  @override
  String get tooMuchGlare => 'बड़ी चमक। लोई थमां हटियै फ्ही कोशश करो।';

  @override
  String get tooDark => 'बड़ा न्हेरा। बद्ध लोई च फ्ही कोशश करो।';

  @override
  String docAccepted(String type) {
    return 'पन्छानेआ गेआ: $type';
  }

  @override
  String docWrong(String expected) {
    return 'एह $expected नेईं लगदा। जांचियै सेही दस्तावेज अपलोड करो।';
  }

  @override
  String get docUnreadable =>
      'अस एह दस्तावेज नेईं पढ़ी सके। होर साफ फोटो लैओ, जां असल PDF अपलोड करो।';

  @override
  String docsMissing(String n) {
    return 'हल्लें $n चाहिदे';
  }

  @override
  String get getOffer => 'मेरी सिद्धांती पेशकश दस्सो';

  @override
  String get approvedInPrinciple => 'सिद्धांती तौरा पर मंजूर';

  @override
  String get sanctioned => 'लोन मंजूर';

  @override
  String get referredTitle => 'असेंगी किश होर समां चाहिदा ऐ';

  @override
  String get rejectedTitle => 'अस हुन एह लोन नेईं देई सकदे';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years साल · सलाना $rate% बदलदी दर';
  }

  @override
  String get whyOffer => 'तुसेंगी एह पेशकश कीऽ मिली';

  @override
  String get whyReferred => 'अग्गें के होग';

  @override
  String get whyRejected => 'असें एह फैसला कीऽ कीता';

  @override
  String get referBody =>
      'इक अधिकारी इक कम्मकाजी दिन च तुंदी अर्जी दिक्खग। हुन तुसेंगी किश करने दी लोड़ नेईं।';

  @override
  String get rejectBody =>
      'तुस कदें बी कुसै माह्‌नू गी इस फैसले दी समीक्षा आस्तै आखी सकदे ओ।';

  @override
  String get addProperty => 'जायदाद दा ब्यौरा जोड़ो';

  @override
  String get viewKfs => 'मुक्ख तथ्य ब्यान दिक्खो';

  @override
  String get grievance => 'समीक्षा मंगो जां शकायत करो';

  @override
  String officerLine(String name, String email) {
    return 'शकायत अधिकारी: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'अर्जी $id';
  }

  @override
  String get startOver => 'नमीं अर्जी शुरू करो';

  @override
  String okScore(String score) {
    return 'भुगतान दा पक्का इतिहास (स्कोर $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI आमदन दा $pct न; साढ़ी हद $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'लोन जायदाद दी कीमत दा $pct ऐ; हद $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'जायदाद दा साढ़ा मुल्लांकन: $low थमां $high';
  }

  @override
  String get okTitle => 'जायदाद दी मलकीयत ते कागज जांचे गे';

  @override
  String get reasonKyc01 =>
      'फोटो थमां तुंदी पन्छान दी पुश्टी नेईं होई सकी। मेहरबानी करियै इक निक्की वीडियो KYC कॉल पूरी करो।';

  @override
  String get reasonFrd02 =>
      'तनखाह पर्ची दी आमदन बैंक च जमा रकम कन्नै नेईं मिलदी। अपना ताजा फॉर्म 16 देओ, जां सैह्‌मती देइयै असेंगी लैन देओ।';

  @override
  String get reasonFrd03 =>
      'तुंदा इक दस्तावेज जारी करने आह्‌ली अथॉरिटी दी पुश्टी च फेल होई गेआ।';

  @override
  String get reasonPol01 => 'अर्जीदार दी उमर घट्टो-घट्ट 21 साल होनी चाहिदी।';

  @override
  String get reasonPol02 =>
      'लोन साढ़ी मंजूर बद्ध शा बद्ध उमर थमां अग्गें चली जाग। घट्ट उमर दा सह-अर्जीदार जोड़ने कन्नै मदद मिली सकदी ऐ।';

  @override
  String get reasonBur01 =>
      'तुंदा क्रेडिट स्कोर साढ़े घट्टो-घट्ट 650 थमां घट्ट ऐ।';

  @override
  String get reasonBur04 =>
      'तुंदा हल्लें क्रेडिट इतिहास नेईं ऐ, इस करी इक अधिकारी तुंदे बैंक रिकॉर्ड दिक्खग।';

  @override
  String get reasonBur05 =>
      'तुंदे क्रेडिट स्कोर गी अधिकारी आसेआ ध्यान कन्नै दिक्खने दी लोड़ ऐ।';

  @override
  String get reasonPrp01 =>
      'साढ़े वकील गी जायदाद दी मलकीयत दी समीक्षा करनी पौग।';

  @override
  String get reasonPrp03 =>
      'कीमत दी पुश्टी आस्तै साढ़े मुल्लांकनकार गी जायदाद दिक्खनी पौग।';

  @override
  String get reasonPrp04 =>
      'समझौते दी कीमत इस जायदाद दे सरकारी सर्कल रेट थमां घट्ट ऐ। मेहरबानी करियै बिक्री समझौता जांचो।';

  @override
  String get reasonAff01 =>
      'तुंदियां मजूदा EMI पैह्‌लें गै आमदन दा बद्ध शा बद्ध हिस्सा लैआ करदियां न।';

  @override
  String get reasonAut01 =>
      'इन्ने बड्डे लोन दी अखीरी जांच इक सीनियर अधिकारी करदा ऐ।';

  @override
  String get reasonRsk01 =>
      'पेशकश पक्की करने आस्तै इक अधिकारी तुंदी अर्जी दिक्खग।';

  @override
  String get reasonRsk02 =>
      'तुंदे क्रेडिट प्रोफाइल दे अधार पर अस हुन एह लोन नेईं देई सकदे।';

  @override
  String get propertyTitle => 'तुंदी जायदाद';

  @override
  String get cityLabel => 'शैह्‌र';

  @override
  String get localityLabel => 'इलाका';

  @override
  String get societyLabel => 'प्रोजेक्ट जां सोसाइटी (जेकर होऐ)';

  @override
  String get areaLabel => 'रकबा (वर्ग फुट)';

  @override
  String get bhkLabel => 'सौने दे कमरे';

  @override
  String get newProperty => 'नमीं';

  @override
  String get resale => 'रीसेल';

  @override
  String get declaredPriceLabel => 'समझौते दी कीमत';

  @override
  String get photosTitle => 'जायदाद दियां फोटोआं';

  @override
  String get photosBody =>
      'जायदाद पर जाइयै फोटोआं लैओ। अस थाह्‌र ते समां जोड़ने आं, तां जे मुल्लांकनकार दौरे दी योजना बनाई सकै।';

  @override
  String get photoFront => 'सामने';

  @override
  String get photoInside => 'अंदर';

  @override
  String get photoView => 'जायदाद थमां नजारा';

  @override
  String geoTagged(String lat, String lng) {
    return 'थाह्‌र जोड़ेआ गेआ ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'थाह्‌र दे बगैर फोटो सांभी गेई। जियो-टैग आस्तै लोकेशन चालू करो।';

  @override
  String get submitProperty => 'अखीरी मंजूरी लैओ';

  @override
  String get fillAll => 'मेहरबानी करियै हर खाना भरो।';

  @override
  String get kfsTitle => 'मुक्ख तथ्य ब्यान';

  @override
  String get kfsLoan => 'लोन दी रकम';

  @override
  String get kfsTenure => 'मुद्दत';

  @override
  String get kfsRate => 'ब्याज दर';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI दी गिनतरी';

  @override
  String get kfsFee => 'प्रोसेसिंग फीस (GST समेत)';

  @override
  String get kfsTotalInterest => 'कुल ब्याज';

  @override
  String get kfsTotalPayable => 'कुल देनी आह्‌ली रकम';

  @override
  String get kfsApr => 'सलाना प्रतिशत दर (APR)';

  @override
  String get kfsCoolingOff =>
      'कूलिंग-ऑफ मुद्दत: दस्तखत दे 3 दिनें दे अंदर सिर्फ मूल रकम ते उनें दिनें दा ब्याज मोड़ियै बगैर जुर्माने निकली सकदे ओ।';

  @override
  String get kfsNote =>
      'डेमो आस्तै नमूना अंक। तुंदा असल KFS मंजूरी पत्तर कन्नै औग।';

  @override
  String get useSample => 'नमूना';

  @override
  String get videoKycDemo =>
      'डेमो: इस कन्नै इक अधिकारी कन्नै वीडियो KYC कॉल बुक होंदी।';

  @override
  String get raiseComplaint => 'शकायत करो';

  @override
  String complaintSent(String ref) {
    return 'तुंदी शकायत दर्ज होई गेई। हवाला $ref।';
  }

  @override
  String get stageSignIn => 'साइन इन';

  @override
  String get stageDetails => 'ब्यौरा';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'पेशकश';

  @override
  String get stageProperty => 'जायदाद';

  @override
  String get homeSubtitle => 'होम लोन · जायदाद पर लोन';

  @override
  String get heroPill => 'मिंटें च फैसला';

  @override
  String heroFacts(String rate, String years) {
    return 'सलाना $rate% थमां · $years साल तगर';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% पूरा · जित्थें छोड़ेआ हा उत्थुआं शुरू करो';
  }

  @override
  String get resume => 'जारी रक्खो';

  @override
  String get calculators => 'कैलकुलेटर';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'म्हीनेवार किश्त';

  @override
  String get calcEligibility => 'जोग्यता';

  @override
  String get calcEligibilitySub => 'तुस कि\'न्ना लेई सकदे ओ';

  @override
  String get emiCalcTitle => 'EMI कैलकुलेटर';

  @override
  String get eligibilityCalcTitle => 'जोग्यता कैलकुलेटर';

  @override
  String totalInterest(String amount) {
    return 'कुल ब्याज $amount';
  }

  @override
  String get calcIncomeOnly =>
      'सिर्फ आमदन दे अधार पर। जायदाद दी कीमत इसगी घट्ट करी सकदी ऐ।';

  @override
  String get verified => 'पुश्टी होई';

  @override
  String get yourLoan => 'तुंदा लोन';

  @override
  String docsProgress(String done, String total) {
    return '$total चा $done दी पुश्टी होई';
  }

  @override
  String get docNeeded => 'चाहिदा';

  @override
  String get docTryAgain => 'फ्ही कोशश';

  @override
  String get fetched => 'लैता गेआ';

  @override
  String get statusApproved => 'मंजूर';

  @override
  String get statusSanctioned => 'मंजूरशुदा';

  @override
  String get statusInReview => 'समीक्षा च';

  @override
  String get statusDeclined => 'नामंजूर';

  @override
  String get trackTitle => 'अपनी अर्जी ट्रैक करो';

  @override
  String get tlSubmitted => 'अर्जी जमा होई';

  @override
  String get tlVerified => 'KYC ते दस्तावेजें दी पुश्टी होई';

  @override
  String get tlInPrinciple => 'सिद्धांती मंजूरी';

  @override
  String get tlProperty => 'जायदाद दा ब्यौरा ते मुल्लांकन';

  @override
  String get tlPropertyNext => 'अपनी जायदाद दा ब्यौरा ते फोटोआं जोड़ो';

  @override
  String get tlOfficer => 'अधिकारी दी समीक्षा';

  @override
  String get tlOfficerNext => 'इक कम्मकाजी दिन च';

  @override
  String get tlLegal => 'कनूनी ते मलकीयत जांच';

  @override
  String get tlSanction => 'अखीरी मंजूरी ते ई-दस्तखत';

  @override
  String get tlSanctionNext => 'मंजूरी पत्तर पर ऑनलाइन दस्तखत करो';

  @override
  String get tlDisbursement => 'रकम जारी';

  @override
  String get helpTitle => 'मदद चाहिदी ऐ?';

  @override
  String get propertyType => 'नमीं जां रीसेल';

  @override
  String get greetMorning => 'शुभ सवेर';

  @override
  String get greetAfternoon => 'शुभ दपैह्‌र';

  @override
  String get greetEvening => 'शुभ संझ';

  @override
  String nearlyThere(String name) {
    return '$name, तुस लगभग पुज्जी गे ओ';
  }

  @override
  String get chooseLanguage => 'अपनी भाशा चुनो';

  @override
  String get languageNote => 'तुस इसगी कदें बी बदली सकदे ओ।';

  @override
  String get liveChecks => 'लाइव जांच';

  @override
  String get checkBureau => 'क्रेडिट ब्यूरो';

  @override
  String checkScore(String score) {
    return 'स्कोर $score';
  }

  @override
  String get checkNoHistory => 'हल्लें कोई इतिहास नेईं';

  @override
  String get checkBank => 'AA राहें बैंक';

  @override
  String get checkBankRead => '12 म्हीने पढ़े गे';

  @override
  String get checkKyc => 'eKYC ते सेल्फी';

  @override
  String get checkPending => 'बाकी';

  @override
  String get checkDocs => 'दस्तावेज';

  @override
  String countOf(String done, String total) {
    return '$total चा $done';
  }

  @override
  String minutesLeft(String n) {
    return 'लगभग $n मिंट बाकी';
  }

  @override
  String ratePa(String rate) {
    return 'सलाना $rate%';
  }

  @override
  String get continueApplication => 'अपनी अर्जी जारी रक्खो';

  @override
  String get shapeOffer => 'अपनी पेशकश तैऽ करो';

  @override
  String get shapeOfferSub => 'सिद्धांती तौरा पर मंजूर · बदलने आस्तै खिच्चो';

  @override
  String get withinLimits => 'तुंदी हद दे अंदर';

  @override
  String get aboveLimits => 'हद थमां बद्ध: रकम घटाओ जां साल बधाओ';

  @override
  String mostYouCan(String amount) {
    return 'बद्ध शा बद्ध लेई सकदे ओ: $amount';
  }

  @override
  String get useMax => 'पूरा लैओ';

  @override
  String get principal => 'मूल रकम';

  @override
  String get interest => 'ब्याज';

  @override
  String get totalRepaid => 'कुल भुगतान';

  @override
  String get emiShareIncome => 'आमदन च EMI दा हिस्सा';

  @override
  String loanShareProperty(String value) {
    return '$value दी जायदाद च लोन दा हिस्सा';
  }

  @override
  String get lockOffer => 'एह पेशकश पक्की करो';

  @override
  String get offerLocked => 'तुंदी पेशकश पक्की होई गेई।';

  @override
  String approvedUpTo(String amount) {
    return '$amount तगर मंजूर';
  }

  @override
  String readingDoc(String doc) {
    return 'तुंदा $doc पढ़ेआ जा करदा ऐ';
  }

  @override
  String get documentAi => 'दस्तावेज AI';

  @override
  String sure(String pct) {
    return '$pct% पक्का';
  }

  @override
  String get readMatches => 'एह उऐ दस्तावेज ऐ जेह्‌ड़ा असें मंगेआ हा';

  @override
  String get readClear => 'साफ फोटो, धुंधलापन जां चमक नेईं';

  @override
  String get whatWeRead => 'असें के पढ़ेआ';

  @override
  String get looksRight => 'ठीक ऐ';

  @override
  String get fieldName => 'नां';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'आधार';

  @override
  String get fieldEmployer => 'मालक';

  @override
  String get fieldNetPay => 'शुद्ध तनखाह';

  @override
  String get fieldPeriod => 'तनखाह दी मुद्दत';

  @override
  String get fieldYear => 'साल';

  @override
  String get fieldIncome => 'आमदन';

  @override
  String get fieldBusiness => 'कारोबार';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'तुंदे लोन आस्तै जरूरी';

  @override
  String get consentSectionOptional =>
      'वैकल्पिक: जदूं तगर तुस चालू नेईं करदे, बंद';

  @override
  String get advancedOptions => 'विकल्प';

  @override
  String consentValidUntil(String given, String until) {
    return '$given गी दित्ती · $until तगर मान्य';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given गी दित्ती · वापस लैने तगर';
  }

  @override
  String get recheckTitle => 'रकम देने थमां ठीक पैह्‌लें इक होर जांच';

  @override
  String get recheckBody =>
      'रकम देने थमां ठीक पैह्‌लें अस तुंदी क्रेडिट रिपोर्ट फ्ही दिखने आं। ना आखने पर अधिकारी उसलै पुच्छी सकदा ऐ।';

  @override
  String get aaMonthsLabel => 'कि\'न्ने म्हीनें दी स्टेटमेंट देनी ऐ';

  @override
  String monthsN(String n) {
    return '$n म्हीने';
  }

  @override
  String get aaAccountsLabel => 'देने आह्‌ले खाते';

  @override
  String get accountSavingsSalary => 'बचत खाता ·· 0912 · तनखाह जमा';

  @override
  String get accountSavings => 'बचत खाता ·· 4821';

  @override
  String get accountFd => 'फिक्स्ड डिपॉजिट ·· 3307';

  @override
  String get aaAccountNeeded => 'घट्टो-घट्ट इक खाता चुनो।';

  @override
  String get kycMethodLabel => 'अपनी पन्छान कि\'यां पक्की करो';

  @override
  String get kycAadhaarOtp => 'आधार OTP';

  @override
  String get kycDigilocker => 'डिजीलॉकर';

  @override
  String get kycVideo => 'वीडियो KYC कॉल';

  @override
  String get useCkycTitle => 'मेरा मजूदा CKYC रिकॉर्ड बरतो';

  @override
  String get useCkycBody =>
      'जेकर तुसें कुसै होर बैंक जां फंड कन्नै KYC कीते दा ऐ, तां फ्ही पुच्छने दी थाह्‌र अस ओह्‌ रिकॉर्ड लेई लैने आं।';

  @override
  String get optOffersTitle => 'पेशकशां ते नमें प्रोडक्ट';

  @override
  String get optOffersBody =>
      'चुनो जे पेशकशें बारै कि\'यां जानना चांह्‌दे ओ। इनेंगी कदें बी बंद करी सकदे ओ।';

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
      'SMS दे कन्नै WhatsApp पर स्टेटस अपडेट ते EMI याद।';

  @override
  String get optInsuranceTitle => 'होम लोन सुरक्षा कोटेशन';

  @override
  String get optInsuranceBody =>
      'कोटेशन आस्तै अपना नां, उमर ते लोन दी रकम साढ़े बीमा साथी गी देओ। खरीदना कदें बी जरूरी नेईं।';

  @override
  String get getQuote => 'कोटेशन लैओ';

  @override
  String get manageConsents => 'सैह्‌मतियां संभालो';

  @override
  String get manageConsentsBody =>
      'वैकल्पिक सैह्‌मतियां कदें बी बंद करो। जरूरी सैह्‌मती वापस लैने पर अर्जी रुकी जंदी ऐ, ते उसदे आस्तै लैता डेटा अस मटाई दिंदे आं।';

  @override
  String get withdraw => 'वापस लैओ';

  @override
  String get consentHistory => 'सैह्‌मती दा इतिहास';

  @override
  String historyGiven(String item) {
    return '$item दित्ती';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item वापस लैती';
  }

  @override
  String get historyEmpty => 'हल्लें किश नेईं।';

  @override
  String get consentOn => 'चालू';

  @override
  String get consentOff => 'बंद';

  @override
  String get withdrawnRequired =>
      'तुसें इक जरूरी सैह्‌मती वापस लैती, इस करी अर्जी रुकी दी ऐ।';

  @override
  String get checkMatchPending =>
      'फोटो मलान: आधार जां पैन कार्ड अपलोड करने पर होग';

  @override
  String get realDetailsIntro =>
      'अपने बारे च दस्सो। अस हर जानकारी तुंदे कागजें कन्नै जांचने आं।';

  @override
  String get fullNameLabel => 'पूरा नां (जि\'यां पैन कार्ड पर ऐ)';

  @override
  String get emailLabel => 'ईमेल';

  @override
  String get employerLabel => 'नियोक्ता जां कारोबार दा नां';

  @override
  String get creditScoreLabel => 'क्रेडिट स्कोर (मर्जी मताबक)';

  @override
  String get creditScoreHint =>
      'तुंदी CIBIL जां Experian रिपोर्ट थमां, जेकर पता होऐ';

  @override
  String get addressLabel => 'पता';

  @override
  String get saveDetails => 'मेरी जानकारी सांभो';

  @override
  String get selfDeclaredNote =>
      'एह जानकारी तुसें भरी ऐ। अग्गें जेह्ड़े कागज अपलोड करगे, उंदे कन्नै अस इसगी जांचगे।';

  @override
  String get pickDob => 'अपनी जनम तरीक चुनो';

  @override
  String get fillDetails =>
      'किरपा करियै नां, जनम तरीक, कम्म, नियोक्ता ते आमदनी भरो।';

  @override
  String get docSaleDeed => 'बिक्री दा कागज जां अलॉटमेंट पत्तर';

  @override
  String get saleDeedBody =>
      'रजिस्टर बिक्री कागज दी फोटो जां PDF अपलोड करो (जिस सफे पर जायदाद ते खरीददार होऐ)। मालकी जांचने आस्तै अस इसगी पढ़दे आं।';

  @override
  String get statusPending => 'समीक्षा बाकी ऐ';

  @override
  String decisionRef(String ref) {
    return 'फैसले दा रिकार्ड $ref';
  }

  @override
  String get scoreTitle => 'असें तुंदा स्कोर कियां कड्डेआ';

  @override
  String get scoreOutOf => '900 चा';

  @override
  String gradeLabel(String grade) {
    return 'ग्रेड $grade';
  }

  @override
  String scoreStart(String base) {
    return 'हर कोई $base अंकें थमां शुरू करदा ऐ। हेठ हर लाइन अंक जोड़दी जां घटांदी ऐ।';
  }

  @override
  String get scoreNote =>
      'एह फैसले दा क्रेडिट स्कोर आह्‌ला हिस्सा ऐ। तुंदी आमदन, पन्छान, दस्तावेज ते जायदाद बी जांची जंदी ऐ।';

  @override
  String get factorBureau => 'क्रेडिट ब्यूरो स्कोर';

  @override
  String get factorHistory => 'क्रेडिट इतिहास दे ब’रे';

  @override
  String get factorLtv => 'जायदाद दी कीमत दे मकाबले लोन दा हिस्सा';

  @override
  String get factorLoanAmount => 'लोन दी रकम';

  @override
  String get factorMissing => 'उपलब्ध नेईं';

  @override
  String rangeBelow(String x) {
    return '$x शा घट्ट';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$a थमां $b';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x जां मता';
  }

  @override
  String get viewLetter => 'फैसले दी चिट्ठी';

  @override
  String get letterTitle => 'तुंदी फैसले दी चिट्ठी';

  @override
  String get letterPartlyEnglish =>
      'किश लाइनें दा अनुवाद नेईं होई सकेआ, इस करी ओह् अंग्रेजी च न।';

  @override
  String get copyText => 'लिखत कापी करो';

  @override
  String get copied => 'कापी होई गेआ';

  @override
  String get askTitle => 'सुआल पुच्छो';

  @override
  String get askHint => 'जियां: अग्गें केह् होग?';

  @override
  String get askSend => 'भेजो';

  @override
  String get askHuman =>
      'साढ़ी टीम दा कोई माह्‌नू इस बारै तुंदे कन्नै राब्ता करग।';

  @override
  String get uploadPdf => 'PDF अपलोड करो';

  @override
  String get kfsFeeBase => 'प्रोसेसिंग फीस (0.5%)';

  @override
  String get kfsGst => 'फीस पर GST (18%)';

  @override
  String get kfsNoteEngine =>
      'एह इस पेशकश आस्तै कड्डेआ गेदा ऐ। दस्तखत कीते दा मुक्ख तथ्य ब्यान तुंदी मंजूरी चिट्ठी कन्नै औग।';

  @override
  String otpOnServer(String phone) {
    return 'एह टेस्ट सर्वर SMS नेईं भेजदा। $phone दा 6 अंकें दा कोड कंप्यूटर दी सर्वर विंडो च दिक्खदा ऐ।';
  }

  @override
  String get resendOtp => 'नमां कोड भेजो';

  @override
  String get newOtpSent => 'नमां कोड भेजी दित्ता।';

  @override
  String get otpExpired => 'इस कोड दी मियाद मुक्की गेई। नमां कोड भेजो दबाओ।';

  @override
  String get otpTooManyTries => 'मते बारी गलत कोड। नमां कोड भेजो दबाओ।';

  @override
  String get otpTooManySends => 'मते कोड मंगे गे। 15 मिंट रुकियै फी कोशश करो।';
}
