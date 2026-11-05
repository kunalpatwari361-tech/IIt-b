// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nirnay';

  @override
  String get sandboxBanner => 'Demo mode: sample data, no real checks';

  @override
  String get continueLabel => 'Continue';

  @override
  String stepOf(String step, String total) {
    return 'Step $step of $total';
  }

  @override
  String get pleaseWait => 'Please wait…';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get close => 'Close';

  @override
  String get welcomeHeadline => 'Your home loan decision in minutes';

  @override
  String get welcomeBody =>
      'Apply for a Home Loan or a Loan Against Property. We check everything online and always tell you why we decided.';

  @override
  String get chooseProduct => 'What do you need?';

  @override
  String get productHomeLoan => 'Home Loan';

  @override
  String get productHomeLoanSub => 'Buy, build or improve a home';

  @override
  String get productLap => 'Loan Against Property';

  @override
  String get productLapSub => 'Borrow against a property you own';

  @override
  String get startApplication => 'Start application';

  @override
  String get demoCustomers => 'Demo customers';

  @override
  String get demoCustomersBody =>
      'Tap one to fill in its sample mobile number.';

  @override
  String get personaRavi => 'Ravi, 32, salaried, buying a flat';

  @override
  String get personaMeena => 'Meena, 45, runs a garment shop (LAP)';

  @override
  String get personaArjun => 'Arjun, 29, salaried, edited salary slip';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get mobileLabel => 'Mobile number';

  @override
  String get mobileHint => '10-digit mobile number';

  @override
  String get invalidMobile => 'Enter a valid 10-digit mobile number.';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String otpSentTo(String phone) {
    return 'We sent a 6-digit code to $phone.';
  }

  @override
  String get otpLabel => 'OTP';

  @override
  String get verify => 'Verify';

  @override
  String get demoOtp => 'Demo code: 123456';

  @override
  String get wrongOtp => 'That code is wrong. Please try again.';

  @override
  String get deviceBound =>
      'This phone is now linked to your account. Signing in on another phone will need a new OTP.';

  @override
  String get consentTitle => 'Your consent';

  @override
  String get consentIntro =>
      'We only use your data to decide on and run this loan. You can withdraw consent at any time.';

  @override
  String get consentBureauTitle => 'Credit report';

  @override
  String get consentBureauBody =>
      'Check your credit history with a credit bureau (CIBIL, Experian, Equifax or CRIF). This check does not lower your score.';

  @override
  String get consentAaTitle => 'Bank statements through Account Aggregator';

  @override
  String get consentAaBody =>
      'Fetch 12 months of statements from your bank through an RBI-licensed Account Aggregator. You approve the request in your AA app.';

  @override
  String get consentKycTitle => 'Aadhaar eKYC and PAN';

  @override
  String get consentKycBody =>
      'Confirm your identity with UIDAI and the Income Tax Department. We keep only a masked Aadhaar number.';

  @override
  String get consentPrivacyTitle => 'Privacy notice (DPDP Act 2023)';

  @override
  String get consentPrivacyBody =>
      'What we collect: identity, income, bank and property details. Why: to decide on and run your loan. How long: only as long as the law requires. Your rights: see, correct or erase your data, and complain to our Grievance Officer or the Data Protection Board.';

  @override
  String get consentRequired => 'Required';

  @override
  String get consentNeeded => 'Please agree to all the items to continue.';

  @override
  String get agreeAndContinue => 'Agree and continue';

  @override
  String get detailsTitle => 'Your details';

  @override
  String get panLabel => 'PAN';

  @override
  String get panHint => 'ABCDE1234F';

  @override
  String get invalidPan => 'Enter a valid PAN, like ABCDE1234F.';

  @override
  String get fetchDetails => 'Fetch my details';

  @override
  String get fetchedFrom =>
      'Filled from PAN, Aadhaar eKYC and your bank statements. Tap a figure to correct it.';

  @override
  String get nameLabel => 'Name';

  @override
  String get dobLabel => 'Date of birth';

  @override
  String get employmentLabel => 'Work';

  @override
  String get salaried => 'Salaried';

  @override
  String get selfEmployed => 'Self-employed';

  @override
  String get incomeLabel => 'Net monthly income';

  @override
  String get existingEmiLabel => 'Existing EMIs a month';

  @override
  String get propertyValueLabel => 'Property value';

  @override
  String get loanAmountLabel => 'Loan amount';

  @override
  String get tenureLabel => 'Tenure';

  @override
  String yearsLabel(String n) {
    return '$n years';
  }

  @override
  String get eligibleTitle => 'You can get up to';

  @override
  String emiPerMonth(String amount) {
    return 'EMI $amount a month';
  }

  @override
  String rateNote(String rate) {
    return '$rate% a year, floating (illustrative)';
  }

  @override
  String limitedByIncome(String pct) {
    return 'Limited by income: all your EMIs can use up to $pct of your income.';
  }

  @override
  String limitedByProperty(String pct) {
    return 'Limited by the property: a loan this size can be up to $pct of its value.';
  }

  @override
  String get limitedByAsked => 'This is the amount you asked for.';

  @override
  String get eligibilityNote =>
      'A quick check on your details. Your offer comes after our checks.';

  @override
  String get selfieTitle => 'Take a selfie';

  @override
  String get selfieBody =>
      'We match your face with your Aadhaar photo and check that it\'s really you, not a photo of a photo.';

  @override
  String get selfieTips => 'Good light, face the camera, no cap or sunglasses.';

  @override
  String get takeSelfie => 'Take selfie';

  @override
  String get retake => 'Retake';

  @override
  String get checkFace => 'Face found';

  @override
  String get checkLive => 'Live person';

  @override
  String get checkMatch => 'Matches your Aadhaar photo';

  @override
  String get selfieFailed =>
      'We couldn\'t confirm your face. Try again in good light, or book a video KYC call.';

  @override
  String get videoKyc => 'Book a video KYC call';

  @override
  String get docsTitle => 'Your documents';

  @override
  String get docsBody =>
      'Take a clear photo of each document, or pick one from your gallery.';

  @override
  String get docPan => 'PAN card';

  @override
  String get docAadhaar => 'Aadhaar card (masked)';

  @override
  String get docSalarySlip => 'Latest salary slip';

  @override
  String get docForm16 => 'Form 16';

  @override
  String get docItr => 'Income tax return (ITR)';

  @override
  String get docGst => 'GST certificate';

  @override
  String get docBankStatement => 'Bank statement';

  @override
  String get bankViaAa => 'Fetched through your Account Aggregator';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get checking => 'Checking…';

  @override
  String get tooBlurry => 'Too blurry. Hold the phone steady and try again.';

  @override
  String get tooMuchGlare =>
      'Too much glare. Move away from the light and try again.';

  @override
  String get tooDark => 'Too dark. Find more light and try again.';

  @override
  String docAccepted(String type) {
    return 'Recognised: $type';
  }

  @override
  String docWrong(String expected) {
    return 'This doesn\'t look like a $expected. Please check and upload the right document.';
  }

  @override
  String get docUnreadable =>
      'We couldn\'t read this document. Please take a clearer photo, or upload the original PDF.';

  @override
  String docsMissing(String n) {
    return '$n still needed';
  }

  @override
  String get getOffer => 'Get my in-principle offer';

  @override
  String get approvedInPrinciple => 'Approved in principle';

  @override
  String get sanctioned => 'Loan sanctioned';

  @override
  String get referredTitle => 'We need a little more time';

  @override
  String get rejectedTitle => 'We can\'t offer this loan right now';

  @override
  String emiLine(String emi, String years, String rate) {
    return 'EMI $emi · $years years · $rate% p.a. floating';
  }

  @override
  String get whyOffer => 'Why you got this offer';

  @override
  String get whyReferred => 'What happens next';

  @override
  String get whyRejected => 'Why we decided this';

  @override
  String get referBody =>
      'An officer will look at your application within one working day. You don\'t need to do anything now.';

  @override
  String get rejectBody =>
      'You can ask a person to review this decision at any time.';

  @override
  String get addProperty => 'Add property details';

  @override
  String get viewKfs => 'View Key Facts Statement';

  @override
  String get grievance => 'Ask for a review or raise a complaint';

  @override
  String officerLine(String name, String email) {
    return 'Grievance Officer: $name, $email';
  }

  @override
  String applicationNo(String id) {
    return 'Application $id';
  }

  @override
  String get startOver => 'Start a new application';

  @override
  String okScore(String score) {
    return 'Strong repayment history (score $score)';
  }

  @override
  String okFoir(String pct, String cap) {
    return 'EMIs use $pct of income; our limit is $cap';
  }

  @override
  String okLtv(String pct, String cap) {
    return 'Loan is $pct of the property value; the limit is $cap';
  }

  @override
  String okValue(String low, String high) {
    return 'Our valuation of the property: $low to $high';
  }

  @override
  String get okTitle => 'Property title and papers checked';

  @override
  String get reasonKyc01 =>
      'We could not confirm your identity from the photo. Please complete a short video KYC call.';

  @override
  String get reasonFrd02 =>
      'The income on your salary slip does not match your bank credits. Please share your latest Form 16, or let us fetch it with your consent.';

  @override
  String get reasonFrd03 =>
      'One of your documents failed verification with the issuing authority.';

  @override
  String get reasonPol01 => 'Applicants must be at least 21 years old.';

  @override
  String get reasonPol02 =>
      'The loan would run past the maximum age we allow. Adding a younger co-applicant can help.';

  @override
  String get reasonBur01 => 'Your credit score is below our minimum of 650.';

  @override
  String get reasonBur04 =>
      'You do not have a credit history yet, so an officer will review your bank records.';

  @override
  String get reasonBur05 =>
      'Your credit score needs a closer look by an officer.';

  @override
  String get reasonPrp01 => 'Our lawyer needs to review the property title.';

  @override
  String get reasonPrp03 =>
      'We need our valuer to visit the property to confirm its value.';

  @override
  String get reasonPrp04 =>
      'The agreement value is below the government circle rate for this property. Please check the sale agreement.';

  @override
  String get reasonAff01 =>
      'Your current EMIs already use the maximum share of income we can lend against.';

  @override
  String get reasonAut01 =>
      'Loans of this size get a final check by a senior officer.';

  @override
  String get reasonRsk01 =>
      'An officer will review your application to finalise the offer.';

  @override
  String get reasonRsk02 =>
      'Based on your credit profile, we cannot offer this loan right now.';

  @override
  String get propertyTitle => 'Your property';

  @override
  String get cityLabel => 'City';

  @override
  String get localityLabel => 'Locality';

  @override
  String get societyLabel => 'Project or society (if any)';

  @override
  String get areaLabel => 'Area (sq ft)';

  @override
  String get bhkLabel => 'Bedrooms';

  @override
  String get newProperty => 'New';

  @override
  String get resale => 'Resale';

  @override
  String get declaredPriceLabel => 'Agreement value';

  @override
  String get photosTitle => 'Property photos';

  @override
  String get photosBody =>
      'Take the photos at the property. We add the place and time, so our valuer can plan the visit.';

  @override
  String get photoFront => 'Front';

  @override
  String get photoInside => 'Inside';

  @override
  String get photoView => 'View from the property';

  @override
  String geoTagged(String lat, String lng) {
    return 'Location added ($lat, $lng)';
  }

  @override
  String get noLocation =>
      'Photo saved without a location. Turn on location for a geo-tag.';

  @override
  String get submitProperty => 'Get final sanction';

  @override
  String get fillAll => 'Please fill in every field.';

  @override
  String get kfsTitle => 'Key Facts Statement';

  @override
  String get kfsLoan => 'Loan amount';

  @override
  String get kfsTenure => 'Tenure';

  @override
  String get kfsRate => 'Interest rate';

  @override
  String get kfsEmi => 'EMI';

  @override
  String get kfsInstalments => 'Number of EMIs';

  @override
  String get kfsFee => 'Processing fee (with GST)';

  @override
  String get kfsTotalInterest => 'Total interest';

  @override
  String get kfsTotalPayable => 'Total amount payable';

  @override
  String get kfsApr => 'Annual Percentage Rate (APR)';

  @override
  String get kfsCoolingOff =>
      'Cooling-off period: you can exit within 3 days of signing by paying back only the principal and interest for those days, with no penalty.';

  @override
  String get kfsNote =>
      'Sample figures for the demo. Your real KFS comes with your sanction letter.';

  @override
  String get useSample => 'Sample';

  @override
  String get videoKycDemo =>
      'Demo: this would book a video KYC call with an officer.';

  @override
  String get raiseComplaint => 'Raise a complaint';

  @override
  String complaintSent(String ref) {
    return 'Your complaint is registered. Reference $ref.';
  }
}
