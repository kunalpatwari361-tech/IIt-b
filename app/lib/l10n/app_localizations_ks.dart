// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kashmiri (`ks`).
class AppLocalizationsKs extends AppLocalizations {
  AppLocalizationsKs([String locale = 'ks']) : super(locale);

  @override
  String get appTitle => 'نِرنَے';

  @override
  String get sandboxBanner => 'ڈیمو موڈ: نمونہ ڈیٹا، اصل جانچ نہ';

  @override
  String get continueLabel => 'جٲری تھٲوِو';

  @override
  String stepOf(String step, String total) {
    return 'قدم $step / $total';
  }

  @override
  String get pleaseWait => 'مہربٲنی کٔرِتھ پرارِو…';

  @override
  String get errorGeneric => 'کینٛہہ گۄڑبڑ گیہِ۔ دوبارٕ کوشش کٔرِو۔';

  @override
  String get close => 'بند کٔرِو';

  @override
  String get welcomeHeadline => 'کینٛہہ منٹن منٛز تُہُند ہوم لون فیصلہٕ';

  @override
  String get welcomeBody =>
      'ہوم لون یا جایداد پیٹھ لون خٲطرٕ درخواست دِیِو۔ أسۍ چھِ سورُے آن لائن جانچان تہٕ ہمیشہ فیصلُک وجہ ونان۔';

  @override
  String get chooseProduct => 'تۄہہ کیاہ چھُ یژھان؟';

  @override
  String get productHomeLoan => 'ہوم لون';

  @override
  String get productHomeLoanSub => 'گرٛہ کھرید کرُن، بناوُن یا ٹھیک کرُن';

  @override
  String get productLap => 'جایداد پیٹھ لون';

  @override
  String get productLapSub => 'پننہِ جایدادِ پیٹھ قرض نِیو';

  @override
  String get startApplication => 'درخواست شروٗع کٔرِو';

  @override
  String get demoCustomers => 'ڈیمو گاہک';

  @override
  String get demoCustomersBody =>
      'نمونہ موبائل نمبر بَرنہٕ خٲطرٕ اکِس پیٹھ ٹیپ کٔرِو۔';

  @override
  String get personaRavi => 'روی، 32، نوکری کرن وول، فلیٹ کھرید کران';

  @override
  String get personaMeena => 'مینا، 45، پلَون ہنٛز دُکان چلاوان (LAP)';

  @override
  String get personaArjun =>
      'ارجن، 29، نوکری کرن وول، بَدلاونہٕ آمِژ تنخواہ پرچی';

  @override
  String get signInTitle => 'سائن اِن';

  @override
  String get mobileLabel => 'موبائل نمبر';

  @override
  String get mobileHint => '10 ہندسن ہُند موبائل نمبر';

  @override
  String get invalidMobile => 'صحیح 10 ہندسن ہُند موبائل نمبر دِیِو۔';

  @override
  String get sendOtp => 'OTP سوزِو';

  @override
  String otpSentTo(String phone) {
    return 'أسۍ سوٗز $phone پیٹھ 6 ہندسن ہُند کوڈ۔';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'تصدیق کٔرِو';

  @override
  String get demoOtp => 'ڈیمو کوڈ: 123456';

  @override
  String get wrongOtp => 'کوڈ چھُ غلط۔ دوبارٕ کوشش کٔرِو۔';

  @override
  String get deviceBound =>
      'یہِ فون چھُ وۄنۍ تُہٕندِس کھاتس سٕتۍ جُڑیومُت۔ بیٛاکِس فونس پیٹھ سائن اِن خٲطرٕ گژھِ نوٚو OTP۔';

  @override
  String get consentTitle => 'تُہٕنز رضامندی';

  @override
  String get consentIntro =>
      'أسۍ چھِ تُہُند ڈیٹا صرف یَتھ لونس ہٕندِس فیصلس تہٕ انتظامس خٲطرٕ استعمال کران۔ تُہۍ ہیٚکِو کُنہِ ساتہٕ رضامندی واپس ہٮ۪تھ۔';

  @override
  String get consentBureauTitle => 'کریڈٹ رپورٹ';

  @override
  String get consentBureauBody =>
      'کریڈٹ بیورو (CIBIL، Experian، Equifax یا CRIF) پیٹھٕ یِیہِ تُہٕنز کریڈٹ تاریخ وُچھنہٕ۔ امہِ سٕتۍ چھُ نہٕ تُہُند اسکور کم گژھان۔';

  @override
  String get consentAaTitle => 'اکاؤنٹ ایگریگیٹرٕ ذریعہٕ بینک اسٹیٹمنٹ';

  @override
  String get consentAaBody =>
      'RBI لائسنس یافتہ اکاؤنٹ ایگریگیٹرٕ ذریعہٕ یِیہِ تُہٕنزِ بینکہٕ پیٹھٕ 12 رٮ۪تن ہٕنز اسٹیٹمنٹ اَنٕنہٕ۔ درخواست کٔرِو تُہۍ پننہِ AA ایپہِ منٛز منظور۔';

  @override
  String get consentKycTitle => 'آدھار eKYC تہٕ PAN';

  @override
  String get consentKycBody =>
      'UIDAI تہٕ انکم ٹیکس محکمس سٕتۍ یِیہِ تُہٕنز پہچان تصدیق کرنہٕ۔ أسۍ چھِ صرف ژھوٗپراونہٕ آمُت آدھار نمبر تھاوان۔';

  @override
  String get consentPrivacyTitle => 'رازداری نوٹس (DPDP ایکٹ 2023)';

  @override
  String get consentPrivacyBody =>
      'أسۍ کیاہ چھِ جمع کران: پہچان، آمدنی، بینک تہٕ جایدادِ ہٕندۍ تفصیل۔ کیازِ: تُہٕندِس لونس ہٕندِس فیصلس تہٕ انتظامس خٲطرٕ۔ کوتاہ کال: یوت قانون ونہِ۔ تُہٕندۍ حق: پنُن ڈیٹا وُچھُن، ٹھیک کرُن یا مِٹاوُن، تہٕ سانہِ شکایت افسرس یا ڈیٹا پروٹیکشن بورڈس نِش شکایت کرٕنۍ۔';

  @override
  String get consentRequired => 'ضروری';

  @override
  String get consentNeeded =>
      'برونٛہہ کُن پَکنہٕ خٲطرٕ دِیِو سارنی پیٹھ رضامندی۔';

  @override
  String get agreeAndContinue => 'رضامندی دِتھ برونٛہہ پٔکِو';

  @override
  String get detailsTitle => 'تُہٕندۍ تفصیل';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'صحیح PAN دِیِو، یِتھہٕ پٲٹھۍ ABCDE1234F۔';

  @override
  String get fetchDetails => 'میٲنۍ تفصیل اَنِو';

  @override
  String get fetchedFrom =>
      'PAN، آدھار eKYC تہٕ بینک اسٹیٹمنٹہِ پیٹھٕ بٔرِتھ۔ ٹھیک کرنہٕ خٲطرٕ ہندسس پیٹھ ٹیپ کٔرِو۔';

  @override
  String get nameLabel => 'ناو';

  @override
  String get dobLabel => 'زٕنہٕ تٲریخ';

  @override
  String get employmentLabel => 'کٲم';

  @override
  String get salaried => 'نوکری کرن وول';

  @override
  String get selfEmployed => 'پنُن کاروبار';

  @override
  String get incomeLabel => 'رٮ۪تہٕ وار خالص آمدنی';

  @override
  String get existingEmiLabel => 'موجودٕ رٮ۪تہٕ وار EMI';

  @override
  String get propertyValueLabel => 'جایدادِ ہٕنز قیمت';

  @override
  String get loanAmountLabel => 'لونُک رقم';

  @override
  String get tenureLabel => 'مُدت';

  @override
  String yearsLabel(String n) {
    return '$n ؤری';
  }

  @override
  String get eligibleTitle => 'تُہۍ ہیٚکِو زیادٕ کھۄتہٕ زیادٕ نِتھ';

  @override
  String emiPerMonth(String amount) {
    return 'رٮ۪تہٕ وار EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'ؤری وار $rate%، بدلن وٲلۍ شرح (مثال)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'آمدنی ہٕنز حد: تُہٕنزٕ ساری EMI ہیٚکن آمدنی ہٕندِس $pct تام آسِتھ۔';
  }

  @override
  String limitedByProperty(String pct) {
    return 'جایدادِ ہٕنز حد: یوت لون ہیٚکہِ قیمتہِ ہٕندِس $pct تام آسِتھ۔';
  }

  @override
  String get limitedByAsked => 'یہِ چھُ تُہُند مونٛگمُت رقم۔';

  @override
  String get eligibilityNote =>
      'تُہٕندیٚن تفصیلن ہٕنز جلدی جانچ۔ سانہِ جانچہِ پتہٕ یِیہِ پیشکش۔';

  @override
  String get selfieTitle => 'سیلفی نِیو';

  @override
  String get selfieBody =>
      'أسۍ چھِ تُہُند بُتھ آدھار فوٹوہس سٕتۍ مِلاوان تہٕ وُچھان زِ یہِ چھِو واقعی تُہۍ، فوٹوہُک فوٹو نہٕ۔';

  @override
  String get selfieTips => 'جان گاش، کیمرس کُن وُچھِو، ٹوپی یا عینک نہٕ۔';

  @override
  String get takeSelfie => 'سیلفی نِیو';

  @override
  String get retake => 'دوبارٕ نِیو';

  @override
  String get checkFace => 'بُتھ لوٚب';

  @override
  String get checkLive => 'زندٕ انسان';

  @override
  String get checkMatch => 'آدھار فوٹوہس سٕتۍ چھُ مِلان';

  @override
  String get selfieFailed =>
      'أسۍ ہیٚکٕو نہٕ تُہٕندِس بُتھِس تصدیق کٔرِتھ۔ جانِہ گاشس منٛز دوبارٕ کوشش کٔرِو، یا وڈیو KYC کال بُک کٔرِو۔';

  @override
  String get videoKyc => 'وڈیو KYC کال بُک کٔرِو';

  @override
  String get docsTitle => 'تُہٕندۍ دستاویز';

  @override
  String get docsBody => 'پرٛتھ دستاویزُک صاف فوٹو نِیو، یا گیلری منٛزٕ ژارِو۔';

  @override
  String get docPan => 'PAN کارڈ';

  @override
  String get docAadhaar => 'آدھار کارڈ (ژھوٗپراونہٕ آمُت)';

  @override
  String get docSalarySlip => 'تازٕ تنخواہ پرچی';

  @override
  String get docForm16 => 'فارم 16';

  @override
  String get docItr => 'انکم ٹیکس ریٹرن (ITR)';

  @override
  String get docGst => 'GST سرٹیفکیٹ';

  @override
  String get docBankStatement => 'بینک اسٹیٹمنٹ';

  @override
  String get bankViaAa => 'تُہٕندِس اکاؤنٹ ایگریگیٹرٕ ذریعہٕ اَنٕنہٕ آمُت';

  @override
  String get camera => 'کیمرہ';

  @override
  String get gallery => 'گیلری';

  @override
  String get checking => 'جانچ چھےٚ سپدان…';

  @override
  String get tooBlurry => 'واریاہ دُھنٛدلہٕ۔ فون ٹھہراوِتھ دوبارٕ کوشش کٔرِو۔';

  @override
  String get tooMuchGlare => 'واریاہ چمک۔ گاشہٕ نِشہِ ہٹِتھ دوبارٕ کوشش کٔرِو۔';

  @override
  String get tooDark => 'واریاہ اَنہٕ گٹہٕ۔ زیادٕ گاشس منٛز دوبارٕ کوشش کٔرِو۔';

  @override
  String docAccepted(String type) {
    return 'پرٛزنووُن: $type';
  }

  @override
  String docWrong(String expected) {
    return 'یہِ چھُ نہٕ $expected باسان۔ جانچ کٔرِتھ صحیح دستاویز اپلوڈ کٔرِو۔';
  }

  @override
  String get docUnreadable =>
      'أسۍ ہیٚکٕو نہٕ یہِ دستاویز پٔرِتھ۔ زیادٕ صاف فوٹو نِیو، یا اصل PDF اپلوڈ کٔرِو۔';

  @override
  String docsMissing(String n) {
    return 'وۄنۍ $n گژھن';
  }

  @override
  String get getOffer => 'میٲنۍ اصولی پیشکش ہٲوِو';

  @override
  String get approvedInPrinciple => 'اصولی طور منظور';

  @override
  String get sanctioned => 'لون منظور';

  @override
  String get referredTitle => 'أسۍ گژھِ کینٛہہ زیادٕ وقت';

  @override
  String get rejectedTitle => 'أسۍ ہیٚکو نہٕ وۄنۍ یہِ لون دِتھ';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years ؤری · ؤری وار $rate% بدلن وٲلۍ';
  }

  @override
  String get whyOffer => 'تۄہہ کیازِ میٚلۍ یہِ پیشکش';

  @override
  String get whyReferred => 'برونٛہہ کیاہ سپدِ';

  @override
  String get whyRejected => 'أسۍ کیازِ کوٚر یہِ فیصلہٕ';

  @override
  String get referBody =>
      'اکھ افسر وُچھِ اکِس کٲمہِ دۄہس منٛز تُہٕنز درخواست۔ وۄنۍ چھُ نہٕ تۄہہ کینٛہہ کرُن۔';

  @override
  String get rejectBody =>
      'تُہۍ ہیٚکِو کُنہِ ساتہٕ کٲنٛسہِ انسانس یَتھ فیصلس پیٹھ نظرثانی کرنہٕ خٲطرٕ وٕنِتھ۔';

  @override
  String get addProperty => 'جایدادِ ہٕندۍ تفصیل شٲمِل کٔرِو';

  @override
  String get viewKfs => 'اہم حقیقتن ہُند بیان وُچھِو';

  @override
  String get grievance => 'نظرثانی مَنٛگِو یا شکایت کٔرِو';

  @override
  String officerLine(String name, String email) {
    return 'شکایت افسر: $name، $email';
  }

  @override
  String applicationNo(String id) {
    return 'درخواست $id';
  }

  @override
  String get startOver => 'نٔو درخواست شروٗع کٔرِو';

  @override
  String okScore(String score) {
    return 'ادائیگی ہٕنز مضبوط تاریخ (اسکور $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI چھِ آمدنی ہُند $pct؛ سٲنۍ حد $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'لون چھُ جایدادِ ہٕنزِ قیمتہِ ہُند $pct؛ حد $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'جایدادِ ہٕنز سٲنۍ قیمت: $low پیٹھٕ $high تام';
  }

  @override
  String get okTitle => 'جایدادِ ہٕنز مٲلکی تہٕ کاغذات جانچنہٕ آمٕتۍ';

  @override
  String get reasonKyc01 =>
      'فوٹوہ پیٹھٕ ہیٚکٕو نہٕ تُہٕنز پہچان تصدیق کٔرِتھ۔ مہربٲنی کٔرِتھ اکھ لۄکٕٹ وڈیو KYC کال مکمل کٔرِو۔';

  @override
  String get reasonFrd02 =>
      'تنخواہ پرچی ہٕنز آمدنی چھےٚ نہٕ بینکس منٛز جمع رقمس سٕتۍ مِلان۔ پنُن تازٕ فارم 16 دِیِو، یا رضامندی سٕتۍ دِیِو أسۍ اَنُن۔';

  @override
  String get reasonFrd03 =>
      'تُہُند اکھ دستاویز گوو جٲری کرن وٲلِس ادارس ہٕنزِ تصدیقہِ منٛز ناکام۔';

  @override
  String get reasonPol01 =>
      'درخواست دِنہٕ وٲلِس پَزِ کم از کم 21 ؤری عمر آسٕنۍ۔';

  @override
  String get reasonPol02 =>
      'لون گژھِ سانہِ اجازت دِنہٕ آمژِ زیادٕ کھۄتہٕ زیادٕ عمرِ برونٛہہ۔ کم عمرُک ساتھی درخواست دِنہٕ وول شٲمِل کرنہٕ سٕتۍ ہیٚکہِ مدد مٮ۪لِتھ۔';

  @override
  String get reasonBur01 =>
      'تُہُند کریڈٹ اسکور چھُ سانہِ کم از کم 650 کھۄتہٕ کم۔';

  @override
  String get reasonBur04 =>
      'تُہٕنز چھےٚ نہٕ وۄنۍ تام کریڈٹ تاریخ، امہِ موجوب وُچھِ اکھ افسر تُہٕندۍ بینک ریکارڈ۔';

  @override
  String get reasonBur05 => 'تُہٕندِس کریڈٹ اسکورس چھےٚ افسرٕ سٕنز نظر لازمی۔';

  @override
  String get reasonPrp01 =>
      'سانِس وکیلس پَزِ جایدادِ ہٕنزِ مٲلکی ہُند جائزٕ ہیوٚن۔';

  @override
  String get reasonPrp03 =>
      'قیمتہِ ہٕنزِ تصدیقہِ خٲطرٕ پَزِ سانِس قیمت لاگن وٲلِس جایداد وُچھٕنۍ۔';

  @override
  String get reasonPrp04 =>
      'معاہدُک قیمت چھُ یَتھ جایدادِ ہٕندِس سرکٲری سرکل ریٹس کھۄتہٕ کم۔ مہربٲنی کٔرِتھ کِنہٕ ہُند معاہدٕ جانچِو۔';

  @override
  String get reasonAff01 =>
      'تُہٕنزٕ موجودٕ EMI چھےٚ گۄڈے آمدنی ہُند زیادٕ کھۄتہٕ زیادٕ حصہٕ نِوان۔';

  @override
  String get reasonAut01 =>
      'یِتھہٕ بٔڈِس لونس ہٕنز آخری جانچ چھُ اکھ سینیئر افسر کران۔';

  @override
  String get reasonRsk01 =>
      'پیشکش طے کرنہٕ خٲطرٕ وُچھِ اکھ افسر تُہٕنز درخواست۔';

  @override
  String get reasonRsk02 =>
      'تُہٕندِس کریڈٹ پروفائلس پیٹھ ہیٚکو نہٕ أسۍ وۄنۍ یہِ لون دِتھ۔';

  @override
  String get propertyTitle => 'تُہٕنز جایداد';

  @override
  String get cityLabel => 'شہر';

  @override
  String get localityLabel => 'علاقہٕ';

  @override
  String get societyLabel => 'پروجیکٹ یا سوسائٹی (اگر آسہِ)';

  @override
  String get areaLabel => 'رقبہٕ (مربع فٹ)';

  @override
  String get bhkLabel => 'شونٛگنہٕ کُٹھ';

  @override
  String get newProperty => 'نٔو';

  @override
  String get resale => 'ری سیل';

  @override
  String get declaredPriceLabel => 'معاہدُک قیمت';

  @override
  String get photosTitle => 'جایدادِ ہٕندۍ فوٹو';

  @override
  String get photosBody =>
      'جایدادِ پیٹھ گٔژھِتھ نِیو فوٹو۔ أسۍ چھِ جاے تہٕ وقت شٲمِل کران، تاکہ قیمت لاگن وول ہیٚکہِ دورُک منصوبہٕ بنٲوِتھ۔';

  @override
  String get photoFront => 'برونٛہٕ کُن';

  @override
  String get photoInside => 'اندرٕ';

  @override
  String get photoView => 'جایدادِ پیٹھٕ نظارٕ';

  @override
  String geoTagged(String lat, String lng) {
    return 'جاے شٲمِل کرنہٕ آیہِ ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'فوٹو آو جایہِ ورٲے محفوظ کرنہٕ۔ جیو ٹیگ خٲطرٕ کٔرِو لوکیشن آن۔';

  @override
  String get submitProperty => 'آخری منظوری نِیو';

  @override
  String get fillAll => 'مہربٲنی کٔرِتھ بٔرِو پرٛتھ خانہٕ۔';

  @override
  String get kfsTitle => 'اہم حقیقتن ہُند بیان';

  @override
  String get kfsLoan => 'لونُک رقم';

  @override
  String get kfsTenure => 'مُدت';

  @override
  String get kfsRate => 'سودٕچ شرح';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI ہُند تعداد';

  @override
  String get kfsFee => 'پروسیسنگ فیس (GST سمیت)';

  @override
  String get kfsTotalInterest => 'کُل سود';

  @override
  String get kfsTotalPayable => 'کُل ادا کرنہٕ وول رقم';

  @override
  String get kfsApr => 'ؤری وار فیصد شرح (APR)';

  @override
  String get kfsCoolingOff =>
      'کولنگ آف مُدت: دستخطہٕ پتہٕ 3 دۄہن اندر ہیٚکِو صرف اصل رقم تہٕ تِمن دۄہن ہُند سود واپس دِتھ بغیر جرمانہٕ نیٚبر نٮ۪رِتھ۔';

  @override
  String get kfsNote =>
      'ڈیمو خٲطرٕ نمونہ ہندسہٕ۔ تُہُند اصل KFS یِیہِ منظوری خطس سٕتۍ۔';

  @override
  String get useSample => 'نمونہ';

  @override
  String get videoKycDemo =>
      'ڈیمو: امہِ سٕتۍ گژھِہے اکِس افسرس سٕتۍ وڈیو KYC کال بُک۔';

  @override
  String get raiseComplaint => 'شکایت کٔرِو';

  @override
  String complaintSent(String ref) {
    return 'تُہٕنز شکایت گیہِ درج۔ حوالہٕ $ref۔';
  }

  @override
  String get stageSignIn => 'سائن اِن';

  @override
  String get stageDetails => 'تفصیل';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'پیشکش';

  @override
  String get stageProperty => 'جایداد';

  @override
  String get homeSubtitle => 'ہوم لون · جایداد پیٹھ لون';

  @override
  String get heroPill => 'منٹن منٛز فیصلہٕ';

  @override
  String heroFacts(String rate, String years) {
    return 'ؤری وار $rate% پیٹھٕ · $years ؤری تام';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% مکمل · یتہِ ترٛوو اوٚس تتہِ پیٹھٕ شروٗع کٔرِو';
  }

  @override
  String get resume => 'جٲری تھٲوِو';

  @override
  String get calculators => 'کیلکولیٹر';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'رٮ۪تہٕ وار قسط';

  @override
  String get calcEligibility => 'اہلیت';

  @override
  String get calcEligibilitySub => 'تُہۍ ہیٚکِو کوتاہ نِتھ';

  @override
  String get emiCalcTitle => 'EMI کیلکولیٹر';

  @override
  String get eligibilityCalcTitle => 'اہلیت کیلکولیٹر';

  @override
  String totalInterest(String amount) {
    return 'کُل سود $amount';
  }

  @override
  String get calcIncomeOnly =>
      'صرف آمدنی ہٕندِس بنیادس پیٹھ۔ جایدادِ ہٕنز قیمت ہیٚکہِ یہِ کم کٔرِتھ۔';

  @override
  String get verified => 'تصدیق شُدہ';

  @override
  String get yourLoan => 'تُہُند لون';

  @override
  String docsProgress(String done, String total) {
    return '$total منٛزٕ $done تصدیق شُدہ';
  }

  @override
  String get docNeeded => 'گژھِ';

  @override
  String get docTryAgain => 'دوبارٕ کوشش';

  @override
  String get fetched => 'اَنٕنہٕ آو';

  @override
  String get statusApproved => 'منظور';

  @override
  String get statusSanctioned => 'منظور شُدہ';

  @override
  String get statusInReview => 'جائزس منٛز';

  @override
  String get statusDeclined => 'نامنظور';

  @override
  String get trackTitle => 'پنٕنۍ درخواست ٹریک کٔرِو';

  @override
  String get tlSubmitted => 'درخواست گیہِ جمع';

  @override
  String get tlVerified => 'KYC تہٕ دستاویزن ہٕنز تصدیق';

  @override
  String get tlInPrinciple => 'اصولی منظوری';

  @override
  String get tlProperty => 'جایدادِ ہٕندۍ تفصیل تہٕ قیمت';

  @override
  String get tlPropertyNext => 'پننہِ جایدادِ ہٕندۍ تفصیل تہٕ فوٹو شٲمِل کٔرِو';

  @override
  String get tlOfficer => 'افسرٕ سُنٛد جائزٕ';

  @override
  String get tlOfficerNext => 'اکِس کٲمہِ دۄہس اندر';

  @override
  String get tlLegal => 'قانونی تہٕ مٲلکی جانچ';

  @override
  String get tlSanction => 'آخری منظوری تہٕ ای دستخط';

  @override
  String get tlSanctionNext => 'پننِس منظوری خطس پیٹھ آن لائن دستخط کٔرِو';

  @override
  String get tlDisbursement => 'رقمٕچ ادائیگی';

  @override
  String get helpTitle => 'مدد گژھِ؟';

  @override
  String get propertyType => 'نٔو یا ری سیل';

  @override
  String get greetMorning => 'صُبح بخیر';

  @override
  String get greetAfternoon => 'دۄپہر بخیر';

  @override
  String get greetEvening => 'شام بخیر';

  @override
  String nearlyThere(String name) {
    return '$name، تُہۍ واتِو تقریباً';
  }

  @override
  String get chooseLanguage => 'پنٕنۍ زبان ژارِو';

  @override
  String get languageNote => 'تُہۍ ہیٚکِو یہِ کُنہِ ساتہٕ بدلٲوِتھ۔';

  @override
  String get liveChecks => 'لایو جانچ';

  @override
  String get checkBureau => 'کریڈٹ بیورو';

  @override
  String checkScore(String score) {
    return 'اسکور $score';
  }

  @override
  String get checkNoHistory => 'وۄنۍ تام کانٛہہ تاریخ نہٕ';

  @override
  String get checkBank => 'AA ذریعہٕ بینک';

  @override
  String get checkBankRead => '12 رٮ۪تہٕ پٔرِتھ';

  @override
  String get checkKyc => 'eKYC تہٕ سیلفی';

  @override
  String get checkPending => 'باقی';

  @override
  String get checkDocs => 'دستاویز';

  @override
  String countOf(String done, String total) {
    return '$total منٛزٕ $done';
  }

  @override
  String minutesLeft(String n) {
    return 'تقریباً $n منٹ باقی';
  }

  @override
  String ratePa(String rate) {
    return 'ؤری وار $rate%';
  }

  @override
  String get continueApplication => 'پنٕنۍ درخواست جٲری تھٲوِو';

  @override
  String get shapeOffer => 'پنٕنۍ پیشکش طے کٔرِو';

  @override
  String get shapeOfferSub => 'اصولی طور منظور · بدلاونہٕ خٲطرٕ کھٔنٛچِو';

  @override
  String get withinLimits => 'تُہٕنزِ حدِ اندر';

  @override
  String get aboveLimits => 'حدِ کھۄتہٕ زیادٕ: رقم کم کٔرِو یا ؤری ہُرٲوِو';

  @override
  String mostYouCan(String amount) {
    return 'زیادٕ کھۄتہٕ زیادٕ ہیٚکِو نِتھ: $amount';
  }

  @override
  String get useMax => 'زیادٕ کھۄتہٕ زیادٕ نِیو';

  @override
  String get principal => 'اصل رقم';

  @override
  String get interest => 'سود';

  @override
  String get totalRepaid => 'کُل ادائیگی';

  @override
  String get emiShareIncome => 'آمدنی منٛز EMI ہُند حصہٕ';

  @override
  String loanShareProperty(String value) {
    return '$value جایدادِ منٛز لونُک حصہٕ';
  }

  @override
  String get lockOffer => 'یہِ پیشکش پکٕ کٔرِو';

  @override
  String get offerLocked => 'تُہٕنز پیشکش گیہِ پکٕ۔';

  @override
  String approvedUpTo(String amount) {
    return '$amount تام منظور';
  }

  @override
  String readingDoc(String doc) {
    return 'تُہُند $doc چھُ پرنہٕ یِوان';
  }

  @override
  String get documentAi => 'دستاویز AI';

  @override
  String sure(String pct) {
    return '$pct% یقینی';
  }

  @override
  String get readMatches => 'یہِ چھُ سُے دستاویز یُس أسۍ مونٛگمُت اوٚس';

  @override
  String get readClear => 'صاف فوٹو، دُھنٛد یا چمک نہٕ';

  @override
  String get whatWeRead => 'أسۍ کیاہ پوٚر';

  @override
  String get looksRight => 'ٹھیک چھُ';

  @override
  String get fieldName => 'ناو';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'آدھار';

  @override
  String get fieldEmployer => 'مالک';

  @override
  String get fieldNetPay => 'خالص تنخواہ';

  @override
  String get fieldPeriod => 'تنخواہ ہٕنز مُدت';

  @override
  String get fieldYear => 'ؤری';

  @override
  String get fieldIncome => 'آمدنی';

  @override
  String get fieldBusiness => 'کاروبار';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'تُہٕندِس لونس خٲطرٕ ضروری';

  @override
  String get consentSectionOptional =>
      'اختیٲری: یوت تام تُہۍ آن کٔرِو نہٕ، بند';

  @override
  String get advancedOptions => 'اختیار';

  @override
  String consentValidUntil(String given, String until) {
    return '$given دِژ · $until تام صحیح';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given دِژ · واپس ہیٚنہٕ تام';
  }

  @override
  String get recheckTitle => 'رقم دِنہٕ برونٛہہ اکھ بیٚاکھ جانچ';

  @override
  String get recheckBody =>
      'رقم دِنہٕ برونٛہہ چھِ أسۍ تُہٕنز کریڈٹ رپورٹ دوبارٕ وُچھان۔ نہٕ وَنِو تہٕ ہیٚکہِ افسر تمہِ وِزِ پرٛژھِتھ۔';

  @override
  String get aaMonthsLabel => 'کوتاہ رٮ۪تن ہٕنز اسٹیٹمنٹ دِیِو';

  @override
  String monthsN(String n) {
    return '$n رٮ۪تہٕ';
  }

  @override
  String get aaAccountsLabel => 'دِنہٕ وٲلۍ کھاتہٕ';

  @override
  String get accountSavingsSalary => 'بچت کھاتہٕ ·· 0912 · تنخواہ جمع';

  @override
  String get accountSavings => 'بچت کھاتہٕ ·· 4821';

  @override
  String get accountFd => 'فکسڈ ڈپازٹ ·· 3307';

  @override
  String get aaAccountNeeded => 'کم از کم اکھ کھاتہٕ ژارِو۔';

  @override
  String get kycMethodLabel => 'پنٕنۍ پہچان کِتھہٕ پٲٹھۍ تصدیق کٔرِو';

  @override
  String get kycAadhaarOtp => 'آدھار OTP';

  @override
  String get kycDigilocker => 'ڈیجی لاکر';

  @override
  String get kycVideo => 'وڈیو KYC کال';

  @override
  String get useCkycTitle => 'میون موجودٕ CKYC ریکارڈ استعمال کٔرِو';

  @override
  String get useCkycBody =>
      'اگر تُہۍ بیٛاکِس بینکس یا فنڈس سٕتۍ KYC کوٚرمُت چھُو، تیٚلہِ چھِ أسۍ دوبارٕ پرٛژھنہٕ بدلہٕ سُے ریکارڈ ہیوان۔';

  @override
  String get optOffersTitle => 'پیشکشہٕ تہٕ نٔوۍ چیز';

  @override
  String get optOffersBody =>
      'ژارِو زِ پیشکشن متعلق کِتھہٕ پٲٹھۍ زانُن چھُو یژھان۔ یِمن ہیٚکِو کُنہِ ساتہٕ بند کٔرِتھ۔';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ای میل';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp پیٹھ لون اپ ڈیٹ';

  @override
  String get optUpdatesBody =>
      'SMS سٕتۍ سٕتۍ WhatsApp پیٹھ اسٹیٹس اپ ڈیٹ تہٕ EMI یاد۔';

  @override
  String get optInsuranceTitle => 'ہوم لون حفاظتُک کوٹیشن';

  @override
  String get optInsuranceBody =>
      'کوٹیشن خٲطرٕ دِیِو پنُن ناو، عمر تہٕ لونُک رقم سانِس انشورنس شریکس۔ کھرید کرُن چھُ نہٕ زانٛہہ ضروری۔';

  @override
  String get getQuote => 'کوٹیشن نِیو';

  @override
  String get manageConsents => 'رضامندی سنبھٲلِو';

  @override
  String get manageConsentsBody =>
      'اختیٲری رضامندی کٔرِو کُنہِ ساتہٕ بند۔ ضروری رضامندی واپس ہیٚنہٕ سٕتۍ چھےٚ درخواست رُکان، تہٕ امہِ خٲطرٕ اَنٕنہٕ آمُت ڈیٹا چھِ أسۍ مِٹاوان۔';

  @override
  String get withdraw => 'واپس نِیو';

  @override
  String get consentHistory => 'رضامندی ہٕنز تاریخ';

  @override
  String historyGiven(String item) {
    return '$item دِژ';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item واپس ہیٚژ';
  }

  @override
  String get historyEmpty => 'وۄنۍ تام کینٛہہ نہٕ۔';

  @override
  String get consentOn => 'آن';

  @override
  String get consentOff => 'بند';

  @override
  String get withdrawnRequired =>
      'تُہۍ ہیٚژ اکھ ضروری رضامندی واپس، امہِ موجوب چھےٚ درخواست رُکمٕژ۔';

  @override
  String get checkMatchPending =>
      'تصویر میلان: آدھار یا پین کارڈ اپ لوڈ کرنہٕ پیٹھ';
}
