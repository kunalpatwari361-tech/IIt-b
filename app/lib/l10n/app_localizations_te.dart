// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appTitle => 'నిర్ణయ్';

  @override
  String get sandboxBanner => 'డెమో మోడ్: నమూనా సమాచారం, నిజమైన తనిఖీలు కావు';

  @override
  String get continueLabel => 'కొనసాగించండి';

  @override
  String stepOf(String step, String total) {
    return 'దశ $step / $total';
  }

  @override
  String get pleaseWait => 'దయచేసి వేచి ఉండండి…';

  @override
  String get errorGeneric => 'ఏదో తప్పు జరిగింది. మళ్ళీ ప్రయత్నించండి.';

  @override
  String get close => 'మూసివేయండి';

  @override
  String get welcomeHeadline => 'కొన్ని నిమిషాల్లో మీ హోమ్ లోన్ నిర్ణయం';

  @override
  String get welcomeBody =>
      'హోమ్ లోన్ లేదా ఆస్తిపై లోన్ కోసం దరఖాస్తు చేయండి. మేము అన్నీ ఆన్‌లైన్‌లో తనిఖీ చేస్తాము, నిర్ణయానికి కారణం ఎప్పుడూ చెబుతాము.';

  @override
  String get chooseProduct => 'మీకు ఏమి కావాలి?';

  @override
  String get productHomeLoan => 'హోమ్ లోన్';

  @override
  String get productHomeLoanSub => 'ఇల్లు కొనడం, కట్టడం లేదా మెరుగుపరచడం';

  @override
  String get productLap => 'ఆస్తిపై లోన్';

  @override
  String get productLapSub => 'మీ సొంత ఆస్తిపై రుణం తీసుకోండి';

  @override
  String get startApplication => 'దరఖాస్తు ప్రారంభించండి';

  @override
  String get demoCustomers => 'డెమో కస్టమర్లు';

  @override
  String get demoCustomersBody =>
      'నమూనా మొబైల్ నంబర్ నింపడానికి ఒకదానిపై నొక్కండి.';

  @override
  String get personaRavi => 'రవి, 32, ఉద్యోగి, ఫ్లాట్ కొంటున్నారు';

  @override
  String get personaMeena => 'మీనా, 45, బట్టల దుకాణం నడుపుతున్నారు (LAP)';

  @override
  String get personaArjun => 'అర్జున్, 29, ఉద్యోగి, మార్చిన జీతం స్లిప్';

  @override
  String get signInTitle => 'సైన్ ఇన్';

  @override
  String get mobileLabel => 'మొబైల్ నంబర్';

  @override
  String get mobileHint => '10 అంకెల మొబైల్ నంబర్';

  @override
  String get invalidMobile => 'సరైన 10 అంకెల మొబైల్ నంబర్ ఇవ్వండి.';

  @override
  String get sendOtp => 'OTP పంపండి';

  @override
  String otpSentTo(String phone) {
    return '$phone కి 6 అంకెల కోడ్ పంపాము.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'ధృవీకరించండి';

  @override
  String get demoOtp => 'డెమో కోడ్: 123456';

  @override
  String get wrongOtp => 'కోడ్ తప్పు. మళ్ళీ ప్రయత్నించండి.';

  @override
  String get deviceBound =>
      'ఈ ఫోన్ ఇప్పుడు మీ ఖాతాతో లింక్ అయింది. మరో ఫోన్‌లో సైన్ ఇన్ చేయడానికి కొత్త OTP కావాలి.';

  @override
  String get consentTitle => 'మీ సమ్మతి';

  @override
  String get consentIntro =>
      'మీ సమాచారాన్ని ఈ లోన్ నిర్ణయం, నిర్వహణ కోసం మాత్రమే వాడతాము. మీరు ఎప్పుడైనా సమ్మతిని వెనక్కి తీసుకోవచ్చు.';

  @override
  String get consentBureauTitle => 'క్రెడిట్ రిపోర్ట్';

  @override
  String get consentBureauBody =>
      'క్రెడిట్ బ్యూరో (CIBIL, Experian, Equifax లేదా CRIF) నుండి మీ క్రెడిట్ చరిత్రను చూస్తాము. దీనివల్ల మీ స్కోర్ తగ్గదు.';

  @override
  String get consentAaTitle =>
      'అకౌంట్ అగ్రిగేటర్ ద్వారా బ్యాంక్ స్టేట్‌మెంట్లు';

  @override
  String get consentAaBody =>
      'RBI లైసెన్స్ పొందిన అకౌంట్ అగ్రిగేటర్ ద్వారా మీ బ్యాంక్ నుండి 12 నెలల స్టేట్‌మెంట్లు తెస్తాము. అభ్యర్థనను మీరు మీ AA యాప్‌లో ఆమోదిస్తారు.';

  @override
  String get consentKycTitle => 'ఆధార్ eKYC మరియు PAN';

  @override
  String get consentKycBody =>
      'UIDAI మరియు ఆదాయపు పన్ను శాఖతో మీ గుర్తింపును నిర్ధారిస్తాము. మేము దాచిన ఆధార్ నంబర్ మాత్రమే ఉంచుతాము.';

  @override
  String get consentPrivacyTitle => 'గోప్యతా నోటీసు (DPDP చట్టం 2023)';

  @override
  String get consentPrivacyBody =>
      'ఏమి సేకరిస్తాము: గుర్తింపు, ఆదాయం, బ్యాంక్ మరియు ఆస్తి వివరాలు. ఎందుకు: మీ లోన్ నిర్ణయం, నిర్వహణ కోసం. ఎంతకాలం: చట్టం కోరినంత కాలం మాత్రమే. మీ హక్కులు: మీ సమాచారాన్ని చూడటం, సరిచేయడం లేదా తొలగించడం, మా ఫిర్యాదుల అధికారి లేదా డేటా రక్షణ బోర్డుకు ఫిర్యాదు చేయడం.';

  @override
  String get consentRequired => 'తప్పనిసరి';

  @override
  String get consentNeeded => 'కొనసాగడానికి అన్నింటికీ అంగీకరించండి.';

  @override
  String get agreeAndContinue => 'అంగీకరించి కొనసాగించండి';

  @override
  String get detailsTitle => 'మీ వివరాలు';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'సరైన PAN ఇవ్వండి, ఉదా. ABCDE1234F.';

  @override
  String get fetchDetails => 'నా వివరాలు తీసుకురండి';

  @override
  String get fetchedFrom =>
      'PAN, ఆధార్ eKYC మరియు మీ బ్యాంక్ స్టేట్‌మెంట్ల నుండి నింపబడింది. సరిచేయడానికి అంకెపై నొక్కండి.';

  @override
  String get nameLabel => 'పేరు';

  @override
  String get dobLabel => 'పుట్టిన తేదీ';

  @override
  String get employmentLabel => 'పని';

  @override
  String get salaried => 'ఉద్యోగి';

  @override
  String get selfEmployed => 'స్వయం ఉపాధి';

  @override
  String get incomeLabel => 'నెలవారీ నికర ఆదాయం';

  @override
  String get existingEmiLabel => 'ప్రస్తుత నెలవారీ EMIలు';

  @override
  String get propertyValueLabel => 'ఆస్తి విలువ';

  @override
  String get loanAmountLabel => 'లోన్ మొత్తం';

  @override
  String get tenureLabel => 'కాలవ్యవధి';

  @override
  String yearsLabel(String n) {
    return '$n సంవత్సరాలు';
  }

  @override
  String get eligibleTitle => 'మీకు గరిష్ఠంగా లభించేది';

  @override
  String emiPerMonth(String amount) {
    return 'నెలకు EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'సంవత్సరానికి $rate%, మారే వడ్డీ (ఉదాహరణ)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'ఆదాయం వల్ల పరిమితి: మీ అన్ని EMIలు కలిపి ఆదాయంలో $pct వరకు ఉండవచ్చు.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'ఆస్తి వల్ల పరిమితి: ఈ పరిమాణం లోన్ విలువలో $pct వరకు ఉండవచ్చు.';
  }

  @override
  String get limitedByAsked => 'ఇది మీరు అడిగిన మొత్తం.';

  @override
  String get eligibilityNote =>
      'మీ వివరాలపై త్వరిత తనిఖీ. మా తనిఖీల తర్వాత మీ ఆఫర్ వస్తుంది.';

  @override
  String get selfieTitle => 'సెల్ఫీ తీసుకోండి';

  @override
  String get selfieBody =>
      'మీ ముఖాన్ని ఆధార్ ఫోటోతో పోల్చి, అది నిజంగా మీరేనా, ఫోటోకి ఫోటో కాదా అని చూస్తాము.';

  @override
  String get selfieTips =>
      'మంచి వెలుతురు, కెమెరా వైపు చూడండి, టోపీ లేదా కళ్లద్దాలు వద్దు.';

  @override
  String get takeSelfie => 'సెల్ఫీ తీయండి';

  @override
  String get retake => 'మళ్ళీ తీయండి';

  @override
  String get checkFace => 'ముఖం కనిపించింది';

  @override
  String get checkLive => 'నిజమైన వ్యక్తి';

  @override
  String get checkMatch => 'ఆధార్ ఫోటోతో సరిపోలింది';

  @override
  String get selfieFailed =>
      'మీ ముఖాన్ని నిర్ధారించలేకపోయాము. మంచి వెలుతురులో మళ్ళీ ప్రయత్నించండి, లేదా వీడియో KYC కాల్ బుక్ చేయండి.';

  @override
  String get videoKyc => 'వీడియో KYC కాల్ బుక్ చేయండి';

  @override
  String get docsTitle => 'మీ పత్రాలు';

  @override
  String get docsBody =>
      'ప్రతి పత్రానికి స్పష్టమైన ఫోటో తీయండి, లేదా గ్యాలరీ నుండి ఎంచుకోండి.';

  @override
  String get docPan => 'PAN కార్డ్';

  @override
  String get docAadhaar => 'ఆధార్ కార్డ్ (దాచినది)';

  @override
  String get docSalarySlip => 'తాజా జీతం స్లిప్';

  @override
  String get docForm16 => 'ఫారం 16';

  @override
  String get docItr => 'ఆదాయపు పన్ను రిటర్న్ (ITR)';

  @override
  String get docGst => 'GST సర్టిఫికేట్';

  @override
  String get docBankStatement => 'బ్యాంక్ స్టేట్‌మెంట్';

  @override
  String get bankViaAa => 'మీ అకౌంట్ అగ్రిగేటర్ ద్వారా తెచ్చినది';

  @override
  String get camera => 'కెమెరా';

  @override
  String get gallery => 'గ్యాలరీ';

  @override
  String get checking => 'తనిఖీ చేస్తోంది…';

  @override
  String get tooBlurry =>
      'చాలా మసకగా ఉంది. ఫోన్ కదలకుండా పట్టుకుని మళ్ళీ ప్రయత్నించండి.';

  @override
  String get tooMuchGlare =>
      'చాలా మెరుపు. వెలుతురు నుండి దూరంగా జరిగి మళ్ళీ ప్రయత్నించండి.';

  @override
  String get tooDark =>
      'చాలా చీకటిగా ఉంది. ఎక్కువ వెలుతురులో మళ్ళీ ప్రయత్నించండి.';

  @override
  String docAccepted(String type) {
    return 'గుర్తించబడింది: $type';
  }

  @override
  String docWrong(String expected) {
    return 'ఇది $expected లా కనిపించడం లేదు. తనిఖీ చేసి సరైన పత్రం అప్‌లోడ్ చేయండి.';
  }

  @override
  String get docUnreadable =>
      'ఈ పత్రాన్ని చదవలేకపోయాము. స్పష్టమైన ఫోటో తీయండి, లేదా అసలు PDF అప్‌లోడ్ చేయండి.';

  @override
  String docsMissing(String n) {
    return 'ఇంకా $n కావాలి';
  }

  @override
  String get getOffer => 'నా సూత్రప్రాయ ఆఫర్ చూపండి';

  @override
  String get approvedInPrinciple => 'సూత్రప్రాయంగా ఆమోదించబడింది';

  @override
  String get sanctioned => 'లోన్ మంజూరైంది';

  @override
  String get referredTitle => 'మాకు కొంచెం ఎక్కువ సమయం కావాలి';

  @override
  String get rejectedTitle => 'ప్రస్తుతం ఈ లోన్ ఇవ్వలేము';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years సంవత్సరాలు · సంవత్సరానికి $rate% మారే వడ్డీ';
  }

  @override
  String get whyOffer => 'మీకు ఈ ఆఫర్ ఎందుకు వచ్చింది';

  @override
  String get whyReferred => 'తర్వాత ఏమి జరుగుతుంది';

  @override
  String get whyRejected => 'మేము ఇలా ఎందుకు నిర్ణయించాము';

  @override
  String get referBody =>
      'ఒక అధికారి ఒక పని దినంలో మీ దరఖాస్తును చూస్తారు. ఇప్పుడు మీరు ఏమీ చేయనక్కర్లేదు.';

  @override
  String get rejectBody =>
      'ఈ నిర్ణయాన్ని ఒక వ్యక్తి సమీక్షించాలని మీరు ఎప్పుడైనా అడగవచ్చు.';

  @override
  String get addProperty => 'ఆస్తి వివరాలు జోడించండి';

  @override
  String get viewKfs => 'ముఖ్య వాస్తవాల ప్రకటన చూడండి';

  @override
  String get grievance => 'సమీక్ష కోరండి లేదా ఫిర్యాదు చేయండి';

  @override
  String officerLine(String name, String email) {
    return 'ఫిర్యాదుల అధికారి: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'దరఖాస్తు $id';
  }

  @override
  String get startOver => 'కొత్త దరఖాస్తు ప్రారంభించండి';

  @override
  String okScore(String score) {
    return 'మంచి చెల్లింపు చరిత్ర (స్కోర్ $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMIలు ఆదాయంలో $pct; మా పరిమితి $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'లోన్ ఆస్తి విలువలో $pct; పరిమితి $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'ఆస్తికి మా విలువ: $low నుండి $high';
  }

  @override
  String get okTitle => 'ఆస్తి హక్కు పత్రాలు తనిఖీ చేయబడ్డాయి';

  @override
  String get reasonKyc01 =>
      'ఫోటో నుండి మీ గుర్తింపును నిర్ధారించలేకపోయాము. దయచేసి చిన్న వీడియో KYC కాల్ పూర్తి చేయండి.';

  @override
  String get reasonFrd02 =>
      'మీ జీతం స్లిప్‌లోని ఆదాయం బ్యాంక్ జమలతో సరిపోలడం లేదు. మీ తాజా ఫారం 16 ఇవ్వండి, లేదా సమ్మతితో మమ్మల్ని తీసుకురానివ్వండి.';

  @override
  String get reasonFrd03 =>
      'మీ పత్రాలలో ఒకటి జారీ చేసిన సంస్థ ధృవీకరణలో విఫలమైంది.';

  @override
  String get reasonPol01 => 'దరఖాస్తుదారుల వయస్సు కనీసం 21 సంవత్సరాలు ఉండాలి.';

  @override
  String get reasonPol02 =>
      'లోన్ మేము అనుమతించే గరిష్ఠ వయస్సు దాటిపోతుంది. చిన్న వయస్సు సహ-దరఖాస్తుదారుని జోడిస్తే సహాయపడవచ్చు.';

  @override
  String get reasonBur01 =>
      'మీ క్రెడిట్ స్కోర్ మా కనీస 650 కంటే తక్కువగా ఉంది.';

  @override
  String get reasonBur04 =>
      'మీకు ఇంకా క్రెడిట్ చరిత్ర లేదు, కాబట్టి ఒక అధికారి మీ బ్యాంక్ రికార్డులను చూస్తారు.';

  @override
  String get reasonBur05 =>
      'మీ క్రెడిట్ స్కోర్‌ను ఒక అధికారి జాగ్రత్తగా చూడాలి.';

  @override
  String get reasonPrp01 => 'మా న్యాయవాది ఆస్తి హక్కును సమీక్షించాలి.';

  @override
  String get reasonPrp03 =>
      'విలువను నిర్ధారించడానికి మా విలువకర్త ఆస్తిని సందర్శించాలి.';

  @override
  String get reasonPrp04 =>
      'ఒప్పంద విలువ ఈ ఆస్తికి ప్రభుత్వ సర్కిల్ రేటు కంటే తక్కువగా ఉంది. దయచేసి అమ్మకపు ఒప్పందాన్ని తనిఖీ చేయండి.';

  @override
  String get reasonAff01 =>
      'మీ ప్రస్తుత EMIలు ఇప్పటికే మేము అనుమతించే గరిష్ఠ ఆదాయ భాగాన్ని వాడుతున్నాయి.';

  @override
  String get reasonAut01 =>
      'ఈ పరిమాణం లోన్లను ఒక సీనియర్ అధికారి చివరిగా తనిఖీ చేస్తారు.';

  @override
  String get reasonRsk01 =>
      'ఆఫర్‌ను ఖరారు చేయడానికి ఒక అధికారి మీ దరఖాస్తును చూస్తారు.';

  @override
  String get reasonRsk02 =>
      'మీ క్రెడిట్ ప్రొఫైల్ ఆధారంగా, ప్రస్తుతం ఈ లోన్ ఇవ్వలేము.';

  @override
  String get propertyTitle => 'మీ ఆస్తి';

  @override
  String get cityLabel => 'నగరం';

  @override
  String get localityLabel => 'ప్రాంతం';

  @override
  String get societyLabel => 'ప్రాజెక్ట్ లేదా సొసైటీ (ఉంటే)';

  @override
  String get areaLabel => 'విస్తీర్ణం (చ. అడుగులు)';

  @override
  String get bhkLabel => 'పడక గదులు';

  @override
  String get newProperty => 'కొత్తది';

  @override
  String get resale => 'రీసేల్';

  @override
  String get declaredPriceLabel => 'ఒప్పంద విలువ';

  @override
  String get photosTitle => 'ఆస్తి ఫోటోలు';

  @override
  String get photosBody =>
      'ఆస్తి వద్దే ఫోటోలు తీయండి. మా విలువకర్త సందర్శనను ప్లాన్ చేయడానికి మేము స్థలం, సమయం జోడిస్తాము.';

  @override
  String get photoFront => 'ముందు వైపు';

  @override
  String get photoInside => 'లోపల';

  @override
  String get photoView => 'ఆస్తి నుండి దృశ్యం';

  @override
  String geoTagged(String lat, String lng) {
    return 'స్థానం జోడించబడింది ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'స్థానం లేకుండా ఫోటో సేవ్ అయింది. జియో-ట్యాగ్ కోసం లొకేషన్ ఆన్ చేయండి.';

  @override
  String get submitProperty => 'తుది మంజూరు పొందండి';

  @override
  String get fillAll => 'దయచేసి అన్ని ఖాళీలు నింపండి.';

  @override
  String get kfsTitle => 'ముఖ్య వాస్తవాల ప్రకటన';

  @override
  String get kfsLoan => 'లోన్ మొత్తం';

  @override
  String get kfsTenure => 'కాలవ్యవధి';

  @override
  String get kfsRate => 'వడ్డీ రేటు';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMIల సంఖ్య';

  @override
  String get kfsFee => 'ప్రాసెసింగ్ ఫీజు (GST తో)';

  @override
  String get kfsTotalInterest => 'మొత్తం వడ్డీ';

  @override
  String get kfsTotalPayable => 'చెల్లించాల్సిన మొత్తం';

  @override
  String get kfsApr => 'వార్షిక శాతం రేటు (APR)';

  @override
  String get kfsCoolingOff =>
      'కూలింగ్-ఆఫ్ కాలం: సంతకం చేసిన 3 రోజుల్లో అసలు, ఆ రోజుల వడ్డీ మాత్రమే చెల్లించి జరిమానా లేకుండా వైదొలగవచ్చు.';

  @override
  String get kfsNote =>
      'డెమో కోసం నమూనా అంకెలు. మీ నిజమైన KFS మంజూరు లేఖతో వస్తుంది.';

  @override
  String get useSample => 'నమూనా';

  @override
  String get videoKycDemo =>
      'డెమో: ఇది ఒక అధికారితో వీడియో KYC కాల్ బుక్ చేసేది.';

  @override
  String get raiseComplaint => 'ఫిర్యాదు చేయండి';

  @override
  String complaintSent(String ref) {
    return 'మీ ఫిర్యాదు నమోదైంది. రిఫరెన్స్ $ref.';
  }

  @override
  String get stageSignIn => 'సైన్ ఇన్';

  @override
  String get stageDetails => 'వివరాలు';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'ఆఫర్';

  @override
  String get stageProperty => 'ఆస్తి';

  @override
  String get homeSubtitle => 'హోమ్ లోన్ · ఆస్తిపై లోన్';

  @override
  String get heroPill => 'నిమిషాల్లో నిర్ణయం';

  @override
  String heroFacts(String rate, String years) {
    return 'సంవత్సరానికి $rate% నుండి · $years సంవత్సరాల వరకు';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% పూర్తి · ఆపిన చోట నుండి కొనసాగించండి';
  }

  @override
  String get resume => 'కొనసాగించు';

  @override
  String get calculators => 'కాలిక్యులేటర్లు';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'నెలవారీ వాయిదా';

  @override
  String get calcEligibility => 'అర్హత';

  @override
  String get calcEligibilitySub => 'మీకు ఎంత లభిస్తుంది';

  @override
  String get emiCalcTitle => 'EMI కాలిక్యులేటర్';

  @override
  String get eligibilityCalcTitle => 'అర్హత కాలిక్యులేటర్';

  @override
  String totalInterest(String amount) {
    return 'మొత్తం వడ్డీ $amount';
  }

  @override
  String get calcIncomeOnly =>
      'ఆదాయం ఆధారంగా మాత్రమే. ఆస్తి విలువ దీన్ని తగ్గించవచ్చు.';

  @override
  String get verified => 'ధృవీకరించబడింది';

  @override
  String get yourLoan => 'మీ లోన్';

  @override
  String docsProgress(String done, String total) {
    return '$total లో $done ధృవీకరించబడ్డాయి';
  }

  @override
  String get docNeeded => 'కావాలి';

  @override
  String get docTryAgain => 'మళ్ళీ ప్రయత్నించండి';

  @override
  String get fetched => 'తెచ్చినది';

  @override
  String get statusApproved => 'ఆమోదించబడింది';

  @override
  String get statusSanctioned => 'మంజూరైంది';

  @override
  String get statusInReview => 'సమీక్షలో';

  @override
  String get statusDeclined => 'తిరస్కరించబడింది';

  @override
  String get trackTitle => 'మీ దరఖాస్తును ట్రాక్ చేయండి';

  @override
  String get tlSubmitted => 'దరఖాస్తు సమర్పించబడింది';

  @override
  String get tlVerified => 'KYC, పత్రాలు ధృవీకరించబడ్డాయి';

  @override
  String get tlInPrinciple => 'సూత్రప్రాయ ఆమోదం';

  @override
  String get tlProperty => 'ఆస్తి వివరాలు, విలువ నిర్ధారణ';

  @override
  String get tlPropertyNext => 'మీ ఆస్తి వివరాలు, ఫోటోలు జోడించండి';

  @override
  String get tlOfficer => 'అధికారి సమీక్ష';

  @override
  String get tlOfficerNext => 'ఒక పని దినంలో';

  @override
  String get tlLegal => 'చట్టపరమైన, హక్కు తనిఖీ';

  @override
  String get tlSanction => 'తుది మంజూరు, ఈ-సంతకం';

  @override
  String get tlSanctionNext => 'మీ మంజూరు లేఖపై ఆన్‌లైన్‌లో సంతకం చేయండి';

  @override
  String get tlDisbursement => 'నిధుల విడుదల';

  @override
  String get helpTitle => 'సహాయం కావాలా?';

  @override
  String get propertyType => 'కొత్తదా లేదా రీసేలా';

  @override
  String get greetMorning => 'శుభోదయం';

  @override
  String get greetAfternoon => 'శుభ మధ్యాహ్నం';

  @override
  String get greetEvening => 'శుభ సాయంత్రం';

  @override
  String nearlyThere(String name) {
    return '$name, మీరు దాదాపు చేరుకున్నారు';
  }

  @override
  String get chooseLanguage => 'మీ భాషను ఎంచుకోండి';

  @override
  String get languageNote => 'దీన్ని మీరు ఎప్పుడైనా మార్చవచ్చు.';

  @override
  String get liveChecks => 'లైవ్ తనిఖీలు';

  @override
  String get checkBureau => 'క్రెడిట్ బ్యూరో';

  @override
  String checkScore(String score) {
    return 'స్కోర్ $score';
  }

  @override
  String get checkNoHistory => 'ఇంకా చరిత్ర లేదు';

  @override
  String get checkBank => 'AA ద్వారా బ్యాంక్';

  @override
  String get checkBankRead => '12 నెలలు చదివాము';

  @override
  String get checkKyc => 'eKYC, సెల్ఫీ';

  @override
  String get checkPending => 'పెండింగ్';

  @override
  String get checkDocs => 'పత్రాలు';

  @override
  String countOf(String done, String total) {
    return '$total లో $done';
  }

  @override
  String minutesLeft(String n) {
    return 'సుమారు $n నిమిషాలు మిగిలాయి';
  }

  @override
  String ratePa(String rate) {
    return 'సంవత్సరానికి $rate%';
  }

  @override
  String get continueApplication => 'మీ దరఖాస్తును కొనసాగించండి';

  @override
  String get shapeOffer => 'మీ ఆఫర్‌ను రూపొందించండి';

  @override
  String get shapeOfferSub =>
      'సూత్రప్రాయంగా ఆమోదించబడింది · మార్చడానికి లాగండి';

  @override
  String get withinLimits => 'మీ పరిమితుల్లో ఉంది';

  @override
  String get aboveLimits =>
      'పరిమితి దాటింది: మొత్తం తగ్గించండి లేదా సంవత్సరాలు పెంచండి';

  @override
  String mostYouCan(String amount) {
    return 'గరిష్ఠంగా తీసుకోగలిగేది: $amount';
  }

  @override
  String get useMax => 'గరిష్ఠం తీసుకోండి';

  @override
  String get principal => 'అసలు';

  @override
  String get interest => 'వడ్డీ';

  @override
  String get totalRepaid => 'మొత్తం చెల్లింపు';

  @override
  String get emiShareIncome => 'ఆదాయంలో EMIల భాగం';

  @override
  String loanShareProperty(String value) {
    return '$value ఆస్తిలో లోన్ భాగం';
  }

  @override
  String get lockOffer => 'ఈ ఆఫర్‌ను ఖరారు చేయండి';

  @override
  String get offerLocked => 'మీ ఆఫర్ ఖరారైంది.';

  @override
  String approvedUpTo(String amount) {
    return '$amount వరకు ఆమోదించబడింది';
  }

  @override
  String readingDoc(String doc) {
    return 'మీ $doc చదువుతున్నాము';
  }

  @override
  String get documentAi => 'పత్రం AI';

  @override
  String sure(String pct) {
    return '$pct% ఖచ్చితం';
  }

  @override
  String get readMatches => 'మేము అడిగిన పత్రమే ఇది';

  @override
  String get readClear => 'స్పష్టమైన ఫోటో, మసక లేదా మెరుపు లేదు';

  @override
  String get whatWeRead => 'మేము చదివినది';

  @override
  String get looksRight => 'సరిగ్గా ఉంది';

  @override
  String get fieldName => 'పేరు';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'ఆధార్';

  @override
  String get fieldEmployer => 'యజమాని';

  @override
  String get fieldNetPay => 'నికర జీతం';

  @override
  String get fieldPeriod => 'జీతం కాలం';

  @override
  String get fieldYear => 'సంవత్సరం';

  @override
  String get fieldIncome => 'ఆదాయం';

  @override
  String get fieldBusiness => 'వ్యాపారం';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'మీ లోన్‌కు అవసరం';

  @override
  String get consentSectionOptional => 'ఐచ్ఛికం: మీరు ఆన్ చేసే వరకు ఆఫ్';

  @override
  String get advancedOptions => 'ఎంపికలు';

  @override
  String consentValidUntil(String given, String until) {
    return '$given న ఇచ్చారు · $until వరకు చెల్లుతుంది';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given న ఇచ్చారు · వెనక్కి తీసుకునే వరకు';
  }

  @override
  String get recheckTitle => 'డబ్బు ఇచ్చే ముందు మరో తనిఖీ';

  @override
  String get recheckBody =>
      'డబ్బు ఇచ్చే ముందు మీ క్రెడిట్ రిపోర్ట్‌ను మళ్ళీ చూస్తాము. వద్దంటే అప్పుడు ఒక అధికారి అడగవచ్చు.';

  @override
  String get aaMonthsLabel => 'ఎన్ని నెలల స్టేట్‌మెంట్లు పంచుకోవాలి';

  @override
  String monthsN(String n) {
    return '$n నెలలు';
  }

  @override
  String get aaAccountsLabel => 'పంచుకునే ఖాతాలు';

  @override
  String get accountSavingsSalary => 'సేవింగ్స్ ·· 0912 · జీతం జమలు';

  @override
  String get accountSavings => 'సేవింగ్స్ ·· 4821';

  @override
  String get accountFd => 'ఫిక్స్‌డ్ డిపాజిట్ ·· 3307';

  @override
  String get aaAccountNeeded => 'కనీసం ఒక ఖాతాను ఎంచుకోండి.';

  @override
  String get kycMethodLabel => 'మీ గుర్తింపును ఎలా నిర్ధారించాలి';

  @override
  String get kycAadhaarOtp => 'ఆధార్ OTP';

  @override
  String get kycDigilocker => 'డిజిలాకర్';

  @override
  String get kycVideo => 'వీడియో KYC కాల్';

  @override
  String get useCkycTitle => 'నా ప్రస్తుత CKYC రికార్డ్ వాడండి';

  @override
  String get useCkycBody =>
      'మరో బ్యాంక్ లేదా ఫండ్‌తో KYC చేసి ఉంటే, మళ్ళీ అడగకుండా ఆ రికార్డ్ తెస్తాము.';

  @override
  String get optOffersTitle => 'ఆఫర్లు, కొత్త ఉత్పత్తులు';

  @override
  String get optOffersBody =>
      'ఆఫర్ల గురించి ఎలా తెలుసుకోవాలో ఎంచుకోండి. వీటిని ఎప్పుడైనా ఆఫ్ చేయవచ్చు.';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ఈమెయిల్';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp లో లోన్ అప్‌డేట్లు';

  @override
  String get optUpdatesBody =>
      'SMS తో పాటు WhatsApp లో స్టేటస్ అప్‌డేట్లు, EMI రిమైండర్లు.';

  @override
  String get optInsuranceTitle => 'హోమ్ లోన్ రక్షణ కోట్';

  @override
  String get optInsuranceBody =>
      'కోట్ కోసం మీ పేరు, వయస్సు, లోన్ మొత్తం మా బీమా భాగస్వామితో పంచుకోండి. కొనడం ఎప్పుడూ తప్పనిసరి కాదు.';

  @override
  String get getQuote => 'కోట్ పొందండి';

  @override
  String get manageConsents => 'సమ్మతులను నిర్వహించండి';

  @override
  String get manageConsentsBody =>
      'ఐచ్ఛిక సమ్మతులను ఎప్పుడైనా ఆఫ్ చేయండి. అవసరమైనది వెనక్కి తీసుకుంటే దరఖాస్తు ఆగుతుంది, దాని కోసం తెచ్చిన సమాచారాన్ని తొలగిస్తాము.';

  @override
  String get withdraw => 'వెనక్కి తీసుకోండి';

  @override
  String get consentHistory => 'సమ్మతి చరిత్ర';

  @override
  String historyGiven(String item) {
    return '$item ఇచ్చారు';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item వెనక్కి తీసుకున్నారు';
  }

  @override
  String get historyEmpty => 'ఇంకా ఏమీ లేదు.';

  @override
  String get consentOn => 'ఆన్';

  @override
  String get consentOff => 'ఆఫ్';

  @override
  String get withdrawnRequired =>
      'మీరు అవసరమైన సమ్మతిని వెనక్కి తీసుకున్నారు, కాబట్టి దరఖాస్తు ఆగింది.';

  @override
  String get checkMatchPending =>
      'ఫోటో సరిపోలిక: ఆధార్ లేదా పాన్ కార్డ్ అప్‌లోడ్ చేసినప్పుడు జరుగుతుంది';
}
