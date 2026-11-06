// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'نرنے';

  @override
  String get sandboxBanner => 'ڈیمو موڈ: نمونہ ڈیٹا، اصل جانچ نہیں';

  @override
  String get continueLabel => 'جاری رکھیں';

  @override
  String stepOf(String step, String total) {
    return 'مرحلہ $step / $total';
  }

  @override
  String get pleaseWait => 'براہ کرم انتظار کریں…';

  @override
  String get errorGeneric => 'کچھ غلط ہو گیا۔ دوبارہ کوشش کریں۔';

  @override
  String get close => 'بند کریں';

  @override
  String get welcomeHeadline => 'چند منٹ میں آپ کے ہوم لون کا فیصلہ';

  @override
  String get welcomeBody =>
      'ہوم لون یا جائیداد کے عوض لون کے لیے درخواست دیں۔ ہم سب کچھ آن لائن جانچتے ہیں اور ہمیشہ فیصلے کی وجہ بتاتے ہیں۔';

  @override
  String get chooseProduct => 'آپ کو کیا چاہیے؟';

  @override
  String get productHomeLoan => 'ہوم لون';

  @override
  String get productHomeLoanSub => 'گھر خریدنا، بنانا یا بہتر کرنا';

  @override
  String get productLap => 'جائیداد کے عوض لون';

  @override
  String get productLapSub => 'اپنی جائیداد کے عوض قرض لیں';

  @override
  String get startApplication => 'درخواست شروع کریں';

  @override
  String get demoCustomers => 'ڈیمو صارفین';

  @override
  String get demoCustomersBody =>
      'نمونہ موبائل نمبر بھرنے کے لیے ایک پر ٹیپ کریں۔';

  @override
  String get personaRavi => 'روی، 32، تنخواہ دار، فلیٹ خرید رہے ہیں';

  @override
  String get personaMeena => 'مینا، 45، کپڑوں کی دکان چلاتی ہیں (LAP)';

  @override
  String get personaArjun => 'ارجن، 29، تنخواہ دار، بدلی ہوئی تنخواہ پرچی';

  @override
  String get signInTitle => 'سائن ان';

  @override
  String get mobileLabel => 'موبائل نمبر';

  @override
  String get mobileHint => '10 ہندسوں کا موبائل نمبر';

  @override
  String get invalidMobile => 'درست 10 ہندسوں کا موبائل نمبر درج کریں۔';

  @override
  String get sendOtp => 'OTP بھیجیں';

  @override
  String otpSentTo(String phone) {
    return 'ہم نے $phone پر 6 ہندسوں کا کوڈ بھیجا ہے۔';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'تصدیق کریں';

  @override
  String get demoOtp => 'ڈیمو کوڈ: 123456';

  @override
  String get wrongOtp => 'کوڈ غلط ہے۔ دوبارہ کوشش کریں۔';

  @override
  String get deviceBound =>
      'یہ فون اب آپ کے اکاؤنٹ سے جڑ گیا ہے۔ دوسرے فون پر سائن ان کے لیے نیا OTP درکار ہوگا۔';

  @override
  String get consentTitle => 'آپ کی رضامندی';

  @override
  String get consentIntro =>
      'ہم آپ کا ڈیٹا صرف اس لون کے فیصلے اور انتظام کے لیے استعمال کرتے ہیں۔ آپ کسی بھی وقت رضامندی واپس لے سکتے ہیں۔';

  @override
  String get consentBureauTitle => 'کریڈٹ رپورٹ';

  @override
  String get consentBureauBody =>
      'کریڈٹ بیورو (CIBIL، Experian، Equifax یا CRIF) سے آپ کی کریڈٹ تاریخ دیکھی جائے گی۔ اس سے آپ کا اسکور کم نہیں ہوتا۔';

  @override
  String get consentAaTitle => 'اکاؤنٹ ایگریگیٹر کے ذریعے بینک اسٹیٹمنٹ';

  @override
  String get consentAaBody =>
      'RBI سے لائسنس یافتہ اکاؤنٹ ایگریگیٹر کے ذریعے آپ کے بینک سے 12 مہینوں کی اسٹیٹمنٹ لی جائے گی۔ درخواست آپ اپنی AA ایپ میں منظور کرتے ہیں۔';

  @override
  String get consentKycTitle => 'آدھار eKYC اور PAN';

  @override
  String get consentKycBody =>
      'UIDAI اور محکمہ انکم ٹیکس کے ساتھ آپ کی شناخت کی تصدیق ہوگی۔ ہم صرف چھپا ہوا آدھار نمبر رکھتے ہیں۔';

  @override
  String get consentPrivacyTitle => 'رازداری کا نوٹس (DPDP ایکٹ 2023)';

  @override
  String get consentPrivacyBody =>
      'ہم کیا جمع کرتے ہیں: شناخت، آمدنی، بینک اور جائیداد کی تفصیلات۔ کیوں: آپ کے لون کے فیصلے اور انتظام کے لیے۔ کب تک: صرف جتنا قانون کہے۔ آپ کے حقوق: اپنا ڈیٹا دیکھنا، درست کرنا یا مٹانا، اور ہمارے شکایتی افسر یا ڈیٹا پروٹیکشن بورڈ سے شکایت کرنا۔';

  @override
  String get consentRequired => 'ضروری';

  @override
  String get consentNeeded => 'آگے بڑھنے کے لیے تمام نکات پر رضامندی دیں۔';

  @override
  String get agreeAndContinue => 'رضامندی دے کر آگے بڑھیں';

  @override
  String get detailsTitle => 'آپ کی تفصیلات';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'درست PAN درج کریں، جیسے ABCDE1234F۔';

  @override
  String get fetchDetails => 'میری تفصیلات لائیں';

  @override
  String get fetchedFrom =>
      'PAN، آدھار eKYC اور آپ کی بینک اسٹیٹمنٹ سے بھرا گیا۔ درست کرنے کے لیے رقم پر ٹیپ کریں۔';

  @override
  String get nameLabel => 'نام';

  @override
  String get dobLabel => 'تاریخ پیدائش';

  @override
  String get employmentLabel => 'کام';

  @override
  String get salaried => 'تنخواہ دار';

  @override
  String get selfEmployed => 'خود روزگار';

  @override
  String get incomeLabel => 'ماہانہ خالص آمدنی';

  @override
  String get existingEmiLabel => 'موجودہ ماہانہ EMI';

  @override
  String get propertyValueLabel => 'جائیداد کی قیمت';

  @override
  String get loanAmountLabel => 'لون کی رقم';

  @override
  String get tenureLabel => 'مدت';

  @override
  String yearsLabel(String n) {
    return '$n سال';
  }

  @override
  String get eligibleTitle => 'آپ زیادہ سے زیادہ لے سکتے ہیں';

  @override
  String emiPerMonth(String amount) {
    return 'ماہانہ EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'سالانہ $rate%، متغیر (مثال)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'آمدنی کی حد: آپ کی تمام EMI مل کر آمدنی کے $pct تک ہو سکتی ہیں۔';
  }

  @override
  String limitedByProperty(String pct) {
    return 'جائیداد کی حد: اس سائز کا لون قیمت کے $pct تک ہو سکتا ہے۔';
  }

  @override
  String get limitedByAsked => 'یہ آپ کی مانگی ہوئی رقم ہے۔';

  @override
  String get eligibilityNote =>
      'آپ کی تفصیلات کی فوری جانچ۔ ہماری جانچ کے بعد آپ کی پیشکش آئے گی۔';

  @override
  String get selfieTitle => 'سیلفی لیں';

  @override
  String get selfieBody =>
      'ہم آپ کا چہرہ آدھار کی تصویر سے ملاتے ہیں اور دیکھتے ہیں کہ یہ واقعی آپ ہیں، تصویر کی تصویر نہیں۔';

  @override
  String get selfieTips =>
      'اچھی روشنی، کیمرے کی طرف دیکھیں، ٹوپی یا دھوپ کا چشمہ نہیں۔';

  @override
  String get takeSelfie => 'سیلفی لیں';

  @override
  String get retake => 'دوبارہ لیں';

  @override
  String get checkFace => 'چہرہ ملا';

  @override
  String get checkLive => 'زندہ شخص';

  @override
  String get checkMatch => 'آدھار کی تصویر سے ملتا ہے';

  @override
  String get selfieFailed =>
      'ہم آپ کے چہرے کی تصدیق نہیں کر سکے۔ اچھی روشنی میں دوبارہ کوشش کریں، یا ویڈیو KYC کال بک کریں۔';

  @override
  String get videoKyc => 'ویڈیو KYC کال بک کریں';

  @override
  String get docsTitle => 'آپ کے دستاویزات';

  @override
  String get docsBody => 'ہر دستاویز کی صاف تصویر لیں، یا گیلری سے منتخب کریں۔';

  @override
  String get docPan => 'PAN کارڈ';

  @override
  String get docAadhaar => 'آدھار کارڈ (چھپا ہوا)';

  @override
  String get docSalarySlip => 'تازہ تنخواہ پرچی';

  @override
  String get docForm16 => 'فارم 16';

  @override
  String get docItr => 'انکم ٹیکس ریٹرن (ITR)';

  @override
  String get docGst => 'GST سرٹیفکیٹ';

  @override
  String get docBankStatement => 'بینک اسٹیٹمنٹ';

  @override
  String get bankViaAa => 'آپ کے اکاؤنٹ ایگریگیٹر کے ذریعے لیا گیا';

  @override
  String get camera => 'کیمرہ';

  @override
  String get gallery => 'گیلری';

  @override
  String get checking => 'جانچ ہو رہی ہے…';

  @override
  String get tooBlurry => 'بہت دھندلا۔ فون کو ساکن رکھ کر دوبارہ کوشش کریں۔';

  @override
  String get tooMuchGlare => 'بہت چمک۔ روشنی سے ہٹ کر دوبارہ کوشش کریں۔';

  @override
  String get tooDark => 'بہت اندھیرا۔ زیادہ روشنی میں دوبارہ کوشش کریں۔';

  @override
  String docAccepted(String type) {
    return 'پہچانا گیا: $type';
  }

  @override
  String docWrong(String expected) {
    return 'یہ $expected نہیں لگتا۔ جانچ کر صحیح دستاویز اپ لوڈ کریں۔';
  }

  @override
  String get docUnreadable =>
      'ہم یہ دستاویز نہیں پڑھ سکے۔ زیادہ صاف تصویر لیں، یا اصل PDF اپ لوڈ کریں۔';

  @override
  String docsMissing(String n) {
    return 'ابھی $n باقی';
  }

  @override
  String get getOffer => 'میری اصولی پیشکش دکھائیں';

  @override
  String get approvedInPrinciple => 'اصولی طور پر منظور';

  @override
  String get sanctioned => 'لون منظور';

  @override
  String get referredTitle => 'ہمیں تھوڑا اور وقت چاہیے';

  @override
  String get rejectedTitle => 'ہم ابھی یہ لون نہیں دے سکتے';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years سال · سالانہ $rate% متغیر';
  }

  @override
  String get whyOffer => 'آپ کو یہ پیشکش کیوں ملی';

  @override
  String get whyReferred => 'آگے کیا ہوگا';

  @override
  String get whyRejected => 'ہم نے یہ فیصلہ کیوں کیا';

  @override
  String get referBody =>
      'ایک افسر ایک کاروباری دن میں آپ کی درخواست دیکھے گا۔ ابھی آپ کو کچھ کرنے کی ضرورت نہیں۔';

  @override
  String get rejectBody =>
      'آپ کسی بھی وقت کسی شخص سے اس فیصلے پر نظرثانی کے لیے کہہ سکتے ہیں۔';

  @override
  String get addProperty => 'جائیداد کی تفصیلات شامل کریں';

  @override
  String get viewKfs => 'اہم حقائق کا بیان دیکھیں';

  @override
  String get grievance => 'نظرثانی مانگیں یا شکایت کریں';

  @override
  String officerLine(String name, String email) {
    return 'شکایتی افسر: $name، $email';
  }

  @override
  String applicationNo(String id) {
    return 'درخواست $id';
  }

  @override
  String get startOver => 'نئی درخواست شروع کریں';

  @override
  String okScore(String score) {
    return 'ادائیگی کی مضبوط تاریخ (اسکور $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI آمدنی کا $pct ہیں؛ ہماری حد $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'لون جائیداد کی قیمت کا $pct ہے؛ حد $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'جائیداد کی ہماری قیمت: $low سے $high';
  }

  @override
  String get okTitle => 'جائیداد کی ملکیت اور کاغذات جانچے گئے';

  @override
  String get reasonKyc01 =>
      'تصویر سے آپ کی شناخت کی تصدیق نہیں ہو سکی۔ براہ کرم ایک مختصر ویڈیو KYC کال مکمل کریں۔';

  @override
  String get reasonFrd02 =>
      'تنخواہ پرچی کی آمدنی بینک میں جمع رقم سے میل نہیں کھاتی۔ اپنا تازہ فارم 16 دیں، یا رضامندی سے ہمیں لینے دیں۔';

  @override
  String get reasonFrd03 =>
      'آپ کا ایک دستاویز جاری کرنے والے ادارے کی تصدیق میں ناکام رہا۔';

  @override
  String get reasonPol01 => 'درخواست دہندہ کی عمر کم از کم 21 سال ہونی چاہیے۔';

  @override
  String get reasonPol02 =>
      'لون ہماری اجازت کردہ زیادہ سے زیادہ عمر سے آگے جائے گا۔ کم عمر شریک درخواست دہندہ شامل کرنے سے مدد مل سکتی ہے۔';

  @override
  String get reasonBur01 => 'آپ کا کریڈٹ اسکور ہمارے کم از کم 650 سے نیچے ہے۔';

  @override
  String get reasonBur04 =>
      'آپ کی ابھی کریڈٹ تاریخ نہیں ہے، اس لیے ایک افسر آپ کے بینک ریکارڈ دیکھے گا۔';

  @override
  String get reasonBur05 => 'آپ کے کریڈٹ اسکور کو افسر کی گہری نظر درکار ہے۔';

  @override
  String get reasonPrp01 =>
      'ہمارے وکیل کو جائیداد کی ملکیت کا جائزہ لینا ہوگا۔';

  @override
  String get reasonPrp03 =>
      'قیمت کی تصدیق کے لیے ہمارے قیمت لگانے والے کو جائیداد دیکھنی ہوگی۔';

  @override
  String get reasonPrp04 =>
      'معاہدے کی قیمت اس جائیداد کے سرکاری سرکل ریٹ سے کم ہے۔ براہ کرم فروخت کا معاہدہ جانچیں۔';

  @override
  String get reasonAff01 =>
      'آپ کی موجودہ EMI پہلے ہی آمدنی کا زیادہ سے زیادہ حصہ لے رہی ہیں۔';

  @override
  String get reasonAut01 =>
      'اس سائز کے لون کی آخری جانچ ایک سینئر افسر کرتا ہے۔';

  @override
  String get reasonRsk01 =>
      'پیشکش طے کرنے کے لیے ایک افسر آپ کی درخواست دیکھے گا۔';

  @override
  String get reasonRsk02 =>
      'آپ کے کریڈٹ پروفائل کی بنیاد پر ہم ابھی یہ لون نہیں دے سکتے۔';

  @override
  String get propertyTitle => 'آپ کی جائیداد';

  @override
  String get cityLabel => 'شہر';

  @override
  String get localityLabel => 'علاقہ';

  @override
  String get societyLabel => 'پروجیکٹ یا سوسائٹی (اگر ہو)';

  @override
  String get areaLabel => 'رقبہ (مربع فٹ)';

  @override
  String get bhkLabel => 'بیڈروم';

  @override
  String get newProperty => 'نئی';

  @override
  String get resale => 'ری سیل';

  @override
  String get declaredPriceLabel => 'معاہدے کی قیمت';

  @override
  String get photosTitle => 'جائیداد کی تصاویر';

  @override
  String get photosBody =>
      'تصاویر جائیداد پر جا کر لیں۔ ہم جگہ اور وقت شامل کرتے ہیں، تاکہ قیمت لگانے والا دورے کی منصوبہ بندی کر سکے۔';

  @override
  String get photoFront => 'سامنے';

  @override
  String get photoInside => 'اندر';

  @override
  String get photoView => 'جائیداد سے منظر';

  @override
  String geoTagged(String lat, String lng) {
    return 'مقام شامل ہوا ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'تصویر مقام کے بغیر محفوظ ہوئی۔ جیو ٹیگ کے لیے لوکیشن آن کریں۔';

  @override
  String get submitProperty => 'حتمی منظوری حاصل کریں';

  @override
  String get fillAll => 'براہ کرم ہر خانہ بھریں۔';

  @override
  String get kfsTitle => 'اہم حقائق کا بیان';

  @override
  String get kfsLoan => 'لون کی رقم';

  @override
  String get kfsTenure => 'مدت';

  @override
  String get kfsRate => 'شرح سود';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI کی تعداد';

  @override
  String get kfsFee => 'پروسیسنگ فیس (GST سمیت)';

  @override
  String get kfsTotalInterest => 'کل سود';

  @override
  String get kfsTotalPayable => 'کل قابل ادائیگی رقم';

  @override
  String get kfsApr => 'سالانہ فیصد شرح (APR)';

  @override
  String get kfsCoolingOff =>
      'کولنگ آف مدت: دستخط کے 3 دن کے اندر صرف اصل رقم اور ان دنوں کا سود واپس کر کے بغیر جرمانے کے نکل سکتے ہیں۔';

  @override
  String get kfsNote =>
      'ڈیمو کے لیے نمونہ اعداد۔ آپ کا اصل KFS منظوری خط کے ساتھ آئے گا۔';

  @override
  String get useSample => 'نمونہ';

  @override
  String get videoKycDemo =>
      'ڈیمو: اس سے ایک افسر کے ساتھ ویڈیو KYC کال بک ہوتی۔';

  @override
  String get raiseComplaint => 'شکایت درج کریں';

  @override
  String complaintSent(String ref) {
    return 'آپ کی شکایت درج ہو گئی۔ حوالہ $ref۔';
  }

  @override
  String get stageSignIn => 'سائن ان';

  @override
  String get stageDetails => 'تفصیلات';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'پیشکش';

  @override
  String get stageProperty => 'جائیداد';

  @override
  String get homeSubtitle => 'ہوم لون · جائیداد کے عوض لون';

  @override
  String get heroPill => 'منٹوں میں فیصلہ';

  @override
  String heroFacts(String rate, String years) {
    return 'سالانہ $rate% سے · $years سال تک';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% مکمل · جہاں چھوڑا تھا وہیں سے شروع کریں';
  }

  @override
  String get resume => 'جاری رکھیں';

  @override
  String get calculators => 'کیلکولیٹر';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'ماہانہ قسط';

  @override
  String get calcEligibility => 'اہلیت';

  @override
  String get calcEligibilitySub => 'آپ کتنا لے سکتے ہیں';

  @override
  String get emiCalcTitle => 'EMI کیلکولیٹر';

  @override
  String get eligibilityCalcTitle => 'اہلیت کیلکولیٹر';

  @override
  String totalInterest(String amount) {
    return 'کل سود $amount';
  }

  @override
  String get calcIncomeOnly =>
      'صرف آمدنی کی بنیاد پر۔ جائیداد کی قیمت اسے کم کر سکتی ہے۔';

  @override
  String get verified => 'تصدیق شدہ';

  @override
  String get yourLoan => 'آپ کا لون';

  @override
  String docsProgress(String done, String total) {
    return '$total میں سے $done تصدیق شدہ';
  }

  @override
  String get docNeeded => 'درکار';

  @override
  String get docTryAgain => 'دوبارہ کوشش';

  @override
  String get fetched => 'لیا گیا';

  @override
  String get statusApproved => 'منظور';

  @override
  String get statusSanctioned => 'منظور شدہ';

  @override
  String get statusInReview => 'جائزے میں';

  @override
  String get statusDeclined => 'نامنظور';

  @override
  String get trackTitle => 'اپنی درخواست ٹریک کریں';

  @override
  String get tlSubmitted => 'درخواست جمع ہوئی';

  @override
  String get tlVerified => 'KYC اور دستاویزات کی تصدیق ہوئی';

  @override
  String get tlInPrinciple => 'اصولی منظوری';

  @override
  String get tlProperty => 'جائیداد کی تفصیلات اور قیمت';

  @override
  String get tlPropertyNext => 'اپنی جائیداد کی تفصیلات اور تصاویر شامل کریں';

  @override
  String get tlOfficer => 'افسر کا جائزہ';

  @override
  String get tlOfficerNext => 'ایک کاروباری دن میں';

  @override
  String get tlLegal => 'قانونی اور ملکیت کی جانچ';

  @override
  String get tlSanction => 'حتمی منظوری اور ای دستخط';

  @override
  String get tlSanctionNext => 'اپنے منظوری خط پر آن لائن دستخط کریں';

  @override
  String get tlDisbursement => 'رقم کی ادائیگی';

  @override
  String get helpTitle => 'مدد چاہیے؟';

  @override
  String get propertyType => 'نئی یا ری سیل';

  @override
  String get greetMorning => 'صبح بخیر';

  @override
  String get greetAfternoon => 'سہ پہر بخیر';

  @override
  String get greetEvening => 'شام بخیر';

  @override
  String nearlyThere(String name) {
    return '$name، آپ تقریباً پہنچ گئے';
  }

  @override
  String get chooseLanguage => 'اپنی زبان منتخب کریں';

  @override
  String get languageNote => 'آپ اسے کسی بھی وقت بدل سکتے ہیں۔';

  @override
  String get liveChecks => 'براہ راست جانچ';

  @override
  String get checkBureau => 'کریڈٹ بیورو';

  @override
  String checkScore(String score) {
    return 'اسکور $score';
  }

  @override
  String get checkNoHistory => 'ابھی کوئی تاریخ نہیں';

  @override
  String get checkBank => 'AA کے ذریعے بینک';

  @override
  String get checkBankRead => '12 مہینے پڑھے گئے';

  @override
  String get checkKyc => 'eKYC اور سیلفی';

  @override
  String get checkPending => 'باقی';

  @override
  String get checkDocs => 'دستاویزات';

  @override
  String countOf(String done, String total) {
    return '$total میں سے $done';
  }

  @override
  String minutesLeft(String n) {
    return 'تقریباً $n منٹ باقی';
  }

  @override
  String ratePa(String rate) {
    return 'سالانہ $rate%';
  }

  @override
  String get continueApplication => 'اپنی درخواست جاری رکھیں';

  @override
  String get shapeOffer => 'اپنی پیشکش طے کریں';

  @override
  String get shapeOfferSub => 'اصولی طور پر منظور · بدلنے کے لیے کھینچیں';

  @override
  String get withinLimits => 'آپ کی حد کے اندر';

  @override
  String get aboveLimits => 'حد سے زیادہ: رقم کم کریں یا سال بڑھائیں';

  @override
  String mostYouCan(String amount) {
    return 'زیادہ سے زیادہ لے سکتے ہیں: $amount';
  }

  @override
  String get useMax => 'زیادہ سے زیادہ لیں';

  @override
  String get principal => 'اصل رقم';

  @override
  String get interest => 'سود';

  @override
  String get totalRepaid => 'کل ادائیگی';

  @override
  String get emiShareIncome => 'آمدنی میں EMI کا حصہ';

  @override
  String loanShareProperty(String value) {
    return '$value کی جائیداد میں لون کا حصہ';
  }

  @override
  String get lockOffer => 'یہ پیشکش پکی کریں';

  @override
  String get offerLocked => 'آپ کی پیشکش پکی ہو گئی۔';

  @override
  String approvedUpTo(String amount) {
    return '$amount تک منظور';
  }

  @override
  String readingDoc(String doc) {
    return 'آپ کا $doc پڑھا جا رہا ہے';
  }

  @override
  String get documentAi => 'دستاویز AI';

  @override
  String sure(String pct) {
    return '$pct% یقینی';
  }

  @override
  String get readMatches => 'یہ وہی دستاویز ہے جو ہم نے مانگا تھا';

  @override
  String get readClear => 'صاف تصویر، دھندلاہٹ یا چمک نہیں';

  @override
  String get whatWeRead => 'ہم نے کیا پڑھا';

  @override
  String get looksRight => 'درست ہے';

  @override
  String get fieldName => 'نام';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'آدھار';

  @override
  String get fieldEmployer => 'آجر';

  @override
  String get fieldNetPay => 'خالص تنخواہ';

  @override
  String get fieldPeriod => 'تنخواہ کی مدت';

  @override
  String get fieldYear => 'سال';

  @override
  String get fieldIncome => 'آمدنی';

  @override
  String get fieldBusiness => 'کاروبار';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'آپ کے لون کے لیے ضروری';

  @override
  String get consentSectionOptional => 'اختیاری: جب تک آپ آن نہ کریں، بند';

  @override
  String get advancedOptions => 'اختیارات';

  @override
  String consentValidUntil(String given, String until) {
    return '$given کو دی گئی · $until تک درست';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given کو دی گئی · واپس لینے تک';
  }

  @override
  String get recheckTitle => 'رقم دینے سے ٹھیک پہلے ایک اور جانچ';

  @override
  String get recheckBody =>
      'رقم دینے سے ٹھیک پہلے ہم آپ کی کریڈٹ رپورٹ دوبارہ دیکھتے ہیں۔ انکار پر افسر تب آپ سے پوچھ سکتا ہے۔';

  @override
  String get aaMonthsLabel => 'کتنے مہینوں کی اسٹیٹمنٹ دیں';

  @override
  String monthsN(String n) {
    return '$n مہینے';
  }

  @override
  String get aaAccountsLabel => 'دیے جانے والے اکاؤنٹ';

  @override
  String get accountSavingsSalary => 'بچت اکاؤنٹ ·· 0912 · تنخواہ کی آمد';

  @override
  String get accountSavings => 'بچت اکاؤنٹ ·· 4821';

  @override
  String get accountFd => 'فکسڈ ڈپازٹ ·· 3307';

  @override
  String get aaAccountNeeded => 'کم از کم ایک اکاؤنٹ منتخب کریں۔';

  @override
  String get kycMethodLabel => 'اپنی شناخت کیسے تصدیق کریں';

  @override
  String get kycAadhaarOtp => 'آدھار OTP';

  @override
  String get kycDigilocker => 'ڈیجی لاکر';

  @override
  String get kycVideo => 'ویڈیو KYC کال';

  @override
  String get useCkycTitle => 'میرا موجودہ CKYC ریکارڈ استعمال کریں';

  @override
  String get useCkycBody =>
      'اگر آپ نے کسی اور بینک یا فنڈ کے ساتھ KYC کیا ہے، تو دوبارہ پوچھنے کے بجائے ہم وہی ریکارڈ لے لیتے ہیں۔';

  @override
  String get optOffersTitle => 'پیشکشیں اور نئی مصنوعات';

  @override
  String get optOffersBody =>
      'منتخب کریں کہ پیشکشوں کے بارے میں کیسے جاننا چاہتے ہیں۔ انہیں کبھی بھی بند کر سکتے ہیں۔';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ای میل';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp پر لون اپ ڈیٹس';

  @override
  String get optUpdatesBody =>
      'SMS کے ساتھ WhatsApp پر اسٹیٹس اپ ڈیٹس اور EMI یاددہانیاں۔';

  @override
  String get optInsuranceTitle => 'ہوم لون تحفظ کا کوٹیشن';

  @override
  String get optInsuranceBody =>
      'کوٹیشن کے لیے اپنا نام، عمر اور لون کی رقم ہمارے انشورنس شراکت دار کو دیں۔ خریدنا کبھی ضروری نہیں۔';

  @override
  String get getQuote => 'کوٹیشن لیں';

  @override
  String get manageConsents => 'رضامندیاں سنبھالیں';

  @override
  String get manageConsentsBody =>
      'اختیاری رضامندیاں کبھی بھی بند کریں۔ ضروری رضامندی واپس لینے پر درخواست رک جاتی ہے، اور اس کے لیے لیا گیا ڈیٹا ہم مٹا دیتے ہیں۔';

  @override
  String get withdraw => 'واپس لیں';

  @override
  String get consentHistory => 'رضامندی کی تاریخ';

  @override
  String historyGiven(String item) {
    return '$item دی گئی';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item واپس لی گئی';
  }

  @override
  String get historyEmpty => 'ابھی کچھ نہیں۔';

  @override
  String get consentOn => 'آن';

  @override
  String get consentOff => 'بند';

  @override
  String get withdrawnRequired =>
      'آپ نے ایک ضروری رضامندی واپس لی، اس لیے درخواست رکی ہوئی ہے۔';

  @override
  String get checkMatchPending =>
      'تصویر کا ملان: آدھار یا پین کارڈ اپ لوڈ کرنے پر ہوگا';
}
