// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'নির্ণয়';

  @override
  String get sandboxBanner => 'ডেমো মোড: নমুনা তথ্য, আসল যাচাই নয়';

  @override
  String get continueLabel => 'এগিয়ে যান';

  @override
  String stepOf(String step, String total) {
    return 'ধাপ $step / $total';
  }

  @override
  String get pleaseWait => 'অপেক্ষা করুন…';

  @override
  String get errorGeneric => 'কিছু ভুল হয়েছে। আবার চেষ্টা করুন।';

  @override
  String get close => 'বন্ধ করুন';

  @override
  String get welcomeHeadline => 'কয়েক মিনিটে আপনার হোম লোনের সিদ্ধান্ত';

  @override
  String get welcomeBody =>
      'হোম লোন বা সম্পত্তির বিপরীতে লোনের জন্য আবেদন করুন। আমরা সব অনলাইনে যাচাই করি এবং সবসময় সিদ্ধান্তের কারণ জানাই।';

  @override
  String get chooseProduct => 'আপনার কী দরকার?';

  @override
  String get productHomeLoan => 'হোম লোন';

  @override
  String get productHomeLoanSub => 'বাড়ি কেনা, তৈরি বা সংস্কার';

  @override
  String get productLap => 'সম্পত্তির বিপরীতে লোন';

  @override
  String get productLapSub => 'নিজের সম্পত্তির বিপরীতে ঋণ নিন';

  @override
  String get startApplication => 'আবেদন শুরু করুন';

  @override
  String get demoCustomers => 'ডেমো গ্রাহক';

  @override
  String get demoCustomersBody => 'নমুনা মোবাইল নম্বর ভরতে একটিতে ট্যাপ করুন।';

  @override
  String get personaRavi => 'রবি, ৩২, চাকরিজীবী, ফ্ল্যাট কিনছেন';

  @override
  String get personaMeena => 'মীনা, ৪৫, পোশাকের দোকান চালান (LAP)';

  @override
  String get personaArjun => 'অর্জুন, ২৯, চাকরিজীবী, বদলানো স্যালারি স্লিপ';

  @override
  String get signInTitle => 'সাইন ইন';

  @override
  String get mobileLabel => 'মোবাইল নম্বর';

  @override
  String get mobileHint => '১০ সংখ্যার মোবাইল নম্বর';

  @override
  String get invalidMobile => 'সঠিক ১০ সংখ্যার মোবাইল নম্বর দিন।';

  @override
  String get sendOtp => 'OTP পাঠান';

  @override
  String otpSentTo(String phone) {
    return '$phone নম্বরে ৬ সংখ্যার কোড পাঠানো হয়েছে।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'যাচাই করুন';

  @override
  String get demoOtp => 'ডেমো কোড: 123456';

  @override
  String get wrongOtp => 'কোডটি ভুল। আবার চেষ্টা করুন।';

  @override
  String get deviceBound =>
      'এই ফোনটি এখন আপনার অ্যাকাউন্টের সঙ্গে যুক্ত। অন্য ফোনে সাইন ইন করতে নতুন OTP লাগবে।';

  @override
  String get consentTitle => 'আপনার সম্মতি';

  @override
  String get consentIntro =>
      'আমরা আপনার তথ্য শুধু এই লোনের সিদ্ধান্ত ও পরিচালনার জন্য ব্যবহার করি। যেকোনো সময় সম্মতি তুলে নিতে পারেন।';

  @override
  String get consentBureauTitle => 'ক্রেডিট রিপোর্ট';

  @override
  String get consentBureauBody =>
      'ক্রেডিট ব্যুরো (CIBIL, Experian, Equifax বা CRIF) থেকে আপনার ক্রেডিট ইতিহাস দেখা হবে। এতে আপনার স্কোর কমে না।';

  @override
  String get consentAaTitle =>
      'অ্যাকাউন্ট অ্যাগ্রিগেটরের মাধ্যমে ব্যাংক স্টেটমেন্ট';

  @override
  String get consentAaBody =>
      'RBI-লাইসেন্সপ্রাপ্ত অ্যাকাউন্ট অ্যাগ্রিগেটরের মাধ্যমে আপনার ব্যাংকের ১২ মাসের স্টেটমেন্ট আনা হবে। অনুরোধটি আপনি নিজের AA অ্যাপে অনুমোদন করবেন।';

  @override
  String get consentKycTitle => 'আধার eKYC এবং PAN';

  @override
  String get consentKycBody =>
      'UIDAI ও আয়কর বিভাগের সঙ্গে আপনার পরিচয় নিশ্চিত করা হবে। আমরা শুধু ঢাকা আধার নম্বর রাখি।';

  @override
  String get consentPrivacyTitle => 'গোপনীয়তা বিজ্ঞপ্তি (DPDP আইন ২০২৩)';

  @override
  String get consentPrivacyBody =>
      'কী সংগ্রহ করি: পরিচয়, আয়, ব্যাংক ও সম্পত্তির তথ্য। কেন: আপনার লোনের সিদ্ধান্ত ও পরিচালনার জন্য। কতদিন: আইন যতদিন বলে ততদিন। আপনার অধিকার: তথ্য দেখা, সংশোধন বা মুছে ফেলা, এবং আমাদের অভিযোগ আধিকারিক বা ডেটা সুরক্ষা বোর্ডে অভিযোগ করা।';

  @override
  String get consentRequired => 'আবশ্যক';

  @override
  String get consentNeeded => 'এগোতে সবগুলিতে সম্মতি দিন।';

  @override
  String get agreeAndContinue => 'সম্মতি দিয়ে এগিয়ে যান';

  @override
  String get detailsTitle => 'আপনার তথ্য';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'সঠিক PAN দিন, যেমন ABCDE1234F।';

  @override
  String get fetchDetails => 'আমার তথ্য আনুন';

  @override
  String get fetchedFrom =>
      'PAN, আধার eKYC ও ব্যাংক স্টেটমেন্ট থেকে ভরা হয়েছে। সংশোধন করতে সংখ্যায় ট্যাপ করুন।';

  @override
  String get nameLabel => 'নাম';

  @override
  String get dobLabel => 'জন্মতারিখ';

  @override
  String get employmentLabel => 'কাজ';

  @override
  String get salaried => 'চাকরিজীবী';

  @override
  String get selfEmployed => 'স্ব-নিযুক্ত';

  @override
  String get incomeLabel => 'মাসিক নিট আয়';

  @override
  String get existingEmiLabel => 'বর্তমান মাসিক EMI';

  @override
  String get propertyValueLabel => 'সম্পত্তির মূল্য';

  @override
  String get loanAmountLabel => 'লোনের পরিমাণ';

  @override
  String get tenureLabel => 'মেয়াদ';

  @override
  String yearsLabel(String n) {
    return '$n বছর';
  }

  @override
  String get eligibleTitle => 'আপনি পেতে পারেন সর্বোচ্চ';

  @override
  String emiPerMonth(String amount) {
    return 'মাসিক EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'বার্ষিক $rate%, পরিবর্তনশীল (উদাহরণ)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'আয় অনুযায়ী সীমা: সব EMI মিলিয়ে আয়ের $pct পর্যন্ত হতে পারে।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'সম্পত্তি অনুযায়ী সীমা: এই আকারের লোন মূল্যের $pct পর্যন্ত হতে পারে।';
  }

  @override
  String get limitedByAsked => 'এটি আপনার চাওয়া পরিমাণ।';

  @override
  String get eligibilityNote =>
      'আপনার তথ্যের দ্রুত হিসাব। আমাদের যাচাইয়ের পরে অফার আসবে।';

  @override
  String get selfieTitle => 'সেলফি তুলুন';

  @override
  String get selfieBody =>
      'আমরা আপনার মুখ আধারের ছবির সঙ্গে মেলাই এবং দেখি এটি সত্যিই আপনি, ছবির ছবি নয়।';

  @override
  String get selfieTips =>
      'ভালো আলো, ক্যামেরার দিকে তাকান, টুপি বা সানগ্লাস নয়।';

  @override
  String get takeSelfie => 'সেলফি তুলুন';

  @override
  String get retake => 'আবার তুলুন';

  @override
  String get checkFace => 'মুখ পাওয়া গেছে';

  @override
  String get checkLive => 'জীবিত ব্যক্তি';

  @override
  String get checkMatch => 'আধারের ছবির সঙ্গে মেলে';

  @override
  String get selfieFailed =>
      'আপনার মুখ নিশ্চিত করা যায়নি। ভালো আলোয় আবার চেষ্টা করুন, বা ভিডিও KYC কল বুক করুন।';

  @override
  String get videoKyc => 'ভিডিও KYC কল বুক করুন';

  @override
  String get docsTitle => 'আপনার নথি';

  @override
  String get docsBody =>
      'প্রতিটি নথির পরিষ্কার ছবি তুলুন, বা গ্যালারি থেকে বেছে নিন।';

  @override
  String get docPan => 'PAN কার্ড';

  @override
  String get docAadhaar => 'আধার কার্ড (ঢাকা)';

  @override
  String get docSalarySlip => 'সাম্প্রতিক স্যালারি স্লিপ';

  @override
  String get docForm16 => 'ফর্ম 16';

  @override
  String get docItr => 'আয়কর রিটার্ন (ITR)';

  @override
  String get docGst => 'GST সার্টিফিকেট';

  @override
  String get docBankStatement => 'ব্যাংক স্টেটমেন্ট';

  @override
  String get bankViaAa => 'আপনার অ্যাকাউন্ট অ্যাগ্রিগেটর থেকে আনা হয়েছে';

  @override
  String get camera => 'ক্যামেরা';

  @override
  String get gallery => 'গ্যালারি';

  @override
  String get checking => 'যাচাই হচ্ছে…';

  @override
  String get tooBlurry => 'খুব ঝাপসা। ফোন স্থির রেখে আবার চেষ্টা করুন।';

  @override
  String get tooMuchGlare => 'খুব বেশি ঝলক। আলো থেকে সরে আবার চেষ্টা করুন।';

  @override
  String get tooDark => 'খুব অন্ধকার। আরও আলোয় আবার চেষ্টা করুন।';

  @override
  String docAccepted(String type) {
    return 'চেনা গেছে: $type';
  }

  @override
  String docWrong(String expected) {
    return 'এটি $expected মনে হচ্ছে না। দেখে সঠিক নথি আপলোড করুন।';
  }

  @override
  String get docUnreadable =>
      'নথিটি পড়া যায়নি। আরও পরিষ্কার ছবি তুলুন, বা আসল PDF আপলোড করুন।';

  @override
  String docsMissing(String n) {
    return 'আরও $nটি দরকার';
  }

  @override
  String get getOffer => 'আমার প্রাথমিক অফার দেখান';

  @override
  String get approvedInPrinciple => 'প্রাথমিকভাবে অনুমোদিত';

  @override
  String get sanctioned => 'লোন মঞ্জুর';

  @override
  String get referredTitle => 'আমাদের একটু বেশি সময় লাগবে';

  @override
  String get rejectedTitle => 'এখন এই লোন দেওয়া সম্ভব নয়';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years বছর · বার্ষিক $rate% পরিবর্তনশীল';
  }

  @override
  String get whyOffer => 'কেন এই অফার পেলেন';

  @override
  String get whyReferred => 'এরপর কী হবে';

  @override
  String get whyRejected => 'কেন এই সিদ্ধান্ত';

  @override
  String get referBody =>
      'একজন আধিকারিক এক কর্মদিবসের মধ্যে আপনার আবেদন দেখবেন। এখন আপনাকে কিছু করতে হবে না।';

  @override
  String get rejectBody =>
      'আপনি যেকোনো সময় একজন ব্যক্তিকে এই সিদ্ধান্ত পর্যালোচনা করতে বলতে পারেন।';

  @override
  String get addProperty => 'সম্পত্তির তথ্য যোগ করুন';

  @override
  String get viewKfs => 'মূল তথ্য বিবরণী দেখুন';

  @override
  String get grievance => 'পর্যালোচনা চান বা অভিযোগ করুন';

  @override
  String officerLine(String name, String email) {
    return 'অভিযোগ আধিকারিক: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'আবেদন $id';
  }

  @override
  String get startOver => 'নতুন আবেদন শুরু করুন';

  @override
  String okScore(String score) {
    return 'ভালো পরিশোধের ইতিহাস (স্কোর $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI আয়ের $pct নেয়; আমাদের সীমা $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'লোন সম্পত্তির মূল্যের $pct; সীমা $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'সম্পত্তির আমাদের মূল্যায়ন: $low থেকে $high';
  }

  @override
  String get okTitle => 'সম্পত্তির মালিকানা ও কাগজপত্র যাচাই হয়েছে';

  @override
  String get reasonKyc01 =>
      'ছবি থেকে আপনার পরিচয় নিশ্চিত করা যায়নি। একটি ছোট ভিডিও KYC কল সম্পূর্ণ করুন।';

  @override
  String get reasonFrd02 =>
      'স্যালারি স্লিপের আয় ব্যাংকে জমার সঙ্গে মেলে না। সাম্প্রতিক ফর্ম 16 দিন, বা সম্মতি দিয়ে আমাদের আনতে দিন।';

  @override
  String get reasonFrd03 =>
      'আপনার একটি নথি প্রদানকারী কর্তৃপক্ষের যাচাইয়ে উত্তীর্ণ হয়নি।';

  @override
  String get reasonPol01 => 'আবেদনকারীর বয়স কমপক্ষে ২১ বছর হতে হবে।';

  @override
  String get reasonPol02 =>
      'লোনটি আমাদের অনুমোদিত সর্বোচ্চ বয়স পেরিয়ে যাবে। কম বয়সী সহ-আবেদনকারী যোগ করলে সাহায্য হতে পারে।';

  @override
  String get reasonBur01 => 'আপনার ক্রেডিট স্কোর আমাদের ন্যূনতম ৬৫০-এর নিচে।';

  @override
  String get reasonBur04 =>
      'আপনার এখনও ক্রেডিট ইতিহাস নেই, তাই একজন আধিকারিক আপনার ব্যাংক রেকর্ড দেখবেন।';

  @override
  String get reasonBur05 =>
      'আপনার ক্রেডিট স্কোর একজন আধিকারিকের ভালো করে দেখা দরকার।';

  @override
  String get reasonPrp01 =>
      'আমাদের আইনজীবীকে সম্পত্তির মালিকানা পর্যালোচনা করতে হবে।';

  @override
  String get reasonPrp03 =>
      'মূল্য নিশ্চিত করতে আমাদের মূল্যায়নকারীকে সম্পত্তি দেখতে যেতে হবে।';

  @override
  String get reasonPrp04 =>
      'চুক্তিমূল্য এই সম্পত্তির সরকারি সার্কেল রেটের চেয়ে কম। বিক্রয় চুক্তিটি দেখুন।';

  @override
  String get reasonAff01 =>
      'আপনার বর্তমান EMI ইতিমধ্যে আয়ের সর্বোচ্চ অংশ নিচ্ছে।';

  @override
  String get reasonAut01 =>
      'এই আকারের লোন একজন সিনিয়র আধিকারিক শেষবার যাচাই করেন।';

  @override
  String get reasonRsk01 =>
      'অফার চূড়ান্ত করতে একজন আধিকারিক আপনার আবেদন দেখবেন।';

  @override
  String get reasonRsk02 =>
      'আপনার ক্রেডিট প্রোফাইলের ভিত্তিতে এখন এই লোন দেওয়া সম্ভব নয়।';

  @override
  String get propertyTitle => 'আপনার সম্পত্তি';

  @override
  String get cityLabel => 'শহর';

  @override
  String get localityLabel => 'এলাকা';

  @override
  String get societyLabel => 'প্রকল্প বা সোসাইটি (যদি থাকে)';

  @override
  String get areaLabel => 'আয়তন (বর্গফুট)';

  @override
  String get bhkLabel => 'শোবার ঘর';

  @override
  String get newProperty => 'নতুন';

  @override
  String get resale => 'পুনর্বিক্রয়';

  @override
  String get declaredPriceLabel => 'চুক্তিমূল্য';

  @override
  String get photosTitle => 'সম্পত্তির ছবি';

  @override
  String get photosBody =>
      'সম্পত্তিতে গিয়ে ছবি তুলুন। আমরা জায়গা ও সময় যোগ করি, যাতে মূল্যায়নকারী পরিদর্শনের পরিকল্পনা করতে পারেন।';

  @override
  String get photoFront => 'সামনে';

  @override
  String get photoInside => 'ভিতরে';

  @override
  String get photoView => 'সম্পত্তি থেকে দৃশ্য';

  @override
  String geoTagged(String lat, String lng) {
    return 'অবস্থান যোগ হয়েছে ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'অবস্থান ছাড়া ছবি সংরক্ষিত। জিও-ট্যাগের জন্য লোকেশন চালু করুন।';

  @override
  String get submitProperty => 'চূড়ান্ত মঞ্জুরি নিন';

  @override
  String get fillAll => 'সব ঘর পূরণ করুন।';

  @override
  String get kfsTitle => 'মূল তথ্য বিবরণী';

  @override
  String get kfsLoan => 'লোনের পরিমাণ';

  @override
  String get kfsTenure => 'মেয়াদ';

  @override
  String get kfsRate => 'সুদের হার';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI-এর সংখ্যা';

  @override
  String get kfsFee => 'প্রসেসিং ফি (GST সহ)';

  @override
  String get kfsTotalInterest => 'মোট সুদ';

  @override
  String get kfsTotalPayable => 'মোট প্রদেয়';

  @override
  String get kfsApr => 'বার্ষিক শতাংশ হার (APR)';

  @override
  String get kfsCoolingOff =>
      'কুলিং-অফ সময়: স্বাক্ষরের ৩ দিনের মধ্যে শুধু মূলধন ও সেই দিনগুলির সুদ ফেরত দিয়ে বিনা জরিমানায় বেরিয়ে আসতে পারেন।';

  @override
  String get kfsNote =>
      'ডেমোর নমুনা সংখ্যা। আসল KFS আপনার মঞ্জুরিপত্রের সঙ্গে আসবে।';

  @override
  String get useSample => 'নমুনা';

  @override
  String get videoKycDemo =>
      'ডেমো: এতে একজন আধিকারিকের সঙ্গে ভিডিও KYC কল বুক হত।';

  @override
  String get raiseComplaint => 'অভিযোগ করুন';

  @override
  String complaintSent(String ref) {
    return 'আপনার অভিযোগ নথিভুক্ত হয়েছে। রেফারেন্স $ref।';
  }

  @override
  String get stageSignIn => 'সাইন ইন';

  @override
  String get stageDetails => 'তথ্য';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'অফার';

  @override
  String get stageProperty => 'সম্পত্তি';

  @override
  String get homeSubtitle => 'হোম লোন · সম্পত্তির বিপরীতে লোন';

  @override
  String get heroPill => 'মিনিটে সিদ্ধান্ত';

  @override
  String heroFacts(String rate, String years) {
    return 'বার্ষিক $rate% থেকে · $years বছর পর্যন্ত';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% সম্পূর্ণ · যেখানে ছেড়েছিলেন সেখান থেকে শুরু করুন';
  }

  @override
  String get resume => 'আবার শুরু';

  @override
  String get calculators => 'ক্যালকুলেটর';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'মাসিক কিস্তি';

  @override
  String get calcEligibility => 'যোগ্যতা';

  @override
  String get calcEligibilitySub => 'কত পেতে পারেন';

  @override
  String get emiCalcTitle => 'EMI ক্যালকুলেটর';

  @override
  String get eligibilityCalcTitle => 'যোগ্যতা ক্যালকুলেটর';

  @override
  String totalInterest(String amount) {
    return 'মোট সুদ $amount';
  }

  @override
  String get calcIncomeOnly =>
      'শুধু আয়ের ভিত্তিতে। সম্পত্তির মূল্য এটি কমাতে পারে।';

  @override
  String get verified => 'যাচাইকৃত';

  @override
  String get yourLoan => 'আপনার লোন';

  @override
  String docsProgress(String done, String total) {
    return '$totalটির মধ্যে $doneটি যাচাইকৃত';
  }

  @override
  String get docNeeded => 'দরকার';

  @override
  String get docTryAgain => 'আবার চেষ্টা';

  @override
  String get fetched => 'আনা হয়েছে';

  @override
  String get statusApproved => 'অনুমোদিত';

  @override
  String get statusSanctioned => 'মঞ্জুর';

  @override
  String get statusInReview => 'পর্যালোচনায়';

  @override
  String get statusDeclined => 'প্রত্যাখ্যাত';

  @override
  String get trackTitle => 'আপনার আবেদন ট্র্যাক করুন';

  @override
  String get tlSubmitted => 'আবেদন জমা হয়েছে';

  @override
  String get tlVerified => 'KYC ও নথি যাচাই হয়েছে';

  @override
  String get tlInPrinciple => 'প্রাথমিক অনুমোদন';

  @override
  String get tlProperty => 'সম্পত্তির তথ্য ও মূল্যায়ন';

  @override
  String get tlPropertyNext => 'আপনার সম্পত্তির তথ্য ও ছবি যোগ করুন';

  @override
  String get tlOfficer => 'আধিকারিকের পর্যালোচনা';

  @override
  String get tlOfficerNext => 'এক কর্মদিবসের মধ্যে';

  @override
  String get tlLegal => 'আইনি ও মালিকানা যাচাই';

  @override
  String get tlSanction => 'চূড়ান্ত মঞ্জুরি ও ই-সাইন';

  @override
  String get tlSanctionNext => 'অনলাইনে মঞ্জুরিপত্রে স্বাক্ষর করুন';

  @override
  String get tlDisbursement => 'টাকা প্রদান';

  @override
  String get helpTitle => 'সাহায্য দরকার?';

  @override
  String get propertyType => 'নতুন না পুনর্বিক্রয়';

  @override
  String get greetMorning => 'সুপ্রভাত';

  @override
  String get greetAfternoon => 'শুভ অপরাহ্ন';

  @override
  String get greetEvening => 'শুভ সন্ধ্যা';

  @override
  String nearlyThere(String name) {
    return '$name, আপনি প্রায় পৌঁছে গেছেন';
  }

  @override
  String get chooseLanguage => 'আপনার ভাষা বেছে নিন';

  @override
  String get languageNote => 'এটি যেকোনো সময় বদলাতে পারেন।';

  @override
  String get liveChecks => 'লাইভ যাচাই';

  @override
  String get checkBureau => 'ক্রেডিট ব্যুরো';

  @override
  String checkScore(String score) {
    return 'স্কোর $score';
  }

  @override
  String get checkNoHistory => 'এখনও ইতিহাস নেই';

  @override
  String get checkBank => 'AA-র মাধ্যমে ব্যাংক';

  @override
  String get checkBankRead => '১২ মাস পড়া হয়েছে';

  @override
  String get checkKyc => 'eKYC ও সেলফি';

  @override
  String get checkPending => 'বাকি';

  @override
  String get checkDocs => 'নথি';

  @override
  String countOf(String done, String total) {
    return '$totalটির মধ্যে $doneটি';
  }

  @override
  String minutesLeft(String n) {
    return 'প্রায় $n মিনিট বাকি';
  }

  @override
  String ratePa(String rate) {
    return 'বার্ষিক $rate%';
  }

  @override
  String get continueApplication => 'আপনার আবেদন চালিয়ে যান';

  @override
  String get shapeOffer => 'আপনার অফার সাজান';

  @override
  String get shapeOfferSub => 'প্রাথমিকভাবে অনুমোদিত · বদলাতে টানুন';

  @override
  String get withinLimits => 'আপনার সীমার মধ্যে';

  @override
  String get aboveLimits => 'সীমার বেশি: পরিমাণ কমান বা বছর বাড়ান';

  @override
  String mostYouCan(String amount) {
    return 'সর্বোচ্চ নিতে পারেন: $amount';
  }

  @override
  String get useMax => 'সর্বোচ্চ নিন';

  @override
  String get principal => 'মূলধন';

  @override
  String get interest => 'সুদ';

  @override
  String get totalRepaid => 'মোট পরিশোধ';

  @override
  String get emiShareIncome => 'আয়ের অংশ হিসেবে EMI';

  @override
  String loanShareProperty(String value) {
    return '$value সম্পত্তির অংশ হিসেবে লোন';
  }

  @override
  String get lockOffer => 'এই অফার পাকা করুন';

  @override
  String get offerLocked => 'আপনার অফার পাকা হয়েছে।';

  @override
  String approvedUpTo(String amount) {
    return '$amount পর্যন্ত অনুমোদিত';
  }

  @override
  String readingDoc(String doc) {
    return 'আপনার $doc পড়া হচ্ছে';
  }

  @override
  String get documentAi => 'নথি AI';

  @override
  String sure(String pct) {
    return '$pct% নিশ্চিত';
  }

  @override
  String get readMatches => 'এটি আমাদের চাওয়া নথিই';

  @override
  String get readClear => 'পরিষ্কার ছবি, ঝাপসা বা ঝলক নেই';

  @override
  String get whatWeRead => 'আমরা যা পড়েছি';

  @override
  String get looksRight => 'ঠিক আছে';

  @override
  String get fieldName => 'নাম';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'আধার';

  @override
  String get fieldEmployer => 'নিয়োগকর্তা';

  @override
  String get fieldNetPay => 'নিট বেতন';

  @override
  String get fieldPeriod => 'বেতনের সময়কাল';

  @override
  String get fieldYear => 'বছর';

  @override
  String get fieldIncome => 'আয়';

  @override
  String get fieldBusiness => 'ব্যবসা';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'আপনার লোনের জন্য দরকার';

  @override
  String get consentSectionOptional => 'ঐচ্ছিক: আপনি চালু না করলে বন্ধ';

  @override
  String get advancedOptions => 'বিকল্প';

  @override
  String consentValidUntil(String given, String until) {
    return '$given তারিখে দেওয়া · $until পর্যন্ত বৈধ';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given তারিখে দেওয়া · তুলে না নেওয়া পর্যন্ত';
  }

  @override
  String get recheckTitle => 'টাকা দেওয়ার ঠিক আগে আরেকবার যাচাই';

  @override
  String get recheckBody =>
      'টাকা দেওয়ার ঠিক আগে আমরা আবার আপনার ক্রেডিট রিপোর্ট দেখি। না বললে তখন একজন আধিকারিক জিজ্ঞাসা করতে পারেন।';

  @override
  String get aaMonthsLabel => 'কত মাসের স্টেটমেন্ট শেয়ার করবেন';

  @override
  String monthsN(String n) {
    return '$n মাস';
  }

  @override
  String get aaAccountsLabel => 'শেয়ার করার অ্যাকাউন্ট';

  @override
  String get accountSavingsSalary => 'সেভিংস ·· 0912 · বেতন জমা';

  @override
  String get accountSavings => 'সেভিংস ·· 4821';

  @override
  String get accountFd => 'ফিক্সড ডিপোজিট ·· 3307';

  @override
  String get aaAccountNeeded => 'শেয়ার করতে অন্তত একটি অ্যাকাউন্ট বেছে নিন।';

  @override
  String get kycMethodLabel => 'কীভাবে পরিচয় নিশ্চিত করবেন';

  @override
  String get kycAadhaarOtp => 'আধার OTP';

  @override
  String get kycDigilocker => 'ডিজিলকার';

  @override
  String get kycVideo => 'ভিডিও KYC কল';

  @override
  String get useCkycTitle => 'আমার বর্তমান CKYC রেকর্ড ব্যবহার করুন';

  @override
  String get useCkycBody =>
      'অন্য ব্যাংক বা ফান্ডে KYC করা থাকলে, আবার না জিজ্ঞাসা করে আমরা সেই রেকর্ডটি আনি।';

  @override
  String get optOffersTitle => 'অফার ও নতুন পণ্য';

  @override
  String get optOffersBody =>
      'অফারের খবর কীভাবে পেতে চান বেছে নিন। যেকোনো সময় বন্ধ করতে পারেন।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ইমেল';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp-এ লোনের আপডেট';

  @override
  String get optUpdatesBody =>
      'SMS-এর পাশাপাশি WhatsApp-এ স্ট্যাটাস আপডেট ও EMI রিমাইন্ডার।';

  @override
  String get optInsuranceTitle => 'হোম লোন সুরক্ষার কোটেশন';

  @override
  String get optInsuranceBody =>
      'কোটেশনের জন্য আপনার নাম, বয়স ও লোনের পরিমাণ আমাদের বিমা অংশীদারকে দিন। কেনা কখনও বাধ্যতামূলক নয়।';

  @override
  String get getQuote => 'কোটেশন নিন';

  @override
  String get manageConsents => 'সম্মতি পরিচালনা';

  @override
  String get manageConsentsBody =>
      'ঐচ্ছিক সম্মতি যেকোনো সময় বন্ধ করুন। দরকারি সম্মতি তুলে নিলে আবেদন থেমে যায়, এবং তার জন্য আনা তথ্য আমরা মুছে ফেলি।';

  @override
  String get withdraw => 'তুলে নিন';

  @override
  String get consentHistory => 'সম্মতির ইতিহাস';

  @override
  String historyGiven(String item) {
    return '$item দেওয়া হয়েছে';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item তুলে নেওয়া হয়েছে';
  }

  @override
  String get historyEmpty => 'এখনও কিছু নেই।';

  @override
  String get consentOn => 'চালু';

  @override
  String get consentOff => 'বন্ধ';

  @override
  String get withdrawnRequired =>
      'আপনি একটি দরকারি সম্মতি তুলে নিয়েছেন, তাই আবেদন থেমে আছে।';

  @override
  String get checkMatchPending =>
      'ছবি মিলানো: আধার বা প্যান কার্ড আপলোড করলে হবে';

  @override
  String get realDetailsIntro =>
      'আপনার সম্পর্কে বলুন। প্রতিটি তথ্য আমরা আপনার নথির সঙ্গে মিলিয়ে দেখি।';

  @override
  String get fullNameLabel => 'পুরো নাম (প্যান কার্ডে যেমন আছে)';

  @override
  String get emailLabel => 'ইমেল';

  @override
  String get employerLabel => 'নিয়োগকর্তা বা ব্যবসার নাম';

  @override
  String get creditScoreLabel => 'ক্রেডিট স্কোর (ঐচ্ছিক)';

  @override
  String get creditScoreHint =>
      'আপনার CIBIL বা Experian রিপোর্ট থেকে, যদি জানা থাকে';

  @override
  String get addressLabel => 'ঠিকানা';

  @override
  String get saveDetails => 'আমার তথ্য সংরক্ষণ করুন';

  @override
  String get selfDeclaredNote =>
      'এই তথ্য আপনি দিয়েছেন। এরপর আপনি যে নথি আপলোড করবেন, তার সঙ্গে আমরা মিলিয়ে দেখব।';

  @override
  String get pickDob => 'আপনার জন্মতারিখ বেছে নিন';

  @override
  String get fillDetails =>
      'অনুগ্রহ করে নাম, জন্মতারিখ, কাজ, নিয়োগকর্তা ও আয় লিখুন।';

  @override
  String get docSaleDeed => 'বিক্রয় দলিল বা বরাদ্দ পত্র';

  @override
  String get saleDeedBody =>
      'নিবন্ধিত বিক্রয় দলিলের ছবি বা PDF আপলোড করুন (যে পাতায় সম্পত্তি ও ক্রেতা আছে)। মালিকানা যাচাইয়ের জন্য আমরা এটি পড়ি।';

  @override
  String get statusPending => 'পর্যালোচনা বাকি';

  @override
  String decisionRef(String ref) {
    return 'সিদ্ধান্তের রেকর্ড $ref';
  }

  @override
  String get scoreTitle => 'আমরা কীভাবে আপনার স্কোর হিসাব করেছি';

  @override
  String get scoreOutOf => '900-এর মধ্যে';

  @override
  String gradeLabel(String grade) {
    return 'গ্রেড $grade';
  }

  @override
  String scoreStart(String base) {
    return 'সবাই $base পয়েন্ট দিয়ে শুরু করেন। নিচের প্রতিটি লাইন পয়েন্ট যোগ করে বা কমায়।';
  }

  @override
  String get scoreNote =>
      'এটি সিদ্ধান্তের ক্রেডিট স্কোরের অংশ। আপনার আয়, পরিচয়, নথি ও সম্পত্তিও যাচাই করা হয়।';

  @override
  String get factorBureau => 'ক্রেডিট ব্যুরো স্কোর';

  @override
  String get factorHistory => 'ক্রেডিট ইতিহাসের বছর';

  @override
  String get factorLtv => 'সম্পত্তির মূল্যের তুলনায় ঋণের অংশ';

  @override
  String get factorLoanAmount => 'ঋণের পরিমাণ';

  @override
  String get factorMissing => 'পাওয়া যায়নি';

  @override
  String rangeBelow(String x) {
    return '$x-এর কম';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$a থেকে $b';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x বা তার বেশি';
  }

  @override
  String get viewLetter => 'সিদ্ধান্তপত্র';

  @override
  String get letterTitle => 'আপনার সিদ্ধান্তপত্র';

  @override
  String get letterPartlyEnglish =>
      'কিছু লাইন অনুবাদ করা যায়নি, তাই সেগুলি ইংরেজিতে আছে।';

  @override
  String get copyText => 'লেখা কপি করুন';

  @override
  String get copied => 'কপি হয়েছে';

  @override
  String get askTitle => 'প্রশ্ন করুন';

  @override
  String get askHint => 'যেমন: এরপর কী হবে?';

  @override
  String get askSend => 'পাঠান';

  @override
  String get askHuman => 'আমাদের দলের একজন এ বিষয়ে আপনার সঙ্গে যোগাযোগ করবেন।';

  @override
  String get uploadPdf => 'PDF আপলোড করুন';

  @override
  String get kfsFeeBase => 'প্রসেসিং ফি (0.5%)';

  @override
  String get kfsGst => 'ফি-র ওপর GST (18%)';

  @override
  String get kfsNoteEngine =>
      'এই অফারের জন্য হিসাব করা হয়েছে। স্বাক্ষরিত মূল তথ্য বিবরণী আপনার অনুমোদনপত্রের সঙ্গে আসবে।';

  @override
  String otpOnServer(String phone) {
    return 'এই টেস্ট সার্ভার SMS পাঠায় না। $phone-এর 6 অঙ্কের কোড কম্পিউটারের সার্ভার উইন্ডোতে দেখা যায়।';
  }

  @override
  String get resendOtp => 'নতুন কোড পাঠান';

  @override
  String get newOtpSent => 'নতুন কোড পাঠানো হয়েছে।';

  @override
  String get otpExpired => 'এই কোডের মেয়াদ শেষ। নতুন কোড পাঠান চাপুন।';

  @override
  String get otpTooManyTries =>
      'অনেকবার ভুল কোড দেওয়া হয়েছে। নতুন কোড পাঠান চাপুন।';

  @override
  String get otpTooManySends =>
      'অনেক বেশি কোড চাওয়া হয়েছে। 15 মিনিট অপেক্ষা করে আবার চেষ্টা করুন।';
}
