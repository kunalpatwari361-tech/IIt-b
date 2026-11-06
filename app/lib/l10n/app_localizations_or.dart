// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oriya (`or`).
class AppLocalizationsOr extends AppLocalizations {
  AppLocalizationsOr([String locale = 'or']) : super(locale);

  @override
  String get appTitle => 'ନିର୍ଣ୍ଣୟ';

  @override
  String get sandboxBanner => 'ଡେମୋ ମୋଡ୍: ନମୁନା ତଥ୍ୟ, ପ୍ରକୃତ ଯାଞ୍ଚ ନୁହେଁ';

  @override
  String get continueLabel => 'ଆଗକୁ ଯାଆନ୍ତୁ';

  @override
  String stepOf(String step, String total) {
    return 'ପଦକ୍ଷେପ $step / $total';
  }

  @override
  String get pleaseWait => 'ଦୟାକରି ଅପେକ୍ଷା କରନ୍ତୁ…';

  @override
  String get errorGeneric => 'କିଛି ଭୁଲ ହେଲା। ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get close => 'ବନ୍ଦ କରନ୍ତୁ';

  @override
  String get welcomeHeadline => 'କିଛି ମିନିଟରେ ଆପଣଙ୍କ ଗୃହ ଋଣର ନିଷ୍ପତ୍ତି';

  @override
  String get welcomeBody =>
      'ଗୃହ ଋଣ କିମ୍ବା ସମ୍ପତ୍ତି ବଦଳରେ ଋଣ ପାଇଁ ଆବେଦନ କରନ୍ତୁ। ଆମେ ସବୁକିଛି ଅନଲାଇନରେ ଯାଞ୍ଚ କରୁ ଏବଂ ସର୍ବଦା ନିଷ୍ପତ୍ତିର କାରଣ କହୁ।';

  @override
  String get chooseProduct => 'ଆପଣଙ୍କୁ କଣ ଦରକାର?';

  @override
  String get productHomeLoan => 'ଗୃହ ଋଣ';

  @override
  String get productHomeLoanSub => 'ଘର କିଣିବା, ତିଆରି କିମ୍ବା ମରାମତି';

  @override
  String get productLap => 'ସମ୍ପତ୍ତି ବଦଳରେ ଋଣ';

  @override
  String get productLapSub => 'ନିଜ ସମ୍ପତ୍ତି ବଦଳରେ ଋଣ ନିଅନ୍ତୁ';

  @override
  String get startApplication => 'ଆବେଦନ ଆରମ୍ଭ କରନ୍ତୁ';

  @override
  String get demoCustomers => 'ଡେମୋ ଗ୍ରାହକ';

  @override
  String get demoCustomersBody =>
      'ନମୁନା ମୋବାଇଲ ନମ୍ବର ଭରିବାକୁ ଗୋଟିଏରେ ଟ୍ୟାପ୍ କରନ୍ତୁ।';

  @override
  String get personaRavi => 'ରବି, 32, ଚାକିରିଆ, ଫ୍ଲାଟ କିଣୁଛନ୍ତି';

  @override
  String get personaMeena => 'ମୀନା, 45, ଲୁଗା ଦୋକାନ ଚଳାନ୍ତି (LAP)';

  @override
  String get personaArjun => 'ଅର୍ଜୁନ, 29, ଚାକିରିଆ, ବଦଳାଯାଇଥିବା ଦରମା ସ୍ଲିପ୍';

  @override
  String get signInTitle => 'ସାଇନ୍ ଇନ୍';

  @override
  String get mobileLabel => 'ମୋବାଇଲ ନମ୍ବର';

  @override
  String get mobileHint => '10 ଅଙ୍କର ମୋବାଇଲ ନମ୍ବର';

  @override
  String get invalidMobile => 'ଠିକ୍ 10 ଅଙ୍କର ମୋବାଇଲ ନମ୍ବର ଦିଅନ୍ତୁ।';

  @override
  String get sendOtp => 'OTP ପଠାନ୍ତୁ';

  @override
  String otpSentTo(String phone) {
    return '$phone କୁ 6 ଅଙ୍କର କୋଡ୍ ପଠାଗଲା।';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'ଯାଞ୍ଚ କରନ୍ତୁ';

  @override
  String get demoOtp => 'ଡେମୋ କୋଡ୍: 123456';

  @override
  String get wrongOtp => 'କୋଡ୍ ଭୁଲ। ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get deviceBound =>
      'ଏହି ଫୋନ୍ ଏବେ ଆପଣଙ୍କ ଆକାଉଣ୍ଟ ସହ ଯୋଡ଼ିହେଲା। ଅନ୍ୟ ଫୋନରେ ସାଇନ୍ ଇନ୍ ପାଇଁ ନୂଆ OTP ଦରକାର।';

  @override
  String get consentTitle => 'ଆପଣଙ୍କ ସମ୍ମତି';

  @override
  String get consentIntro =>
      'ଆମେ ଆପଣଙ୍କ ତଥ୍ୟ କେବଳ ଏହି ଋଣର ନିଷ୍ପତ୍ତି ଓ ପରିଚାଳନା ପାଇଁ ବ୍ୟବହାର କରୁ। ଆପଣ ଯେକୌଣସି ସମୟରେ ସମ୍ମତି ଫେରାଇ ନେଇପାରିବେ।';

  @override
  String get consentBureauTitle => 'କ୍ରେଡିଟ୍ ରିପୋର୍ଟ';

  @override
  String get consentBureauBody =>
      'କ୍ରେଡିଟ୍ ବ୍ୟୁରୋ (CIBIL, Experian, Equifax କିମ୍ବା CRIF) ରୁ ଆପଣଙ୍କ କ୍ରେଡିଟ୍ ଇତିହାସ ଦେଖାଯିବ। ଏଥିରେ ଆପଣଙ୍କ ସ୍କୋର୍ କମେ ନାହିଁ।';

  @override
  String get consentAaTitle => 'ଆକାଉଣ୍ଟ ଆଗ୍ରିଗେଟର ମାଧ୍ୟମରେ ବ୍ୟାଙ୍କ ଷ୍ଟେଟମେଣ୍ଟ';

  @override
  String get consentAaBody =>
      'RBI ଲାଇସେନ୍ସପ୍ରାପ୍ତ ଆକାଉଣ୍ଟ ଆଗ୍ରିଗେଟର ମାଧ୍ୟମରେ ଆପଣଙ୍କ ବ୍ୟାଙ୍କରୁ 12 ମାସର ଷ୍ଟେଟମେଣ୍ଟ ଅଣାଯିବ। ଅନୁରୋଧକୁ ଆପଣ ନିଜ AA ଆପରେ ଅନୁମୋଦନ କରିବେ।';

  @override
  String get consentKycTitle => 'ଆଧାର eKYC ଓ PAN';

  @override
  String get consentKycBody =>
      'UIDAI ଓ ଆୟକର ବିଭାଗ ସହ ଆପଣଙ୍କ ପରିଚୟ ନିଶ୍ଚିତ କରାଯିବ। ଆମେ କେବଳ ଲୁଚାଯାଇଥିବା ଆଧାର ନମ୍ବର ରଖୁ।';

  @override
  String get consentPrivacyTitle => 'ଗୋପନୀୟତା ବିଜ୍ଞପ୍ତି (DPDP ଆଇନ 2023)';

  @override
  String get consentPrivacyBody =>
      'କଣ ସଂଗ୍ରହ କରୁ: ପରିଚୟ, ଆୟ, ବ୍ୟାଙ୍କ ଓ ସମ୍ପତ୍ତି ବିବରଣୀ। କାହିଁକି: ଆପଣଙ୍କ ଋଣର ନିଷ୍ପତ୍ତି ଓ ପରିଚାଳନା ପାଇଁ। କେତେ ଦିନ: ଆଇନ ଯେତେ ଦିନ କହେ। ଆପଣଙ୍କ ଅଧିକାର: ତଥ୍ୟ ଦେଖିବା, ସଂଶୋଧନ କିମ୍ବା ବିଲୋପ କରିବା, ଏବଂ ଆମ ଅଭିଯୋଗ ଅଧିକାରୀ କିମ୍ବା ଡାଟା ସୁରକ୍ଷା ବୋର୍ଡରେ ଅଭିଯୋଗ କରିବା।';

  @override
  String get consentRequired => 'ଆବଶ୍ୟକ';

  @override
  String get consentNeeded => 'ଆଗକୁ ଯିବା ପାଇଁ ସବୁଥିରେ ସମ୍ମତି ଦିଅନ୍ତୁ।';

  @override
  String get agreeAndContinue => 'ସମ୍ମତି ଦେଇ ଆଗକୁ ଯାଆନ୍ତୁ';

  @override
  String get detailsTitle => 'ଆପଣଙ୍କ ବିବରଣୀ';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'ଠିକ୍ PAN ଦିଅନ୍ତୁ, ଯେପରି ABCDE1234F।';

  @override
  String get fetchDetails => 'ମୋ ବିବରଣୀ ଆଣନ୍ତୁ';

  @override
  String get fetchedFrom =>
      'PAN, ଆଧାର eKYC ଓ ବ୍ୟାଙ୍କ ଷ୍ଟେଟମେଣ୍ଟରୁ ଭରାଯାଇଛି। ସଂଶୋଧନ ପାଇଁ ଅଙ୍କରେ ଟ୍ୟାପ୍ କରନ୍ତୁ।';

  @override
  String get nameLabel => 'ନାମ';

  @override
  String get dobLabel => 'ଜନ୍ମ ତାରିଖ';

  @override
  String get employmentLabel => 'କାମ';

  @override
  String get salaried => 'ଚାକିରିଆ';

  @override
  String get selfEmployed => 'ସ୍ୱନିଯୁକ୍ତ';

  @override
  String get incomeLabel => 'ମାସିକ ନିଟ୍ ଆୟ';

  @override
  String get existingEmiLabel => 'ବର୍ତ୍ତମାନର ମାସିକ EMI';

  @override
  String get propertyValueLabel => 'ସମ୍ପତ୍ତି ମୂଲ୍ୟ';

  @override
  String get loanAmountLabel => 'ଋଣ ରାଶି';

  @override
  String get tenureLabel => 'ଅବଧି';

  @override
  String yearsLabel(String n) {
    return '$n ବର୍ଷ';
  }

  @override
  String get eligibleTitle => 'ଆପଣ ସର୍ବାଧିକ ପାଇପାରିବେ';

  @override
  String emiPerMonth(String amount) {
    return 'ମାସିକ EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'ବାର୍ଷିକ $rate%, ପରିବର୍ତ୍ତନଶୀଳ (ଉଦାହରଣ)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'ଆୟ ଅନୁଯାୟୀ ସୀମା: ସମସ୍ତ EMI ମିଶି ଆୟର $pct ପର୍ଯ୍ୟନ୍ତ ହୋଇପାରେ।';
  }

  @override
  String limitedByProperty(String pct) {
    return 'ସମ୍ପତ୍ତି ଅନୁଯାୟୀ ସୀମା: ଏତେ ଋଣ ମୂଲ୍ୟର $pct ପର୍ଯ୍ୟନ୍ତ ହୋଇପାରେ।';
  }

  @override
  String get limitedByAsked => 'ଏହା ଆପଣ ମାଗିଥିବା ରାଶି।';

  @override
  String get eligibilityNote =>
      'ଆପଣଙ୍କ ବିବରଣୀର ଶୀଘ୍ର ଯାଞ୍ଚ। ଆମ ଯାଞ୍ଚ ପରେ ଅଫର ଆସିବ।';

  @override
  String get selfieTitle => 'ସେଲ୍ଫି ନିଅନ୍ତୁ';

  @override
  String get selfieBody =>
      'ଆମେ ଆପଣଙ୍କ ମୁହଁକୁ ଆଧାର ଫଟୋ ସହ ମିଳାଉ ଏବଂ ଦେଖୁ ଯେ ଏହା ପ୍ରକୃତରେ ଆପଣ, ଫଟୋର ଫଟୋ ନୁହେଁ।';

  @override
  String get selfieTips =>
      'ଭଲ ଆଲୋକ, କ୍ୟାମେରା ଆଡ଼କୁ ଦେଖନ୍ତୁ, ଟୋପି କିମ୍ବା ଚଷମା ନାହିଁ।';

  @override
  String get takeSelfie => 'ସେଲ୍ଫି ନିଅନ୍ତୁ';

  @override
  String get retake => 'ପୁଣି ନିଅନ୍ତୁ';

  @override
  String get checkFace => 'ମୁହଁ ମିଳିଲା';

  @override
  String get checkLive => 'ଜୀବନ୍ତ ବ୍ୟକ୍ତି';

  @override
  String get checkMatch => 'ଆଧାର ଫଟୋ ସହ ମେଳ ଖାଉଛି';

  @override
  String get selfieFailed =>
      'ଆପଣଙ୍କ ମୁହଁ ନିଶ୍ଚିତ କରିହେଲା ନାହିଁ। ଭଲ ଆଲୋକରେ ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ, କିମ୍ବା ଭିଡିଓ KYC କଲ୍ ବୁକ୍ କରନ୍ତୁ।';

  @override
  String get videoKyc => 'ଭିଡିଓ KYC କଲ୍ ବୁକ୍ କରନ୍ତୁ';

  @override
  String get docsTitle => 'ଆପଣଙ୍କ ଦଲିଲ';

  @override
  String get docsBody =>
      'ପ୍ରତ୍ୟେକ ଦଲିଲର ସ୍ପଷ୍ଟ ଫଟୋ ନିଅନ୍ତୁ, କିମ୍ବା ଗ୍ୟାଲେରୀରୁ ବାଛନ୍ତୁ।';

  @override
  String get docPan => 'PAN କାର୍ଡ';

  @override
  String get docAadhaar => 'ଆଧାର କାର୍ଡ (ଲୁଚାଯାଇଥିବା)';

  @override
  String get docSalarySlip => 'ସାମ୍ପ୍ରତିକ ଦରମା ସ୍ଲିପ୍';

  @override
  String get docForm16 => 'ଫର୍ମ 16';

  @override
  String get docItr => 'ଆୟକର ରିଟର୍ଣ୍ଣ (ITR)';

  @override
  String get docGst => 'GST ସାର୍ଟିଫିକେଟ୍';

  @override
  String get docBankStatement => 'ବ୍ୟାଙ୍କ ଷ୍ଟେଟମେଣ୍ଟ';

  @override
  String get bankViaAa => 'ଆପଣଙ୍କ ଆକାଉଣ୍ଟ ଆଗ୍ରିଗେଟର ମାଧ୍ୟମରେ ଅଣାଯାଇଛି';

  @override
  String get camera => 'କ୍ୟାମେରା';

  @override
  String get gallery => 'ଗ୍ୟାଲେରୀ';

  @override
  String get checking => 'ଯାଞ୍ଚ ହେଉଛି…';

  @override
  String get tooBlurry => 'ବହୁତ ଅସ୍ପଷ୍ଟ। ଫୋନ୍ ସ୍ଥିର ରଖି ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get tooMuchGlare => 'ବହୁତ ଚମକ। ଆଲୋକରୁ ଦୂରେଇ ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String get tooDark => 'ବହୁତ ଅନ୍ଧାର। ଅଧିକ ଆଲୋକରେ ପୁଣି ଚେଷ୍ଟା କରନ୍ତୁ।';

  @override
  String docAccepted(String type) {
    return 'ଚିହ୍ନଟ ହେଲା: $type';
  }

  @override
  String docWrong(String expected) {
    return 'ଏହା $expected ପରି ଦେଖାଯାଉନାହିଁ। ଯାଞ୍ଚ କରି ଠିକ୍ ଦଲିଲ ଅପଲୋଡ୍ କରନ୍ତୁ।';
  }

  @override
  String get docUnreadable =>
      'ଏହି ଦଲିଲ ପଢ଼ିହେଲା ନାହିଁ। ଅଧିକ ସ୍ପଷ୍ଟ ଫଟୋ ନିଅନ୍ତୁ, କିମ୍ବା ମୂଳ PDF ଅପଲୋଡ୍ କରନ୍ତୁ।';

  @override
  String docsMissing(String n) {
    return 'ଆଉ $n ଦରକାର';
  }

  @override
  String get getOffer => 'ମୋ ନୀତିଗତ ଅଫର ଦେଖାନ୍ତୁ';

  @override
  String get approvedInPrinciple => 'ନୀତିଗତ ଭାବେ ଅନୁମୋଦିତ';

  @override
  String get sanctioned => 'ଋଣ ମଞ୍ଜୁର';

  @override
  String get referredTitle => 'ଆମକୁ ଟିକିଏ ଅଧିକ ସମୟ ଦରକାର';

  @override
  String get rejectedTitle => 'ଏବେ ଏହି ଋଣ ଦେଇହେବ ନାହିଁ';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years ବର୍ଷ · ବାର୍ଷିକ $rate% ପରିବର୍ତ୍ତନଶୀଳ';
  }

  @override
  String get whyOffer => 'ଆପଣ ଏହି ଅଫର କାହିଁକି ପାଇଲେ';

  @override
  String get whyReferred => 'ଏହାପରେ କଣ ହେବ';

  @override
  String get whyRejected => 'ଆମେ ଏହି ନିଷ୍ପତ୍ତି କାହିଁକି ନେଲୁ';

  @override
  String get referBody =>
      'ଜଣେ ଅଧିକାରୀ ଗୋଟିଏ କାର୍ଯ୍ୟଦିବସ ମଧ୍ୟରେ ଆପଣଙ୍କ ଆବେଦନ ଦେଖିବେ। ଏବେ ଆପଣଙ୍କୁ କିଛି କରିବାକୁ ପଡ଼ିବ ନାହିଁ।';

  @override
  String get rejectBody =>
      'ଆପଣ ଯେକୌଣସି ସମୟରେ ଜଣେ ବ୍ୟକ୍ତିଙ୍କୁ ଏହି ନିଷ୍ପତ୍ତିର ସମୀକ୍ଷା କରିବାକୁ କହିପାରିବେ।';

  @override
  String get addProperty => 'ସମ୍ପତ୍ତି ବିବରଣୀ ଯୋଡ଼ନ୍ତୁ';

  @override
  String get viewKfs => 'ମୁଖ୍ୟ ତଥ୍ୟ ବିବରଣୀ ଦେଖନ୍ତୁ';

  @override
  String get grievance => 'ସମୀକ୍ଷା ମାଗନ୍ତୁ କିମ୍ବା ଅଭିଯୋଗ କରନ୍ତୁ';

  @override
  String officerLine(String name, String email) {
    return 'ଅଭିଯୋଗ ଅଧିକାରୀ: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'ଆବେଦନ $id';
  }

  @override
  String get startOver => 'ନୂଆ ଆବେଦନ ଆରମ୍ଭ କରନ୍ତୁ';

  @override
  String okScore(String score) {
    return 'ଭଲ ପରିଶୋଧ ଇତିହାସ (ସ୍କୋର୍ $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI ଆୟର $pct; ଆମ ସୀମା $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'ଋଣ ସମ୍ପତ୍ତି ମୂଲ୍ୟର $pct; ସୀମା $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'ସମ୍ପତ୍ତିର ଆମ ମୂଲ୍ୟାଙ୍କନ: $low ରୁ $high';
  }

  @override
  String get okTitle => 'ସମ୍ପତ୍ତିର ମାଲିକାନା ଓ କାଗଜପତ୍ର ଯାଞ୍ଚ ହେଲା';

  @override
  String get reasonKyc01 =>
      'ଫଟୋରୁ ଆପଣଙ୍କ ପରିଚୟ ନିଶ୍ଚିତ ହେଲା ନାହିଁ। ଦୟାକରି ଏକ ଛୋଟ ଭିଡିଓ KYC କଲ୍ ସମ୍ପୂର୍ଣ୍ଣ କରନ୍ତୁ।';

  @override
  String get reasonFrd02 =>
      'ଦରମା ସ୍ଲିପ୍‌ର ଆୟ ବ୍ୟାଙ୍କ ଜମା ସହ ମେଳ ଖାଉନାହିଁ। ସାମ୍ପ୍ରତିକ ଫର୍ମ 16 ଦିଅନ୍ତୁ, କିମ୍ବା ସମ୍ମତି ଦେଇ ଆମକୁ ଆଣିବାକୁ ଦିଅନ୍ତୁ।';

  @override
  String get reasonFrd03 =>
      'ଆପଣଙ୍କ ଗୋଟିଏ ଦଲିଲ ଜାରିକାରୀ କର୍ତ୍ତୃପକ୍ଷଙ୍କ ଯାଞ୍ଚରେ ବିଫଳ ହେଲା।';

  @override
  String get reasonPol01 => 'ଆବେଦନକାରୀଙ୍କ ବୟସ ଅତି କମରେ 21 ବର୍ଷ ହେବା ଦରକାର।';

  @override
  String get reasonPol02 =>
      'ଋଣ ଆମ ଅନୁମୋଦିତ ସର୍ବାଧିକ ବୟସ ପାର କରିଯିବ। କମ୍ ବୟସର ସହ-ଆବେଦନକାରୀ ଯୋଡ଼ିଲେ ସାହାଯ୍ୟ ମିଳିପାରେ।';

  @override
  String get reasonBur01 => 'ଆପଣଙ୍କ କ୍ରେଡିଟ୍ ସ୍କୋର୍ ଆମ ସର୍ବନିମ୍ନ 650 ଠାରୁ କମ୍।';

  @override
  String get reasonBur04 =>
      'ଆପଣଙ୍କର ଏପର୍ଯ୍ୟନ୍ତ କ୍ରେଡିଟ୍ ଇତିହାସ ନାହିଁ, ତେଣୁ ଜଣେ ଅଧିକାରୀ ଆପଣଙ୍କ ବ୍ୟାଙ୍କ ରେକର୍ଡ ଦେଖିବେ।';

  @override
  String get reasonBur05 =>
      'ଆପଣଙ୍କ କ୍ରେଡିଟ୍ ସ୍କୋର୍‌କୁ ଜଣେ ଅଧିକାରୀ ଭଲ ଭାବେ ଦେଖିବା ଦରକାର।';

  @override
  String get reasonPrp01 => 'ଆମ ଓକିଲ ସମ୍ପତ୍ତିର ମାଲିକାନା ସମୀକ୍ଷା କରିବା ଦରକାର।';

  @override
  String get reasonPrp03 =>
      'ମୂଲ୍ୟ ନିଶ୍ଚିତ କରିବାକୁ ଆମ ମୂଲ୍ୟାଙ୍କନକାରୀ ସମ୍ପତ୍ତି ପରିଦର୍ଶନ କରିବା ଦରକାର।';

  @override
  String get reasonPrp04 =>
      'ଚୁକ୍ତି ମୂଲ୍ୟ ଏହି ସମ୍ପତ୍ତିର ସରକାରୀ ବେଞ୍ଚମାର୍କ ମୂଲ୍ୟଠାରୁ କମ୍। ଦୟାକରି ବିକ୍ରୟ ଚୁକ୍ତି ଯାଞ୍ଚ କରନ୍ତୁ।';

  @override
  String get reasonAff01 =>
      'ଆପଣଙ୍କ ବର୍ତ୍ତମାନର EMI ପୂର୍ବରୁ ଆୟର ସର୍ବାଧିକ ଅଂଶ ନେଉଛି।';

  @override
  String get reasonAut01 => 'ଏତେ ବଡ଼ ଋଣର ଶେଷ ଯାଞ୍ଚ ଜଣେ ବରିଷ୍ଠ ଅଧିକାରୀ କରନ୍ତି।';

  @override
  String get reasonRsk01 =>
      'ଅଫର ଚୂଡ଼ାନ୍ତ କରିବାକୁ ଜଣେ ଅଧିକାରୀ ଆପଣଙ୍କ ଆବେଦନ ଦେଖିବେ।';

  @override
  String get reasonRsk02 =>
      'ଆପଣଙ୍କ କ୍ରେଡିଟ୍ ପ୍ରୋଫାଇଲ ଆଧାରରେ ଏବେ ଏହି ଋଣ ଦେଇହେବ ନାହିଁ।';

  @override
  String get propertyTitle => 'ଆପଣଙ୍କ ସମ୍ପତ୍ତି';

  @override
  String get cityLabel => 'ସହର';

  @override
  String get localityLabel => 'ଅଞ୍ଚଳ';

  @override
  String get societyLabel => 'ପ୍ରକଳ୍ପ କିମ୍ବା ସୋସାଇଟି (ଯଦି ଥାଏ)';

  @override
  String get areaLabel => 'କ୍ଷେତ୍ରଫଳ (ବର୍ଗ ଫୁଟ)';

  @override
  String get bhkLabel => 'ଶୋଇବା ଘର';

  @override
  String get newProperty => 'ନୂଆ';

  @override
  String get resale => 'ପୁନଃବିକ୍ରୟ';

  @override
  String get declaredPriceLabel => 'ଚୁକ୍ତି ମୂଲ୍ୟ';

  @override
  String get photosTitle => 'ସମ୍ପତ୍ତିର ଫଟୋ';

  @override
  String get photosBody =>
      'ସମ୍ପତ୍ତି ସ୍ଥାନରେ ଫଟୋ ନିଅନ୍ତୁ। ଆମେ ସ୍ଥାନ ଓ ସମୟ ଯୋଡ଼ୁ, ଯାହାଦ୍ୱାରା ମୂଲ୍ୟାଙ୍କନକାରୀ ପରିଦର୍ଶନର ଯୋଜନା କରିପାରିବେ।';

  @override
  String get photoFront => 'ସାମ୍ନା';

  @override
  String get photoInside => 'ଭିତର';

  @override
  String get photoView => 'ସମ୍ପତ୍ତିରୁ ଦୃଶ୍ୟ';

  @override
  String geoTagged(String lat, String lng) {
    return 'ସ୍ଥାନ ଯୋଡ଼ାଗଲା ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'ସ୍ଥାନ ବିନା ଫଟୋ ସଞ୍ଚିତ ହେଲା। ଜିଓ-ଟ୍ୟାଗ୍ ପାଇଁ ଲୋକେସନ ଚାଲୁ କରନ୍ତୁ।';

  @override
  String get submitProperty => 'ଚୂଡ଼ାନ୍ତ ମଞ୍ଜୁରୀ ପାଆନ୍ତୁ';

  @override
  String get fillAll => 'ଦୟାକରି ସବୁ ଘର ପୂରଣ କରନ୍ତୁ।';

  @override
  String get kfsTitle => 'ମୁଖ୍ୟ ତଥ୍ୟ ବିବରଣୀ';

  @override
  String get kfsLoan => 'ଋଣ ରାଶି';

  @override
  String get kfsTenure => 'ଅବଧି';

  @override
  String get kfsRate => 'ସୁଧ ହାର';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI ସଂଖ୍ୟା';

  @override
  String get kfsFee => 'ପ୍ରୋସେସିଂ ଶୁଳ୍କ (GST ସହ)';

  @override
  String get kfsTotalInterest => 'ମୋଟ ସୁଧ';

  @override
  String get kfsTotalPayable => 'ମୋଟ ଦେୟ ରାଶି';

  @override
  String get kfsApr => 'ବାର୍ଷିକ ଶତକଡ଼ା ହାର (APR)';

  @override
  String get kfsCoolingOff =>
      'କୁଲିଂ-ଅଫ୍ ଅବଧି: ଦସ୍ତଖତର 3 ଦିନ ମଧ୍ୟରେ କେବଳ ମୂଳଧନ ଓ ସେହି ଦିନର ସୁଧ ଫେରାଇ ବିନା ଜରିମାନାରେ ବାହାରିପାରିବେ।';

  @override
  String get kfsNote =>
      'ଡେମୋ ପାଇଁ ନମୁନା ଅଙ୍କ। ଆପଣଙ୍କ ପ୍ରକୃତ KFS ମଞ୍ଜୁରୀ ପତ୍ର ସହ ଆସିବ।';

  @override
  String get useSample => 'ନମୁନା';

  @override
  String get videoKycDemo =>
      'ଡେମୋ: ଏହା ଜଣେ ଅଧିକାରୀଙ୍କ ସହ ଭିଡିଓ KYC କଲ୍ ବୁକ୍ କରିଥାନ୍ତା।';

  @override
  String get raiseComplaint => 'ଅଭିଯୋଗ କରନ୍ତୁ';

  @override
  String complaintSent(String ref) {
    return 'ଆପଣଙ୍କ ଅଭିଯୋଗ ପଞ୍ଜିକୃତ ହେଲା। ସନ୍ଦର୍ଭ $ref।';
  }

  @override
  String get stageSignIn => 'ସାଇନ୍ ଇନ୍';

  @override
  String get stageDetails => 'ବିବରଣୀ';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'ଅଫର';

  @override
  String get stageProperty => 'ସମ୍ପତ୍ତି';

  @override
  String get homeSubtitle => 'ଗୃହ ଋଣ · ସମ୍ପତ୍ତି ବଦଳରେ ଋଣ';

  @override
  String get heroPill => 'ମିନିଟରେ ନିଷ୍ପତ୍ତି';

  @override
  String heroFacts(String rate, String years) {
    return 'ବାର୍ଷିକ $rate% ରୁ · $years ବର୍ଷ ପର୍ଯ୍ୟନ୍ତ';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% ସମ୍ପୂର୍ଣ୍ଣ · ଯେଉଁଠି ଛାଡ଼ିଥିଲେ ସେଠାରୁ ଆରମ୍ଭ କରନ୍ତୁ';
  }

  @override
  String get resume => 'ପୁଣି ଆରମ୍ଭ';

  @override
  String get calculators => 'କାଲକୁଲେଟର';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'ମାସିକ କିସ୍ତି';

  @override
  String get calcEligibility => 'ଯୋଗ୍ୟତା';

  @override
  String get calcEligibilitySub => 'ଆପଣ କେତେ ପାଇପାରିବେ';

  @override
  String get emiCalcTitle => 'EMI କାଲକୁଲେଟର';

  @override
  String get eligibilityCalcTitle => 'ଯୋଗ୍ୟତା କାଲକୁଲେଟର';

  @override
  String totalInterest(String amount) {
    return 'ମୋଟ ସୁଧ $amount';
  }

  @override
  String get calcIncomeOnly => 'କେବଳ ଆୟ ଆଧାରରେ। ସମ୍ପତ୍ତି ମୂଲ୍ୟ ଏହାକୁ କମାଇପାରେ।';

  @override
  String get verified => 'ଯାଞ୍ଚିତ';

  @override
  String get yourLoan => 'ଆପଣଙ୍କ ଋଣ';

  @override
  String docsProgress(String done, String total) {
    return '$total ମଧ୍ୟରୁ $done ଯାଞ୍ଚିତ';
  }

  @override
  String get docNeeded => 'ଦରକାର';

  @override
  String get docTryAgain => 'ପୁଣି ଚେଷ୍ଟା';

  @override
  String get fetched => 'ଅଣାଯାଇଛି';

  @override
  String get statusApproved => 'ଅନୁମୋଦିତ';

  @override
  String get statusSanctioned => 'ମଞ୍ଜୁର';

  @override
  String get statusInReview => 'ସମୀକ୍ଷାରେ';

  @override
  String get statusDeclined => 'ପ୍ରତ୍ୟାଖ୍ୟାତ';

  @override
  String get trackTitle => 'ଆପଣଙ୍କ ଆବେଦନ ଟ୍ରାକ୍ କରନ୍ତୁ';

  @override
  String get tlSubmitted => 'ଆବେଦନ ଦାଖଲ ହେଲା';

  @override
  String get tlVerified => 'KYC ଓ ଦଲିଲ ଯାଞ୍ଚ ହେଲା';

  @override
  String get tlInPrinciple => 'ନୀତିଗତ ଅନୁମୋଦନ';

  @override
  String get tlProperty => 'ସମ୍ପତ୍ତି ବିବରଣୀ ଓ ମୂଲ୍ୟାଙ୍କନ';

  @override
  String get tlPropertyNext => 'ଆପଣଙ୍କ ସମ୍ପତ୍ତିର ବିବରଣୀ ଓ ଫଟୋ ଯୋଡ଼ନ୍ତୁ';

  @override
  String get tlOfficer => 'ଅଧିକାରୀଙ୍କ ସମୀକ୍ଷା';

  @override
  String get tlOfficerNext => 'ଗୋଟିଏ କାର୍ଯ୍ୟଦିବସ ମଧ୍ୟରେ';

  @override
  String get tlLegal => 'ଆଇନଗତ ଓ ମାଲିକାନା ଯାଞ୍ଚ';

  @override
  String get tlSanction => 'ଚୂଡ଼ାନ୍ତ ମଞ୍ଜୁରୀ ଓ ଇ-ଦସ୍ତଖତ';

  @override
  String get tlSanctionNext => 'ମଞ୍ଜୁରୀ ପତ୍ରରେ ଅନଲାଇନ ଦସ୍ତଖତ କରନ୍ତୁ';

  @override
  String get tlDisbursement => 'ଟଙ୍କା ପ୍ରଦାନ';

  @override
  String get helpTitle => 'ସାହାଯ୍ୟ ଦରକାର?';

  @override
  String get propertyType => 'ନୂଆ ନା ପୁନଃବିକ୍ରୟ';

  @override
  String get greetMorning => 'ସୁପ୍ରଭାତ';

  @override
  String get greetAfternoon => 'ଶୁଭ ଅପରାହ୍ନ';

  @override
  String get greetEvening => 'ଶୁଭ ସନ୍ଧ୍ୟା';

  @override
  String nearlyThere(String name) {
    return '$name, ଆପଣ ପ୍ରାୟ ପହଞ୍ଚିଗଲେ';
  }

  @override
  String get chooseLanguage => 'ଆପଣଙ୍କ ଭାଷା ବାଛନ୍ତୁ';

  @override
  String get languageNote => 'ଆପଣ ଏହାକୁ ଯେକୌଣସି ସମୟରେ ବଦଳାଇପାରିବେ।';

  @override
  String get liveChecks => 'ଲାଇଭ୍ ଯାଞ୍ଚ';

  @override
  String get checkBureau => 'କ୍ରେଡିଟ୍ ବ୍ୟୁରୋ';

  @override
  String checkScore(String score) {
    return 'ସ୍କୋର୍ $score';
  }

  @override
  String get checkNoHistory => 'ଏପର୍ଯ୍ୟନ୍ତ ଇତିହାସ ନାହିଁ';

  @override
  String get checkBank => 'AA ମାଧ୍ୟମରେ ବ୍ୟାଙ୍କ';

  @override
  String get checkBankRead => '12 ମାସ ପଢ଼ାଗଲା';

  @override
  String get checkKyc => 'eKYC ଓ ସେଲ୍ଫି';

  @override
  String get checkPending => 'ବାକି';

  @override
  String get checkDocs => 'ଦଲିଲ';

  @override
  String countOf(String done, String total) {
    return '$total ମଧ୍ୟରୁ $done';
  }

  @override
  String minutesLeft(String n) {
    return 'ପ୍ରାୟ $n ମିନିଟ ବାକି';
  }

  @override
  String ratePa(String rate) {
    return 'ବାର୍ଷିକ $rate%';
  }

  @override
  String get continueApplication => 'ଆପଣଙ୍କ ଆବେଦନ ଜାରି ରଖନ୍ତୁ';

  @override
  String get shapeOffer => 'ଆପଣଙ୍କ ଅଫର ସ୍ଥିର କରନ୍ତୁ';

  @override
  String get shapeOfferSub => 'ନୀତିଗତ ଭାବେ ଅନୁମୋଦିତ · ବଦଳାଇବାକୁ ଟାଣନ୍ତୁ';

  @override
  String get withinLimits => 'ଆପଣଙ୍କ ସୀମା ମଧ୍ୟରେ';

  @override
  String get aboveLimits => 'ସୀମାଠାରୁ ଅଧିକ: ରାଶି କମାନ୍ତୁ କିମ୍ବା ବର୍ଷ ବଢ଼ାନ୍ତୁ';

  @override
  String mostYouCan(String amount) {
    return 'ସର୍ବାଧିକ ନେଇପାରିବେ: $amount';
  }

  @override
  String get useMax => 'ସର୍ବାଧିକ ନିଅନ୍ତୁ';

  @override
  String get principal => 'ମୂଳଧନ';

  @override
  String get interest => 'ସୁଧ';

  @override
  String get totalRepaid => 'ମୋଟ ପରିଶୋଧ';

  @override
  String get emiShareIncome => 'ଆୟରେ EMI ର ଅଂଶ';

  @override
  String loanShareProperty(String value) {
    return '$value ସମ୍ପତ୍ତିରେ ଋଣର ଅଂଶ';
  }

  @override
  String get lockOffer => 'ଏହି ଅଫର ପକ୍କା କରନ୍ତୁ';

  @override
  String get offerLocked => 'ଆପଣଙ୍କ ଅଫର ପକ୍କା ହେଲା।';

  @override
  String approvedUpTo(String amount) {
    return '$amount ପର୍ଯ୍ୟନ୍ତ ଅନୁମୋଦିତ';
  }

  @override
  String readingDoc(String doc) {
    return 'ଆପଣଙ୍କ $doc ପଢ଼ାଯାଉଛି';
  }

  @override
  String get documentAi => 'ଦଲିଲ AI';

  @override
  String sure(String pct) {
    return '$pct% ନିଶ୍ଚିତ';
  }

  @override
  String get readMatches => 'ଏହା ଆମେ ମାଗିଥିବା ଦଲିଲ';

  @override
  String get readClear => 'ସ୍ପଷ୍ଟ ଫଟୋ, ଅସ୍ପଷ୍ଟତା କିମ୍ବା ଚମକ ନାହିଁ';

  @override
  String get whatWeRead => 'ଆମେ ଯାହା ପଢ଼ିଲୁ';

  @override
  String get looksRight => 'ଠିକ୍ ଅଛି';

  @override
  String get fieldName => 'ନାମ';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'ଆଧାର';

  @override
  String get fieldEmployer => 'ନିଯୁକ୍ତିଦାତା';

  @override
  String get fieldNetPay => 'ନିଟ୍ ଦରମା';

  @override
  String get fieldPeriod => 'ଦରମା ଅବଧି';

  @override
  String get fieldYear => 'ବର୍ଷ';

  @override
  String get fieldIncome => 'ଆୟ';

  @override
  String get fieldBusiness => 'ବ୍ୟବସାୟ';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'ଆପଣଙ୍କ ଋଣ ପାଇଁ ଆବଶ୍ୟକ';

  @override
  String get consentSectionOptional =>
      'ବୈକଳ୍ପିକ: ଆପଣ ଚାଲୁ ନକରିବା ପର୍ଯ୍ୟନ୍ତ ବନ୍ଦ';

  @override
  String get advancedOptions => 'ବିକଳ୍ପ';

  @override
  String consentValidUntil(String given, String until) {
    return '$given ରେ ଦିଆଗଲା · $until ପର୍ଯ୍ୟନ୍ତ ବୈଧ';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given ରେ ଦିଆଗଲା · ଫେରାଇ ନେବା ପର୍ଯ୍ୟନ୍ତ';
  }

  @override
  String get recheckTitle => 'ଟଙ୍କା ଦେବା ପୂର୍ବରୁ ଆଉ ଏକ ଯାଞ୍ଚ';

  @override
  String get recheckBody =>
      'ଟଙ୍କା ଦେବା ପୂର୍ବରୁ ଆମେ ଆପଣଙ୍କ କ୍ରେଡିଟ୍ ରିପୋର୍ଟ ପୁଣି ଦେଖୁ। ନା କହିଲେ ସେତେବେଳେ ଜଣେ ଅଧିକାରୀ ପଚାରିପାରନ୍ତି।';

  @override
  String get aaMonthsLabel => 'କେତେ ମାସର ଷ୍ଟେଟମେଣ୍ଟ ଦେବେ';

  @override
  String monthsN(String n) {
    return '$n ମାସ';
  }

  @override
  String get aaAccountsLabel => 'ଦେବାକୁ ଥିବା ଆକାଉଣ୍ଟ';

  @override
  String get accountSavingsSalary => 'ସଞ୍ଚୟ ·· 0912 · ଦରମା ଜମା';

  @override
  String get accountSavings => 'ସଞ୍ଚୟ ·· 4821';

  @override
  String get accountFd => 'ସ୍ଥାୟୀ ଜମା ·· 3307';

  @override
  String get aaAccountNeeded => 'ଅତି କମରେ ଗୋଟିଏ ଆକାଉଣ୍ଟ ବାଛନ୍ତୁ।';

  @override
  String get kycMethodLabel => 'ପରିଚୟ କିପରି ନିଶ୍ଚିତ କରିବେ';

  @override
  String get kycAadhaarOtp => 'ଆଧାର OTP';

  @override
  String get kycDigilocker => 'ଡିଜିଲକର';

  @override
  String get kycVideo => 'ଭିଡିଓ KYC କଲ୍';

  @override
  String get useCkycTitle => 'ମୋର ବର୍ତ୍ତମାନର CKYC ରେକର୍ଡ ବ୍ୟବହାର କରନ୍ତୁ';

  @override
  String get useCkycBody =>
      'ଅନ୍ୟ ବ୍ୟାଙ୍କ କିମ୍ବା ଫଣ୍ଡରେ KYC କରିଥିଲେ, ପୁଣି ନପଚାରି ଆମେ ସେହି ରେକର୍ଡ ଆଣୁ।';

  @override
  String get optOffersTitle => 'ଅଫର ଓ ନୂଆ ଉତ୍ପାଦ';

  @override
  String get optOffersBody =>
      'ଅଫର ବିଷୟରେ କିପରି ଜାଣିବେ ବାଛନ୍ତୁ। ଯେକୌଣସି ସମୟରେ ବନ୍ଦ କରିପାରିବେ।';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ଇମେଲ';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp ରେ ଋଣ ଅପଡେଟ୍';

  @override
  String get optUpdatesBody => 'SMS ସହ WhatsApp ରେ ସ୍ଥିତି ଅପଡେଟ୍ ଓ EMI ସ୍ମାରକ।';

  @override
  String get optInsuranceTitle => 'ଗୃହ ଋଣ ସୁରକ୍ଷା କୋଟେସନ';

  @override
  String get optInsuranceBody =>
      'କୋଟେସନ ପାଇଁ ଆପଣଙ୍କ ନାମ, ବୟସ ଓ ଋଣ ରାଶି ଆମ ବୀମା ସହଯୋଗୀଙ୍କୁ ଦିଅନ୍ତୁ। କିଣିବା କେବେ ବାଧ୍ୟତାମୂଳକ ନୁହେଁ।';

  @override
  String get getQuote => 'କୋଟେସନ ନିଅନ୍ତୁ';

  @override
  String get manageConsents => 'ସମ୍ମତି ପରିଚାଳନା';

  @override
  String get manageConsentsBody =>
      'ବୈକଳ୍ପିକ ସମ୍ମତି ଯେକୌଣସି ସମୟରେ ବନ୍ଦ କରନ୍ତୁ। ଆବଶ୍ୟକ ସମ୍ମତି ଫେରାଇ ନେଲେ ଆବେଦନ ବନ୍ଦ ହୁଏ, ଏବଂ ସେଥିପାଇଁ ଅଣାଯାଇଥିବା ତଥ୍ୟ ଆମେ ବିଲୋପ କରୁ।';

  @override
  String get withdraw => 'ଫେରାଇ ନିଅନ୍ତୁ';

  @override
  String get consentHistory => 'ସମ୍ମତି ଇତିହାସ';

  @override
  String historyGiven(String item) {
    return '$item ଦିଆଗଲା';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item ଫେରାଇ ନିଆଗଲା';
  }

  @override
  String get historyEmpty => 'ଏପର୍ଯ୍ୟନ୍ତ କିଛି ନାହିଁ।';

  @override
  String get consentOn => 'ଚାଲୁ';

  @override
  String get consentOff => 'ବନ୍ଦ';

  @override
  String get withdrawnRequired =>
      'ଆପଣ ଏକ ଆବଶ୍ୟକ ସମ୍ମତି ଫେରାଇ ନେଲେ, ତେଣୁ ଆବେଦନ ବନ୍ଦ ଅଛି।';

  @override
  String get checkMatchPending =>
      'ଫଟୋ ମେଳ: ଆଧାର କିମ୍ବା ପାନ କାର୍ଡ ଅପଲୋଡ କଲେ ହେବ';
}
