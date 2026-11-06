// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malayalam (`ml`).
class AppLocalizationsMl extends AppLocalizations {
  AppLocalizationsMl([String locale = 'ml']) : super(locale);

  @override
  String get appTitle => 'നിർണയ്';

  @override
  String get sandboxBanner =>
      'ഡെമോ മോഡ്: സാമ്പിൾ വിവരങ്ങൾ, യഥാർത്ഥ പരിശോധനയല്ല';

  @override
  String get continueLabel => 'തുടരുക';

  @override
  String stepOf(String step, String total) {
    return 'ഘട്ടം $step / $total';
  }

  @override
  String get pleaseWait => 'ദയവായി കാത്തിരിക്കുക…';

  @override
  String get errorGeneric => 'എന്തോ പിശക് സംഭവിച്ചു. വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get close => 'അടയ്ക്കുക';

  @override
  String get welcomeHeadline =>
      'മിനിറ്റുകൾക്കുള്ളിൽ നിങ്ങളുടെ ഭവന വായ്പാ തീരുമാനം';

  @override
  String get welcomeBody =>
      'ഭവന വായ്പയ്ക്കോ വസ്തുവിന്മേലുള്ള വായ്പയ്ക്കോ അപേക്ഷിക്കുക. ഞങ്ങൾ എല്ലാം ഓൺലൈനായി പരിശോധിക്കുന്നു, തീരുമാനത്തിന്റെ കാരണം എപ്പോഴും പറയുന്നു.';

  @override
  String get chooseProduct => 'നിങ്ങൾക്ക് എന്താണ് വേണ്ടത്?';

  @override
  String get productHomeLoan => 'ഭവന വായ്പ';

  @override
  String get productHomeLoanSub => 'വീട് വാങ്ങാനോ പണിയാനോ നവീകരിക്കാനോ';

  @override
  String get productLap => 'വസ്തുവിന്മേൽ വായ്പ';

  @override
  String get productLapSub => 'സ്വന്തം വസ്തുവിന്മേൽ കടം എടുക്കുക';

  @override
  String get startApplication => 'അപേക്ഷ തുടങ്ങുക';

  @override
  String get demoCustomers => 'ഡെമോ ഉപഭോക്താക്കൾ';

  @override
  String get demoCustomersBody =>
      'സാമ്പിൾ മൊബൈൽ നമ്പർ നൽകാൻ ഒന്നിൽ ടാപ്പ് ചെയ്യുക.';

  @override
  String get personaRavi => 'രവി, 32, ശമ്പളക്കാരൻ, ഫ്ലാറ്റ് വാങ്ങുന്നു';

  @override
  String get personaMeena => 'മീന, 45, തുണിക്കട നടത്തുന്നു (LAP)';

  @override
  String get personaArjun =>
      'അർജുൻ, 29, ശമ്പളക്കാരൻ, മാറ്റം വരുത്തിയ ശമ്പള സ്ലിപ്പ്';

  @override
  String get signInTitle => 'സൈൻ ഇൻ';

  @override
  String get mobileLabel => 'മൊബൈൽ നമ്പർ';

  @override
  String get mobileHint => '10 അക്ക മൊബൈൽ നമ്പർ';

  @override
  String get invalidMobile => 'ശരിയായ 10 അക്ക മൊബൈൽ നമ്പർ നൽകുക.';

  @override
  String get sendOtp => 'OTP അയയ്ക്കുക';

  @override
  String otpSentTo(String phone) {
    return '$phone ലേക്ക് 6 അക്ക കോഡ് അയച്ചു.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'സ്ഥിരീകരിക്കുക';

  @override
  String get demoOtp => 'ഡെമോ കോഡ്: 123456';

  @override
  String get wrongOtp => 'കോഡ് തെറ്റാണ്. വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get deviceBound =>
      'ഈ ഫോൺ ഇപ്പോൾ നിങ്ങളുടെ അക്കൗണ്ടുമായി ബന്ധിപ്പിച്ചു. മറ്റൊരു ഫോണിൽ സൈൻ ഇൻ ചെയ്യാൻ പുതിയ OTP വേണം.';

  @override
  String get consentTitle => 'നിങ്ങളുടെ സമ്മതം';

  @override
  String get consentIntro =>
      'നിങ്ങളുടെ വിവരങ്ങൾ ഈ വായ്പയുടെ തീരുമാനത്തിനും നടത്തിപ്പിനും മാത്രമേ ഉപയോഗിക്കൂ. എപ്പോൾ വേണമെങ്കിലും സമ്മതം പിൻവലിക്കാം.';

  @override
  String get consentBureauTitle => 'ക്രെഡിറ്റ് റിപ്പോർട്ട്';

  @override
  String get consentBureauBody =>
      'ക്രെഡിറ്റ് ബ്യൂറോയിൽ (CIBIL, Experian, Equifax അല്ലെങ്കിൽ CRIF) നിങ്ങളുടെ ക്രെഡിറ്റ് ചരിത്രം പരിശോധിക്കും. ഇത് നിങ്ങളുടെ സ്കോർ കുറയ്ക്കില്ല.';

  @override
  String get consentAaTitle =>
      'അക്കൗണ്ട് അഗ്രിഗേറ്റർ വഴി ബാങ്ക് സ്റ്റേറ്റ്മെന്റ്';

  @override
  String get consentAaBody =>
      'RBI ലൈസൻസുള്ള അക്കൗണ്ട് അഗ്രിഗേറ്റർ വഴി നിങ്ങളുടെ ബാങ്കിൽ നിന്ന് 12 മാസത്തെ സ്റ്റേറ്റ്മെന്റ് എടുക്കും. അഭ്യർത്ഥന നിങ്ങളുടെ AA ആപ്പിൽ നിങ്ങൾ അംഗീകരിക്കും.';

  @override
  String get consentKycTitle => 'ആധാർ eKYC, PAN';

  @override
  String get consentKycBody =>
      'UIDAI, ആദായനികുതി വകുപ്പ് എന്നിവയുമായി നിങ്ങളുടെ തിരിച്ചറിയൽ സ്ഥിരീകരിക്കും. മറച്ച ആധാർ നമ്പർ മാത്രമേ സൂക്ഷിക്കൂ.';

  @override
  String get consentPrivacyTitle => 'സ്വകാര്യതാ അറിയിപ്പ് (DPDP നിയമം 2023)';

  @override
  String get consentPrivacyBody =>
      'എന്ത് ശേഖരിക്കുന്നു: തിരിച്ചറിയൽ, വരുമാനം, ബാങ്ക്, വസ്തു വിവരങ്ങൾ. എന്തിന്: നിങ്ങളുടെ വായ്പയുടെ തീരുമാനത്തിനും നടത്തിപ്പിനും. എത്ര കാലം: നിയമം ആവശ്യപ്പെടുന്നത്ര മാത്രം. നിങ്ങളുടെ അവകാശങ്ങൾ: വിവരങ്ങൾ കാണാനും തിരുത്താനും മായ്ക്കാനും, ഞങ്ങളുടെ പരാതി പരിഹാര ഓഫീസറോടോ ഡാറ്റ സംരക്ഷണ ബോർഡിനോടോ പരാതിപ്പെടാനും.';

  @override
  String get consentRequired => 'നിർബന്ധം';

  @override
  String get consentNeeded => 'തുടരാൻ എല്ലാറ്റിനും സമ്മതം നൽകുക.';

  @override
  String get agreeAndContinue => 'സമ്മതിച്ച് തുടരുക';

  @override
  String get detailsTitle => 'നിങ്ങളുടെ വിവരങ്ങൾ';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'ശരിയായ PAN നൽകുക, ഉദാ. ABCDE1234F.';

  @override
  String get fetchDetails => 'എന്റെ വിവരങ്ങൾ എടുക്കുക';

  @override
  String get fetchedFrom =>
      'PAN, ആധാർ eKYC, ബാങ്ക് സ്റ്റേറ്റ്മെന്റ് എന്നിവയിൽ നിന്ന് പൂരിപ്പിച്ചു. തിരുത്താൻ ഒരു തുകയിൽ ടാപ്പ് ചെയ്യുക.';

  @override
  String get nameLabel => 'പേര്';

  @override
  String get dobLabel => 'ജനനത്തീയതി';

  @override
  String get employmentLabel => 'ജോലി';

  @override
  String get salaried => 'ശമ്പളക്കാരൻ';

  @override
  String get selfEmployed => 'സ്വയം തൊഴിൽ';

  @override
  String get incomeLabel => 'പ്രതിമാസ അറ്റ വരുമാനം';

  @override
  String get existingEmiLabel => 'നിലവിലെ പ്രതിമാസ EMI';

  @override
  String get propertyValueLabel => 'വസ്തുവിന്റെ മൂല്യം';

  @override
  String get loanAmountLabel => 'വായ്പാ തുക';

  @override
  String get tenureLabel => 'കാലാവധി';

  @override
  String yearsLabel(String n) {
    return '$n വർഷം';
  }

  @override
  String get eligibleTitle => 'നിങ്ങൾക്ക് പരമാവധി ലഭിക്കുന്നത്';

  @override
  String emiPerMonth(String amount) {
    return 'പ്രതിമാസ EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'വർഷം $rate%, മാറുന്ന പലിശ (ഉദാഹരണം)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'വരുമാനം കൊണ്ടുള്ള പരിധി: എല്ലാ EMI യും ചേർന്ന് വരുമാനത്തിന്റെ $pct വരെ ആകാം.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'വസ്തു കൊണ്ടുള്ള പരിധി: ഈ വലുപ്പമുള്ള വായ്പ മൂല്യത്തിന്റെ $pct വരെ ആകാം.';
  }

  @override
  String get limitedByAsked => 'ഇത് നിങ്ങൾ ചോദിച്ച തുകയാണ്.';

  @override
  String get eligibilityNote =>
      'നിങ്ങളുടെ വിവരങ്ങളുടെ പെട്ടെന്നുള്ള പരിശോധന. ഞങ്ങളുടെ പരിശോധനയ്ക്ക് ശേഷം ഓഫർ വരും.';

  @override
  String get selfieTitle => 'സെൽഫി എടുക്കുക';

  @override
  String get selfieBody =>
      'നിങ്ങളുടെ മുഖം ആധാർ ഫോട്ടോയുമായി ഒത്തുനോക്കി, അത് ശരിക്കും നിങ്ങളാണെന്നും ഫോട്ടോയുടെ ഫോട്ടോ അല്ലെന്നും ഉറപ്പാക്കും.';

  @override
  String get selfieTips =>
      'നല്ല വെളിച്ചം, ക്യാമറയിലേക്ക് നോക്കുക, തൊപ്പിയോ കൂളിംഗ് ഗ്ലാസോ വേണ്ട.';

  @override
  String get takeSelfie => 'സെൽഫി എടുക്കുക';

  @override
  String get retake => 'വീണ്ടും എടുക്കുക';

  @override
  String get checkFace => 'മുഖം കണ്ടെത്തി';

  @override
  String get checkLive => 'ജീവനുള്ള വ്യക്തി';

  @override
  String get checkMatch => 'ആധാർ ഫോട്ടോയുമായി ഒത്തുപോകുന്നു';

  @override
  String get selfieFailed =>
      'നിങ്ങളുടെ മുഖം സ്ഥിരീകരിക്കാനായില്ല. നല്ല വെളിച്ചത്തിൽ വീണ്ടും ശ്രമിക്കുക, അല്ലെങ്കിൽ വീഡിയോ KYC കോൾ ബുക്ക് ചെയ്യുക.';

  @override
  String get videoKyc => 'വീഡിയോ KYC കോൾ ബുക്ക് ചെയ്യുക';

  @override
  String get docsTitle => 'നിങ്ങളുടെ രേഖകൾ';

  @override
  String get docsBody =>
      'ഓരോ രേഖയുടെയും വ്യക്തമായ ഫോട്ടോ എടുക്കുക, അല്ലെങ്കിൽ ഗാലറിയിൽ നിന്ന് തിരഞ്ഞെടുക്കുക.';

  @override
  String get docPan => 'PAN കാർഡ്';

  @override
  String get docAadhaar => 'ആധാർ കാർഡ് (മറച്ചത്)';

  @override
  String get docSalarySlip => 'ഏറ്റവും പുതിയ ശമ്പള സ്ലിപ്പ്';

  @override
  String get docForm16 => 'ഫോം 16';

  @override
  String get docItr => 'ആദായനികുതി റിട്ടേൺ (ITR)';

  @override
  String get docGst => 'GST സർട്ടിഫിക്കറ്റ്';

  @override
  String get docBankStatement => 'ബാങ്ക് സ്റ്റേറ്റ്മെന്റ്';

  @override
  String get bankViaAa => 'നിങ്ങളുടെ അക്കൗണ്ട് അഗ്രിഗേറ്റർ വഴി എടുത്തത്';

  @override
  String get camera => 'ക്യാമറ';

  @override
  String get gallery => 'ഗാലറി';

  @override
  String get checking => 'പരിശോധിക്കുന്നു…';

  @override
  String get tooBlurry =>
      'വളരെ മങ്ങിയതാണ്. ഫോൺ അനങ്ങാതെ പിടിച്ച് വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get tooMuchGlare =>
      'അമിതമായ തിളക്കം. വെളിച്ചത്തിൽ നിന്ന് മാറി വീണ്ടും ശ്രമിക്കുക.';

  @override
  String get tooDark =>
      'വളരെ ഇരുണ്ടതാണ്. കൂടുതൽ വെളിച്ചത്തിൽ വീണ്ടും ശ്രമിക്കുക.';

  @override
  String docAccepted(String type) {
    return 'തിരിച്ചറിഞ്ഞു: $type';
  }

  @override
  String docWrong(String expected) {
    return 'ഇത് $expected ആണെന്ന് തോന്നുന്നില്ല. പരിശോധിച്ച് ശരിയായ രേഖ അപ്‌ലോഡ് ചെയ്യുക.';
  }

  @override
  String get docUnreadable =>
      'ഈ രേഖ വായിക്കാനായില്ല. കൂടുതൽ വ്യക്തമായ ഫോട്ടോ എടുക്കുക, അല്ലെങ്കിൽ യഥാർത്ഥ PDF അപ്‌ലോഡ് ചെയ്യുക.';

  @override
  String docsMissing(String n) {
    return 'ഇനിയും $n വേണം';
  }

  @override
  String get getOffer => 'എന്റെ തത്വത്തിലുള്ള ഓഫർ കാണിക്കുക';

  @override
  String get approvedInPrinciple => 'തത്വത്തിൽ അംഗീകരിച്ചു';

  @override
  String get sanctioned => 'വായ്പ അനുവദിച്ചു';

  @override
  String get referredTitle => 'ഞങ്ങൾക്ക് കുറച്ചുകൂടി സമയം വേണം';

  @override
  String get rejectedTitle => 'ഇപ്പോൾ ഈ വായ്പ നൽകാനാവില്ല';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years വർഷം · വർഷം $rate% മാറുന്ന പലിശ';
  }

  @override
  String get whyOffer => 'നിങ്ങൾക്ക് ഈ ഓഫർ കിട്ടിയത് എന്തുകൊണ്ട്';

  @override
  String get whyReferred => 'ഇനി എന്ത് സംഭവിക്കും';

  @override
  String get whyRejected => 'ഞങ്ങൾ ഇങ്ങനെ തീരുമാനിച്ചത് എന്തുകൊണ്ട്';

  @override
  String get referBody =>
      'ഒരു ഓഫീസർ ഒരു പ്രവൃത്തിദിവസത്തിനുള്ളിൽ നിങ്ങളുടെ അപേക്ഷ നോക്കും. ഇപ്പോൾ നിങ്ങൾ ഒന്നും ചെയ്യേണ്ടതില്ല.';

  @override
  String get rejectBody =>
      'ഈ തീരുമാനം ഒരാൾ പുനഃപരിശോധിക്കാൻ എപ്പോൾ വേണമെങ്കിലും ആവശ്യപ്പെടാം.';

  @override
  String get addProperty => 'വസ്തുവിന്റെ വിവരങ്ങൾ ചേർക്കുക';

  @override
  String get viewKfs => 'പ്രധാന വസ്തുതാ പ്രസ്താവന കാണുക';

  @override
  String get grievance => 'പുനഃപരിശോധന ആവശ്യപ്പെടുക അല്ലെങ്കിൽ പരാതിപ്പെടുക';

  @override
  String officerLine(String name, String email) {
    return 'പരാതി പരിഹാര ഓഫീസർ: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'അപേക്ഷ $id';
  }

  @override
  String get startOver => 'പുതിയ അപേക്ഷ തുടങ്ങുക';

  @override
  String okScore(String score) {
    return 'മികച്ച തിരിച്ചടവ് ചരിത്രം (സ്കോർ $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI വരുമാനത്തിന്റെ $pct; ഞങ്ങളുടെ പരിധി $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'വായ്പ വസ്തു മൂല്യത്തിന്റെ $pct; പരിധി $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'വസ്തുവിന്റെ ഞങ്ങളുടെ മൂല്യനിർണയം: $low മുതൽ $high വരെ';
  }

  @override
  String get okTitle => 'വസ്തുവിന്റെ ഉടമസ്ഥാവകാശവും രേഖകളും പരിശോധിച്ചു';

  @override
  String get reasonKyc01 =>
      'ഫോട്ടോയിൽ നിന്ന് നിങ്ങളുടെ തിരിച്ചറിയൽ സ്ഥിരീകരിക്കാനായില്ല. ദയവായി ഒരു ചെറിയ വീഡിയോ KYC കോൾ പൂർത്തിയാക്കുക.';

  @override
  String get reasonFrd02 =>
      'ശമ്പള സ്ലിപ്പിലെ വരുമാനം ബാങ്കിലെ വരവുകളുമായി ഒത്തുപോകുന്നില്ല. ഏറ്റവും പുതിയ ഫോം 16 നൽകുക, അല്ലെങ്കിൽ സമ്മതത്തോടെ ഞങ്ങളെ എടുക്കാൻ അനുവദിക്കുക.';

  @override
  String get reasonFrd03 =>
      'നിങ്ങളുടെ ഒരു രേഖ നൽകിയ അധികാരിയുടെ പരിശോധനയിൽ പരാജയപ്പെട്ടു.';

  @override
  String get reasonPol01 => 'അപേക്ഷകർക്ക് കുറഞ്ഞത് 21 വയസ്സ് വേണം.';

  @override
  String get reasonPol02 =>
      'വായ്പ ഞങ്ങൾ അനുവദിക്കുന്ന പരമാവധി പ്രായം കടന്നുപോകും. പ്രായം കുറഞ്ഞ ഒരു സഹ-അപേക്ഷകനെ ചേർക്കുന്നത് സഹായിക്കും.';

  @override
  String get reasonBur01 =>
      'നിങ്ങളുടെ ക്രെഡിറ്റ് സ്കോർ ഞങ്ങളുടെ കുറഞ്ഞ പരിധിയായ 650 ൽ താഴെയാണ്.';

  @override
  String get reasonBur04 =>
      'നിങ്ങൾക്ക് ഇതുവരെ ക്രെഡിറ്റ് ചരിത്രമില്ല, അതിനാൽ ഒരു ഓഫീസർ നിങ്ങളുടെ ബാങ്ക് രേഖകൾ നോക്കും.';

  @override
  String get reasonBur05 =>
      'നിങ്ങളുടെ ക്രെഡിറ്റ് സ്കോർ ഒരു ഓഫീസർ സൂക്ഷ്മമായി നോക്കേണ്ടതുണ്ട്.';

  @override
  String get reasonPrp01 =>
      'ഞങ്ങളുടെ അഭിഭാഷകൻ വസ്തുവിന്റെ ഉടമസ്ഥാവകാശം പരിശോധിക്കണം.';

  @override
  String get reasonPrp03 =>
      'മൂല്യം സ്ഥിരീകരിക്കാൻ ഞങ്ങളുടെ മൂല്യനിർണയക്കാരൻ വസ്തു സന്ദർശിക്കണം.';

  @override
  String get reasonPrp04 =>
      'കരാർ മൂല്യം ഈ വസ്തുവിന്റെ സർക്കാർ ന്യായവിലയേക്കാൾ കുറവാണ്. ദയവായി വിൽപന കരാർ പരിശോധിക്കുക.';

  @override
  String get reasonAff01 =>
      'നിങ്ങളുടെ നിലവിലെ EMI ഇതിനകം വരുമാനത്തിന്റെ പരമാവധി ഭാഗം ഉപയോഗിക്കുന്നു.';

  @override
  String get reasonAut01 =>
      'ഈ വലുപ്പമുള്ള വായ്പകൾ ഒരു സീനിയർ ഓഫീസർ അന്തിമമായി പരിശോധിക്കും.';

  @override
  String get reasonRsk01 =>
      'ഓഫർ അന്തിമമാക്കാൻ ഒരു ഓഫീസർ നിങ്ങളുടെ അപേക്ഷ നോക്കും.';

  @override
  String get reasonRsk02 =>
      'നിങ്ങളുടെ ക്രെഡിറ്റ് പ്രൊഫൈൽ അടിസ്ഥാനമാക്കി, ഇപ്പോൾ ഈ വായ്പ നൽകാനാവില്ല.';

  @override
  String get propertyTitle => 'നിങ്ങളുടെ വസ്തു';

  @override
  String get cityLabel => 'നഗരം';

  @override
  String get localityLabel => 'പ്രദേശം';

  @override
  String get societyLabel => 'പ്രോജക്റ്റ് അല്ലെങ്കിൽ സൊസൈറ്റി (ഉണ്ടെങ്കിൽ)';

  @override
  String get areaLabel => 'വിസ്തീർണം (ച. അടി)';

  @override
  String get bhkLabel => 'കിടപ്പുമുറികൾ';

  @override
  String get newProperty => 'പുതിയത്';

  @override
  String get resale => 'പുനർവിൽപന';

  @override
  String get declaredPriceLabel => 'കരാർ മൂല്യം';

  @override
  String get photosTitle => 'വസ്തുവിന്റെ ഫോട്ടോകൾ';

  @override
  String get photosBody =>
      'വസ്തുവിൽ വെച്ച് ഫോട്ടോ എടുക്കുക. മൂല്യനിർണയക്കാരന് സന്ദർശനം ആസൂത്രണം ചെയ്യാൻ ഞങ്ങൾ സ്ഥലവും സമയവും ചേർക്കും.';

  @override
  String get photoFront => 'മുൻവശം';

  @override
  String get photoInside => 'അകം';

  @override
  String get photoView => 'വസ്തുവിൽ നിന്നുള്ള കാഴ്ച';

  @override
  String geoTagged(String lat, String lng) {
    return 'സ്ഥലം ചേർത്തു ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'സ്ഥലമില്ലാതെ ഫോട്ടോ സേവ് ചെയ്തു. ജിയോ-ടാഗിനായി ലൊക്കേഷൻ ഓണാക്കുക.';

  @override
  String get submitProperty => 'അന്തിമ അനുമതി നേടുക';

  @override
  String get fillAll => 'ദയവായി എല്ലാ കോളങ്ങളും പൂരിപ്പിക്കുക.';

  @override
  String get kfsTitle => 'പ്രധാന വസ്തുതാ പ്രസ്താവന';

  @override
  String get kfsLoan => 'വായ്പാ തുക';

  @override
  String get kfsTenure => 'കാലാവധി';

  @override
  String get kfsRate => 'പലിശ നിരക്ക്';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI കളുടെ എണ്ണം';

  @override
  String get kfsFee => 'പ്രോസസ്സിംഗ് ഫീസ് (GST സഹിതം)';

  @override
  String get kfsTotalInterest => 'ആകെ പലിശ';

  @override
  String get kfsTotalPayable => 'ആകെ അടയ്ക്കേണ്ട തുക';

  @override
  String get kfsApr => 'വാർഷിക ശതമാന നിരക്ക് (APR)';

  @override
  String get kfsCoolingOff =>
      'കൂളിംഗ്-ഓഫ് കാലയളവ്: ഒപ്പിട്ട് 3 ദിവസത്തിനുള്ളിൽ മുതലും ആ ദിവസങ്ങളിലെ പലിശയും മാത്രം തിരിച്ചടച്ച് പിഴയില്ലാതെ പിന്മാറാം.';

  @override
  String get kfsNote =>
      'ഡെമോയ്ക്കുള്ള സാമ്പിൾ കണക്കുകൾ. യഥാർത്ഥ KFS അനുമതി കത്തിനൊപ്പം വരും.';

  @override
  String get useSample => 'സാമ്പിൾ';

  @override
  String get videoKycDemo =>
      'ഡെമോ: ഇത് ഒരു ഓഫീസറുമായി വീഡിയോ KYC കോൾ ബുക്ക് ചെയ്യുമായിരുന്നു.';

  @override
  String get raiseComplaint => 'പരാതി നൽകുക';

  @override
  String complaintSent(String ref) {
    return 'നിങ്ങളുടെ പരാതി രജിസ്റ്റർ ചെയ്തു. റഫറൻസ് $ref.';
  }

  @override
  String get stageSignIn => 'സൈൻ ഇൻ';

  @override
  String get stageDetails => 'വിവരങ്ങൾ';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'ഓഫർ';

  @override
  String get stageProperty => 'വസ്തു';

  @override
  String get homeSubtitle => 'ഭവന വായ്പ · വസ്തുവിന്മേൽ വായ്പ';

  @override
  String get heroPill => 'മിനിറ്റുകൾക്കുള്ളിൽ തീരുമാനം';

  @override
  String heroFacts(String rate, String years) {
    return 'വർഷം $rate% മുതൽ · $years വർഷം വരെ';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% പൂർത്തിയായി · നിർത്തിയിടത്ത് നിന്ന് തുടരുക';
  }

  @override
  String get resume => 'തുടരുക';

  @override
  String get calculators => 'കാൽക്കുലേറ്ററുകൾ';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'പ്രതിമാസ ഗഡു';

  @override
  String get calcEligibility => 'യോഗ്യത';

  @override
  String get calcEligibilitySub => 'നിങ്ങൾക്ക് എത്ര കിട്ടും';

  @override
  String get emiCalcTitle => 'EMI കാൽക്കുലേറ്റർ';

  @override
  String get eligibilityCalcTitle => 'യോഗ്യതാ കാൽക്കുലേറ്റർ';

  @override
  String totalInterest(String amount) {
    return 'ആകെ പലിശ $amount';
  }

  @override
  String get calcIncomeOnly =>
      'വരുമാനം മാത്രം അടിസ്ഥാനമാക്കി. വസ്തുവിന്റെ മൂല്യം ഇത് കുറച്ചേക്കാം.';

  @override
  String get verified => 'സ്ഥിരീകരിച്ചു';

  @override
  String get yourLoan => 'നിങ്ങളുടെ വായ്പ';

  @override
  String docsProgress(String done, String total) {
    return '$total ൽ $done സ്ഥിരീകരിച്ചു';
  }

  @override
  String get docNeeded => 'വേണം';

  @override
  String get docTryAgain => 'വീണ്ടും ശ്രമിക്കുക';

  @override
  String get fetched => 'എടുത്തു';

  @override
  String get statusApproved => 'അംഗീകരിച്ചു';

  @override
  String get statusSanctioned => 'അനുവദിച്ചു';

  @override
  String get statusInReview => 'പരിശോധനയിൽ';

  @override
  String get statusDeclined => 'നിരസിച്ചു';

  @override
  String get trackTitle => 'നിങ്ങളുടെ അപേക്ഷ ട്രാക്ക് ചെയ്യുക';

  @override
  String get tlSubmitted => 'അപേക്ഷ സമർപ്പിച്ചു';

  @override
  String get tlVerified => 'KYC യും രേഖകളും സ്ഥിരീകരിച്ചു';

  @override
  String get tlInPrinciple => 'തത്വത്തിലുള്ള അംഗീകാരം';

  @override
  String get tlProperty => 'വസ്തു വിവരങ്ങളും മൂല്യനിർണയവും';

  @override
  String get tlPropertyNext =>
      'നിങ്ങളുടെ വസ്തുവിന്റെ വിവരങ്ങളും ഫോട്ടോകളും ചേർക്കുക';

  @override
  String get tlOfficer => 'ഓഫീസറുടെ പരിശോധന';

  @override
  String get tlOfficerNext => 'ഒരു പ്രവൃത്തിദിവസത്തിനുള്ളിൽ';

  @override
  String get tlLegal => 'നിയമപരവും ഉടമസ്ഥാവകാശവുമായ പരിശോധന';

  @override
  String get tlSanction => 'അന്തിമ അനുമതിയും ഇ-ഒപ്പും';

  @override
  String get tlSanctionNext => 'അനുമതി കത്തിൽ ഓൺലൈനായി ഒപ്പിടുക';

  @override
  String get tlDisbursement => 'തുക വിതരണം';

  @override
  String get helpTitle => 'സഹായം വേണോ?';

  @override
  String get propertyType => 'പുതിയതോ പുനർവിൽപനയോ';

  @override
  String get greetMorning => 'സുപ്രഭാതം';

  @override
  String get greetAfternoon => 'ശുഭ ഉച്ച';

  @override
  String get greetEvening => 'ശുഭ സായാഹ്നം';

  @override
  String nearlyThere(String name) {
    return '$name, നിങ്ങൾ ഏതാണ്ട് എത്തി';
  }

  @override
  String get chooseLanguage => 'നിങ്ങളുടെ ഭാഷ തിരഞ്ഞെടുക്കുക';

  @override
  String get languageNote => 'ഇത് എപ്പോൾ വേണമെങ്കിലും മാറ്റാം.';

  @override
  String get liveChecks => 'തത്സമയ പരിശോധനകൾ';

  @override
  String get checkBureau => 'ക്രെഡിറ്റ് ബ്യൂറോ';

  @override
  String checkScore(String score) {
    return 'സ്കോർ $score';
  }

  @override
  String get checkNoHistory => 'ഇതുവരെ ചരിത്രമില്ല';

  @override
  String get checkBank => 'AA വഴി ബാങ്ക്';

  @override
  String get checkBankRead => '12 മാസം വായിച്ചു';

  @override
  String get checkKyc => 'eKYC യും സെൽഫിയും';

  @override
  String get checkPending => 'ബാക്കി';

  @override
  String get checkDocs => 'രേഖകൾ';

  @override
  String countOf(String done, String total) {
    return '$total ൽ $done';
  }

  @override
  String minutesLeft(String n) {
    return 'ഏകദേശം $n മിനിറ്റ് ബാക്കി';
  }

  @override
  String ratePa(String rate) {
    return 'വർഷം $rate%';
  }

  @override
  String get continueApplication => 'നിങ്ങളുടെ അപേക്ഷ തുടരുക';

  @override
  String get shapeOffer => 'നിങ്ങളുടെ ഓഫർ രൂപപ്പെടുത്തുക';

  @override
  String get shapeOfferSub => 'തത്വത്തിൽ അംഗീകരിച്ചു · മാറ്റാൻ വലിക്കുക';

  @override
  String get withinLimits => 'നിങ്ങളുടെ പരിധിക്കുള്ളിൽ';

  @override
  String get aboveLimits =>
      'പരിധി കവിഞ്ഞു: തുക കുറയ്ക്കുക അല്ലെങ്കിൽ വർഷം കൂട്ടുക';

  @override
  String mostYouCan(String amount) {
    return 'പരമാവധി എടുക്കാവുന്നത്: $amount';
  }

  @override
  String get useMax => 'പരമാവധി എടുക്കുക';

  @override
  String get principal => 'മുതൽ';

  @override
  String get interest => 'പലിശ';

  @override
  String get totalRepaid => 'ആകെ തിരിച്ചടവ്';

  @override
  String get emiShareIncome => 'വരുമാനത്തിൽ EMI യുടെ പങ്ക്';

  @override
  String loanShareProperty(String value) {
    return '$value വസ്തുവിൽ വായ്പയുടെ പങ്ക്';
  }

  @override
  String get lockOffer => 'ഈ ഓഫർ ഉറപ്പിക്കുക';

  @override
  String get offerLocked => 'നിങ്ങളുടെ ഓഫർ ഉറപ്പിച്ചു.';

  @override
  String approvedUpTo(String amount) {
    return '$amount വരെ അംഗീകരിച്ചു';
  }

  @override
  String readingDoc(String doc) {
    return 'നിങ്ങളുടെ $doc വായിക്കുന്നു';
  }

  @override
  String get documentAi => 'രേഖ AI';

  @override
  String sure(String pct) {
    return '$pct% ഉറപ്പ്';
  }

  @override
  String get readMatches => 'ഞങ്ങൾ ആവശ്യപ്പെട്ട രേഖ തന്നെ';

  @override
  String get readClear => 'വ്യക്തമായ ഫോട്ടോ, മങ്ങലോ തിളക്കമോ ഇല്ല';

  @override
  String get whatWeRead => 'ഞങ്ങൾ വായിച്ചത്';

  @override
  String get looksRight => 'ശരിയാണ്';

  @override
  String get fieldName => 'പേര്';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'ആധാർ';

  @override
  String get fieldEmployer => 'തൊഴിലുടമ';

  @override
  String get fieldNetPay => 'അറ്റ ശമ്പളം';

  @override
  String get fieldPeriod => 'ശമ്പള കാലയളവ്';

  @override
  String get fieldYear => 'വർഷം';

  @override
  String get fieldIncome => 'വരുമാനം';

  @override
  String get fieldBusiness => 'ബിസിനസ്';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'നിങ്ങളുടെ വായ്പയ്ക്ക് ആവശ്യം';

  @override
  String get consentSectionOptional => 'ഐച്ഛികം: നിങ്ങൾ ഓണാക്കുന്നത് വരെ ഓഫ്';

  @override
  String get advancedOptions => 'ഓപ്ഷനുകൾ';

  @override
  String consentValidUntil(String given, String until) {
    return '$given ന് നൽകി · $until വരെ സാധുത';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given ന് നൽകി · പിൻവലിക്കുന്നത് വരെ';
  }

  @override
  String get recheckTitle => 'തുക നൽകുന്നതിന് തൊട്ടുമുമ്പ് ഒരു പരിശോധന കൂടി';

  @override
  String get recheckBody =>
      'തുക നൽകുന്നതിന് തൊട്ടുമുമ്പ് നിങ്ങളുടെ ക്രെഡിറ്റ് റിപ്പോർട്ട് വീണ്ടും നോക്കും. വേണ്ടെന്ന് പറഞ്ഞാൽ അപ്പോൾ ഒരു ഓഫീസർ ചോദിച്ചേക്കാം.';

  @override
  String get aaMonthsLabel => 'എത്ര മാസത്തെ സ്റ്റേറ്റ്മെന്റ് പങ്കിടണം';

  @override
  String monthsN(String n) {
    return '$n മാസം';
  }

  @override
  String get aaAccountsLabel => 'പങ്കിടേണ്ട അക്കൗണ്ടുകൾ';

  @override
  String get accountSavingsSalary => 'സേവിംഗ്സ് ·· 0912 · ശമ്പള വരവ്';

  @override
  String get accountSavings => 'സേവിംഗ്സ് ·· 4821';

  @override
  String get accountFd => 'സ്ഥിര നിക്ഷേപം ·· 3307';

  @override
  String get aaAccountNeeded => 'കുറഞ്ഞത് ഒരു അക്കൗണ്ട് തിരഞ്ഞെടുക്കുക.';

  @override
  String get kycMethodLabel => 'തിരിച്ചറിയൽ എങ്ങനെ സ്ഥിരീകരിക്കാം';

  @override
  String get kycAadhaarOtp => 'ആധാർ OTP';

  @override
  String get kycDigilocker => 'ഡിജിലോക്കർ';

  @override
  String get kycVideo => 'വീഡിയോ KYC കോൾ';

  @override
  String get useCkycTitle => 'എന്റെ നിലവിലെ CKYC രേഖ ഉപയോഗിക്കുക';

  @override
  String get useCkycBody =>
      'മറ്റൊരു ബാങ്കിലോ ഫണ്ടിലോ KYC ചെയ്തിട്ടുണ്ടെങ്കിൽ, വീണ്ടും ചോദിക്കാതെ ആ രേഖ എടുക്കും.';

  @override
  String get optOffersTitle => 'ഓഫറുകളും പുതിയ ഉൽപ്പന്നങ്ങളും';

  @override
  String get optOffersBody =>
      'ഓഫറുകളെക്കുറിച്ച് എങ്ങനെ അറിയണമെന്ന് തിരഞ്ഞെടുക്കുക. എപ്പോൾ വേണമെങ്കിലും ഓഫാക്കാം.';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ഇമെയിൽ';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp ൽ വായ്പാ അപ്ഡേറ്റുകൾ';

  @override
  String get optUpdatesBody =>
      'SMS നൊപ്പം WhatsApp ലും സ്റ്റാറ്റസ് അപ്ഡേറ്റുകളും EMI ഓർമ്മപ്പെടുത്തലുകളും.';

  @override
  String get optInsuranceTitle => 'ഭവന വായ്പാ സംരക്ഷണ ക്വോട്ട്';

  @override
  String get optInsuranceBody =>
      'ക്വോട്ടിനായി നിങ്ങളുടെ പേര്, പ്രായം, വായ്പാ തുക എന്നിവ ഞങ്ങളുടെ ഇൻഷുറൻസ് പങ്കാളിയുമായി പങ്കിടുക. വാങ്ങൽ ഒരിക്കലും നിർബന്ധമല്ല.';

  @override
  String get getQuote => 'ക്വോട്ട് നേടുക';

  @override
  String get manageConsents => 'സമ്മതങ്ങൾ കൈകാര്യം ചെയ്യുക';

  @override
  String get manageConsentsBody =>
      'ഐച്ഛിക സമ്മതങ്ങൾ എപ്പോൾ വേണമെങ്കിലും ഓഫാക്കാം. ആവശ്യമായ ഒന്ന് പിൻവലിച്ചാൽ അപേക്ഷ നിൽക്കും, അതിനായി എടുത്ത വിവരങ്ങൾ ഞങ്ങൾ മായ്ക്കും.';

  @override
  String get withdraw => 'പിൻവലിക്കുക';

  @override
  String get consentHistory => 'സമ്മത ചരിത്രം';

  @override
  String historyGiven(String item) {
    return '$item നൽകി';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item പിൻവലിച്ചു';
  }

  @override
  String get historyEmpty => 'ഇതുവരെ ഒന്നുമില്ല.';

  @override
  String get consentOn => 'ഓൺ';

  @override
  String get consentOff => 'ഓഫ്';

  @override
  String get withdrawnRequired =>
      'ആവശ്യമായ ഒരു സമ്മതം നിങ്ങൾ പിൻവലിച്ചു, അതിനാൽ അപേക്ഷ നിർത്തിവെച്ചു.';

  @override
  String get checkMatchPending =>
      'ഫോട്ടോ പൊരുത്തം: ആധാർ അല്ലെങ്കിൽ പാൻ കാർഡ് അപ്‌ലോഡ് ചെയ്യുമ്പോൾ നടക്കും';
}
