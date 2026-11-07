// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'નિર્ણય';

  @override
  String get sandboxBanner => 'ડેમો મોડ: નમૂના માહિતી, સાચી ચકાસણી નથી';

  @override
  String get continueLabel => 'આગળ વધો';

  @override
  String stepOf(String step, String total) {
    return 'પગલું $step / $total';
  }

  @override
  String get pleaseWait => 'કૃપા કરી રાહ જુઓ…';

  @override
  String get errorGeneric => 'કંઈક ખોટું થયું. ફરી પ્રયાસ કરો.';

  @override
  String get close => 'બંધ કરો';

  @override
  String get welcomeHeadline => 'થોડી મિનિટોમાં તમારી હોમ લોનનો નિર્ણય';

  @override
  String get welcomeBody =>
      'હોમ લોન અથવા મિલકત સામે લોન માટે અરજી કરો. અમે બધું ઓનલાઇન ચકાસીએ છીએ અને હંમેશાં નિર્ણયનું કારણ જણાવીએ છીએ.';

  @override
  String get chooseProduct => 'તમારે શું જોઈએ છે?';

  @override
  String get productHomeLoan => 'હોમ લોન';

  @override
  String get productHomeLoanSub => 'ઘર ખરીદવું, બાંધવું કે સુધારવું';

  @override
  String get productLap => 'મિલકત સામે લોન';

  @override
  String get productLapSub => 'તમારી પોતાની મિલકત સામે ઉધાર લો';

  @override
  String get startApplication => 'અરજી શરૂ કરો';

  @override
  String get demoCustomers => 'ડેમો ગ્રાહકો';

  @override
  String get demoCustomersBody => 'નમૂના મોબાઇલ નંબર ભરવા માટે એક પર ટેપ કરો.';

  @override
  String get personaRavi => 'રવિ, 32, નોકરિયાત, ફ્લેટ ખરીદે છે';

  @override
  String get personaMeena => 'મીના, 45, કપડાંની દુકાન ચલાવે છે (LAP)';

  @override
  String get personaArjun => 'અર્જુન, 29, નોકરિયાત, બદલેલી પગાર સ્લિપ';

  @override
  String get signInTitle => 'સાઇન ઇન';

  @override
  String get mobileLabel => 'મોબાઇલ નંબર';

  @override
  String get mobileHint => '10 અંકનો મોબાઇલ નંબર';

  @override
  String get invalidMobile => 'સાચો 10 અંકનો મોબાઇલ નંબર દાખલ કરો.';

  @override
  String get sendOtp => 'OTP મોકલો';

  @override
  String otpSentTo(String phone) {
    return '$phone પર 6 અંકનો કોડ મોકલ્યો છે.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'ચકાસો';

  @override
  String get demoOtp => 'ડેમો કોડ: 123456';

  @override
  String get wrongOtp => 'કોડ ખોટો છે. ફરી પ્રયાસ કરો.';

  @override
  String get deviceBound =>
      'આ ફોન હવે તમારા ખાતા સાથે જોડાયો છે. બીજા ફોન પર સાઇન ઇન કરવા નવો OTP જોઈશે.';

  @override
  String get consentTitle => 'તમારી સંમતિ';

  @override
  String get consentIntro =>
      'અમે તમારી માહિતી ફક્ત આ લોનના નિર્ણય અને સંચાલન માટે વાપરીએ છીએ. તમે ગમે ત્યારે સંમતિ પાછી ખેંચી શકો છો.';

  @override
  String get consentBureauTitle => 'ક્રેડિટ રિપોર્ટ';

  @override
  String get consentBureauBody =>
      'ક્રેડિટ બ્યુરો (CIBIL, Experian, Equifax અથવા CRIF) પાસેથી તમારો ક્રેડિટ ઇતિહાસ ચકાસાશે. આનાથી તમારો સ્કોર ઘટતો નથી.';

  @override
  String get consentAaTitle => 'એકાઉન્ટ એગ્રીગેટર દ્વારા બેંક સ્ટેટમેન્ટ';

  @override
  String get consentAaBody =>
      'RBI-લાઇસન્સ ધરાવતા એકાઉન્ટ એગ્રીગેટર દ્વારા તમારી બેંકના 12 મહિનાના સ્ટેટમેન્ટ મેળવાશે. વિનંતી તમે તમારી AA એપમાં મંજૂર કરો છો.';

  @override
  String get consentKycTitle => 'આધાર eKYC અને PAN';

  @override
  String get consentKycBody =>
      'UIDAI અને આવકવેરા વિભાગ સાથે તમારી ઓળખ ચકાસાશે. અમે ફક્ત છુપાવેલો આધાર નંબર રાખીએ છીએ.';

  @override
  String get consentPrivacyTitle => 'ગોપનીયતા સૂચના (DPDP કાયદો 2023)';

  @override
  String get consentPrivacyBody =>
      'શું એકત્ર કરીએ છીએ: ઓળખ, આવક, બેંક અને મિલકતની વિગતો. શા માટે: તમારી લોનના નિર્ણય અને સંચાલન માટે. કેટલો સમય: કાયદો કહે તેટલો જ. તમારા અધિકારો: માહિતી જોવી, સુધારવી કે ભૂંસવી, અને અમારા ફરિયાદ અધિકારી અથવા ડેટા સુરક્ષા બોર્ડને ફરિયાદ કરવી.';

  @override
  String get consentRequired => 'જરૂરી';

  @override
  String get consentNeeded => 'આગળ વધવા માટે બધી બાબતોમાં સંમતિ આપો.';

  @override
  String get agreeAndContinue => 'સંમતિ આપી આગળ વધો';

  @override
  String get detailsTitle => 'તમારી વિગતો';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'સાચો PAN દાખલ કરો, જેમ કે ABCDE1234F.';

  @override
  String get fetchDetails => 'મારી વિગતો લાવો';

  @override
  String get fetchedFrom =>
      'PAN, આધાર eKYC અને બેંક સ્ટેટમેન્ટમાંથી ભરાયું છે. સુધારવા માટે આંકડા પર ટેપ કરો.';

  @override
  String get nameLabel => 'નામ';

  @override
  String get dobLabel => 'જન્મતારીખ';

  @override
  String get employmentLabel => 'કામ';

  @override
  String get salaried => 'નોકરિયાત';

  @override
  String get selfEmployed => 'સ્વરોજગાર';

  @override
  String get incomeLabel => 'માસિક ચોખ્ખી આવક';

  @override
  String get existingEmiLabel => 'હાલના માસિક EMI';

  @override
  String get propertyValueLabel => 'મિલકતની કિંમત';

  @override
  String get loanAmountLabel => 'લોનની રકમ';

  @override
  String get tenureLabel => 'મુદત';

  @override
  String yearsLabel(String n) {
    return '$n વર્ષ';
  }

  @override
  String get eligibleTitle => 'તમને વધુમાં વધુ મળી શકે છે';

  @override
  String emiPerMonth(String amount) {
    return 'માસિક EMI $amount';
  }

  @override
  String rateNote(String rate) {
    return 'વાર્ષિક $rate%, બદલાતો દર (ઉદાહરણ)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'આવક મુજબ મર્યાદા: બધા EMI મળીને આવકના $pct સુધી હોઈ શકે.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'મિલકત મુજબ મર્યાદા: આટલી લોન કિંમતના $pct સુધી હોઈ શકે.';
  }

  @override
  String get limitedByAsked => 'આ તમે માંગેલી રકમ છે.';

  @override
  String get eligibilityNote =>
      'તમારી વિગતોની ઝડપી ચકાસણી. અમારી ચકાસણી પછી ઓફર આવશે.';

  @override
  String get selfieTitle => 'સેલ્ફી લો';

  @override
  String get selfieBody =>
      'અમે તમારો ચહેરો આધાર ફોટો સાથે મેળવીએ છીએ અને ખાતરી કરીએ છીએ કે તે ખરેખર તમે છો, ફોટાનો ફોટો નથી.';

  @override
  String get selfieTips => 'સારો પ્રકાશ, કેમેરા તરફ જુઓ, ટોપી કે ગોગલ્સ નહીં.';

  @override
  String get takeSelfie => 'સેલ્ફી લો';

  @override
  String get retake => 'ફરી લો';

  @override
  String get checkFace => 'ચહેરો મળ્યો';

  @override
  String get checkLive => 'જીવંત વ્યક્તિ';

  @override
  String get checkMatch => 'આધાર ફોટો સાથે મેળ ખાય છે';

  @override
  String get selfieFailed =>
      'તમારો ચહેરો પુષ્ટિ કરી શકાયો નહીં. સારા પ્રકાશમાં ફરી પ્રયાસ કરો, અથવા વિડિયો KYC કૉલ બુક કરો.';

  @override
  String get videoKyc => 'વિડિયો KYC કૉલ બુક કરો';

  @override
  String get docsTitle => 'તમારા દસ્તાવેજો';

  @override
  String get docsBody =>
      'દરેક દસ્તાવેજનો સ્પષ્ટ ફોટો લો, અથવા ગેલેરીમાંથી પસંદ કરો.';

  @override
  String get docPan => 'PAN કાર્ડ';

  @override
  String get docAadhaar => 'આધાર કાર્ડ (છુપાવેલું)';

  @override
  String get docSalarySlip => 'તાજેતરની પગાર સ્લિપ';

  @override
  String get docForm16 => 'ફોર્મ 16';

  @override
  String get docItr => 'આવકવેરા રિટર્ન (ITR)';

  @override
  String get docGst => 'GST પ્રમાણપત્ર';

  @override
  String get docBankStatement => 'બેંક સ્ટેટમેન્ટ';

  @override
  String get bankViaAa => 'તમારા એકાઉન્ટ એગ્રીગેટર દ્વારા મેળવ્યું';

  @override
  String get camera => 'કેમેરા';

  @override
  String get gallery => 'ગેલેરી';

  @override
  String get checking => 'ચકાસી રહ્યા છીએ…';

  @override
  String get tooBlurry => 'ખૂબ ઝાંખું. ફોન સ્થિર રાખી ફરી પ્રયાસ કરો.';

  @override
  String get tooMuchGlare => 'ખૂબ ચમક. પ્રકાશથી દૂર જઈ ફરી પ્રયાસ કરો.';

  @override
  String get tooDark => 'ખૂબ અંધારું. વધુ પ્રકાશમાં ફરી પ્રયાસ કરો.';

  @override
  String docAccepted(String type) {
    return 'ઓળખાયું: $type';
  }

  @override
  String docWrong(String expected) {
    return 'આ $expected જેવું લાગતું નથી. તપાસી સાચો દસ્તાવેજ અપલોડ કરો.';
  }

  @override
  String get docUnreadable =>
      'આ દસ્તાવેજ વાંચી શકાયો નહીં. વધુ સ્પષ્ટ ફોટો લો, અથવા મૂળ PDF અપલોડ કરો.';

  @override
  String docsMissing(String n) {
    return 'હજુ $n જોઈએ';
  }

  @override
  String get getOffer => 'મારી સૈદ્ધાંતિક ઓફર બતાવો';

  @override
  String get approvedInPrinciple => 'સૈદ્ધાંતિક રીતે મંજૂર';

  @override
  String get sanctioned => 'લોન મંજૂર';

  @override
  String get referredTitle => 'અમને થોડો વધુ સમય જોઈએ છે';

  @override
  String get rejectedTitle => 'હાલ અમે આ લોન આપી શકતા નથી';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years વર્ષ · વાર્ષિક $rate% બદલાતો દર';
  }

  @override
  String get whyOffer => 'તમને આ ઓફર કેમ મળી';

  @override
  String get whyReferred => 'હવે શું થશે';

  @override
  String get whyRejected => 'અમે આ નિર્ણય કેમ લીધો';

  @override
  String get referBody =>
      'એક અધિકારી એક કામકાજના દિવસમાં તમારી અરજી જોશે. અત્યારે તમારે કંઈ કરવાની જરૂર નથી.';

  @override
  String get rejectBody =>
      'તમે ગમે ત્યારે કોઈ વ્યક્તિને આ નિર્ણયની સમીક્ષા કરવા કહી શકો છો.';

  @override
  String get addProperty => 'મિલકતની વિગતો ઉમેરો';

  @override
  String get viewKfs => 'મુખ્ય તથ્ય પત્રક જુઓ';

  @override
  String get grievance => 'સમીક્ષા માંગો અથવા ફરિયાદ કરો';

  @override
  String officerLine(String name, String email) {
    return 'ફરિયાદ અધિકારી: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'અરજી $id';
  }

  @override
  String get startOver => 'નવી અરજી શરૂ કરો';

  @override
  String okScore(String score) {
    return 'ચુકવણીનો મજબૂત ઇતિહાસ (સ્કોર $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMI આવકના $pct છે; અમારી મર્યાદા $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'લોન મિલકતની કિંમતના $pct છે; મર્યાદા $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'મિલકતનું અમારું મૂલ્યાંકન: $low થી $high';
  }

  @override
  String get okTitle => 'મિલકતની માલિકી અને કાગળો ચકાસાયા';

  @override
  String get reasonKyc01 =>
      'ફોટા પરથી તમારી ઓળખ પુષ્ટિ કરી શકાઈ નહીં. કૃપા કરી ટૂંકો વિડિયો KYC કૉલ પૂરો કરો.';

  @override
  String get reasonFrd02 =>
      'પગાર સ્લિપ પરની આવક બેંક જમા સાથે મેળ ખાતી નથી. તાજેતરનું ફોર્મ 16 આપો, અથવા સંમતિથી અમને મેળવવા દો.';

  @override
  String get reasonFrd03 =>
      'તમારો એક દસ્તાવેજ જારી કરનાર સત્તાની ચકાસણીમાં નિષ્ફળ ગયો.';

  @override
  String get reasonPol01 => 'અરજદારની ઉંમર ઓછામાં ઓછી 21 વર્ષ હોવી જોઈએ.';

  @override
  String get reasonPol02 =>
      'લોન અમારી મહત્તમ મંજૂર ઉંમર પછી પણ ચાલશે. ઓછી ઉંમરના સહ-અરજદાર ઉમેરવાથી મદદ મળી શકે.';

  @override
  String get reasonBur01 => 'તમારો ક્રેડિટ સ્કોર અમારા લઘુત્તમ 650 થી ઓછો છે.';

  @override
  String get reasonBur04 =>
      'તમારો હજુ ક્રેડિટ ઇતિહાસ નથી, તેથી એક અધિકારી તમારા બેંક રેકોર્ડ જોશે.';

  @override
  String get reasonBur05 =>
      'તમારા ક્રેડિટ સ્કોરને અધિકારીએ ધ્યાનથી જોવાની જરૂર છે.';

  @override
  String get reasonPrp01 => 'અમારા વકીલે મિલકતની માલિકીની સમીક્ષા કરવી પડશે.';

  @override
  String get reasonPrp03 =>
      'કિંમતની પુષ્ટિ માટે અમારા મૂલ્યાંકનકારે મિલકતની મુલાકાત લેવી પડશે.';

  @override
  String get reasonPrp04 =>
      'કરાર કિંમત આ મિલકતના સરકારી જંત્રી દર કરતાં ઓછી છે. કૃપા કરી વેચાણ કરાર તપાસો.';

  @override
  String get reasonAff01 =>
      'તમારા હાલના EMI પહેલેથી જ આવકનો મહત્તમ ભાગ વાપરે છે.';

  @override
  String get reasonAut01 =>
      'આટલી મોટી લોનની અંતિમ ચકાસણી વરિષ્ઠ અધિકારી કરે છે.';

  @override
  String get reasonRsk01 => 'ઓફર નક્કી કરવા એક અધિકારી તમારી અરજી જોશે.';

  @override
  String get reasonRsk02 =>
      'તમારી ક્રેડિટ પ્રોફાઇલના આધારે, હાલ અમે આ લોન આપી શકતા નથી.';

  @override
  String get propertyTitle => 'તમારી મિલકત';

  @override
  String get cityLabel => 'શહેર';

  @override
  String get localityLabel => 'વિસ્તાર';

  @override
  String get societyLabel => 'પ્રોજેક્ટ અથવા સોસાયટી (હોય તો)';

  @override
  String get areaLabel => 'ક્ષેત્રફળ (ચો. ફૂટ)';

  @override
  String get bhkLabel => 'બેડરૂમ';

  @override
  String get newProperty => 'નવી';

  @override
  String get resale => 'રીસેલ';

  @override
  String get declaredPriceLabel => 'કરાર કિંમત';

  @override
  String get photosTitle => 'મિલકતના ફોટા';

  @override
  String get photosBody =>
      'મિલકત પર જઈને ફોટા લો. અમે સ્થળ અને સમય ઉમેરીએ છીએ, જેથી મૂલ્યાંકનકાર મુલાકાતનું આયોજન કરી શકે.';

  @override
  String get photoFront => 'આગળનો ભાગ';

  @override
  String get photoInside => 'અંદર';

  @override
  String get photoView => 'મિલકતમાંથી દેખાતું દૃશ્ય';

  @override
  String geoTagged(String lat, String lng) {
    return 'સ્થાન ઉમેર્યું ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'સ્થાન વિના ફોટો સાચવ્યો. જિયો-ટેગ માટે લોકેશન ચાલુ કરો.';

  @override
  String get submitProperty => 'અંતિમ મંજૂરી મેળવો';

  @override
  String get fillAll => 'કૃપા કરી બધાં ખાનાં ભરો.';

  @override
  String get kfsTitle => 'મુખ્ય તથ્ય પત્રક';

  @override
  String get kfsLoan => 'લોનની રકમ';

  @override
  String get kfsTenure => 'મુદત';

  @override
  String get kfsRate => 'વ્યાજ દર';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'EMI ની સંખ્યા';

  @override
  String get kfsFee => 'પ્રોસેસિંગ ફી (GST સાથે)';

  @override
  String get kfsTotalInterest => 'કુલ વ્યાજ';

  @override
  String get kfsTotalPayable => 'કુલ ચૂકવવાની રકમ';

  @override
  String get kfsApr => 'વાર્ષિક ટકાવારી દર (APR)';

  @override
  String get kfsCoolingOff =>
      'કૂલિંગ-ઓફ સમયગાળો: સહી કર્યાના 3 દિવસમાં ફક્ત મુદ્દલ અને તે દિવસોનું વ્યાજ પાછું આપી દંડ વિના બહાર નીકળી શકો છો.';

  @override
  String get kfsNote =>
      'ડેમો માટે નમૂના આંકડા. તમારું સાચું KFS મંજૂરી પત્ર સાથે આવશે.';

  @override
  String get useSample => 'નમૂનો';

  @override
  String get videoKycDemo => 'ડેમો: આનાથી અધિકારી સાથે વિડિયો KYC કૉલ બુક થાત.';

  @override
  String get raiseComplaint => 'ફરિયાદ કરો';

  @override
  String complaintSent(String ref) {
    return 'તમારી ફરિયાદ નોંધાઈ ગઈ. સંદર્ભ $ref.';
  }

  @override
  String get stageSignIn => 'સાઇન ઇન';

  @override
  String get stageDetails => 'વિગતો';

  @override
  String get stageKyc => 'KYC';

  @override
  String get stageOffer => 'ઓફર';

  @override
  String get stageProperty => 'મિલકત';

  @override
  String get homeSubtitle => 'હોમ લોન · મિલકત સામે લોન';

  @override
  String get heroPill => 'મિનિટોમાં નિર્ણય';

  @override
  String heroFacts(String rate, String years) {
    return 'વાર્ષિક $rate% થી · $years વર્ષ સુધી';
  }

  @override
  String resumeBody(String pct) {
    return '$pct% પૂરું · જ્યાં અટક્યા ત્યાંથી આગળ વધો';
  }

  @override
  String get resume => 'ફરી શરૂ';

  @override
  String get calculators => 'કેલ્ક્યુલેટર';

  @override
  String get calcEmi => 'EMI';

  @override
  String get calcEmiSub => 'માસિક હપ્તો';

  @override
  String get calcEligibility => 'પાત્રતા';

  @override
  String get calcEligibilitySub => 'તમને કેટલું મળી શકે';

  @override
  String get emiCalcTitle => 'EMI કેલ્ક્યુલેટર';

  @override
  String get eligibilityCalcTitle => 'પાત્રતા કેલ્ક્યુલેટર';

  @override
  String totalInterest(String amount) {
    return 'કુલ વ્યાજ $amount';
  }

  @override
  String get calcIncomeOnly => 'ફક્ત આવકના આધારે. મિલકતની કિંમત આ ઘટાડી શકે.';

  @override
  String get verified => 'ચકાસાયેલું';

  @override
  String get yourLoan => 'તમારી લોન';

  @override
  String docsProgress(String done, String total) {
    return '$total માંથી $done ચકાસાયા';
  }

  @override
  String get docNeeded => 'જોઈએ';

  @override
  String get docTryAgain => 'ફરી પ્રયાસ';

  @override
  String get fetched => 'મેળવ્યું';

  @override
  String get statusApproved => 'મંજૂર';

  @override
  String get statusSanctioned => 'મંજૂર થઈ';

  @override
  String get statusInReview => 'સમીક્ષામાં';

  @override
  String get statusDeclined => 'નામંજૂર';

  @override
  String get trackTitle => 'તમારી અરજી ટ્રેક કરો';

  @override
  String get tlSubmitted => 'અરજી સબમિટ થઈ';

  @override
  String get tlVerified => 'KYC અને દસ્તાવેજો ચકાસાયા';

  @override
  String get tlInPrinciple => 'સૈદ્ધાંતિક મંજૂરી';

  @override
  String get tlProperty => 'મિલકતની વિગતો અને મૂલ્યાંકન';

  @override
  String get tlPropertyNext => 'તમારી મિલકતની વિગતો અને ફોટા ઉમેરો';

  @override
  String get tlOfficer => 'અધિકારીની સમીક્ષા';

  @override
  String get tlOfficerNext => 'એક કામકાજના દિવસમાં';

  @override
  String get tlLegal => 'કાનૂની અને માલિકી ચકાસણી';

  @override
  String get tlSanction => 'અંતિમ મંજૂરી અને ઈ-સહી';

  @override
  String get tlSanctionNext => 'મંજૂરી પત્ર પર ઓનલાઇન સહી કરો';

  @override
  String get tlDisbursement => 'રકમની ચુકવણી';

  @override
  String get helpTitle => 'મદદ જોઈએ છે?';

  @override
  String get propertyType => 'નવી કે રીસેલ';

  @override
  String get greetMorning => 'સુપ્રભાત';

  @override
  String get greetAfternoon => 'શુભ બપોર';

  @override
  String get greetEvening => 'શુભ સાંજ';

  @override
  String nearlyThere(String name) {
    return '$name, તમે લગભગ પહોંચી ગયા';
  }

  @override
  String get chooseLanguage => 'તમારી ભાષા પસંદ કરો';

  @override
  String get languageNote => 'તમે આ ગમે ત્યારે બદલી શકો છો.';

  @override
  String get liveChecks => 'લાઇવ ચકાસણી';

  @override
  String get checkBureau => 'ક્રેડિટ બ્યુરો';

  @override
  String checkScore(String score) {
    return 'સ્કોર $score';
  }

  @override
  String get checkNoHistory => 'હજુ ઇતિહાસ નથી';

  @override
  String get checkBank => 'AA દ્વારા બેંક';

  @override
  String get checkBankRead => '12 મહિના વાંચ્યા';

  @override
  String get checkKyc => 'eKYC અને સેલ્ફી';

  @override
  String get checkPending => 'બાકી';

  @override
  String get checkDocs => 'દસ્તાવેજો';

  @override
  String countOf(String done, String total) {
    return '$total માંથી $done';
  }

  @override
  String minutesLeft(String n) {
    return 'લગભગ $n મિનિટ બાકી';
  }

  @override
  String ratePa(String rate) {
    return 'વાર્ષિક $rate%';
  }

  @override
  String get continueApplication => 'તમારી અરજી ચાલુ રાખો';

  @override
  String get shapeOffer => 'તમારી ઓફર નક્કી કરો';

  @override
  String get shapeOfferSub => 'સૈદ્ધાંતિક રીતે મંજૂર · બદલવા ખેંચો';

  @override
  String get withinLimits => 'તમારી મર્યાદામાં';

  @override
  String get aboveLimits => 'મર્યાદાથી વધુ: રકમ ઘટાડો અથવા વર્ષ વધારો';

  @override
  String mostYouCan(String amount) {
    return 'વધુમાં વધુ લઈ શકો: $amount';
  }

  @override
  String get useMax => 'મહત્તમ લો';

  @override
  String get principal => 'મુદ્દલ';

  @override
  String get interest => 'વ્યાજ';

  @override
  String get totalRepaid => 'કુલ ચુકવણી';

  @override
  String get emiShareIncome => 'આવકમાં EMI નો હિસ્સો';

  @override
  String loanShareProperty(String value) {
    return '$value ની મિલકતમાં લોનનો હિસ્સો';
  }

  @override
  String get lockOffer => 'આ ઓફર પાકી કરો';

  @override
  String get offerLocked => 'તમારી ઓફર પાકી થઈ.';

  @override
  String approvedUpTo(String amount) {
    return '$amount સુધી મંજૂર';
  }

  @override
  String readingDoc(String doc) {
    return 'તમારું $doc વાંચી રહ્યા છીએ';
  }

  @override
  String get documentAi => 'દસ્તાવેજ AI';

  @override
  String sure(String pct) {
    return '$pct% ખાતરી';
  }

  @override
  String get readMatches => 'આ એ જ દસ્તાવેજ છે જે અમે માંગ્યો હતો';

  @override
  String get readClear => 'સ્પષ્ટ ફોટો, ઝાંખપ કે ચમક નથી';

  @override
  String get whatWeRead => 'અમે શું વાંચ્યું';

  @override
  String get looksRight => 'બરાબર છે';

  @override
  String get fieldName => 'નામ';

  @override
  String get fieldPan => 'PAN';

  @override
  String get fieldAadhaar => 'આધાર';

  @override
  String get fieldEmployer => 'નોકરીદાતા';

  @override
  String get fieldNetPay => 'ચોખ્ખો પગાર';

  @override
  String get fieldPeriod => 'પગારનો સમયગાળો';

  @override
  String get fieldYear => 'વર્ષ';

  @override
  String get fieldIncome => 'આવક';

  @override
  String get fieldBusiness => 'વ્યવસાય';

  @override
  String get fieldGstin => 'GSTIN';

  @override
  String get consentSectionRequired => 'તમારી લોન માટે જરૂરી';

  @override
  String get consentSectionOptional =>
      'વૈકલ્પિક: તમે ચાલુ ન કરો ત્યાં સુધી બંધ';

  @override
  String get advancedOptions => 'વિકલ્પો';

  @override
  String consentValidUntil(String given, String until) {
    return '$given એ આપી · $until સુધી માન્ય';
  }

  @override
  String consentUntilWithdrawn(String given) {
    return '$given એ આપી · પાછી ખેંચો ત્યાં સુધી';
  }

  @override
  String get recheckTitle => 'રકમ આપતાં પહેલાં વધુ એક ચકાસણી';

  @override
  String get recheckBody =>
      'રકમ આપતાં પહેલાં અમે તમારો ક્રેડિટ રિપોર્ટ ફરી જોઈએ છીએ. ના કહો તો ત્યારે અધિકારી પૂછી શકે.';

  @override
  String get aaMonthsLabel => 'કેટલા મહિનાના સ્ટેટમેન્ટ આપવા';

  @override
  String monthsN(String n) {
    return '$n મહિના';
  }

  @override
  String get aaAccountsLabel => 'આપવાનાં ખાતાં';

  @override
  String get accountSavingsSalary => 'બચત ખાતું ·· 0912 · પગાર જમા';

  @override
  String get accountSavings => 'બચત ખાતું ·· 4821';

  @override
  String get accountFd => 'ફિક્સ્ડ ડિપોઝિટ ·· 3307';

  @override
  String get aaAccountNeeded => 'ઓછામાં ઓછું એક ખાતું પસંદ કરો.';

  @override
  String get kycMethodLabel => 'ઓળખ કેવી રીતે ચકાસવી';

  @override
  String get kycAadhaarOtp => 'આધાર OTP';

  @override
  String get kycDigilocker => 'ડિજીલોકર';

  @override
  String get kycVideo => 'વિડિયો KYC કૉલ';

  @override
  String get useCkycTitle => 'મારો હાલનો CKYC રેકોર્ડ વાપરો';

  @override
  String get useCkycBody =>
      'બીજી બેંક કે ફંડમાં KYC કર્યું હોય, તો ફરી પૂછવાને બદલે અમે તે રેકોર્ડ લાવીએ છીએ.';

  @override
  String get optOffersTitle => 'ઓફર અને નવી પ્રોડક્ટ';

  @override
  String get optOffersBody =>
      'ઓફર વિશે કેવી રીતે જાણવું છે તે પસંદ કરો. ગમે ત્યારે બંધ કરી શકો.';

  @override
  String get channelSms => 'SMS';

  @override
  String get channelEmail => 'ઈમેલ';

  @override
  String get channelWhatsapp => 'WhatsApp';

  @override
  String get optUpdatesTitle => 'WhatsApp પર લોન અપડેટ';

  @override
  String get optUpdatesBody =>
      'SMS સાથે WhatsApp પર સ્ટેટસ અપડેટ અને EMI રિમાઇન્ડર.';

  @override
  String get optInsuranceTitle => 'હોમ લોન સુરક્ષા ક્વોટ';

  @override
  String get optInsuranceBody =>
      'ક્વોટ માટે તમારું નામ, ઉંમર અને લોનની રકમ અમારા વીમા ભાગીદારને આપો. ખરીદવું ક્યારેય ફરજિયાત નથી.';

  @override
  String get getQuote => 'ક્વોટ મેળવો';

  @override
  String get manageConsents => 'સંમતિ સંભાળો';

  @override
  String get manageConsentsBody =>
      'વૈકલ્પિક સંમતિ ગમે ત્યારે બંધ કરો. જરૂરી સંમતિ પાછી ખેંચવાથી અરજી અટકે છે, અને તેના માટે મેળવેલી માહિતી અમે ભૂંસી નાખીએ છીએ.';

  @override
  String get withdraw => 'પાછી ખેંચો';

  @override
  String get consentHistory => 'સંમતિનો ઇતિહાસ';

  @override
  String historyGiven(String item) {
    return '$item આપી';
  }

  @override
  String historyWithdrawn(String item) {
    return '$item પાછી ખેંચી';
  }

  @override
  String get historyEmpty => 'હજુ કંઈ નથી.';

  @override
  String get consentOn => 'ચાલુ';

  @override
  String get consentOff => 'બંધ';

  @override
  String get withdrawnRequired =>
      'તમે જરૂરી સંમતિ પાછી ખેંચી, તેથી અરજી અટકી છે.';

  @override
  String get checkMatchPending =>
      'ફોટો મેળ: આધાર અથવા પાન કાર્ડ અપલોડ કરશો ત્યારે થશે';

  @override
  String get realDetailsIntro =>
      'તમારા વિશે જણાવો. દરેક વિગત અમે તમારા દસ્તાવેજો સાથે ચકાસીએ છીએ.';

  @override
  String get fullNameLabel => 'પૂરું નામ (પાન કાર્ડ પર છે તેમ)';

  @override
  String get emailLabel => 'ઈમેલ';

  @override
  String get employerLabel => 'નોકરીદાતા અથવા વ્યવસાયનું નામ';

  @override
  String get creditScoreLabel => 'ક્રેડિટ સ્કોર (વૈકલ્પિક)';

  @override
  String get creditScoreHint =>
      'તમારા CIBIL અથવા Experian રિપોર્ટમાંથી, જો ખબર હોય';

  @override
  String get addressLabel => 'સરનામું';

  @override
  String get saveDetails => 'મારી વિગતો સાચવો';

  @override
  String get selfDeclaredNote =>
      'આ વિગતો તમે ભરી છે. આગળ તમે અપલોડ કરશો તે દસ્તાવેજો સાથે અમે ચકાસીશું.';

  @override
  String get pickDob => 'તમારી જન્મતારીખ પસંદ કરો';

  @override
  String get fillDetails =>
      'કૃપા કરીને નામ, જન્મતારીખ, કામ, નોકરીદાતા અને આવક ભરો.';

  @override
  String get docSaleDeed => 'વેચાણ દસ્તાવેજ અથવા ફાળવણી પત્ર';

  @override
  String get saleDeedBody =>
      'નોંધાયેલા વેચાણ દસ્તાવેજનો ફોટો અથવા PDF અપલોડ કરો (જે પાના પર મિલકત અને ખરીદનાર હોય). માલિકી તપાસવા અમે તેને વાંચીએ છીએ.';

  @override
  String get statusPending => 'સમીક્ષા બાકી';

  @override
  String decisionRef(String ref) {
    return 'નિર્ણય રેકોર્ડ $ref';
  }

  @override
  String get scoreTitle => 'અમે તમારો સ્કોર કેવી રીતે ગણ્યો';

  @override
  String get scoreOutOf => '900 માંથી';

  @override
  String gradeLabel(String grade) {
    return 'ગ્રેડ $grade';
  }

  @override
  String scoreStart(String base) {
    return 'દરેકની શરૂઆત $base પોઇન્ટથી થાય છે. નીચેની દરેક લાઇન પોઇન્ટ ઉમેરે છે અથવા ઘટાડે છે.';
  }

  @override
  String get scoreNote =>
      'આ નિર્ણયનો ક્રેડિટ સ્કોર ભાગ છે. તમારી આવક, ઓળખ, દસ્તાવેજો અને મિલકતની પણ તપાસ થાય છે.';

  @override
  String get factorBureau => 'ક્રેડિટ બ્યુરો સ્કોર';

  @override
  String get factorHistory => 'ક્રેડિટ ઇતિહાસનાં વર્ષો';

  @override
  String get factorLtv => 'મિલકતની કિંમતની સરખામણીમાં લોનનો હિસ્સો';

  @override
  String get factorLoanAmount => 'લોનની રકમ';

  @override
  String get factorMissing => 'ઉપલબ્ધ નથી';

  @override
  String rangeBelow(String x) {
    return '$x થી ઓછું';
  }

  @override
  String rangeBetween(String a, String b) {
    return '$a થી $b';
  }

  @override
  String rangeAtLeast(String x) {
    return '$x કે વધુ';
  }

  @override
  String get viewLetter => 'નિર્ણય પત્ર';

  @override
  String get letterTitle => 'તમારો નિર્ણય પત્ર';

  @override
  String get letterPartlyEnglish =>
      'કેટલીક લાઇનોનો અનુવાદ થઈ શક્યો નહીં, તેથી તે અંગ્રેજીમાં છે.';

  @override
  String get copyText => 'લખાણ કૉપિ કરો';

  @override
  String get copied => 'કૉપિ થયું';

  @override
  String get askTitle => 'પ્રશ્ન પૂછો';

  @override
  String get askHint => 'ઉદા.: હવે આગળ શું થશે?';

  @override
  String get askSend => 'મોકલો';

  @override
  String get askHuman => 'અમારી ટીમની એક વ્યક્તિ આ અંગે તમારો સંપર્ક કરશે.';

  @override
  String get uploadPdf => 'PDF અપલોડ કરો';

  @override
  String get kfsFeeBase => 'પ્રોસેસિંગ ફી (0.5%)';

  @override
  String get kfsGst => 'ફી પર GST (18%)';

  @override
  String get kfsNoteEngine =>
      'આ ઑફર માટે ગણતરી કરેલ છે. સહી કરેલું મુખ્ય તથ્ય પત્રક તમારા મંજૂરી પત્ર સાથે આવશે.';

  @override
  String otpOnServer(String phone) {
    return 'આ ટેસ્ટ સર્વર SMS મોકલતું નથી. $phone માટેનો 6 અંકનો કોડ કમ્પ્યુટર પરની સર્વર વિન્ડોમાં દેખાય છે.';
  }

  @override
  String get resendOtp => 'નવો કોડ મોકલો';

  @override
  String get newOtpSent => 'નવો કોડ મોકલ્યો.';

  @override
  String get otpExpired => 'આ કોડની મુદત પૂરી થઈ. નવો કોડ મોકલો દબાવો.';

  @override
  String get otpTooManyTries => 'ઘણી વાર ખોટો કોડ નાખ્યો. નવો કોડ મોકલો દબાવો.';

  @override
  String get otpTooManySends =>
      'ઘણા બધા કોડ માગ્યા. 15 મિનિટ રાહ જોઈને ફરી પ્રયાસ કરો.';
}
