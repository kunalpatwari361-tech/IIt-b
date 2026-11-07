// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sindhi (`sd`).
class AppLocalizationsSd extends AppLocalizations {
  AppLocalizationsSd([String locale = 'sd']) : super(locale);

  @override
  String get appTitle => 'نرنيه';

  @override
  String get sandboxBanner => 'ڊيمو موڊ: نمونو ڊيٽا، اصل جاچ ناهي';

  @override
  String get continueLabel => 'جاري رکو';

  @override
  String stepOf(String step, String total) {
    return 'قدم $step / $total';
  }

  @override
  String get pleaseWait => 'مهرباني ڪري انتظار ڪريو…';

  @override
  String get errorGeneric => 'ڪجهه غلط ٿي ويو. ٻيهر ڪوشش ڪريو.';

  @override
  String get close => 'بند ڪريو';

  @override
  String get welcomeHeadline => 'ڪجهه منٽن ۾ توهان جي هوم لون جو فيصلو';

  @override
  String get welcomeBody =>
      'هوم لون يا ملڪيت جي بدلي لون لاءِ درخواست ڏيو. اسين سڀ ڪجهه آن لائن جاچيون ٿا ۽ هميشه فيصلي جو سبب ٻڌايون ٿا.';

  @override
  String get chooseProduct => 'توهان کي ڇا گهرجي؟';

  @override
  String get productHomeLoan => 'هوم لون';

  @override
  String get productHomeLoanSub => 'گهر خريد ڪرڻ، ٺاهڻ يا سڌارڻ';

  @override
  String get productLap => 'ملڪيت جي بدلي لون';

  @override
  String get productLapSub => 'پنهنجي ملڪيت جي بدلي قرض وٺو';

  @override
  String get startApplication => 'درخواست شروع ڪريو';

  @override
  String get demoCustomers => 'ڊيمو گراهڪ';

  @override
  String get demoCustomersBody =>
      'نمونو موبائل نمبر ڀرڻ لاءِ ڪنهن هڪ تي ٽيپ ڪريو.';

  @override
  String get personaRavi => 'روي، 32، نوڪري پيشه، فليٽ خريد ڪري رهيو آهي';

  @override
  String get personaMeena => 'مينا، 45، ڪپڙن جو دڪان هلائي ٿي (LAP)';

  @override
  String get personaArjun => 'ارجن، 29، نوڪري پيشه، بدليل پگهار پرچي';

  @override
  String get signInTitle => 'سائن ان';

  @override
  String get mobileLabel => 'موبائل نمبر';

  @override
  String get mobileHint => '10 انگن جو موبائل نمبر';

  @override
  String get invalidMobile => 'صحيح 10 انگن جو موبائل نمبر داخل ڪريو.';

  @override
  String get sendOtp => 'OTP موڪليو';

  @override
  String otpSentTo(String phone) {
    return 'اسان $phone تي 6 انگن جو ڪوڊ موڪليو آهي.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'تصديق ڪريو';

  @override
  String get demoOtp => 'ڊيمو ڪوڊ: 123456';

  @override
  String get wrongOtp => 'ڪوڊ غلط آهي. ٻيهر ڪوشش ڪريو.';

  @override
  String get deviceBound =>
      'هي فون هاڻي توهان جي کاتي سان ڳنڍجي ويو آهي. ٻئي فون تي سائن ان لاءِ نئون OTP گهرجندو.';

  @override
  String get consentTitle => 'توهان جي رضامندي';

  @override
  String get consentIntro =>
      'اسين توهان جو ڊيٽا صرف هن لون جي فيصلي ۽ انتظام لاءِ استعمال ڪريون ٿا. توهان ڪنهن به وقت رضامندي واپس وٺي سگهو ٿا.';

  @override
  String get consentBureauTitle => 'ڪريڊٽ رپورٽ';

  @override
  String get consentBureauBody =>
      'ڪريڊٽ بيورو (CIBIL، Experian، Equifax يا CRIF) کان توهان جي ڪريڊٽ تاريخ ڏٺي ويندي. ان سان توهان جو اسڪور گهٽ نه ٿيندو.';

  @override
  String get consentAaTitle => 'اڪائونٽ ايگريگيٽر ذريعي بينڪ اسٽيٽمينٽ';

  @override
  String get consentAaBody =>
      'RBI لائسنس يافته اڪائونٽ ايگريگيٽر ذريعي توهان جي بينڪ مان 12 مهينن جي اسٽيٽمينٽ ورتي ويندي. درخواست توهان پنهنجي AA ايپ ۾ منظور ڪريو ٿا.';

  @override
  String get consentKycTitle => 'آڌار eKYC ۽ PAN';

  @override
  String get consentKycBody =>
      'UIDAI ۽ انڪم ٽيڪس کاتي سان توهان جي سڃاڻپ جي تصديق ٿيندي. اسين صرف لڪايل آڌار نمبر رکون ٿا.';

  @override
  String get consentPrivacyTitle => 'رازداري جو نوٽيس (DPDP ايڪٽ 2023)';

  @override
  String get consentPrivacyBody =>
      'اسين ڇا گڏ ڪريون ٿا: سڃاڻپ، آمدني، بينڪ ۽ ملڪيت جا تفصيل. ڇو: توهان جي لون جي فيصلي ۽ انتظام لاءِ. ڪيترو وقت: صرف جيترو قانون چوي. توهان جا حق: پنهنجو ڊيٽا ڏسڻ، درست ڪرڻ يا ميٽڻ، ۽ اسان جي شڪايت آفيسر يا ڊيٽا پروٽيڪشن بورڊ وٽ شڪايت ڪرڻ.';

  @override
  String get consentRequired => 'ضروري';

  @override
  String get consentNeeded => 'اڳتي وڌڻ لاءِ سڀني تي رضامندي ڏيو.';

  @override
  String get agreeAndContinue => 'رضامندي ڏئي اڳتي وڌو';

  @override
  String get detailsTitle => 'توهان جا تفصيل';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'صحيح PAN داخل ڪريو، جيئن ABCDE1234F.';

  @override
  String get fetchDetails => 'منهنجا تفصيل آڻيو';

  @override
  String get fetchedFrom =>
      'PAN، آڌار eKYC ۽ توهان جي بينڪ اسٽيٽمينٽ مان ڀريو ويو. درست ڪرڻ لاءِ انگ تي ٽيپ ڪريو.';

  @override
  String get nameLabel => 'نالو';

  @override
  String get dobLabel => 'ڄمڻ جي تاريخ';

  @override
  String get employmentLabel => 'ڪم';

  @override
  String get salaried => 'نوڪري پيشه';

  @override
  String get selfEmployed => 'پنهنجو ڪاروبار';

  @override
  String get incomeLabel => 'مهيني جي خالص آمدني';

  @override
  String get existingEmiLabel => 'موجوده مهيني جون EMI';

  @override
  String get propertyValueLabel => 'ملڪيت جي قيمت';

  @override
  String get loanAmountLabel => 'لون جي رقم';

  @override
  String get tenureLabel => 'مدت';

  @override
  String yearsLabel(String n) {
    return '$n سال';
  }

  @override
  String get eligibleTitle => 'توهان وڌ ۾ وڌ وٺي سگهو ٿا';

  @override
  String emiPerMonth(String amount) {
    return 'مهيني جي EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'سالياني $rate%، بدلجندڙ (مثال)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'آمدني جي حد: توهان جون سڀ EMI گڏجي آمدني جي $pct تائين ٿي سگهن ٿيون.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'ملڪيت جي حد: ايترو لون قيمت جي $pct تائين ٿي سگهي ٿو.';
  }

  @override
  String get limitedByAsked => 'هي توهان جي گهريل رقم آهي.';

  @override
  String get eligibilityNote =>
      'توهان جي تفصيلن جي تڪڙي جاچ. اسان جي جاچ کانپوءِ آڇ ايندي.';

  @override
  String get selfieTitle => 'سيلفي وٺو';

  @override
  String get selfieBody =>
      'اسين توهان جو چهرو آڌار جي فوٽو سان ملايون ٿا ۽ ڏسون ٿا ته هي واقعي توهان آهيو، فوٽو جو فوٽو ناهي.';

  @override
  String get selfieTips => 'سٺي روشني، ڪئميرا ڏانهن ڏسو، ٽوپي يا چشمو نه.';

  @override
  String get takeSelfie => 'سيلفي وٺو';

  @override
  String get retake => 'ٻيهر وٺو';

  @override
  String get checkFace => 'چهرو مليو';

  @override
  String get checkLive => 'جيئرو ماڻهو';

  @override
  String get checkMatch => 'آڌار جي فوٽو سان ملي ٿو';

  @override
  String get selfieFailed =>
      'اسين توهان جي چهري جي تصديق نه ڪري سگهياسين. سٺي روشني ۾ ٻيهر ڪوشش ڪريو، يا وڊيو KYC ڪال بڪ ڪريو.';

  @override
  String get videoKyc => 'وڊيو KYC ڪال بڪ ڪريو';

  @override
  String get docsTitle => 'توهان جا دستاويز';

  @override
  String get docsBody => 'هر دستاويز جو صاف فوٽو وٺو، يا گيلري مان چونڊيو.';

  @override
  String get docPan => 'PAN ڪارڊ';

  @override
  String get docAadhaar => 'آڌار ڪارڊ (لڪايل)';

  @override
  String get docSalarySlip => 'تازي پگهار پرچي';

  @override
  String get docForm16 => 'فارم 16';

  @override
  String get docItr => 'انڪم ٽيڪس ريٽرن (ITR)';

  @override
  String get docGst => 'GST سرٽيفڪيٽ';

  @override
  String get docBankStatement => 'بينڪ اسٽيٽمينٽ';

  @override
  String get bankViaAa => 'توهان جي اڪائونٽ ايگريگيٽر ذريعي ورتو ويو';

  @override
  String get camera => 'ڪئميرا';

  @override
  String get gallery => 'گيلري';

  @override
  String get checking => 'جاچ ٿي رهي آهي…';

  @override
  String get tooBlurry => 'تمام ڌنڌلو. فون کي بيٺل رکي ٻيهر ڪوشش ڪريو.';

  @override
  String get tooMuchGlare => 'تمام گهڻي چمڪ. روشني کان هٽي ٻيهر ڪوشش ڪريو.';

  @override
  String get tooDark => 'تمام اونداهو. وڌيڪ روشني ۾ ٻيهر ڪوشش ڪريو.';

  @override
  String docAccepted(String type) {
    return 'سڃاتو ويو: $type';
  }

  @override
  String docWrong(String expected) {
    return 'هي $expected نٿو لڳي. جاچي صحيح دستاويز اپلوڊ ڪريو.';
  }

  @override
  String get docUnreadable =>
      'اسين هي دستاويز پڙهي نه سگهياسين. وڌيڪ صاف فوٽو وٺو، يا اصل PDF اپلوڊ ڪريو.';

  @override
  String docsMissing(String n) {
    return 'اڃا $n گهرجن';
  }

  @override
  String get getOffer => 'منهنجي اصولي آڇ ڏيکاريو';

  @override
  String get approvedInPrinciple => 'اصولي طور منظور';

  @override
  String get sanctioned => 'لون منظور';

  @override
  String get referredTitle => 'اسان کي ٿورو وڌيڪ وقت گهرجي';

  @override
  String get rejectedTitle => 'اسين هن وقت هي لون نٿا ڏئي سگهون';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years سال · سالياني $rate% بدلجندڙ';
  }

  @override
  String get whyOffer => 'توهان کي هي آڇ ڇو ملي';

  @override
  String get whyReferred => 'اڳتي ڇا ٿيندو';

  @override
  String get whyRejected => 'اسان هي فيصلو ڇو ڪيو';

  @override
  String get referBody =>
      'هڪ آفيسر هڪ ڪم واري ڏينهن ۾ توهان جي درخواست ڏسندو. هاڻي توهان کي ڪجهه ڪرڻ جي ضرورت ناهي.';

  @override
  String get rejectBody =>
      'توهان ڪنهن به وقت ڪنهن ماڻهو کي هن فيصلي تي نظرثاني لاءِ چئي سگهو ٿا.';

  @override
  String get addProperty => 'ملڪيت جا تفصيل شامل ڪريو';

  @override
  String get viewKfs => 'اهم حقيقتن جو بيان ڏسو';

  @override
  String get grievance => 'نظرثاني گهرو يا شڪايت ڪريو';

  @override
  String officerLine(String name, String email) {
    return 'شڪايت آفيسر: $name، $email';
  }

  @override
  String applicationNo(String id) {
    return 'درخواست $id';
  }

  @override
  String get startOver => 'نئين درخواست شروع ڪريو';

  @override
  String okScore(String score) {
    return 'ادائيگي جي مضبوط تاريخ (اسڪور $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI آمدني جو $pct آهن؛ اسان جي حد $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'لون ملڪيت جي قيمت جو $pct آهي؛ حد $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'ملڪيت جو اسان جو اندازو: $low کان $high';
  }

  @override
  String get okTitle => 'ملڪيت جي مالڪي ۽ ڪاغذ جاچيا ويا';

  @override
  String get reasonKyc01 =>
      'فوٽو مان توهان جي سڃاڻپ جي تصديق نه ٿي سگهي. مهرباني ڪري هڪ ننڍي وڊيو KYC ڪال پوري ڪريو.';

  @override
  String get reasonFrd02 =>
      'پگهار پرچي جي آمدني بينڪ ۾ جمع رقم سان نٿي ملي. پنهنجو تازو فارم 16 ڏيو، يا رضامندي سان اسان کي وٺڻ ڏيو.';

  @override
  String get reasonFrd03 =>
      'توهان جو هڪ دستاويز جاري ڪندڙ اداري جي تصديق ۾ ناڪام ٿيو.';

  @override
  String get reasonPol01 => 'درخواست ڏيندڙ جي عمر گهٽ ۾ گهٽ 21 سال هجڻ گهرجي.';

  @override
  String get reasonPol02 =>
      'لون اسان جي اجازت ڏنل وڌ ۾ وڌ عمر کان اڳتي ويندو. ننڍي عمر جو گڏيل درخواست ڏيندڙ شامل ڪرڻ سان مدد ملي سگهي ٿي.';

  @override
  String get reasonBur01 =>
      'توهان جو ڪريڊٽ اسڪور اسان جي گهٽ ۾ گهٽ 650 کان هيٺ آهي.';

  @override
  String get reasonBur04 =>
      'توهان جي اڃا ڪريڊٽ تاريخ ناهي، ان ڪري هڪ آفيسر توهان جا بينڪ رڪارڊ ڏسندو.';

  @override
  String get reasonBur05 =>
      'توهان جي ڪريڊٽ اسڪور کي آفيسر جي ويجهي نظر جي ضرورت آهي.';

  @override
  String get reasonPrp01 =>
      'اسان جي وڪيل کي ملڪيت جي مالڪي جو جائزو وٺڻو پوندو.';

  @override
  String get reasonPrp03 =>
      'قيمت جي تصديق لاءِ اسان جي قيمت لڳائيندڙ کي ملڪيت ڏسڻي پوندي.';

  @override
  String get reasonPrp04 =>
      'معاهدي جي قيمت هن ملڪيت جي سرڪاري سرڪل ريٽ کان گهٽ آهي. مهرباني ڪري وڪري جو معاهدو جاچيو.';

  @override
  String get reasonAff01 =>
      'توهان جون موجوده EMI اڳ ۾ ئي آمدني جو وڌ ۾ وڌ حصو وٺي رهيون آهن.';

  @override
  String get reasonAut01 => 'ايتري وڏي لون جي آخري جاچ هڪ سينيئر آفيسر ڪري ٿو.';

  @override
  String get reasonRsk01 => 'آڇ طئي ڪرڻ لاءِ هڪ آفيسر توهان جي درخواست ڏسندو.';

  @override
  String get reasonRsk02 =>
      'توهان جي ڪريڊٽ پروفائل جي بنياد تي اسين هن وقت هي لون نٿا ڏئي سگهون.';

  @override
  String get propertyTitle => 'توهان جي ملڪيت';

  @override
  String get cityLabel => 'شهر';

  @override
  String get localityLabel => 'علائقو';

  @override
  String get societyLabel => 'پروجيڪٽ يا سوسائٽي (جيڪڏهن هجي)';

  @override
  String get areaLabel => 'ايراضي (چورس فٽ)';

  @override
  String get bhkLabel => 'سمهڻ جا ڪمرا';

  @override
  String get newProperty => 'نئين';

  @override
  String get resale => 'ري سيل';

  @override
  String get declaredPriceLabel => 'معاهدي جي قيمت';

  @override
  String get photosTitle => 'ملڪيت جا فوٽو';

  @override
  String get photosBody =>
      'ملڪيت تي وڃي فوٽو وٺو. اسين جڳهه ۽ وقت شامل ڪريون ٿا، ته جيئن قيمت لڳائيندڙ دوري جي رٿابندي ڪري سگهي.';

  @override
  String get photoFront => 'سامهون';

  @override
  String get photoInside => 'اندر';

  @override
  String get photoView => 'ملڪيت مان نظارو';

  @override
  String geoTagged(String lat, String lng) {
    return 'جڳهه شامل ڪئي وئي ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'فوٽو جڳهه کانسواءِ محفوظ ٿيو. جيو ٽيگ لاءِ لوڪيشن آن ڪريو.';

  @override
  String get submitProperty => 'آخري منظوري وٺو';

  @override
  String get fillAll => 'مهرباني ڪري هر خانو ڀريو.';

  @override
  String get kfsTitle => 'اهم حقيقتن جو بيان';

  @override
  String get kfsLoan => 'لون جي رقم';

  @override
  String get kfsTenure => 'مدت';

  @override
  String get kfsRate => 'وياج جي شرح';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI جو تعداد';

  @override
  String get kfsFee => 'پروسيسنگ فيس (GST سميت)';

  @override
  String get kfsTotalInterest => 'ڪل وياج';

  @override
  String get kfsTotalPayable => 'ڪل ادا ڪرڻ واري رقم';

  @override
  String get kfsApr => 'سالياني سيڪڙو شرح (APR)';

  @override
  String get kfsCoolingOff =>
      'ڪولنگ آف مدت: صحيح ڪرڻ جي 3 ڏينهن اندر صرف اصل رقم ۽ انهن ڏينهن جو وياج موٽائي بغير ڏنڊ جي نڪري سگهو ٿا.';

  @override
  String get kfsNote =>
      'ڊيمو لاءِ نمونا انگ. توهان جو اصل KFS منظوري خط سان ايندو.';

  @override
  String get useSample => 'نمونو';

  @override
  String get videoKycDemo =>
      'ڊيمو: هن سان هڪ آفيسر سان وڊيو KYC ڪال بڪ ٿئي ها.';

  @override
  String get raiseComplaint => 'شڪايت ڪريو';

  @override
  String complaintSent(String ref) {
    return 'توهان جي شڪايت درج ٿي وئي. حوالو $ref.';
  }

  @override
  String get stageSignIn => 'سائن ان';

  @override
  String get stageDetails => 'تفصيل';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'آڇ';

  @override
  String get stageProperty => 'ملڪيت';

  @override
  String get homeSubtitle => 'هوم لون · ملڪيت جي بدلي لون';

  @override
  String get heroPill => 'منٽن ۾ فيصلو';

  @override
  String heroFacts(String rate, String years) {
    return 'سالياني $rate% کان · $years سالن تائين';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% مڪمل · جتي ڇڏيو هو اتان شروع ڪريو';
  }

  @override
  String get resume => 'جاري رکو';

  @override
  String get calculators => 'ڪيلڪيوليٽر';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'مهيني جي قسط';

  @override
  String get calcEligibility => 'اهليت';

  @override
  String get calcEligibilitySub => 'توهان ڪيترو وٺي سگهو ٿا';

  @override
  String get emiCalcTitle => 'EMI ڪيلڪيوليٽر';

  @override
  String get eligibilityCalcTitle => 'اهليت ڪيلڪيوليٽر';

  @override
  String totalInterest(String amount) {
    return 'ڪل وياج $amount';
  }

  @override
  String get calcIncomeOnly =>
      'صرف آمدني جي بنياد تي. ملڪيت جي قيمت ان کي گهٽائي سگهي ٿي.';

  @override
  String get verified => 'تصديق ٿيل';

  @override
  String get yourLoan => 'توهان جو لون';

  @override
  String docsProgress(String done, String total) {
    return '$total مان $done تصديق ٿيل';
  }

  @override
  String get docNeeded => 'گهرجي';

  @override
  String get docTryAgain => 'ٻيهر ڪوشش';

  @override
  String get fetched => 'ورتو ويو';

  @override
  String get statusApproved => 'منظور';

  @override
  String get statusSanctioned => 'منظور ٿيل';

  @override
  String get statusInReview => 'جائزي ۾';

  @override
  String get statusDeclined => 'نامنظور';

  @override
  String get trackTitle => 'پنهنجي درخواست ٽريڪ ڪريو';

  @override
  String get tlSubmitted => 'درخواست جمع ٿي';

  @override
  String get tlVerified => 'KYC ۽ دستاويزن جي تصديق ٿي';

  @override
  String get tlInPrinciple => 'اصولي منظوري';

  @override
  String get tlProperty => 'ملڪيت جا تفصيل ۽ قيمت';

  @override
  String get tlPropertyNext => 'پنهنجي ملڪيت جا تفصيل ۽ فوٽو شامل ڪريو';

  @override
  String get tlOfficer => 'آفيسر جو جائزو';

  @override
  String get tlOfficerNext => 'هڪ ڪم واري ڏينهن اندر';

  @override
  String get tlLegal => 'قانوني ۽ مالڪي جاچ';

  @override
  String get tlSanction => 'آخري منظوري ۽ اي صحيح';

  @override
  String get tlSanctionNext => 'پنهنجي منظوري خط تي آن لائن صحيح ڪريو';

  @override
  String get tlDisbursement => 'رقم جي ادائيگي';

  @override
  String get helpTitle => 'مدد گهرجي؟';

  @override
  String get propertyType => 'نئين يا ري سيل';

  @override
  String get greetMorning => 'صبح بخير';

  @override
  String get greetAfternoon => 'منجهند بخير';

  @override
  String get greetEvening => 'شام بخير';

  @override
  String nearlyThere(String name) {
    return '$name، توهان لڳ ڀڳ پهچي ويا آهيو';
  }

  @override
  String get chooseLanguage => 'پنهنجي ٻولي چونڊيو';

  @override
  String get languageNote => 'توهان ان کي ڪنهن به وقت بدلائي سگهو ٿا.';

  @override
  String get liveChecks => 'سڌيون جاچون';

  @override
  String get checkBureau => 'ڪريڊٽ بيورو';

  @override
  String checkScore(String score) {
    return 'اسڪور $score';
  }

  @override
  String get checkNoHistory => 'اڃا ڪا تاريخ ناهي';

  @override
  String get checkBank => 'AA ذريعي بينڪ';

  @override
  String get checkBankRead => '12 مهينا پڙهيا ويا';

  @override
  String get checkKyc => 'eKYC ۽ سيلفي';

  @override
  String get checkPending => 'باقي';

  @override
  String get checkDocs => 'دستاويز';

  @override
  String countOf(String done, String total) {
    return '$total مان $done';
  }

  @override
  String minutesLeft(String n) {
    return 'لڳ ڀڳ $n منٽ باقي';
  }

  @override
  String ratePa(String rate) {
    return 'سالياني $rate%';
  }

  @override
  String get continueApplication => 'پنهنجي درخواست جاري رکو';

  @override
  String get shapeOffer => 'پنهنجي آڇ طئي ڪريو';

  @override
  String get shapeOfferSub => 'اصولي طور منظور · بدلائڻ لاءِ ڇڪيو';

  @override
  String get withinLimits => 'توهان جي حد اندر';

  @override
  String get aboveLimits => 'حد کان وڌيڪ: رقم گهٽايو يا سال وڌايو';

  @override
  String mostYouCan(String amount) {
    return 'وڌ ۾ وڌ وٺي سگهو ٿا: $amount';
  }

  @override
  String get useMax => 'وڌ ۾ وڌ وٺو';

  @override
  String get principal => 'اصل رقم';

  @override
  String get interest => 'وياج';

  @override
  String get totalRepaid => 'ڪل ادائيگي';

  @override
  String get emiShareIncome => 'آمدني ۾ EMI جو حصو';

  @override
  String loanShareProperty(String value) {
    return '$value جي ملڪيت ۾ لون جو حصو';
  }

  @override
  String get lockOffer => 'هي آڇ پڪي ڪريو';

  @override
  String get offerLocked => 'توهان جي آڇ پڪي ٿي وئي.';

  @override
  String approvedUpTo(String amount) {
    return '$amount تائين منظور';
  }

  @override
  String readingDoc(String doc) {
    return 'توهان جو $doc پڙهيو پيو وڃي';
  }

  @override
  String get documentAi => 'دستاويز AI';

  @override
  String sure(String pct) {
    return '$pct% يقيني';
  }

  @override
  String get readMatches => 'هي اهو ئي دستاويز آهي جيڪو اسان گهريو هو';

  @override
  String get readClear => 'صاف فوٽو، ڌنڌلائپ يا چمڪ ناهي';

  @override
  String get whatWeRead => 'اسان ڇا پڙهيو';

  @override
  String get looksRight => 'صحيح آهي';

  @override
  String get fieldName => 'نالو';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'آڌار';

  @override
  String get fieldEmployer => 'نوڪري ڏيندڙ';

  @override
  String get fieldNetPay => 'خالص پگهار';

  @override
  String get fieldPeriod => 'پگهار جي مدت';

  @override
  String get fieldYear => 'سال';

  @override
  String get fieldIncome => 'آمدني';

  @override
  String get fieldBusiness => 'ڪاروبار';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'توهان جي لون لاءِ ضروري';

  @override
  String get consentSectionOptional =>
      'اختياري: جيستائين توهان آن نه ڪريو، بند';

  @override
  String get advancedOptions => 'اختيار';

  @override
  String consentValidUntil(String given, String until) {
    return '$given تي ڏني · $until تائين صحيح';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given تي ڏني · واپس وٺڻ تائين';
  }

  @override
  String get recheckTitle => 'رقم ڏيڻ کان اڳ هڪ ٻي جاچ';

  @override
  String get recheckBody =>
      'رقم ڏيڻ کان ٿورو اڳ اسين توهان جي ڪريڊٽ رپورٽ ٻيهر ڏسون ٿا. انڪار ڪرڻ تي آفيسر تڏهن پڇي سگهي ٿو.';

  @override
  String get aaMonthsLabel => 'ڪيترن مهينن جي اسٽيٽمينٽ ڏيو';

  @override
  String monthsN(String n) {
    return '$n مهينا';
  }

  @override
  String get aaAccountsLabel => 'ڏيڻ وارا کاتا';

  @override
  String get accountSavingsSalary => 'بچت کاتو ·· 0912 · پگهار جمع';

  @override
  String get accountSavings => 'بچت کاتو ·· 4821';

  @override
  String get accountFd => 'فڪسڊ ڊپازٽ ·· 3307';

  @override
  String get aaAccountNeeded => 'گهٽ ۾ گهٽ هڪ کاتو چونڊيو.';

  @override
  String get kycMethodLabel => 'پنهنجي سڃاڻپ ڪيئن تصديق ڪريو';

  @override
  String get kycAadhaarOtp => 'آڌار OTP';

  @override
  String get kycDigilocker => 'ڊجي لاڪر';

  @override
  String get kycVideo => 'وڊيو KYC ڪال';

  @override
  String get useCkycTitle => 'منهنجو موجوده CKYC رڪارڊ استعمال ڪريو';

  @override
  String get useCkycBody =>
      'جيڪڏهن توهان ٻي بينڪ يا فنڊ سان KYC ڪئي آهي، ته ٻيهر پڇڻ بدران اسين اهو رڪارڊ وٺون ٿا.';

  @override
  String get optOffersTitle => 'آڇون ۽ نيون شيون';

  @override
  String get optOffersBody =>
      'چونڊيو ته آڇن بابت ڪيئن ڄاڻڻ چاهيو ٿا. انهن کي ڪنهن به وقت بند ڪري سگهو ٿا.';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'اي ميل';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp تي لون اپڊيٽ';

  @override
  String get optUpdatesBody =>
      'SMS سان گڏ WhatsApp تي اسٽيٽس اپڊيٽ ۽ EMI يادگيريون.';

  @override
  String get optInsuranceTitle => 'هوم لون تحفظ جو ڪوٽيشن';

  @override
  String get optInsuranceBody =>
      'ڪوٽيشن لاءِ پنهنجو نالو، عمر ۽ لون جي رقم اسان جي انشورنس ڀائيوار کي ڏيو. خريد ڪرڻ ڪڏهن به لازمي ناهي.';

  @override
  String get getQuote => 'ڪوٽيشن وٺو';

  @override
  String get manageConsents => 'رضامنديون سنڀاليو';

  @override
  String get manageConsentsBody =>
      'اختياري رضامنديون ڪنهن به وقت بند ڪريو. ضروري رضامندي واپس وٺڻ تي درخواست رڪجي ٿي، ۽ ان لاءِ ورتل ڊيٽا اسين ميٽي ڇڏيون ٿا.';

  @override
  String get withdraw => 'واپس وٺو';

  @override
  String get consentHistory => 'رضامندي جي تاريخ';

  @override
  String historyGiven(String item) {
    return '$item ڏني وئي';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item واپس ورتي وئي';
  }

  @override
  String get historyEmpty => 'اڃا ڪجهه ناهي.';

  @override
  String get consentOn => 'آن';

  @override
  String get consentOff => 'بند';

  @override
  String get withdrawnRequired =>
      'توهان هڪ ضروري رضامندي واپس ورتي، ان ڪري درخواست رڪيل آهي.';

  @override
  String get checkMatchPending =>
      'تصوير جو ميلاپ: آڌار يا پين ڪارڊ اپلوڊ ڪرڻ تي ٿيندو';

  @override
  String get realDetailsIntro =>
      'پنهنجي باري ۾ ٻڌايو. اسين هر تفصيل اوهان جي دستاويزن سان جانچيون ٿا.';

  @override
  String get fullNameLabel => 'پورو نالو (جيئن پين ڪارڊ تي آهي)';

  @override
  String get emailLabel => 'اي ميل';

  @override
  String get employerLabel => 'آجر يا ڪاروبار جو نالو';

  @override
  String get creditScoreLabel => 'ڪريڊٽ اسڪور (اختياري)';

  @override
  String get creditScoreHint =>
      'اوهان جي CIBIL يا Experian رپورٽ مان، جيڪڏهن خبر هجي';

  @override
  String get addressLabel => 'پتو';

  @override
  String get saveDetails => 'منهنجون تفصيلون محفوظ ڪريو';

  @override
  String get selfDeclaredNote =>
      'اهي تفصيلون اوهان ڀريون آهن. اڳتي جيڪي دستاويز اپلوڊ ڪندا، انهن سان اسين جانچينداسين.';

  @override
  String get pickDob => 'پنهنجي ڄمڻ جي تاريخ چونڊيو';

  @override
  String get fillDetails =>
      'مهرباني ڪري نالو، ڄمڻ جي تاريخ، ڪم، آجر ۽ آمدني ڀريو.';

  @override
  String get docSaleDeed => 'وڪري جو دستاويز يا الاٽمينٽ خط';

  @override
  String get saleDeedBody =>
      'رجسٽرڊ وڪري دستاويز جي تصوير يا PDF اپلوڊ ڪريو (اهو صفحو جنهن ۾ ملڪيت ۽ خريدار هجي). ملڪيت جانچڻ لاءِ اسين ان کي پڙهون ٿا.';

  @override
  String get statusPending => 'جائزو باقي آهي';

  @override
  String decisionRef(String ref) {
    return 'فيصلي جو رڪارڊ $ref';
  }

  @override
  String get scoreTitle => 'اسان توهان جو اسڪور ڪيئن ڪڍيو';

  @override
  String get scoreOutOf => '900 مان';

  @override
  String gradeLabel(String grade) {
    return 'گريڊ $grade';
  }

  @override
  String scoreStart(String base) {
    return 'هر ڪو $base پوائنٽن کان شروع ڪري ٿو. هيٺ هر سٽ پوائنٽ وڌائي يا گهٽائي ٿي.';
  }

  @override
  String get scoreNote =>
      'هي فيصلي جو ڪريڊٽ اسڪور وارو حصو آهي. توهان جي آمدني، سڃاڻپ، دستاويز ۽ ملڪيت پڻ جانچي وڃي ٿي.';

  @override
  String get factorBureau => 'ڪريڊٽ بيورو اسڪور';

  @override
  String get factorHistory => 'ڪريڊٽ تاريخ جا سال';

  @override
  String get factorLtv => 'ملڪيت جي قيمت جي مقابلي ۾ لون جو حصو';

  @override
  String get factorLoanAmount => 'لون جي رقم';

  @override
  String get factorMissing => 'موجود ناهي';

  @override
  String rangeBelow(String x) {
    return '$x کان گهٽ';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$a کان $b';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x يا وڌيڪ';
  }

  @override
  String get viewLetter => 'فيصلي جو خط';

  @override
  String get letterTitle => 'توهان جو فيصلي جو خط';

  @override
  String get letterPartlyEnglish =>
      'ڪجهه سٽن جو ترجمو نه ٿي سگهيو، تنهنڪري اهي انگريزي ۾ آهن.';

  @override
  String get copyText => 'متن ڪاپي ڪريو';

  @override
  String get copied => 'ڪاپي ٿي ويو';

  @override
  String get askTitle => 'سوال پڇو';

  @override
  String get askHint => 'مثال: اڳتي ڇا ٿيندو؟';

  @override
  String get askSend => 'موڪليو';

  @override
  String get askHuman =>
      'اسان جي ٽيم جو ڪو ماڻهو ان بابت توهان سان رابطو ڪندو.';

  @override
  String get uploadPdf => 'PDF اپلوڊ ڪريو';

  @override
  String get kfsFeeBase => 'پروسيسنگ فيس (0.5%)';

  @override
  String get kfsGst => 'فيس تي GST (18%)';

  @override
  String get kfsNoteEngine =>
      'هي هن آڇ لاءِ ڪڍيو ويو آهي. صحيح ٿيل اهم حقيقتن جو بيان توهان جي منظوري خط سان گڏ ايندو.';

  @override
  String otpOnServer(String phone) {
    return 'هي ٽيسٽ سرور SMS نٿو موڪلي. $phone لاءِ 6 انگن جو ڪوڊ ڪمپيوٽر جي سرور ونڊو ۾ نظر اچي ٿو.';
  }

  @override
  String get resendOtp => 'نئون ڪوڊ موڪليو';

  @override
  String get newOtpSent => 'نئون ڪوڊ موڪليو ويو.';

  @override
  String get otpExpired => 'هن ڪوڊ جي مدت ختم ٿي وئي. نئون ڪوڊ موڪليو دٻايو.';

  @override
  String get otpTooManyTries => 'گهڻي ڀيرا غلط ڪوڊ. نئون ڪوڊ موڪليو دٻايو.';

  @override
  String get otpTooManySends =>
      'تمام گهڻا ڪوڊ گهريا ويا. 15 منٽ ترسي ٻيهر ڪوشش ڪريو.';
}
