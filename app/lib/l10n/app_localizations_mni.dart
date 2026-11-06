// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Manipuri (`mni`).
class AppLocalizationsMni extends AppLocalizations {
  AppLocalizationsMni([String locale = 'mni']) : super(locale);

  @override
  String get appTitle => 'নির্ণয়';

  @override
  String get sandboxBanner => 'ডেমো মোড: খুদম ডেটা, অচুম্বা চেকপ নত্তে';

  @override
  String get continueLabel => 'মখা চত্থরো';

  @override
  String stepOf(String step, String total) {
    return 'খোংথাং $step / $total';
  }

  @override
  String get pleaseWait => 'চানবীদুনা ঙাইবীয়ু…';

  @override
  String get errorGeneric => 'করিগুম্বা অশোয়বা থোকখ্রে। অমুক হন্না হোৎনবীয়ু।';

  @override
  String get close => 'লোইশিনবীয়ু';

  @override
  String get welcomeHeadline => 'মিনিট খরগী মনুংদা নখোয়গী য়ুম লোনগী ৱারেপ';

  @override
  String get welcomeBody =>
      'য়ুম লোন নত্রগা লমগী মথক্তা লোনগীদমক এপ্লাই তৌবীয়ু। ঐখোয়না পুম্নমক অনলাইনদা চেক তৌই অমসুং ৱারেপকী মরম মতম পুম্বদা তাকই।';

  @override
  String get chooseProduct => 'নহাক্কী করি মথৌ তাবগে?';

  @override
  String get productHomeLoan => 'য়ুম লোন';

  @override
  String get productHomeLoanSub => 'য়ুম লৈবা, সাবা নত্রগা শেমদোকপা';

  @override
  String get productLap => 'লমগী মথক্তা লোন';

  @override
  String get productLapSub => 'নহাক্কী লমগী মথক্তা লোন লৌবীয়ু';

  @override
  String get startApplication => 'এপ্লিকেসন হৌবীয়ু';

  @override
  String get demoCustomers => 'ডেমো কস্টমরশিং';

  @override
  String get demoCustomersBody => 'খুদম মোবাইল নম্বর থাগৎনবা অমদা টেপ তৌবীয়ু।';

  @override
  String get personaRavi => 'রবি, 32, থবক তৌবা, ফ্লেট লৈরি';

  @override
  String get personaMeena => 'মীনা, 45, ফি দুকান চলাই (LAP)';

  @override
  String get personaArjun => 'অর্জুন, 29, থবক তৌবা, হোংদোকখিবা সেলারি স্লিপ';

  @override
  String get signInTitle => 'সাইন ইন';

  @override
  String get mobileLabel => 'মোবাইল নম্বর';

  @override
  String get mobileHint => 'মশিং 10 লৈবা মোবাইল নম্বর';

  @override
  String get invalidMobile => 'চুম্বা মশিং 10গী মোবাইল নম্বর হাপচিনবীয়ু।';

  @override
  String get sendOtp => 'OTP থাবীয়ু';

  @override
  String otpSentTo(String phone) {
    return '$phoneদা মশিং 6গী কোড থাখ্রে।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'চেক তৌবীয়ু';

  @override
  String get demoOtp => 'ডেমো কোড: 123456';

  @override
  String get wrongOtp => 'কোড অসি অশোয়বা লৈ। অমুক হন্না হোৎনবীয়ু।';

  @override
  String get deviceBound =>
      'ফোন অসি হৌজিক নহাক্কী একাউন্টগা শম্নখ্রে। অতোপ্পা ফোনদা সাইন ইন তৌনবা অনৌবা OTP মথৌ তাই।';

  @override
  String get consentTitle => 'নহাক্কী অয়াবা';

  @override
  String get consentIntro =>
      'ঐখোয়না নহাক্কী ডেটা লোন অসিগী ৱারেপ অমসুং পাংথোকপগীদমক খক্তা শিজিন্নই। নহাক্না মতম কয়াদা অয়াবা হন্দোকপা য়াই।';

  @override
  String get consentBureauTitle => 'ক্রেডিট রিপোর্ট';

  @override
  String get consentBureauBody =>
      'ক্রেডিট ব্যুরো (CIBIL, Experian, Equifax নত্রগা CRIF)দগী নহাক্কী ক্রেডিট হিস্টরী য়েংগনি। মসিনা নহাক্কী স্কোর হন্থহন্দে।';

  @override
  String get consentAaTitle => 'একাউন্ট এগ্রিগেটরগী খুত্থাংদা বেঙ্ক স্টেটমেন্ট';

  @override
  String get consentAaBody =>
      'RBI লাইসেন্স লৈবা একাউন্ট এগ্রিগেটরগী খুত্থাংদা নহাক্কী বেঙ্কদগী থা 12গী স্টেটমেন্ট পুরকনি। হায়জবা অদু নহাক্না নহাক্কী AA এপদা অয়াবা পীগনি।';

  @override
  String get consentKycTitle => 'আধার eKYC অমসুং PAN';

  @override
  String get consentKycBody =>
      'UIDAI অমসুং ইনকম টেক্স দিপার্টমেন্টগা লোয়ননা নহাক্কী মমিং খঙদোকপা চেক তৌগনি। ঐখোয়না নোংমাংবা আধার নম্বর খক্তা থম্মি।';

  @override
  String get consentPrivacyTitle => 'প্রাইভেসি নোটিস (DPDP এক্ট 2023)';

  @override
  String get consentPrivacyBody =>
      'ঐখোয়না করি পুল্লবগে: মমিং, শেন্থোকপা, বেঙ্ক অমসুং লমগী ৱাফমশিং। করিগীদমক: নহাক্কী লোনগী ৱারেপ অমসুং পাংথোকপগীদমক। মতম কয়া: আইননা হায়বা মতম খক্তা। নহাক্কী হক: ডেটা য়েংবা, শেমদোকপা নত্রগা মুথৎপা, অমসুং ঐখোয়গী গ্রিভান্স অফিসর নত্রগা ডেটা প্রোটেকসন বোর্ডদা নিংথিজবা থাবা।';

  @override
  String get consentRequired => 'মথৌ তাবা';

  @override
  String get consentNeeded => 'মখা চত্থনবা পুম্নমক্তা অয়াবা পীবীয়ু।';

  @override
  String get agreeAndContinue => 'অয়াবা পীদুনা মখা চত্থরো';

  @override
  String get detailsTitle => 'নহাক্কী ৱাফমশিং';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'চুম্বা PAN হাপচিনবীয়ু, খুদমগী ABCDE1234F।';

  @override
  String get fetchDetails => 'ঐগী ৱাফমশিং পুরকপীয়ু';

  @override
  String get fetchedFrom =>
      'PAN, আধার eKYC অমসুং বেঙ্ক স্টেটমেন্টদগী থাগৎখ্রে। শেমদোকপা মশিংদা টেপ তৌবীয়ু।';

  @override
  String get nameLabel => 'মমিং';

  @override
  String get dobLabel => 'পোকখিবা তারিখ';

  @override
  String get employmentLabel => 'থবক';

  @override
  String get salaried => 'থবক তৌবা';

  @override
  String get selfEmployed => 'মশাগী থবক';

  @override
  String get incomeLabel => 'থাগী শেন্থোকপা';

  @override
  String get existingEmiLabel => 'হৌজিক্কী থাগী EMI';

  @override
  String get propertyValueLabel => 'লমগী মমল';

  @override
  String get loanAmountLabel => 'লোনগী শেল';

  @override
  String get tenureLabel => 'মতম';

  @override
  String yearsLabel(String n) {
    return 'চহী $n';
  }

  @override
  String get eligibleTitle => 'নহাক্না খ্বাইদগী য়াম্না ফংবা য়াই';

  @override
  String emiPerMonth(String amount) {
    return 'থাগী EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'চহীগী $rate%, হোংবা য়াবা (খুদম)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'শেন্থোকপগী লান: নহাক্কী EMI পুম্নমক শেন্থোকপগী $pct ফাওবা য়াই।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'লমগী লান: লোন অসি মমলগী $pct ফাওবা য়াই।';
  }

  @override
  String get limitedByAsked => 'মসি নহাক্না হায়জখিবা শেলনি।';

  @override
  String get eligibilityNote =>
      'নহাক্কী ৱাফমশিংগী থুনা চেক। ঐখোয়গী চেক মতুংদা অফর লাকই।';

  @override
  String get selfieTitle => 'সেলফি লৌবীয়ু';

  @override
  String get selfieBody =>
      'ঐখোয়না নহাক্কী মমৈ আধারগী ফোতোগা চান্নহল্লি অমসুং মসি তশেংনা নহাক্নি, ফোতোগী ফোতো নত্তে হায়বা য়েংলি।';

  @override
  String get selfieTips =>
      'ফজবা মঙাল, কেমেরাদা য়েংবীয়ু, টুপি নত্রগা চশমা শিজিন্নগনু।';

  @override
  String get takeSelfie => 'সেলফি লৌবীয়ু';

  @override
  String get retake => 'অমুক হন্না লৌবীয়ু';

  @override
  String get checkFace => 'মমৈ ফংখ্রে';

  @override
  String get checkLive => 'হিংলিবা মীওই';

  @override
  String get checkMatch => 'আধারগী ফোতোগা চাই';

  @override
  String get selfieFailed =>
      'নহাক্কী মমৈ চেক তৌবা ঙমদ্রে। ফজবা মঙালদা অমুক হন্না হোৎনবীয়ু, নত্রগা ভিডিও KYC কল বুক তৌবীয়ু।';

  @override
  String get videoKyc => 'ভিডিও KYC কল বুক তৌবীয়ু';

  @override
  String get docsTitle => 'নহাক্কী লাইরিকশিং';

  @override
  String get docsBody =>
      'লাইরিক খুদিংমক্কী মঙাল ফজনা ফোতো লৌবীয়ু, নত্রগা গেলেরীদগী খনবীয়ু।';

  @override
  String get docPan => 'PAN কার্ড';

  @override
  String get docAadhaar => 'আধার কার্ড (নোংমাংবা)';

  @override
  String get docSalarySlip => 'অনৌবা সেলারি স্লিপ';

  @override
  String get docForm16 => 'ফর্ম 16';

  @override
  String get docItr => 'ইনকম টেক্স রিটার্ন (ITR)';

  @override
  String get docGst => 'GST সর্টিফিকেট';

  @override
  String get docBankStatement => 'বেঙ্ক স্টেটমেন্ট';

  @override
  String get bankViaAa => 'নহাক্কী একাউন্ট এগ্রিগেটরগী খুত্থাংদা পুরকখ্রে';

  @override
  String get camera => 'কেমেরা';

  @override
  String get gallery => 'গেলেরী';

  @override
  String get checking => 'চেক তৌরি…';

  @override
  String get tooBlurry =>
      'য়াম্না মঙাল নাইদ্রে। ফোন চেৎনা পাইদুনা অমুক হন্না হোৎনবীয়ু।';

  @override
  String get tooMuchGlare =>
      'য়াম্না জলোক্লি। মঙালদগী লাপ্না লেপ্লদুনা অমুক হন্না হোৎনবীয়ু।';

  @override
  String get tooDark =>
      'য়াম্না অমম্বা। মঙাল হেন্না লৈবা মফমদা অমুক হন্না হোৎনবীয়ু।';

  @override
  String docAccepted(String type) {
    return 'খঙদোকখ্রে: $type';
  }

  @override
  String docWrong(String expected) {
    return 'মসি $expected মাদি ঔদ্রে। চেক তৌদুনা চুম্বা লাইরিক আপলোড তৌবীয়ু।';
  }

  @override
  String get docUnreadable =>
      'লাইরিক অসি পাবা ঙমদ্রে। হেন্না মঙাল ফজবা ফোতো লৌবীয়ু, নত্রগা অশেংবা PDF আপলোড তৌবীয়ু।';

  @override
  String docsMissing(String n) {
    return 'হৌজিকসু $n মথৌ তাই';
  }

  @override
  String get getOffer => 'ঐগী প্রিন্সিপলগী অফর উৎপীয়ু';

  @override
  String get approvedInPrinciple => 'প্রিন্সিপলদা অয়াবা পীখ্রে';

  @override
  String get sanctioned => 'লোন অয়াবা পীখ্রে';

  @override
  String get referredTitle => 'ঐখোয়না মতম খরা হেন্না মথৌ তাই';

  @override
  String get rejectedTitle => 'হৌজিক লোন অসি পীবা ঙমদে';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · চহী $years · চহীগী $rate% হোংবা য়াবা';
  }

  @override
  String get whyOffer => 'নহাক্না অফর অসি করিগী ফংলিবগে';

  @override
  String get whyReferred => 'মতুংদা করি থোককনি';

  @override
  String get whyRejected => 'ঐখোয়না ৱারেপ অসি করিগী লৌখিবগে';

  @override
  String get referBody =>
      'অফিসর অমনা থবক নুমিৎ অমগী মনুংদা নহাক্কী এপ্লিকেসন য়েংগনি। হৌজিক নহাক্না করিমত্তা তৌরিগদবা লৈতে।';

  @override
  String get rejectBody =>
      'নহাক্না মতম কয়াদা মীওই অমদা ৱারেপ অসি অমুক হন্না য়েংনবা হায়বা য়াই।';

  @override
  String get addProperty => 'লমগী ৱাফমশিং হাপচিনবীয়ু';

  @override
  String get viewKfs => 'মরু ওইবা ৱাফমগী লাইরিক য়েংবীয়ু';

  @override
  String get grievance =>
      'অমুক হন্না য়েংনবা হায়জবীয়ু নত্রগা নিংথিজবা থাবীয়ু';

  @override
  String officerLine(String name, String email) {
    return 'গ্রিভান্স অফিসর: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'এপ্লিকেসন $id';
  }

  @override
  String get startOver => 'অনৌবা এপ্লিকেসন হৌবীয়ু';

  @override
  String okScore(String score) {
    return 'শেল হন্দোকপগী ফজবা হিস্টরী (স্কোর $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMIনা শেন্থোকপগী $pct লৌই; ঐখোয়গী লান $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'লোন অসি লমগী মমলগী $pct; লান $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'লমগী ঐখোয়গী মমল: $lowদগী $high ফাওবা';
  }

  @override
  String get okTitle => 'লমগী মালিকানা অমসুং লাইরিকশিং চেক তৌখ্রে';

  @override
  String get reasonKyc01 =>
      'ফোতোদগী নহাক্কী মমিং খঙদোকপা ঙমদ্রে। চানবীদুনা অপিকপা ভিডিও KYC কল অমা লোইশিনবীয়ু।';

  @override
  String get reasonFrd02 =>
      'সেলারি স্লিপকী শেন্থোকপা বেঙ্কতা চংবা শেলগা চাদে। নহাক্কী অনৌবা ফর্ম 16 পীবীয়ু, নত্রগা অয়াবা পীদুনা ঐখোয়বু পুরকনবা য়াবীয়ু।';

  @override
  String get reasonFrd03 =>
      'নহাক্কী লাইরিক অমা পীবা অথোরিটীগী চেকপদা মায় পাক্তে।';

  @override
  String get reasonPol01 => 'এপ্লাই তৌবা মীওইগী চহী খ্বাইদগী নমনা 21 ওইগদবনি।';

  @override
  String get reasonPol02 =>
      'লোন অসিনা ঐখোয়না য়াবা খ্বাইদগী য়াম্বা চহী শোনগনি। চহী নাপিবা কো-এপ্লিকেন্ট অমা হাপচিনবনা মতেং পাংবা য়াই।';

  @override
  String get reasonBur01 =>
      'নহাক্কী ক্রেডিট স্কোর ঐখোয়গী খ্বাইদগী নমবা 650দগী নাপই।';

  @override
  String get reasonBur04 =>
      'নহাক্কী হৌজিক ফাওবা ক্রেডিট হিস্টরী লৈতে, মরম অসিনা অফিসর অমনা নহাক্কী বেঙ্ক রেকর্ড য়েংগনি।';

  @override
  String get reasonBur05 =>
      'নহাক্কী ক্রেডিট স্কোর অফিসর অমনা চেকশিন্না য়েংগদবনি।';

  @override
  String get reasonPrp01 => 'ঐখোয়গী লোয়রনা লমগী মালিকানা য়েংগদবনি।';

  @override
  String get reasonPrp03 =>
      'মমল খঙদোকপগীদমক ঐখোয়গী ভেলুয়রনা লম অদু চৎলগা য়েংগদবনি।';

  @override
  String get reasonPrp04 =>
      'এগ্রিমেন্টকী মমল অসি লম অসিগী সরকারগী সর্কল রেটতগী নাপই। চানবীদুনা য়োনবগী এগ্রিমেন্ট চেক তৌবীয়ু।';

  @override
  String get reasonAff01 =>
      'নহাক্কী হৌজিক্কী EMIনা হান্নসু শেন্থোকপগী খ্বাইদগী য়াম্বা শরুক লৌরে।';

  @override
  String get reasonAut01 =>
      'য়াম্না চাউবা লোনশিংগী অরোইবা চেক সিনিয়র অফিসর অমনা তৌই।';

  @override
  String get reasonRsk01 =>
      'অফর লোইশিন্নবা অফিসর অমনা নহাক্কী এপ্লিকেসন য়েংগনি।';

  @override
  String get reasonRsk02 =>
      'নহাক্কী ক্রেডিট প্রোফাইলগী মথক্তা হৌজিক লোন অসি পীবা ঙমদে।';

  @override
  String get propertyTitle => 'নহাক্কী লম';

  @override
  String get cityLabel => 'সহর';

  @override
  String get localityLabel => 'লৈকাই';

  @override
  String get societyLabel => 'প্রোজেক্ট নত্রগা সোসাইটি (লৈরবদি)';

  @override
  String get areaLabel => 'লমগী চাউবা (স্কোয়ার ফুট)';

  @override
  String get bhkLabel => 'তুমফম কাংলুপ';

  @override
  String get newProperty => 'অনৌবা';

  @override
  String get resale => 'অমুক হন্না য়োনবা';

  @override
  String get declaredPriceLabel => 'এগ্রিমেন্টকী মমল';

  @override
  String get photosTitle => 'লমগী ফোতোশিং';

  @override
  String get photosBody =>
      'লম অদুদা চৎলগা ফোতো লৌবীয়ু। ভেলুয়রনা চৎনবা প্লেন তৌবা ঙম্নবা ঐখোয়না মফম অমসুং মতম হাপচিল্লি।';

  @override
  String get photoFront => 'মমাংগী শরুক';

  @override
  String get photoInside => 'মনুং';

  @override
  String get photoView => 'লমদগী উবা';

  @override
  String geoTagged(String lat, String lng) {
    return 'মফম হাপচিনখ্রে ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'মফম য়াওদনা ফোতো থম্মে। জিও-টেগকীদমক লোকেসন অন তৌবীয়ু।';

  @override
  String get submitProperty => 'অরোইবা অয়াবা ফংবীয়ু';

  @override
  String get fillAll => 'চানবীদুনা মফম পুম্নমক থাগৎপীয়ু।';

  @override
  String get kfsTitle => 'মরু ওইবা ৱাফমগী লাইরিক';

  @override
  String get kfsLoan => 'লোনগী শেল';

  @override
  String get kfsTenure => 'মতম';

  @override
  String get kfsRate => 'ইন্টরেস্ট রেট';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMIগী মশিং';

  @override
  String get kfsFee => 'প্রোসেসিং ফি (GST য়াওনা)';

  @override
  String get kfsTotalInterest => 'পুম্নমক ইন্টরেস্ট';

  @override
  String get kfsTotalPayable => 'পুম্নমক পীগদবা শেল';

  @override
  String get kfsApr => 'চহীগী পর্সেন্ট রেট (APR)';

  @override
  String get kfsCoolingOff =>
      'কুলিং-অফ মতম: সাইন তৌবা মতুংদা নুমিৎ 3গী মনুংদা মূল শেল অমসুং নুমিৎ অদুগী ইন্টরেস্ট খক্তা হন্দোক্লগা চাইরেং য়াওদনা থোকখিবা য়াই।';

  @override
  String get kfsNote =>
      'ডেমোগীদমক খুদম মশিংশিং। নহাক্কী অশেংবা KFS সেঙ্কসন চিঠিগা লোয়ননা লাকই।';

  @override
  String get useSample => 'খুদম';

  @override
  String get videoKycDemo => 'ডেমো: মসিনা অফিসর অমগা ভিডিও KYC কল বুক তৌগদবনি।';

  @override
  String get raiseComplaint => 'নিংথিজবা থাবীয়ু';

  @override
  String complaintSent(String ref) {
    return 'নহাক্কী নিংথিজবা রেজিস্টর তৌখ্রে। রেফরেন্স $ref।';
  }

  @override
  String get stageSignIn => 'সাইন ইন';

  @override
  String get stageDetails => 'ৱাফম';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'অফর';

  @override
  String get stageProperty => 'লম';

  @override
  String get homeSubtitle => 'য়ুম লোন · লমগী মথক্তা লোন';

  @override
  String get heroPill => 'মিনিট খরদা ৱারেপ';

  @override
  String heroFacts(String rate, String years) {
    return 'চহীগী $rate%দগী · চহী $years ফাওবা';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% লোইরে · থাদোকখিবা মফমদগী হৌবীয়ু';
  }

  @override
  String get resume => 'মখা চত্থরো';

  @override
  String get calculators => 'কেলকুলেটর';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'থাগী শেল';

  @override
  String get calcEligibility => 'চাবা য়াবা';

  @override
  String get calcEligibilitySub => 'নহাক্না কয়া ফংবা য়াই';

  @override
  String get emiCalcTitle => 'EMI কেলকুলেটর';

  @override
  String get eligibilityCalcTitle => 'চাবা য়াবগী কেলকুলেটর';

  @override
  String totalInterest(String amount) {
    return 'পুম্নমক ইন্টরেস্ট $amount';
  }

  @override
  String get calcIncomeOnly =>
      'শেন্থোকপগী মথক্তা খক্তা। লমগী মমলনা মসি হন্থহনবা য়াই।';

  @override
  String get verified => 'চেক তৌখ্রে';

  @override
  String get yourLoan => 'নহাক্কী লোন';

  @override
  String docsProgress(String done, String total) {
    return '$totalগী মনুংদা $done চেক তৌখ্রে';
  }

  @override
  String get docNeeded => 'মথৌ তাই';

  @override
  String get docTryAgain => 'অমুক হন্না হোৎনবীয়ু';

  @override
  String get fetched => 'পুরকখ্রে';

  @override
  String get statusApproved => 'অয়াবা পীখ্রে';

  @override
  String get statusSanctioned => 'সেঙ্কসন তৌখ্রে';

  @override
  String get statusInReview => 'য়েংলি';

  @override
  String get statusDeclined => 'য়াদ্রে';

  @override
  String get trackTitle => 'নহাক্কী এপ্লিকেসন ট্রেক তৌবীয়ু';

  @override
  String get tlSubmitted => 'এপ্লিকেসন থাখ্রে';

  @override
  String get tlVerified => 'KYC অমসুং লাইরিকশিং চেক তৌখ্রে';

  @override
  String get tlInPrinciple => 'প্রিন্সিপলগী অয়াবা';

  @override
  String get tlProperty => 'লমগী ৱাফম অমসুং মমল';

  @override
  String get tlPropertyNext => 'নহাক্কী লমগী ৱাফম অমসুং ফোতো হাপচিনবীয়ু';

  @override
  String get tlOfficer => 'অফিসরগী য়েংবা';

  @override
  String get tlOfficerNext => 'থবক নুমিৎ অমগী মনুংদা';

  @override
  String get tlLegal => 'আইন অমসুং মালিকানাগী চেক';

  @override
  String get tlSanction => 'অরোইবা অয়াবা অমসুং ই-সাইন';

  @override
  String get tlSanctionNext => 'সেঙ্কসন চিঠিদা অনলাইনদা সাইন তৌবীয়ু';

  @override
  String get tlDisbursement => 'শেল পীবা';

  @override
  String get helpTitle => 'মতেং মথৌ তাব্রা?';

  @override
  String get propertyType => 'অনৌবা নত্রগা অমুক হন্না য়োনবা';

  @override
  String get greetMorning => 'নুংঙাইবা অয়ুক';

  @override
  String get greetAfternoon => 'নুংঙাইবা নুমিৎ';

  @override
  String get greetEvening => 'নুংঙাইবা নুমিৎকাং';

  @override
  String nearlyThere(String name) {
    return '$name, নহাক য়াম্না নকখ্রে';
  }

  @override
  String get chooseLanguage => 'নহাক্কী লোল খনবীয়ু';

  @override
  String get languageNote => 'নহাক্না মসি মতম কয়াদা হোংদোকপা য়াই।';

  @override
  String get liveChecks => 'লাইভ চেক';

  @override
  String get checkBureau => 'ক্রেডিট ব্যুরো';

  @override
  String checkScore(String score) {
    return 'স্কোর $score';
  }

  @override
  String get checkNoHistory => 'হৌজিক ফাওবা হিস্টরী লৈতে';

  @override
  String get checkBank => 'AAগী খুত্থাংদা বেঙ্ক';

  @override
  String get checkBankRead => 'থা 12 পাখ্রে';

  @override
  String get checkKyc => 'eKYC অমসুং সেলফি';

  @override
  String get checkPending => 'লৈরি';

  @override
  String get checkDocs => 'লাইরিকশিং';

  @override
  String countOf(String done, String total) {
    return '$totalগী মনুংদা $done';
  }

  @override
  String minutesLeft(String n) {
    return 'মিনিট $n মখায় লৈরি';
  }

  @override
  String ratePa(String rate) {
    return 'চহীগী $rate%';
  }

  @override
  String get continueApplication => 'নহাক্কী এপ্লিকেসন মখা চত্থরো';

  @override
  String get shapeOffer => 'নহাক্কী অফর শেমবীয়ু';

  @override
  String get shapeOfferSub => 'প্রিন্সিপলদা অয়াবা পীখ্রে · হোংদোকপা চিংবীয়ু';

  @override
  String get withinLimits => 'নহাক্কী লানগী মনুংদা';

  @override
  String get aboveLimits =>
      'লান শোনখ্রে: শেল হন্থহনবীয়ু নত্রগা চহী হাপচিনবীয়ু';

  @override
  String mostYouCan(String amount) {
    return 'খ্বাইদগী য়াম্না লৌবা য়াই: $amount';
  }

  @override
  String get useMax => 'খ্বাইদগী য়াম্না লৌবীয়ু';

  @override
  String get principal => 'মূল শেল';

  @override
  String get interest => 'ইন্টরেস্ট';

  @override
  String get totalRepaid => 'পুম্নমক হন্দোকপা';

  @override
  String get emiShareIncome => 'শেন্থোকপদা EMIগী শরুক';

  @override
  String loanShareProperty(String value) {
    return '$valueগী লমদা লোনগী শরুক';
  }

  @override
  String get lockOffer => 'অফর অসি লোইশিনবীয়ু';

  @override
  String get offerLocked => 'নহাক্কী অফর লোইশিনখ্রে।';

  @override
  String approvedUpTo(String amount) {
    return '$amount ফাওবা অয়াবা পীখ্রে';
  }

  @override
  String readingDoc(String doc) {
    return 'নহাক্কী $doc পারি';
  }

  @override
  String get documentAi => 'লাইরিক AI';

  @override
  String sure(String pct) {
    return '$pct% শোয়দনা';
  }

  @override
  String get readMatches => 'মসি ঐখোয়না হায়জখিবা লাইরিকনি';

  @override
  String get readClear => 'মঙাল ফজবা ফোতো, নাইদবা নত্রগা জলোকপা লৈতে';

  @override
  String get whatWeRead => 'ঐখোয়না করি পাখিবগে';

  @override
  String get looksRight => 'চুম্মি';

  @override
  String get fieldName => 'মমিং';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'আধার';

  @override
  String get fieldEmployer => 'থবক পীবা';

  @override
  String get fieldNetPay => 'নেট সেলারি';

  @override
  String get fieldPeriod => 'সেলারিগী মতম';

  @override
  String get fieldYear => 'চহী';

  @override
  String get fieldIncome => 'শেন্থোকপা';

  @override
  String get fieldBusiness => 'সুবৈ';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'নহাক্কী লোনগীদমক মথৌ তাবা';

  @override
  String get consentSectionOptional => 'অপাম্বা: নহাক্না অন তৌদ্রিফাওবা অফ';

  @override
  String get advancedOptions => 'খনবা য়াবা';

  @override
  String consentValidUntil(String given, String until) {
    return '$givenদা পীখি · $until ফাওবা চলি';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$givenদা পীখি · হন্দোক্তবা ফাওবা';
  }

  @override
  String get recheckTitle => 'শেল পীদ্রিঙৈদা অমুক চেক অমা';

  @override
  String get recheckBody =>
      'শেল পীদ্রিঙৈদা ঐখোয়না নহাক্কী ক্রেডিট রিপোর্ট অমুক য়েংই। য়াদ্রবদি মতম অদুদা অফিসর অমনা হংবা য়াই।';

  @override
  String get aaMonthsLabel => 'থা কয়াগী স্টেটমেন্ট পীগদগে';

  @override
  String monthsN(String n) {
    return 'থা $n';
  }

  @override
  String get aaAccountsLabel => 'পীগদবা একাউন্টশিং';

  @override
  String get accountSavingsSalary => 'সেভিংস ·· 0912 · সেলারি চংবা';

  @override
  String get accountSavings => 'সেভিংস ·· 4821';

  @override
  String get accountFd => 'ফিক্সড ডিপোজিট ·· 3307';

  @override
  String get aaAccountNeeded => 'খ্বাইদগী নমনা একাউন্ট অমা খনবীয়ু।';

  @override
  String get kycMethodLabel => 'মমিং করম্না চেক তৌগনি';

  @override
  String get kycAadhaarOtp => 'আধার OTP';

  @override
  String get kycDigilocker => 'ডিজিলোকর';

  @override
  String get kycVideo => 'ভিডিও KYC কল';

  @override
  String get useCkycTitle => 'ঐগী হৌজিক্কী CKYC রেকর্ড শিজিন্নবীয়ু';

  @override
  String get useCkycBody =>
      'অতোপ্পা বেঙ্ক নত্রগা ফন্দতা KYC তৌরবদি, অমুক হংদনা ঐখোয়না রেকর্ড অদু পুরকই।';

  @override
  String get optOffersTitle => 'অফর অমসুং অনৌবা পোৎশিং';

  @override
  String get optOffersBody =>
      'অফরগী মরমদা করম্না খঙবা পাম্বগে খনবীয়ু। মতম কয়াদা অফ তৌবা য়াই।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ইমেল';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsAppতা লোনগী অপদেট';

  @override
  String get optUpdatesBody =>
      'SMSগা লোয়ননা WhatsAppতা স্টেটস অপদেট অমসুং EMI নিংশিংবা।';

  @override
  String get optInsuranceTitle => 'য়ুম লোন ঙাক-শেনবগী কোটেসন';

  @override
  String get optInsuranceBody =>
      'কোটেসনগীদমক নহাক্কী মমিং, চহী অমসুং লোনগী শেল ঐখোয়গী ইন্সুরেন্স পার্টনরদা পীবীয়ু। লৈবা মতম কয়াদা মথৌ তাদে।';

  @override
  String get getQuote => 'কোটেসন লৌবীয়ু';

  @override
  String get manageConsents => 'অয়াবা পাংথোকপা';

  @override
  String get manageConsentsBody =>
      'অপাম্বা অয়াবাশিং মতম কয়াদা অফ তৌবীয়ু। মথৌ তাবা অমা হন্দোকপদা এপ্লিকেসন লেপ্লি, অমসুং মদুগীদমক পুরকখিবা ডেটা ঐখোয়না মুথৎলি।';

  @override
  String get withdraw => 'হন্দোকপা';

  @override
  String get consentHistory => 'অয়াবাগী হিস্টরী';

  @override
  String historyGiven(String item) {
    return '$item পীখ্রে';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item হন্দোকখ্রে';
  }

  @override
  String get historyEmpty => 'হৌজিক ফাওবা করিমত্তা লৈতে।';

  @override
  String get consentOn => 'অন';

  @override
  String get consentOff => 'অফ';

  @override
  String get withdrawnRequired =>
      'নহাক্না মথৌ তাবা অয়াবা অমা হন্দোকখ্রে, মরম অসিনা এপ্লিকেসন লেপ্লে।';

  @override
  String get checkMatchPending =>
      'ফটো মাপনা: আধার নত্রগা পেন কার্ড অপলোড তৌবা মতমদা তৌগনি';
}
