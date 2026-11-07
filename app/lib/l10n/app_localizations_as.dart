// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Assamese (`as`).
class AppLocalizationsAs extends AppLocalizations {
  AppLocalizationsAs([String locale = 'as']) : super(locale);

  @override
  String get appTitle => 'নিৰ্ণয়';

  @override
  String get sandboxBanner => 'ডেমো মোড: নমুনা তথ্য, প্ৰকৃত পৰীক্ষা নহয়';

  @override
  String get continueLabel => 'আগবাঢ়ক';

  @override
  String stepOf(String step, String total) {
    return 'পদক্ষেপ $step / $total';
  }

  @override
  String get pleaseWait => 'অনুগ্ৰহ কৰি অপেক্ষা কৰক…';

  @override
  String get errorGeneric => 'কিবা ভুল হ\'ল। পুনৰ চেষ্টা কৰক।';

  @override
  String get close => 'বন্ধ কৰক';

  @override
  String get welcomeHeadline => 'কেইমিনিটমানতে আপোনাৰ গৃহ ঋণৰ সিদ্ধান্ত';

  @override
  String get welcomeBody =>
      'গৃহ ঋণ বা সম্পত্তিৰ বিপৰীতে ঋণৰ বাবে আবেদন কৰক। আমি সকলো অনলাইনত পৰীক্ষা কৰোঁ আৰু সদায় সিদ্ধান্তৰ কাৰণ জনাওঁ।';

  @override
  String get chooseProduct => 'আপোনাক কি লাগে?';

  @override
  String get productHomeLoan => 'গৃহ ঋণ';

  @override
  String get productHomeLoanSub => 'ঘৰ কিনা, সজা বা উন্নত কৰা';

  @override
  String get productLap => 'সম্পত্তিৰ বিপৰীতে ঋণ';

  @override
  String get productLapSub => 'নিজৰ সম্পত্তিৰ বিপৰীতে ধাৰ লওক';

  @override
  String get startApplication => 'আবেদন আৰম্ভ কৰক';

  @override
  String get demoCustomers => 'ডেমো গ্ৰাহক';

  @override
  String get demoCustomersBody => 'নমুনা মোবাইল নম্বৰ ভৰাবলৈ এটাত টেপ কৰক।';

  @override
  String get personaRavi => 'ৰবি, 32, চাকৰিয়াল, ফ্লেট কিনিছে';

  @override
  String get personaMeena => 'মীনা, 45, কাপোৰৰ দোকান চলায় (LAP)';

  @override
  String get personaArjun => 'অৰ্জুন, 29, চাকৰিয়াল, সলনি কৰা দৰমহাৰ স্লিপ';

  @override
  String get signInTitle => 'ছাইন ইন';

  @override
  String get mobileLabel => 'মোবাইল নম্বৰ';

  @override
  String get mobileHint => '10 অংকৰ মোবাইল নম্বৰ';

  @override
  String get invalidMobile => 'শুদ্ধ 10 অংকৰ মোবাইল নম্বৰ দিয়ক।';

  @override
  String get sendOtp => 'OTP পঠিয়াওক';

  @override
  String otpSentTo(String phone) {
    return '$phone লৈ 6 অংকৰ কোড পঠিওৱা হৈছে।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'সত্যাপন কৰক';

  @override
  String get demoOtp => 'ডেমো কোড: 123456';

  @override
  String get wrongOtp => 'কোডটো ভুল। পুনৰ চেষ্টা কৰক।';

  @override
  String get deviceBound =>
      'এই ফোনটো এতিয়া আপোনাৰ একাউণ্টৰ সৈতে সংযুক্ত। আন ফোনত ছাইন ইন কৰিবলৈ নতুন OTP লাগিব।';

  @override
  String get consentTitle => 'আপোনাৰ সন্মতি';

  @override
  String get consentIntro =>
      'আমি আপোনাৰ তথ্য কেৱল এই ঋণৰ সিদ্ধান্ত আৰু পৰিচালনাৰ বাবে ব্যৱহাৰ কৰোঁ। আপুনি যিকোনো সময়তে সন্মতি উঠাই ল\'ব পাৰে।';

  @override
  String get consentBureauTitle => 'ক্ৰেডিট ৰিপ\'ৰ্ট';

  @override
  String get consentBureauBody =>
      'ক্ৰেডিট ব্যুৰো (CIBIL, Experian, Equifax বা CRIF)ৰ পৰা আপোনাৰ ক্ৰেডিট ইতিহাস চোৱা হ\'ব। ইয়াৰ ফলত আপোনাৰ স্ক\'ৰ কমি নাযায়।';

  @override
  String get consentAaTitle => 'একাউণ্ট এগ্ৰিগেটৰৰ যোগেদি বেংক ষ্টেটমেণ্ট';

  @override
  String get consentAaBody =>
      'RBI-অনুজ্ঞাপ্ৰাপ্ত একাউণ্ট এগ্ৰিগেটৰৰ যোগেদি আপোনাৰ বেংকৰ 12 মাহৰ ষ্টেটমেণ্ট অনা হ\'ব। অনুৰোধটো আপুনি নিজৰ AA এপত অনুমোদন কৰিব।';

  @override
  String get consentKycTitle => 'আধাৰ eKYC আৰু PAN';

  @override
  String get consentKycBody =>
      'UIDAI আৰু আয়কৰ বিভাগৰ সৈতে আপোনাৰ পৰিচয় নিশ্চিত কৰা হ\'ব। আমি কেৱল ঢাকি ৰখা আধাৰ নম্বৰ ৰাখোঁ।';

  @override
  String get consentPrivacyTitle => 'গোপনীয়তা জাননী (DPDP আইন 2023)';

  @override
  String get consentPrivacyBody =>
      'কি সংগ্ৰহ কৰোঁ: পৰিচয়, আয়, বেংক আৰু সম্পত্তিৰ বিৱৰণ। কিয়: আপোনাৰ ঋণৰ সিদ্ধান্ত আৰু পৰিচালনাৰ বাবে। কিমান দিন: আইনে যিমান দিন কয়। আপোনাৰ অধিকাৰ: তথ্য চোৱা, শুধৰোৱা বা মচা, আৰু আমাৰ অভিযোগ বিষয়া বা ডাটা সুৰক্ষা ব\'ৰ্ডত অভিযোগ কৰা।';

  @override
  String get consentRequired => 'আৱশ্যকীয়';

  @override
  String get consentNeeded => 'আগবাঢ়িবলৈ সকলোতে সন্মতি দিয়ক।';

  @override
  String get agreeAndContinue => 'সন্মতি দি আগবাঢ়ক';

  @override
  String get detailsTitle => 'আপোনাৰ বিৱৰণ';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'শুদ্ধ PAN দিয়ক, যেনে ABCDE1234F।';

  @override
  String get fetchDetails => 'মোৰ বিৱৰণ আনক';

  @override
  String get fetchedFrom =>
      'PAN, আধাৰ eKYC আৰু বেংক ষ্টেটমেণ্টৰ পৰা ভৰোৱা হৈছে। শুধৰাবলৈ সংখ্যাত টেপ কৰক।';

  @override
  String get nameLabel => 'নাম';

  @override
  String get dobLabel => 'জন্ম তাৰিখ';

  @override
  String get employmentLabel => 'কাম';

  @override
  String get salaried => 'চাকৰিয়াল';

  @override
  String get selfEmployed => 'স্বনিয়োজিত';

  @override
  String get incomeLabel => 'মাহেকীয়া নিকা আয়';

  @override
  String get existingEmiLabel => 'বৰ্তমানৰ মাহেকীয়া EMI';

  @override
  String get propertyValueLabel => 'সম্পত্তিৰ মূল্য';

  @override
  String get loanAmountLabel => 'ঋণৰ পৰিমাণ';

  @override
  String get tenureLabel => 'ম্যাদ';

  @override
  String yearsLabel(String n) {
    return '$n বছৰ';
  }

  @override
  String get eligibleTitle => 'আপুনি সৰ্বাধিক পাব পাৰে';

  @override
  String emiPerMonth(String amount) {
    return 'মাহেকীয়া EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'বছৰি $rate%, সলনি হোৱা হাৰ (উদাহৰণ)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'আয়ৰ সীমা: আপোনাৰ সকলো EMI মিলি আয়ৰ $pct লৈকে হ\'ব পাৰে।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'সম্পত্তিৰ সীমা: ইমান ঋণ মূল্যৰ $pct লৈকে হ\'ব পাৰে।';
  }

  @override
  String get limitedByAsked => 'এইটো আপুনি বিচৰা পৰিমাণ।';

  @override
  String get eligibilityNote =>
      'আপোনাৰ বিৱৰণৰ এক দ্ৰুত পৰীক্ষা। আমাৰ পৰীক্ষাৰ পিছত প্ৰস্তাৱ আহিব।';

  @override
  String get selfieTitle => 'ছেলফি লওক';

  @override
  String get selfieBody =>
      'আমি আপোনাৰ মুখ আধাৰৰ ফটোৰ সৈতে মিলাওঁ আৰু চাওঁ যে ই সঁচাকৈয়ে আপুনি, ফটোৰ ফটো নহয়।';

  @override
  String get selfieTips => 'ভাল পোহৰ, কেমেৰালৈ চাওক, টুপী বা চশমা নহয়।';

  @override
  String get takeSelfie => 'ছেলফি লওক';

  @override
  String get retake => 'পুনৰ লওক';

  @override
  String get checkFace => 'মুখ পোৱা গ\'ল';

  @override
  String get checkLive => 'জীৱিত ব্যক্তি';

  @override
  String get checkMatch => 'আধাৰৰ ফটোৰ সৈতে মিলে';

  @override
  String get selfieFailed =>
      'আপোনাৰ মুখ নিশ্চিত কৰিব পৰা নগ\'ল। ভাল পোহৰত পুনৰ চেষ্টা কৰক, বা ভিডিঅ\' KYC কল বুক কৰক।';

  @override
  String get videoKyc => 'ভিডিঅ\' KYC কল বুক কৰক';

  @override
  String get docsTitle => 'আপোনাৰ নথি';

  @override
  String get docsBody => 'প্ৰতিখন নথিৰ স্পষ্ট ফটো লওক, বা গেলেৰীৰ পৰা বাছক।';

  @override
  String get docPan => 'PAN কাৰ্ড';

  @override
  String get docAadhaar => 'আধাৰ কাৰ্ড (ঢাকি ৰখা)';

  @override
  String get docSalarySlip => 'শেহতীয়া দৰমহাৰ স্লিপ';

  @override
  String get docForm16 => 'ফৰ্ম 16';

  @override
  String get docItr => 'আয়কৰ ৰিটাৰ্ণ (ITR)';

  @override
  String get docGst => 'GST প্ৰমাণপত্ৰ';

  @override
  String get docBankStatement => 'বেংক ষ্টেটমেণ্ট';

  @override
  String get bankViaAa => 'আপোনাৰ একাউণ্ট এগ্ৰিগেটৰৰ যোগেদি অনা হৈছে';

  @override
  String get camera => 'কেমেৰা';

  @override
  String get gallery => 'গেলেৰী';

  @override
  String get checking => 'পৰীক্ষা কৰি আছে…';

  @override
  String get tooBlurry => 'বৰ অস্পষ্ট। ফোন স্থিৰ কৰি ধৰি পুনৰ চেষ্টা কৰক।';

  @override
  String get tooMuchGlare => 'বেছি চিকমিকনি। পোহৰৰ পৰা আঁতৰি পুনৰ চেষ্টা কৰক।';

  @override
  String get tooDark => 'বৰ আন্ধাৰ। বেছি পোহৰত পুনৰ চেষ্টা কৰক।';

  @override
  String docAccepted(String type) {
    return 'চিনাক্ত কৰা হ\'ল: $type';
  }

  @override
  String docWrong(String expected) {
    return 'এইটো $expected যেন লগা নাই। পৰীক্ষা কৰি শুদ্ধ নথি আপল\'ড কৰক।';
  }

  @override
  String get docUnreadable =>
      'এই নথি পঢ়িব পৰা নগ\'ল। স্পষ্ট ফটো লওক, বা মূল PDF আপল\'ড কৰক।';

  @override
  String docsMissing(String n) {
    return 'আৰু $nখন লাগে';
  }

  @override
  String get getOffer => 'মোৰ নীতিগত প্ৰস্তাৱ দেখুৱাওক';

  @override
  String get approvedInPrinciple => 'নীতিগতভাৱে অনুমোদিত';

  @override
  String get sanctioned => 'ঋণ মঞ্জুৰ';

  @override
  String get referredTitle => 'আমাক অলপ বেছি সময় লাগিব';

  @override
  String get rejectedTitle => 'এতিয়া এই ঋণ দিব নোৱাৰোঁ';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years বছৰ · বছৰি $rate% সলনি হোৱা হাৰ';
  }

  @override
  String get whyOffer => 'আপুনি এই প্ৰস্তাৱ কিয় পালে';

  @override
  String get whyReferred => 'ইয়াৰ পিছত কি হ\'ব';

  @override
  String get whyRejected => 'আমি এই সিদ্ধান্ত কিয় ল\'লোঁ';

  @override
  String get referBody =>
      'এজন বিষয়াই এটা কৰ্মদিৱসৰ ভিতৰত আপোনাৰ আবেদন চাব। এতিয়া আপুনি একো কৰিব নালাগে।';

  @override
  String get rejectBody =>
      'আপুনি যিকোনো সময়তে এজন ব্যক্তিক এই সিদ্ধান্ত পুনৰীক্ষণ কৰিবলৈ ক\'ব পাৰে।';

  @override
  String get addProperty => 'সম্পত্তিৰ বিৱৰণ যোগ কৰক';

  @override
  String get viewKfs => 'মূল তথ্যৰ বিবৃতি চাওক';

  @override
  String get grievance => 'পুনৰীক্ষণ বিচাৰক বা অভিযোগ কৰক';

  @override
  String officerLine(String name, String email) {
    return 'অভিযোগ বিষয়া: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'আবেদন $id';
  }

  @override
  String get startOver => 'নতুন আবেদন আৰম্ভ কৰক';

  @override
  String okScore(String score) {
    return 'ভাল পৰিশোধৰ ইতিহাস (স্ক\'ৰ $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI আয়ৰ $pct; আমাৰ সীমা $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'ঋণ সম্পত্তিৰ মূল্যৰ $pct; সীমা $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'সম্পত্তিৰ আমাৰ মূল্যায়ন: $lowৰ পৰা $high';
  }

  @override
  String get okTitle => 'সম্পত্তিৰ মালিকীস্বত্ব আৰু কাগজপত্ৰ পৰীক্ষা কৰা হ\'ল';

  @override
  String get reasonKyc01 =>
      'ফটোৰ পৰা আপোনাৰ পৰিচয় নিশ্চিত কৰিব পৰা নগ\'ল। অনুগ্ৰহ কৰি এটা চুটি ভিডিঅ\' KYC কল সম্পূৰ্ণ কৰক।';

  @override
  String get reasonFrd02 =>
      'দৰমহাৰ স্লিপৰ আয় বেংকত জমা হোৱাৰ সৈতে নিমিলে। শেহতীয়া ফৰ্ম 16 দিয়ক, বা সন্মতি দি আমাক আনিবলৈ দিয়ক।';

  @override
  String get reasonFrd03 =>
      'আপোনাৰ এখন নথি জাৰীকাৰী কৰ্তৃপক্ষৰ সত্যাপনত বিফল হ\'ল।';

  @override
  String get reasonPol01 => 'আবেদনকাৰীৰ বয়স কমেও 21 বছৰ হ\'ব লাগিব।';

  @override
  String get reasonPol02 =>
      'ঋণটো আমাৰ অনুমোদিত সৰ্বাধিক বয়স পাৰ হৈ যাব। কম বয়সৰ সহ-আবেদনকাৰী যোগ কৰিলে সহায় হ\'ব পাৰে।';

  @override
  String get reasonBur01 => 'আপোনাৰ ক্ৰেডিট স্ক\'ৰ আমাৰ নূন্যতম 650তকৈ কম।';

  @override
  String get reasonBur04 =>
      'আপোনাৰ এতিয়াও ক্ৰেডিট ইতিহাস নাই, গতিকে এজন বিষয়াই আপোনাৰ বেংক ৰেকৰ্ড চাব।';

  @override
  String get reasonBur05 =>
      'আপোনাৰ ক্ৰেডিট স্ক\'ৰ এজন বিষয়াই ভালদৰে চোৱাৰ প্ৰয়োজন।';

  @override
  String get reasonPrp01 =>
      'আমাৰ উকীলে সম্পত্তিৰ মালিকীস্বত্ব পুনৰীক্ষণ কৰিব লাগিব।';

  @override
  String get reasonPrp03 =>
      'মূল্য নিশ্চিত কৰিবলৈ আমাৰ মূল্যায়নকাৰীয়ে সম্পত্তি চাবলৈ যাব লাগিব।';

  @override
  String get reasonPrp04 =>
      'চুক্তিৰ মূল্য এই সম্পত্তিৰ চৰকাৰী চাৰ্কল ৰেটতকৈ কম। অনুগ্ৰহ কৰি বিক্ৰী চুক্তি পৰীক্ষা কৰক।';

  @override
  String get reasonAff01 =>
      'আপোনাৰ বৰ্তমানৰ EMIয়ে ইতিমধ্যে আয়ৰ সৰ্বাধিক অংশ লৈছে।';

  @override
  String get reasonAut01 => 'এই আকাৰৰ ঋণৰ শেষ পৰীক্ষা এজন জ্যেষ্ঠ বিষয়াই কৰে।';

  @override
  String get reasonRsk01 =>
      'প্ৰস্তাৱ চূড়ান্ত কৰিবলৈ এজন বিষয়াই আপোনাৰ আবেদন চাব।';

  @override
  String get reasonRsk02 =>
      'আপোনাৰ ক্ৰেডিট প্ৰ\'ফাইলৰ ভিত্তিত এতিয়া এই ঋণ দিব নোৱাৰোঁ।';

  @override
  String get propertyTitle => 'আপোনাৰ সম্পত্তি';

  @override
  String get cityLabel => 'চহৰ';

  @override
  String get localityLabel => 'অঞ্চল';

  @override
  String get societyLabel => 'প্ৰকল্প বা ছ\'চাইটি (যদি থাকে)';

  @override
  String get areaLabel => 'আয়তন (বৰ্গফুট)';

  @override
  String get bhkLabel => 'শোৱনি কোঠা';

  @override
  String get newProperty => 'নতুন';

  @override
  String get resale => 'পুনৰ বিক্ৰী';

  @override
  String get declaredPriceLabel => 'চুক্তিৰ মূল্য';

  @override
  String get photosTitle => 'সম্পত্তিৰ ফটো';

  @override
  String get photosBody =>
      'সম্পত্তিৰ ঠাইতে ফটো লওক। আমি ঠাই আৰু সময় যোগ কৰোঁ, যাতে মূল্যায়নকাৰীয়ে পৰিদৰ্শনৰ পৰিকল্পনা কৰিব পাৰে।';

  @override
  String get photoFront => 'সন্মুখ';

  @override
  String get photoInside => 'ভিতৰ';

  @override
  String get photoView => 'সম্পত্তিৰ পৰা দৃশ্য';

  @override
  String geoTagged(String lat, String lng) {
    return 'স্থান যোগ কৰা হ\'ল ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'স্থান অবিহনে ফটো সংৰক্ষিত। জিঅ\'-টেগৰ বাবে লোকেশ্বন অন কৰক।';

  @override
  String get submitProperty => 'চূড়ান্ত মঞ্জুৰী লওক';

  @override
  String get fillAll => 'অনুগ্ৰহ কৰি সকলো ঘৰ পূৰণ কৰক।';

  @override
  String get kfsTitle => 'মূল তথ্যৰ বিবৃতি';

  @override
  String get kfsLoan => 'ঋণৰ পৰিমাণ';

  @override
  String get kfsTenure => 'ম্যাদ';

  @override
  String get kfsRate => 'সুতৰ হাৰ';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMIৰ সংখ্যা';

  @override
  String get kfsFee => 'প্ৰচেছিং মাচুল (GST সহ)';

  @override
  String get kfsTotalInterest => 'মুঠ সুত';

  @override
  String get kfsTotalPayable => 'মুঠ পৰিশোধযোগ্য';

  @override
  String get kfsApr => 'বাৰ্ষিক শতাংশ হাৰ (APR)';

  @override
  String get kfsCoolingOff =>
      'কুলিং-অফ সময়: চহী কৰাৰ 3 দিনৰ ভিতৰত কেৱল মূলধন আৰু সেই দিনকেইটাৰ সুত ঘূৰাই দি জৰিমনা নোহোৱাকৈ ওলাই আহিব পাৰে।';

  @override
  String get kfsNote =>
      'ডেমোৰ বাবে নমুনা সংখ্যা। আপোনাৰ প্ৰকৃত KFS মঞ্জুৰী পত্ৰৰ সৈতে আহিব।';

  @override
  String get useSample => 'নমুনা';

  @override
  String get videoKycDemo =>
      'ডেমো: ইয়াৰ দ্বাৰা এজন বিষয়াৰ সৈতে ভিডিঅ\' KYC কল বুক হ\'লহেঁতেন।';

  @override
  String get raiseComplaint => 'অভিযোগ কৰক';

  @override
  String complaintSent(String ref) {
    return 'আপোনাৰ অভিযোগ পঞ্জীয়ন হ\'ল। প্ৰসংগ $ref।';
  }

  @override
  String get stageSignIn => 'ছাইন ইন';

  @override
  String get stageDetails => 'বিৱৰণ';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'প্ৰস্তাৱ';

  @override
  String get stageProperty => 'সম্পত্তি';

  @override
  String get homeSubtitle => 'গৃহ ঋণ · সম্পত্তিৰ বিপৰীতে ঋণ';

  @override
  String get heroPill => 'মিনিটতে সিদ্ধান্ত';

  @override
  String heroFacts(String rate, String years) {
    return 'বছৰি $rate%ৰ পৰা · $years বছৰলৈকে';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% সম্পূৰ্ণ · য\'ত এৰিছিল তাৰ পৰা আৰম্ভ কৰক';
  }

  @override
  String get resume => 'পুনৰ আৰম্ভ';

  @override
  String get calculators => 'কেলকুলেটৰ';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'মাহেকীয়া কিস্তি';

  @override
  String get calcEligibility => 'যোগ্যতা';

  @override
  String get calcEligibilitySub => 'আপুনি কিমান পাব পাৰে';

  @override
  String get emiCalcTitle => 'EMI কেলকুলেটৰ';

  @override
  String get eligibilityCalcTitle => 'যোগ্যতা কেলকুলেটৰ';

  @override
  String totalInterest(String amount) {
    return 'মুঠ সুত $amount';
  }

  @override
  String get calcIncomeOnly =>
      'কেৱল আয়ৰ ভিত্তিত। সম্পত্তিৰ মূল্যই ইয়াক কমাব পাৰে।';

  @override
  String get verified => 'সত্যাপিত';

  @override
  String get yourLoan => 'আপোনাৰ ঋণ';

  @override
  String docsProgress(String done, String total) {
    return '$totalখনৰ ভিতৰত $doneখন সত্যাপিত';
  }

  @override
  String get docNeeded => 'লাগে';

  @override
  String get docTryAgain => 'পুনৰ চেষ্টা';

  @override
  String get fetched => 'অনা হ\'ল';

  @override
  String get statusApproved => 'অনুমোদিত';

  @override
  String get statusSanctioned => 'মঞ্জুৰ';

  @override
  String get statusInReview => 'পুনৰীক্ষণত';

  @override
  String get statusDeclined => 'নাকচ';

  @override
  String get trackTitle => 'আপোনাৰ আবেদন ট্ৰেক কৰক';

  @override
  String get tlSubmitted => 'আবেদন দাখিল হ\'ল';

  @override
  String get tlVerified => 'KYC আৰু নথি সত্যাপিত';

  @override
  String get tlInPrinciple => 'নীতিগত অনুমোদন';

  @override
  String get tlProperty => 'সম্পত্তিৰ বিৱৰণ আৰু মূল্যায়ন';

  @override
  String get tlPropertyNext => 'আপোনাৰ সম্পত্তিৰ বিৱৰণ আৰু ফটো যোগ কৰক';

  @override
  String get tlOfficer => 'বিষয়াৰ পুনৰীক্ষণ';

  @override
  String get tlOfficerNext => 'এটা কৰ্মদিৱসৰ ভিতৰত';

  @override
  String get tlLegal => 'আইনী আৰু মালিকীস্বত্বৰ পৰীক্ষা';

  @override
  String get tlSanction => 'চূড়ান্ত মঞ্জুৰী আৰু ই-চহী';

  @override
  String get tlSanctionNext => 'মঞ্জুৰী পত্ৰত অনলাইনত চহী কৰক';

  @override
  String get tlDisbursement => 'ধন প্ৰদান';

  @override
  String get helpTitle => 'সহায় লাগে?';

  @override
  String get propertyType => 'নতুন নে পুনৰ বিক্ৰী';

  @override
  String get greetMorning => 'সুপ্ৰভাত';

  @override
  String get greetAfternoon => 'শুভ দুপৰীয়া';

  @override
  String get greetEvening => 'শুভ সন্ধিয়া';

  @override
  String nearlyThere(String name) {
    return '$name, আপুনি প্ৰায় পালেহি';
  }

  @override
  String get chooseLanguage => 'আপোনাৰ ভাষা বাছক';

  @override
  String get languageNote => 'আপুনি ইয়াক যিকোনো সময়তে সলনি কৰিব পাৰে।';

  @override
  String get liveChecks => 'লাইভ পৰীক্ষা';

  @override
  String get checkBureau => 'ক্ৰেডিট ব্যুৰো';

  @override
  String checkScore(String score) {
    return 'স্ক\'ৰ $score';
  }

  @override
  String get checkNoHistory => 'এতিয়াও ইতিহাস নাই';

  @override
  String get checkBank => 'AAৰ যোগেদি বেংক';

  @override
  String get checkBankRead => '12 মাহ পঢ়া হ\'ল';

  @override
  String get checkKyc => 'eKYC আৰু ছেলফি';

  @override
  String get checkPending => 'বাকী';

  @override
  String get checkDocs => 'নথি';

  @override
  String countOf(String done, String total) {
    return '$totalৰ ভিতৰত $done';
  }

  @override
  String minutesLeft(String n) {
    return 'প্ৰায় $n মিনিট বাকী';
  }

  @override
  String ratePa(String rate) {
    return 'বছৰি $rate%';
  }

  @override
  String get continueApplication => 'আপোনাৰ আবেদন অব্যাহত ৰাখক';

  @override
  String get shapeOffer => 'আপোনাৰ প্ৰস্তাৱ সাজক';

  @override
  String get shapeOfferSub => 'নীতিগতভাৱে অনুমোদিত · সলনি কৰিবলৈ টানক';

  @override
  String get withinLimits => 'আপোনাৰ সীমাৰ ভিতৰত';

  @override
  String get aboveLimits => 'সীমাতকৈ বেছি: পৰিমাণ কমাওক বা বছৰ বঢ়াওক';

  @override
  String mostYouCan(String amount) {
    return 'সৰ্বাধিক ল\'ব পাৰে: $amount';
  }

  @override
  String get useMax => 'সৰ্বাধিক লওক';

  @override
  String get principal => 'মূলধন';

  @override
  String get interest => 'সুত';

  @override
  String get totalRepaid => 'মুঠ পৰিশোধ';

  @override
  String get emiShareIncome => 'আয়ৰ অংশ হিচাপে EMI';

  @override
  String loanShareProperty(String value) {
    return '$value সম্পত্তিৰ অংশ হিচাপে ঋণ';
  }

  @override
  String get lockOffer => 'এই প্ৰস্তাৱ নিশ্চিত কৰক';

  @override
  String get offerLocked => 'আপোনাৰ প্ৰস্তাৱ নিশ্চিত হ\'ল।';

  @override
  String approvedUpTo(String amount) {
    return '$amountলৈকে অনুমোদিত';
  }

  @override
  String readingDoc(String doc) {
    return 'আপোনাৰ $doc পঢ়ি আছোঁ';
  }

  @override
  String get documentAi => 'নথি AI';

  @override
  String sure(String pct) {
    return '$pct% নিশ্চিত';
  }

  @override
  String get readMatches => 'এইখনেই আমি বিচৰা নথি';

  @override
  String get readClear => 'স্পষ্ট ফটো, অস্পষ্টতা বা চিকমিকনি নাই';

  @override
  String get whatWeRead => 'আমি যি পঢ়িলোঁ';

  @override
  String get looksRight => 'ঠিক আছে';

  @override
  String get fieldName => 'নাম';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'আধাৰ';

  @override
  String get fieldEmployer => 'নিয়োগকৰ্তা';

  @override
  String get fieldNetPay => 'নিকা দৰমহা';

  @override
  String get fieldPeriod => 'দৰমহাৰ সময়কাল';

  @override
  String get fieldYear => 'বছৰ';

  @override
  String get fieldIncome => 'আয়';

  @override
  String get fieldBusiness => 'ব্যৱসায়';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'আপোনাৰ ঋণৰ বাবে প্ৰয়োজনীয়';

  @override
  String get consentSectionOptional => 'ঐচ্ছিক: আপুনি অন নকৰালৈকে বন্ধ';

  @override
  String get advancedOptions => 'বিকল্প';

  @override
  String consentValidUntil(String given, String until) {
    return '$givenত দিয়া · $untilলৈকে বৈধ';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$givenত দিয়া · উঠাই নোলোৱালৈকে';
  }

  @override
  String get recheckTitle => 'ধন দিয়াৰ ঠিক আগতে আৰু এবাৰ পৰীক্ষা';

  @override
  String get recheckBody =>
      'ধন দিয়াৰ ঠিক আগতে আমি আপোনাৰ ক্ৰেডিট ৰিপ\'ৰ্ট পুনৰ চাওঁ। নালাগে বুলিলে তেতিয়া এজন বিষয়াই সুধিব পাৰে।';

  @override
  String get aaMonthsLabel => 'কিমান মাহৰ ষ্টেটমেণ্ট দিব';

  @override
  String monthsN(String n) {
    return '$n মাহ';
  }

  @override
  String get aaAccountsLabel => 'দিবলগীয়া একাউণ্ট';

  @override
  String get accountSavingsSalary => 'সঞ্চয় ·· 0912 · দৰমহা জমা';

  @override
  String get accountSavings => 'সঞ্চয় ·· 4821';

  @override
  String get accountFd => 'স্থায়ী জমা ·· 3307';

  @override
  String get aaAccountNeeded => 'কমেও এটা একাউণ্ট বাছক।';

  @override
  String get kycMethodLabel => 'পৰিচয় কেনেকৈ নিশ্চিত কৰিব';

  @override
  String get kycAadhaarOtp => 'আধাৰ OTP';

  @override
  String get kycDigilocker => 'ডিজিলকাৰ';

  @override
  String get kycVideo => 'ভিডিঅ\' KYC কল';

  @override
  String get useCkycTitle => 'মোৰ বৰ্তমানৰ CKYC ৰেকৰ্ড ব্যৱহাৰ কৰক';

  @override
  String get useCkycBody =>
      'আন বেংক বা ফাণ্ডত KYC কৰিছে যদি, পুনৰ নুসুধি আমি সেই ৰেকৰ্ড আনোঁ।';

  @override
  String get optOffersTitle => 'অফাৰ আৰু নতুন সামগ্ৰী';

  @override
  String get optOffersBody =>
      'অফাৰৰ বিষয়ে কেনেকৈ জানিব বিচাৰে বাছক। যিকোনো সময়তে বন্ধ কৰিব পাৰে।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ইমেইল';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsAppত ঋণৰ আপডেট';

  @override
  String get optUpdatesBody =>
      'SMSৰ লগতে WhatsAppত স্থিতিৰ আপডেট আৰু EMI সোঁৱৰণী।';

  @override
  String get optInsuranceTitle => 'গৃহ ঋণ সুৰক্ষাৰ কোটেশ্যন';

  @override
  String get optInsuranceBody =>
      'কোটেশ্যনৰ বাবে আপোনাৰ নাম, বয়স আৰু ঋণৰ পৰিমাণ আমাৰ বীমা অংশীদাৰক দিয়ক। কিনাটো কেতিয়াও বাধ্যতামূলক নহয়।';

  @override
  String get getQuote => 'কোটেশ্যন লওক';

  @override
  String get manageConsents => 'সন্মতি পৰিচালনা';

  @override
  String get manageConsentsBody =>
      'ঐচ্ছিক সন্মতি যিকোনো সময়তে বন্ধ কৰক। প্ৰয়োজনীয় সন্মতি উঠাই ল\'লে আবেদন ৰৈ যায়, আৰু তাৰ বাবে অনা তথ্য আমি মচি পেলাওঁ।';

  @override
  String get withdraw => 'উঠাই লওক';

  @override
  String get consentHistory => 'সন্মতিৰ ইতিহাস';

  @override
  String historyGiven(String item) {
    return '$item দিয়া হ\'ল';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item উঠাই লোৱা হ\'ল';
  }

  @override
  String get historyEmpty => 'এতিয়াও একো নাই।';

  @override
  String get consentOn => 'অন';

  @override
  String get consentOff => 'বন্ধ';

  @override
  String get withdrawnRequired =>
      'আপুনি এটা প্ৰয়োজনীয় সন্মতি উঠাই ল\'লে, সেয়েহে আবেদন ৰৈ আছে।';

  @override
  String get checkMatchPending =>
      'ফটো মিলোৱা: আধাৰ বা পেন কাৰ্ড আপলোড কৰিলে হ\'ব';

  @override
  String get realDetailsIntro =>
      'আপোনাৰ বিষয়ে কওক। প্ৰতিটো তথ্য আমি আপোনাৰ নথিৰ সৈতে মিলাই চাওঁ।';

  @override
  String get fullNameLabel => 'সম্পূৰ্ণ নাম (পেন কাৰ্ডত যেনেকৈ আছে)';

  @override
  String get emailLabel => 'ইমেইল';

  @override
  String get employerLabel => 'নিয়োগকৰ্তা বা ব্যৱসায়ৰ নাম';

  @override
  String get creditScoreLabel => 'ক্ৰেডিট স্ক\'ৰ (বৈকল্পিক)';

  @override
  String get creditScoreHint =>
      'আপোনাৰ CIBIL বা Experian প্ৰতিবেদনৰ পৰা, যদি জানে';

  @override
  String get addressLabel => 'ঠিকনা';

  @override
  String get saveDetails => 'মোৰ তথ্য সাঁচি ৰাখক';

  @override
  String get selfDeclaredNote =>
      'এই তথ্য আপুনি দিছে। ইয়াৰ পিছত আপুনি আপলোড কৰা নথিৰ সৈতে আমি মিলাই চাম।';

  @override
  String get pickDob => 'আপোনাৰ জন্ম তাৰিখ বাছক';

  @override
  String get fillDetails =>
      'অনুগ্ৰহ কৰি নাম, জন্ম তাৰিখ, কাম, নিয়োগকৰ্তা আৰু আয় দিয়ক।';

  @override
  String get docSaleDeed => 'বিক্ৰী দলিল বা আৱণ্টন পত্ৰ';

  @override
  String get saleDeedBody =>
      'পঞ্জীয়নভুক্ত বিক্ৰী দলিলৰ ফটো বা PDF আপল\'ড কৰক (সম্পত্তি আৰু ক্ৰেতা থকা পৃষ্ঠাটো)। মালিকীস্বত্ব পৰীক্ষা কৰিবলৈ আমি ইয়াক পঢ়োঁ।';

  @override
  String get statusPending => 'পৰ্যালোচনা বাকী';

  @override
  String decisionRef(String ref) {
    return 'সিদ্ধান্তৰ ৰেকৰ্ড $ref';
  }

  @override
  String get scoreTitle => 'আমি আপোনাৰ স্ক\'ৰ কেনেকৈ উলিয়ালোঁ';

  @override
  String get scoreOutOf => '900 ৰ ভিতৰত';

  @override
  String gradeLabel(String grade) {
    return 'গ্ৰেড $grade';
  }

  @override
  String scoreStart(String base) {
    return 'সকলোৱে $base পইণ্টৰ পৰা আৰম্ভ কৰে। তলৰ প্ৰতিটো শাৰীয়ে পইণ্ট যোগ কৰে বা কমায়।';
  }

  @override
  String get scoreNote =>
      'এইটো সিদ্ধান্তৰ ক্ৰেডিট স্ক\'ৰৰ অংশ। আপোনাৰ উপাৰ্জন, পৰিচয়, নথি আৰু সম্পত্তিও পৰীক্ষা কৰা হয়।';

  @override
  String get factorBureau => 'ক্ৰেডিট ব্যুৰো স্ক\'ৰ';

  @override
  String get factorHistory => 'ক্ৰেডিট ইতিহাসৰ বছৰ';

  @override
  String get factorLtv => 'সম্পত্তিৰ মূল্যৰ তুলনাত ঋণৰ অংশ';

  @override
  String get factorLoanAmount => 'ঋণৰ পৰিমাণ';

  @override
  String get factorMissing => 'উপলব্ধ নহয়';

  @override
  String rangeBelow(String x) {
    return '$xতকৈ কম';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$aৰ পৰা $bলৈ';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x বা তাতকৈ বেছি';
  }

  @override
  String get viewLetter => 'সিদ্ধান্তৰ পত্ৰ';

  @override
  String get letterTitle => 'আপোনাৰ সিদ্ধান্তৰ পত্ৰ';

  @override
  String get letterPartlyEnglish =>
      'কিছুমান শাৰী অনুবাদ কৰিব পৰা নগ\'ল, সেয়েহে সেইবোৰ ইংৰাজীত আছে।';

  @override
  String get copyText => 'লিখনি কপি কৰক';

  @override
  String get copied => 'কপি হ\'ল';

  @override
  String get askTitle => 'এটা প্ৰশ্ন সোধক';

  @override
  String get askHint => 'যেনে: ইয়াৰ পিছত কি হ\'ব?';

  @override
  String get askSend => 'পঠিয়াওক';

  @override
  String get askHuman =>
      'আমাৰ দলৰ এজন ব্যক্তিয়ে এই বিষয়ে আপোনাৰ সৈতে যোগাযোগ কৰিব।';

  @override
  String get uploadPdf => 'PDF আপল\'ড কৰক';

  @override
  String get kfsFeeBase => 'প্ৰচেছিং মাচুল (0.5%)';

  @override
  String get kfsGst => 'মাচুলৰ ওপৰত GST (18%)';

  @override
  String get kfsNoteEngine =>
      'এই প্ৰস্তাৱৰ বাবে হিচাপ কৰা হৈছে। স্বাক্ষৰিত মূল তথ্যৰ বিবৃতি আপোনাৰ মঞ্জুৰী পত্ৰৰ সৈতে আহিব।';

  @override
  String otpOnServer(String phone) {
    return 'এই পৰীক্ষামূলক ছাৰ্ভাৰে SMS নপঠায়। $phoneৰ 6 অংকৰ ক\'ড কম্পিউটাৰৰ ছাৰ্ভাৰ উইণ্ড\'ত দেখা যায়।';
  }

  @override
  String get resendOtp => 'নতুন ক\'ড পঠিয়াওক';

  @override
  String get newOtpSent => 'নতুন ক\'ড পঠিওৱা হ\'ল।';

  @override
  String get otpExpired => 'এই ক\'ডৰ ম্যাদ উকলিল। নতুন ক\'ড পঠিয়াওক টিপক।';

  @override
  String get otpTooManyTries =>
      'বহুবাৰ ভুল ক\'ড দিয়া হ\'ল। নতুন ক\'ড পঠিয়াওক টিপক।';

  @override
  String get otpTooManySends =>
      'বহুত বেছি ক\'ড বিচৰা হ\'ল। 15 মিনিট অপেক্ষা কৰি পুনৰ চেষ্টা কৰক।';
}
