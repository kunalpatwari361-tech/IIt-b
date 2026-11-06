import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_as.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_brx.dart';
import 'app_localizations_doi.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_kok.dart';
import 'app_localizations_ks.dart';
import 'app_localizations_mai.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mni.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ne.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_sa.dart';
import 'app_localizations_sat.dart';
import 'app_localizations_sd.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('as'),
    Locale('bn'),
    Locale('brx'),
    Locale('doi'),
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
    Locale('kn'),
    Locale('kok'),
    Locale('ks'),
    Locale('mai'),
    Locale('ml'),
    Locale('mni'),
    Locale('mr'),
    Locale('ne'),
    Locale('or'),
    Locale('pa'),
    Locale('sa'),
    Locale('sat'),
    Locale('sd'),
    Locale('ta'),
    Locale('te'),
    Locale('ur'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Nirnay'**
  String get appTitle;

  /// No description provided for @sandboxBanner.
  ///
  /// In en, this message translates to:
  /// **'Demo mode: sample data, no real checks'**
  String get sandboxBanner;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String stepOf(String step, String total);

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait…'**
  String get pleaseWait;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @welcomeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your home loan decision in minutes'**
  String get welcomeHeadline;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Apply for a Home Loan or a Loan Against Property. We check everything online and always tell you why we decided.'**
  String get welcomeBody;

  /// No description provided for @chooseProduct.
  ///
  /// In en, this message translates to:
  /// **'What do you need?'**
  String get chooseProduct;

  /// No description provided for @productHomeLoan.
  ///
  /// In en, this message translates to:
  /// **'Home Loan'**
  String get productHomeLoan;

  /// No description provided for @productHomeLoanSub.
  ///
  /// In en, this message translates to:
  /// **'Buy, build or improve a home'**
  String get productHomeLoanSub;

  /// No description provided for @productLap.
  ///
  /// In en, this message translates to:
  /// **'Loan Against Property'**
  String get productLap;

  /// No description provided for @productLapSub.
  ///
  /// In en, this message translates to:
  /// **'Borrow against a property you own'**
  String get productLapSub;

  /// No description provided for @startApplication.
  ///
  /// In en, this message translates to:
  /// **'Start application'**
  String get startApplication;

  /// No description provided for @demoCustomers.
  ///
  /// In en, this message translates to:
  /// **'Demo customers'**
  String get demoCustomers;

  /// No description provided for @demoCustomersBody.
  ///
  /// In en, this message translates to:
  /// **'Tap one to fill in its sample mobile number.'**
  String get demoCustomersBody;

  /// No description provided for @personaRavi.
  ///
  /// In en, this message translates to:
  /// **'Ravi, 32, salaried, buying a flat'**
  String get personaRavi;

  /// No description provided for @personaMeena.
  ///
  /// In en, this message translates to:
  /// **'Meena, 45, runs a garment shop (LAP)'**
  String get personaMeena;

  /// No description provided for @personaArjun.
  ///
  /// In en, this message translates to:
  /// **'Arjun, 29, salaried, edited salary slip'**
  String get personaArjun;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInTitle;

  /// No description provided for @mobileLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile number'**
  String get mobileLabel;

  /// No description provided for @mobileHint.
  ///
  /// In en, this message translates to:
  /// **'10-digit mobile number'**
  String get mobileHint;

  /// No description provided for @invalidMobile.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 10-digit mobile number.'**
  String get invalidMobile;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to {phone}.'**
  String otpSentTo(String phone);

  /// No description provided for @otpLabel.
  ///
  /// In en, this message translates to:
  /// **'OTP'**
  String get otpLabel;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @demoOtp.
  ///
  /// In en, this message translates to:
  /// **'Demo code: 123456'**
  String get demoOtp;

  /// No description provided for @wrongOtp.
  ///
  /// In en, this message translates to:
  /// **'That code is wrong. Please try again.'**
  String get wrongOtp;

  /// No description provided for @deviceBound.
  ///
  /// In en, this message translates to:
  /// **'This phone is now linked to your account. Signing in on another phone will need a new OTP.'**
  String get deviceBound;

  /// No description provided for @consentTitle.
  ///
  /// In en, this message translates to:
  /// **'Your consent'**
  String get consentTitle;

  /// No description provided for @consentIntro.
  ///
  /// In en, this message translates to:
  /// **'We only use your data to decide on and run this loan. You can withdraw consent at any time.'**
  String get consentIntro;

  /// No description provided for @consentBureauTitle.
  ///
  /// In en, this message translates to:
  /// **'Credit report'**
  String get consentBureauTitle;

  /// No description provided for @consentBureauBody.
  ///
  /// In en, this message translates to:
  /// **'Check your credit history with a credit bureau (CIBIL, Experian, Equifax or CRIF). This check does not lower your score.'**
  String get consentBureauBody;

  /// No description provided for @consentAaTitle.
  ///
  /// In en, this message translates to:
  /// **'Bank statements through Account Aggregator'**
  String get consentAaTitle;

  /// No description provided for @consentAaBody.
  ///
  /// In en, this message translates to:
  /// **'Fetch 12 months of statements from your bank through an RBI-licensed Account Aggregator. You approve the request in your AA app.'**
  String get consentAaBody;

  /// No description provided for @consentKycTitle.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar eKYC and PAN'**
  String get consentKycTitle;

  /// No description provided for @consentKycBody.
  ///
  /// In en, this message translates to:
  /// **'Confirm your identity with UIDAI and the Income Tax Department. We keep only a masked Aadhaar number.'**
  String get consentKycBody;

  /// No description provided for @consentPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy notice (DPDP Act 2023)'**
  String get consentPrivacyTitle;

  /// No description provided for @consentPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'What we collect: identity, income, bank and property details. Why: to decide on and run your loan. How long: only as long as the law requires. Your rights: see, correct or erase your data, and complain to our Grievance Officer or the Data Protection Board.'**
  String get consentPrivacyBody;

  /// No description provided for @consentRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get consentRequired;

  /// No description provided for @consentNeeded.
  ///
  /// In en, this message translates to:
  /// **'Please agree to all the items to continue.'**
  String get consentNeeded;

  /// No description provided for @agreeAndContinue.
  ///
  /// In en, this message translates to:
  /// **'Agree and continue'**
  String get agreeAndContinue;

  /// No description provided for @detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your details'**
  String get detailsTitle;

  /// No description provided for @panLabel.
  ///
  /// In en, this message translates to:
  /// **'PAN'**
  String get panLabel;

  /// No description provided for @panHint.
  ///
  /// In en, this message translates to:
  /// **'ABCDE1234F'**
  String get panHint;

  /// No description provided for @invalidPan.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid PAN, like ABCDE1234F.'**
  String get invalidPan;

  /// No description provided for @fetchDetails.
  ///
  /// In en, this message translates to:
  /// **'Fetch my details'**
  String get fetchDetails;

  /// No description provided for @fetchedFrom.
  ///
  /// In en, this message translates to:
  /// **'Filled from PAN, Aadhaar eKYC and your bank statements. Tap a figure to correct it.'**
  String get fetchedFrom;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @dobLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dobLabel;

  /// No description provided for @employmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get employmentLabel;

  /// No description provided for @salaried.
  ///
  /// In en, this message translates to:
  /// **'Salaried'**
  String get salaried;

  /// No description provided for @selfEmployed.
  ///
  /// In en, this message translates to:
  /// **'Self-employed'**
  String get selfEmployed;

  /// No description provided for @incomeLabel.
  ///
  /// In en, this message translates to:
  /// **'Net monthly income'**
  String get incomeLabel;

  /// No description provided for @existingEmiLabel.
  ///
  /// In en, this message translates to:
  /// **'Existing EMIs a month'**
  String get existingEmiLabel;

  /// No description provided for @propertyValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Property value'**
  String get propertyValueLabel;

  /// No description provided for @loanAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Loan amount'**
  String get loanAmountLabel;

  /// No description provided for @tenureLabel.
  ///
  /// In en, this message translates to:
  /// **'Tenure'**
  String get tenureLabel;

  /// No description provided for @yearsLabel.
  ///
  /// In en, this message translates to:
  /// **'{n} years'**
  String yearsLabel(String n);

  /// No description provided for @eligibleTitle.
  ///
  /// In en, this message translates to:
  /// **'You can get up to'**
  String get eligibleTitle;

  /// No description provided for @emiPerMonth.
  ///
  /// In en, this message translates to:
  /// **'EMI {amount} a month'**
  String emiPerMonth(String amount);

  /// No description provided for @rateNote.
  ///
  /// In en, this message translates to:
  /// **'{rate}% a year, floating (illustrative)'**
  String rateNote(String rate);

  /// No description provided for @limitedByIncome.
  ///
  /// In en, this message translates to:
  /// **'Limited by income: all your EMIs can use up to {pct} of your income.'**
  String limitedByIncome(String pct);

  /// No description provided for @limitedByProperty.
  ///
  /// In en, this message translates to:
  /// **'Limited by the property: a loan this size can be up to {pct} of its value.'**
  String limitedByProperty(String pct);

  /// No description provided for @limitedByAsked.
  ///
  /// In en, this message translates to:
  /// **'This is the amount you asked for.'**
  String get limitedByAsked;

  /// No description provided for @eligibilityNote.
  ///
  /// In en, this message translates to:
  /// **'A quick check on your details. Your offer comes after our checks.'**
  String get eligibilityNote;

  /// No description provided for @selfieTitle.
  ///
  /// In en, this message translates to:
  /// **'Take a selfie'**
  String get selfieTitle;

  /// No description provided for @selfieBody.
  ///
  /// In en, this message translates to:
  /// **'We match your face with your Aadhaar photo and check that it\'s really you, not a photo of a photo.'**
  String get selfieBody;

  /// No description provided for @selfieTips.
  ///
  /// In en, this message translates to:
  /// **'Good light, face the camera, no cap or sunglasses.'**
  String get selfieTips;

  /// No description provided for @takeSelfie.
  ///
  /// In en, this message translates to:
  /// **'Take selfie'**
  String get takeSelfie;

  /// No description provided for @retake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get retake;

  /// No description provided for @checkFace.
  ///
  /// In en, this message translates to:
  /// **'Face found'**
  String get checkFace;

  /// No description provided for @checkLive.
  ///
  /// In en, this message translates to:
  /// **'Live person'**
  String get checkLive;

  /// No description provided for @checkMatch.
  ///
  /// In en, this message translates to:
  /// **'Matches your Aadhaar photo'**
  String get checkMatch;

  /// No description provided for @selfieFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t confirm your face. Try again in good light, or book a video KYC call.'**
  String get selfieFailed;

  /// No description provided for @videoKyc.
  ///
  /// In en, this message translates to:
  /// **'Book a video KYC call'**
  String get videoKyc;

  /// No description provided for @docsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your documents'**
  String get docsTitle;

  /// No description provided for @docsBody.
  ///
  /// In en, this message translates to:
  /// **'Take a clear photo of each document, or pick one from your gallery.'**
  String get docsBody;

  /// No description provided for @docPan.
  ///
  /// In en, this message translates to:
  /// **'PAN card'**
  String get docPan;

  /// No description provided for @docAadhaar.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar card (masked)'**
  String get docAadhaar;

  /// No description provided for @docSalarySlip.
  ///
  /// In en, this message translates to:
  /// **'Latest salary slip'**
  String get docSalarySlip;

  /// No description provided for @docForm16.
  ///
  /// In en, this message translates to:
  /// **'Form 16'**
  String get docForm16;

  /// No description provided for @docItr.
  ///
  /// In en, this message translates to:
  /// **'Income tax return (ITR)'**
  String get docItr;

  /// No description provided for @docGst.
  ///
  /// In en, this message translates to:
  /// **'GST certificate'**
  String get docGst;

  /// No description provided for @docBankStatement.
  ///
  /// In en, this message translates to:
  /// **'Bank statement'**
  String get docBankStatement;

  /// No description provided for @bankViaAa.
  ///
  /// In en, this message translates to:
  /// **'Fetched through your Account Aggregator'**
  String get bankViaAa;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @checking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get checking;

  /// No description provided for @tooBlurry.
  ///
  /// In en, this message translates to:
  /// **'Too blurry. Hold the phone steady and try again.'**
  String get tooBlurry;

  /// No description provided for @tooMuchGlare.
  ///
  /// In en, this message translates to:
  /// **'Too much glare. Move away from the light and try again.'**
  String get tooMuchGlare;

  /// No description provided for @tooDark.
  ///
  /// In en, this message translates to:
  /// **'Too dark. Find more light and try again.'**
  String get tooDark;

  /// No description provided for @docAccepted.
  ///
  /// In en, this message translates to:
  /// **'Recognised: {type}'**
  String docAccepted(String type);

  /// No description provided for @docWrong.
  ///
  /// In en, this message translates to:
  /// **'This doesn\'t look like a {expected}. Please check and upload the right document.'**
  String docWrong(String expected);

  /// No description provided for @docUnreadable.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read this document. Please take a clearer photo, or upload the original PDF.'**
  String get docUnreadable;

  /// No description provided for @docsMissing.
  ///
  /// In en, this message translates to:
  /// **'{n} still needed'**
  String docsMissing(String n);

  /// No description provided for @getOffer.
  ///
  /// In en, this message translates to:
  /// **'Get my in-principle offer'**
  String get getOffer;

  /// No description provided for @approvedInPrinciple.
  ///
  /// In en, this message translates to:
  /// **'Approved in principle'**
  String get approvedInPrinciple;

  /// No description provided for @sanctioned.
  ///
  /// In en, this message translates to:
  /// **'Loan sanctioned'**
  String get sanctioned;

  /// No description provided for @referredTitle.
  ///
  /// In en, this message translates to:
  /// **'We need a little more time'**
  String get referredTitle;

  /// No description provided for @rejectedTitle.
  ///
  /// In en, this message translates to:
  /// **'We can\'t offer this loan right now'**
  String get rejectedTitle;

  /// No description provided for @emiLine.
  ///
  /// In en, this message translates to:
  /// **'EMI {emi} · {years} years · {rate}% p.a. floating'**
  String emiLine(String emi, String years, String rate);

  /// No description provided for @whyOffer.
  ///
  /// In en, this message translates to:
  /// **'Why you got this offer'**
  String get whyOffer;

  /// No description provided for @whyReferred.
  ///
  /// In en, this message translates to:
  /// **'What happens next'**
  String get whyReferred;

  /// No description provided for @whyRejected.
  ///
  /// In en, this message translates to:
  /// **'Why we decided this'**
  String get whyRejected;

  /// No description provided for @referBody.
  ///
  /// In en, this message translates to:
  /// **'An officer will look at your application within one working day. You don\'t need to do anything now.'**
  String get referBody;

  /// No description provided for @rejectBody.
  ///
  /// In en, this message translates to:
  /// **'You can ask a person to review this decision at any time.'**
  String get rejectBody;

  /// No description provided for @addProperty.
  ///
  /// In en, this message translates to:
  /// **'Add property details'**
  String get addProperty;

  /// No description provided for @viewKfs.
  ///
  /// In en, this message translates to:
  /// **'View Key Facts Statement'**
  String get viewKfs;

  /// No description provided for @grievance.
  ///
  /// In en, this message translates to:
  /// **'Ask for a review or raise a complaint'**
  String get grievance;

  /// No description provided for @officerLine.
  ///
  /// In en, this message translates to:
  /// **'Grievance Officer: {name}, {email}'**
  String officerLine(String name, String email);

  /// No description provided for @applicationNo.
  ///
  /// In en, this message translates to:
  /// **'Application {id}'**
  String applicationNo(String id);

  /// No description provided for @startOver.
  ///
  /// In en, this message translates to:
  /// **'Start a new application'**
  String get startOver;

  /// No description provided for @okScore.
  ///
  /// In en, this message translates to:
  /// **'Strong repayment history (score {score})'**
  String okScore(String score);

  /// No description provided for @okFoir.
  ///
  /// In en, this message translates to:
  /// **'EMIs use {pct} of income; our limit is {cap}'**
  String okFoir(String pct, String cap);

  /// No description provided for @okLtv.
  ///
  /// In en, this message translates to:
  /// **'Loan is {pct} of the property value; the limit is {cap}'**
  String okLtv(String pct, String cap);

  /// No description provided for @okValue.
  ///
  /// In en, this message translates to:
  /// **'Our valuation of the property: {low} to {high}'**
  String okValue(String low, String high);

  /// No description provided for @okTitle.
  ///
  /// In en, this message translates to:
  /// **'Property title and papers checked'**
  String get okTitle;

  /// No description provided for @reasonKyc01.
  ///
  /// In en, this message translates to:
  /// **'We could not confirm your identity from the photo. Please complete a short video KYC call.'**
  String get reasonKyc01;

  /// No description provided for @reasonFrd02.
  ///
  /// In en, this message translates to:
  /// **'The income on your salary slip does not match your bank credits. Please share your latest Form 16, or let us fetch it with your consent.'**
  String get reasonFrd02;

  /// No description provided for @reasonFrd03.
  ///
  /// In en, this message translates to:
  /// **'One of your documents failed verification with the issuing authority.'**
  String get reasonFrd03;

  /// No description provided for @reasonPol01.
  ///
  /// In en, this message translates to:
  /// **'Applicants must be at least 21 years old.'**
  String get reasonPol01;

  /// No description provided for @reasonPol02.
  ///
  /// In en, this message translates to:
  /// **'The loan would run past the maximum age we allow. Adding a younger co-applicant can help.'**
  String get reasonPol02;

  /// No description provided for @reasonBur01.
  ///
  /// In en, this message translates to:
  /// **'Your credit score is below our minimum of 650.'**
  String get reasonBur01;

  /// No description provided for @reasonBur04.
  ///
  /// In en, this message translates to:
  /// **'You do not have a credit history yet, so an officer will review your bank records.'**
  String get reasonBur04;

  /// No description provided for @reasonBur05.
  ///
  /// In en, this message translates to:
  /// **'Your credit score needs a closer look by an officer.'**
  String get reasonBur05;

  /// No description provided for @reasonPrp01.
  ///
  /// In en, this message translates to:
  /// **'Our lawyer needs to review the property title.'**
  String get reasonPrp01;

  /// No description provided for @reasonPrp03.
  ///
  /// In en, this message translates to:
  /// **'We need our valuer to visit the property to confirm its value.'**
  String get reasonPrp03;

  /// No description provided for @reasonPrp04.
  ///
  /// In en, this message translates to:
  /// **'The agreement value is below the government circle rate for this property. Please check the sale agreement.'**
  String get reasonPrp04;

  /// No description provided for @reasonAff01.
  ///
  /// In en, this message translates to:
  /// **'Your current EMIs already use the maximum share of income we can lend against.'**
  String get reasonAff01;

  /// No description provided for @reasonAut01.
  ///
  /// In en, this message translates to:
  /// **'Loans of this size get a final check by a senior officer.'**
  String get reasonAut01;

  /// No description provided for @reasonRsk01.
  ///
  /// In en, this message translates to:
  /// **'An officer will review your application to finalise the offer.'**
  String get reasonRsk01;

  /// No description provided for @reasonRsk02.
  ///
  /// In en, this message translates to:
  /// **'Based on your credit profile, we cannot offer this loan right now.'**
  String get reasonRsk02;

  /// No description provided for @propertyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your property'**
  String get propertyTitle;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityLabel;

  /// No description provided for @localityLabel.
  ///
  /// In en, this message translates to:
  /// **'Locality'**
  String get localityLabel;

  /// No description provided for @societyLabel.
  ///
  /// In en, this message translates to:
  /// **'Project or society (if any)'**
  String get societyLabel;

  /// No description provided for @areaLabel.
  ///
  /// In en, this message translates to:
  /// **'Area (sq ft)'**
  String get areaLabel;

  /// No description provided for @bhkLabel.
  ///
  /// In en, this message translates to:
  /// **'Bedrooms'**
  String get bhkLabel;

  /// No description provided for @newProperty.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newProperty;

  /// No description provided for @resale.
  ///
  /// In en, this message translates to:
  /// **'Resale'**
  String get resale;

  /// No description provided for @declaredPriceLabel.
  ///
  /// In en, this message translates to:
  /// **'Agreement value'**
  String get declaredPriceLabel;

  /// No description provided for @photosTitle.
  ///
  /// In en, this message translates to:
  /// **'Property photos'**
  String get photosTitle;

  /// No description provided for @photosBody.
  ///
  /// In en, this message translates to:
  /// **'Take the photos at the property. We add the place and time, so our valuer can plan the visit.'**
  String get photosBody;

  /// No description provided for @photoFront.
  ///
  /// In en, this message translates to:
  /// **'Front'**
  String get photoFront;

  /// No description provided for @photoInside.
  ///
  /// In en, this message translates to:
  /// **'Inside'**
  String get photoInside;

  /// No description provided for @photoView.
  ///
  /// In en, this message translates to:
  /// **'View from the property'**
  String get photoView;

  /// No description provided for @geoTagged.
  ///
  /// In en, this message translates to:
  /// **'Location added ({lat}, {lng})'**
  String geoTagged(String lat, String lng);

  /// No description provided for @noLocation.
  ///
  /// In en, this message translates to:
  /// **'Photo saved without a location. Turn on location for a geo-tag.'**
  String get noLocation;

  /// No description provided for @submitProperty.
  ///
  /// In en, this message translates to:
  /// **'Get final sanction'**
  String get submitProperty;

  /// No description provided for @fillAll.
  ///
  /// In en, this message translates to:
  /// **'Please fill in every field.'**
  String get fillAll;

  /// No description provided for @kfsTitle.
  ///
  /// In en, this message translates to:
  /// **'Key Facts Statement'**
  String get kfsTitle;

  /// No description provided for @kfsLoan.
  ///
  /// In en, this message translates to:
  /// **'Loan amount'**
  String get kfsLoan;

  /// No description provided for @kfsTenure.
  ///
  /// In en, this message translates to:
  /// **'Tenure'**
  String get kfsTenure;

  /// No description provided for @kfsRate.
  ///
  /// In en, this message translates to:
  /// **'Interest rate'**
  String get kfsRate;

  /// No description provided for @kfsEmi.
  ///
  /// In en, this message translates to:
  /// **'EMI'**
  String get kfsEmi;

  /// No description provided for @kfsInstalments.
  ///
  /// In en, this message translates to:
  /// **'Number of EMIs'**
  String get kfsInstalments;

  /// No description provided for @kfsFee.
  ///
  /// In en, this message translates to:
  /// **'Processing fee (with GST)'**
  String get kfsFee;

  /// No description provided for @kfsTotalInterest.
  ///
  /// In en, this message translates to:
  /// **'Total interest'**
  String get kfsTotalInterest;

  /// No description provided for @kfsTotalPayable.
  ///
  /// In en, this message translates to:
  /// **'Total amount payable'**
  String get kfsTotalPayable;

  /// No description provided for @kfsApr.
  ///
  /// In en, this message translates to:
  /// **'Annual Percentage Rate (APR)'**
  String get kfsApr;

  /// No description provided for @kfsCoolingOff.
  ///
  /// In en, this message translates to:
  /// **'Cooling-off period: you can exit within 3 days of signing by paying back only the principal and interest for those days, with no penalty.'**
  String get kfsCoolingOff;

  /// No description provided for @kfsNote.
  ///
  /// In en, this message translates to:
  /// **'Sample figures for the demo. Your real KFS comes with your sanction letter.'**
  String get kfsNote;

  /// No description provided for @useSample.
  ///
  /// In en, this message translates to:
  /// **'Sample'**
  String get useSample;

  /// No description provided for @videoKycDemo.
  ///
  /// In en, this message translates to:
  /// **'Demo: this would book a video KYC call with an officer.'**
  String get videoKycDemo;

  /// No description provided for @raiseComplaint.
  ///
  /// In en, this message translates to:
  /// **'Raise a complaint'**
  String get raiseComplaint;

  /// No description provided for @complaintSent.
  ///
  /// In en, this message translates to:
  /// **'Your complaint is registered. Reference {ref}.'**
  String complaintSent(String ref);

  /// No description provided for @stageSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get stageSignIn;

  /// No description provided for @stageDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get stageDetails;

  /// No description provided for @stageKyc.
  ///
  /// In en, this message translates to:
  /// **'KYC'**
  String get stageKyc;

  /// No description provided for @stageOffer.
  ///
  /// In en, this message translates to:
  /// **'Offer'**
  String get stageOffer;

  /// No description provided for @stageProperty.
  ///
  /// In en, this message translates to:
  /// **'Property'**
  String get stageProperty;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Home Loan · Loan Against Property'**
  String get homeSubtitle;

  /// No description provided for @heroPill.
  ///
  /// In en, this message translates to:
  /// **'DECISION IN MINUTES'**
  String get heroPill;

  /// No description provided for @heroFacts.
  ///
  /// In en, this message translates to:
  /// **'From {rate}% a year · up to {years} years'**
  String heroFacts(String rate, String years);

  /// No description provided for @resumeBody.
  ///
  /// In en, this message translates to:
  /// **'{pct}% done · pick up where you left off'**
  String resumeBody(String pct);

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @calculators.
  ///
  /// In en, this message translates to:
  /// **'Calculators'**
  String get calculators;

  /// No description provided for @calcEmi.
  ///
  /// In en, this message translates to:
  /// **'EMI'**
  String get calcEmi;

  /// No description provided for @calcEmiSub.
  ///
  /// In en, this message translates to:
  /// **'Monthly payment'**
  String get calcEmiSub;

  /// No description provided for @calcEligibility.
  ///
  /// In en, this message translates to:
  /// **'Eligibility'**
  String get calcEligibility;

  /// No description provided for @calcEligibilitySub.
  ///
  /// In en, this message translates to:
  /// **'How much you can get'**
  String get calcEligibilitySub;

  /// No description provided for @emiCalcTitle.
  ///
  /// In en, this message translates to:
  /// **'EMI calculator'**
  String get emiCalcTitle;

  /// No description provided for @eligibilityCalcTitle.
  ///
  /// In en, this message translates to:
  /// **'Eligibility calculator'**
  String get eligibilityCalcTitle;

  /// No description provided for @totalInterest.
  ///
  /// In en, this message translates to:
  /// **'Total interest {amount}'**
  String totalInterest(String amount);

  /// No description provided for @calcIncomeOnly.
  ///
  /// In en, this message translates to:
  /// **'Based on income only. The property\'s value can lower it.'**
  String get calcIncomeOnly;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @yourLoan.
  ///
  /// In en, this message translates to:
  /// **'Your loan'**
  String get yourLoan;

  /// No description provided for @docsProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} verified'**
  String docsProgress(String done, String total);

  /// No description provided for @docNeeded.
  ///
  /// In en, this message translates to:
  /// **'Needed'**
  String get docNeeded;

  /// No description provided for @docTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get docTryAgain;

  /// No description provided for @fetched.
  ///
  /// In en, this message translates to:
  /// **'Fetched'**
  String get fetched;

  /// No description provided for @statusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// No description provided for @statusSanctioned.
  ///
  /// In en, this message translates to:
  /// **'Sanctioned'**
  String get statusSanctioned;

  /// No description provided for @statusInReview.
  ///
  /// In en, this message translates to:
  /// **'In review'**
  String get statusInReview;

  /// No description provided for @statusDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get statusDeclined;

  /// No description provided for @trackTitle.
  ///
  /// In en, this message translates to:
  /// **'Track your application'**
  String get trackTitle;

  /// No description provided for @tlSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Application submitted'**
  String get tlSubmitted;

  /// No description provided for @tlVerified.
  ///
  /// In en, this message translates to:
  /// **'KYC and documents verified'**
  String get tlVerified;

  /// No description provided for @tlInPrinciple.
  ///
  /// In en, this message translates to:
  /// **'In-principle approval'**
  String get tlInPrinciple;

  /// No description provided for @tlProperty.
  ///
  /// In en, this message translates to:
  /// **'Property details and valuation'**
  String get tlProperty;

  /// No description provided for @tlPropertyNext.
  ///
  /// In en, this message translates to:
  /// **'Add your property\'s details and photos'**
  String get tlPropertyNext;

  /// No description provided for @tlOfficer.
  ///
  /// In en, this message translates to:
  /// **'Officer review'**
  String get tlOfficer;

  /// No description provided for @tlOfficerNext.
  ///
  /// In en, this message translates to:
  /// **'Within one working day'**
  String get tlOfficerNext;

  /// No description provided for @tlLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal and title check'**
  String get tlLegal;

  /// No description provided for @tlSanction.
  ///
  /// In en, this message translates to:
  /// **'Final sanction and eSign'**
  String get tlSanction;

  /// No description provided for @tlSanctionNext.
  ///
  /// In en, this message translates to:
  /// **'Sign your sanction letter online'**
  String get tlSanctionNext;

  /// No description provided for @tlDisbursement.
  ///
  /// In en, this message translates to:
  /// **'Disbursement'**
  String get tlDisbursement;

  /// No description provided for @helpTitle.
  ///
  /// In en, this message translates to:
  /// **'Need help?'**
  String get helpTitle;

  /// No description provided for @propertyType.
  ///
  /// In en, this message translates to:
  /// **'New or resale'**
  String get propertyType;

  /// No description provided for @greetMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetMorning;

  /// No description provided for @greetAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetAfternoon;

  /// No description provided for @greetEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetEvening;

  /// No description provided for @nearlyThere.
  ///
  /// In en, this message translates to:
  /// **'{name}, you\'re nearly there'**
  String nearlyThere(String name);

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @languageNote.
  ///
  /// In en, this message translates to:
  /// **'You can change this at any time.'**
  String get languageNote;

  /// No description provided for @liveChecks.
  ///
  /// In en, this message translates to:
  /// **'Live checks'**
  String get liveChecks;

  /// No description provided for @checkBureau.
  ///
  /// In en, this message translates to:
  /// **'Credit bureau'**
  String get checkBureau;

  /// No description provided for @checkScore.
  ///
  /// In en, this message translates to:
  /// **'Score {score}'**
  String checkScore(String score);

  /// No description provided for @checkNoHistory.
  ///
  /// In en, this message translates to:
  /// **'No history yet'**
  String get checkNoHistory;

  /// No description provided for @checkBank.
  ///
  /// In en, this message translates to:
  /// **'Bank via AA'**
  String get checkBank;

  /// No description provided for @checkBankRead.
  ///
  /// In en, this message translates to:
  /// **'12 months read'**
  String get checkBankRead;

  /// No description provided for @checkKyc.
  ///
  /// In en, this message translates to:
  /// **'eKYC and selfie'**
  String get checkKyc;

  /// No description provided for @checkPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get checkPending;

  /// No description provided for @checkDocs.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get checkDocs;

  /// No description provided for @countOf.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total}'**
  String countOf(String done, String total);

  /// No description provided for @minutesLeft.
  ///
  /// In en, this message translates to:
  /// **'about {n} min left'**
  String minutesLeft(String n);

  /// No description provided for @ratePa.
  ///
  /// In en, this message translates to:
  /// **'{rate}% p.a.'**
  String ratePa(String rate);

  /// No description provided for @continueApplication.
  ///
  /// In en, this message translates to:
  /// **'Continue your application'**
  String get continueApplication;

  /// No description provided for @shapeOffer.
  ///
  /// In en, this message translates to:
  /// **'Shape your offer'**
  String get shapeOffer;

  /// No description provided for @shapeOfferSub.
  ///
  /// In en, this message translates to:
  /// **'Approved in principle · drag to adjust'**
  String get shapeOfferSub;

  /// No description provided for @withinLimits.
  ///
  /// In en, this message translates to:
  /// **'Within your limits'**
  String get withinLimits;

  /// No description provided for @aboveLimits.
  ///
  /// In en, this message translates to:
  /// **'Above a limit: lower the amount or add years'**
  String get aboveLimits;

  /// No description provided for @mostYouCan.
  ///
  /// In en, this message translates to:
  /// **'Most you can borrow: {amount}'**
  String mostYouCan(String amount);

  /// No description provided for @useMax.
  ///
  /// In en, this message translates to:
  /// **'Use max'**
  String get useMax;

  /// No description provided for @principal.
  ///
  /// In en, this message translates to:
  /// **'Principal'**
  String get principal;

  /// No description provided for @interest.
  ///
  /// In en, this message translates to:
  /// **'Interest'**
  String get interest;

  /// No description provided for @totalRepaid.
  ///
  /// In en, this message translates to:
  /// **'Total repaid'**
  String get totalRepaid;

  /// No description provided for @emiShareIncome.
  ///
  /// In en, this message translates to:
  /// **'EMIs as share of income'**
  String get emiShareIncome;

  /// No description provided for @loanShareProperty.
  ///
  /// In en, this message translates to:
  /// **'Loan as share of the {value} property'**
  String loanShareProperty(String value);

  /// No description provided for @lockOffer.
  ///
  /// In en, this message translates to:
  /// **'Lock this offer'**
  String get lockOffer;

  /// No description provided for @offerLocked.
  ///
  /// In en, this message translates to:
  /// **'Your offer is locked.'**
  String get offerLocked;

  /// No description provided for @approvedUpTo.
  ///
  /// In en, this message translates to:
  /// **'Approved up to {amount}'**
  String approvedUpTo(String amount);

  /// No description provided for @readingDoc.
  ///
  /// In en, this message translates to:
  /// **'Reading your {doc}'**
  String readingDoc(String doc);

  /// No description provided for @documentAi.
  ///
  /// In en, this message translates to:
  /// **'Document AI'**
  String get documentAi;

  /// No description provided for @sure.
  ///
  /// In en, this message translates to:
  /// **'{pct}% sure'**
  String sure(String pct);

  /// No description provided for @readMatches.
  ///
  /// In en, this message translates to:
  /// **'It\'s the document we asked for'**
  String get readMatches;

  /// No description provided for @readClear.
  ///
  /// In en, this message translates to:
  /// **'Clear photo, no blur or glare'**
  String get readClear;

  /// No description provided for @whatWeRead.
  ///
  /// In en, this message translates to:
  /// **'What we read'**
  String get whatWeRead;

  /// No description provided for @looksRight.
  ///
  /// In en, this message translates to:
  /// **'Looks right'**
  String get looksRight;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fieldName;

  /// No description provided for @fieldPan.
  ///
  /// In en, this message translates to:
  /// **'PAN'**
  String get fieldPan;

  /// No description provided for @fieldAadhaar.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar'**
  String get fieldAadhaar;

  /// No description provided for @fieldEmployer.
  ///
  /// In en, this message translates to:
  /// **'Employer'**
  String get fieldEmployer;

  /// No description provided for @fieldNetPay.
  ///
  /// In en, this message translates to:
  /// **'Net pay'**
  String get fieldNetPay;

  /// No description provided for @fieldPeriod.
  ///
  /// In en, this message translates to:
  /// **'Pay period'**
  String get fieldPeriod;

  /// No description provided for @fieldYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get fieldYear;

  /// No description provided for @fieldIncome.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get fieldIncome;

  /// No description provided for @fieldBusiness.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get fieldBusiness;

  /// No description provided for @fieldGstin.
  ///
  /// In en, this message translates to:
  /// **'GSTIN'**
  String get fieldGstin;

  /// No description provided for @consentSectionRequired.
  ///
  /// In en, this message translates to:
  /// **'Needed for your loan'**
  String get consentSectionRequired;

  /// No description provided for @consentSectionOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional: off unless you turn them on'**
  String get consentSectionOptional;

  /// No description provided for @advancedOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get advancedOptions;

  /// No description provided for @consentValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Given {given} · valid until {until}'**
  String consentValidUntil(String given, String until);

  /// No description provided for @consentUntilWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Given {given} · until you withdraw it'**
  String consentUntilWithdrawn(String given);

  /// No description provided for @recheckTitle.
  ///
  /// In en, this message translates to:
  /// **'One more check just before payout'**
  String get recheckTitle;

  /// No description provided for @recheckBody.
  ///
  /// In en, this message translates to:
  /// **'We look at your credit report again just before paying out. If you say no, an officer may ask you then.'**
  String get recheckBody;

  /// No description provided for @aaMonthsLabel.
  ///
  /// In en, this message translates to:
  /// **'Months of statements to share'**
  String get aaMonthsLabel;

  /// No description provided for @monthsN.
  ///
  /// In en, this message translates to:
  /// **'{n} months'**
  String monthsN(String n);

  /// No description provided for @aaAccountsLabel.
  ///
  /// In en, this message translates to:
  /// **'Accounts to share'**
  String get aaAccountsLabel;

  /// No description provided for @accountSavingsSalary.
  ///
  /// In en, this message translates to:
  /// **'Savings ·· 0912 · salary credits'**
  String get accountSavingsSalary;

  /// No description provided for @accountSavings.
  ///
  /// In en, this message translates to:
  /// **'Savings ·· 4821'**
  String get accountSavings;

  /// No description provided for @accountFd.
  ///
  /// In en, this message translates to:
  /// **'Fixed deposit ·· 3307'**
  String get accountFd;

  /// No description provided for @aaAccountNeeded.
  ///
  /// In en, this message translates to:
  /// **'Pick at least one account to share.'**
  String get aaAccountNeeded;

  /// No description provided for @kycMethodLabel.
  ///
  /// In en, this message translates to:
  /// **'How to confirm your identity'**
  String get kycMethodLabel;

  /// No description provided for @kycAadhaarOtp.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar OTP'**
  String get kycAadhaarOtp;

  /// No description provided for @kycDigilocker.
  ///
  /// In en, this message translates to:
  /// **'DigiLocker'**
  String get kycDigilocker;

  /// No description provided for @kycVideo.
  ///
  /// In en, this message translates to:
  /// **'Video KYC call'**
  String get kycVideo;

  /// No description provided for @useCkycTitle.
  ///
  /// In en, this message translates to:
  /// **'Use my existing CKYC record'**
  String get useCkycTitle;

  /// No description provided for @useCkycBody.
  ///
  /// In en, this message translates to:
  /// **'If you\'ve done KYC with another bank or fund, we fetch that record instead of asking again.'**
  String get useCkycBody;

  /// No description provided for @optOffersTitle.
  ///
  /// In en, this message translates to:
  /// **'Offers and new products'**
  String get optOffersTitle;

  /// No description provided for @optOffersBody.
  ///
  /// In en, this message translates to:
  /// **'Choose how you\'d like to hear about offers. You can turn these off at any time.'**
  String get optOffersBody;

  /// No description provided for @channelSms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get channelSms;

  /// No description provided for @channelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get channelEmail;

  /// No description provided for @channelWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get channelWhatsapp;

  /// No description provided for @optUpdatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Loan updates on WhatsApp'**
  String get optUpdatesTitle;

  /// No description provided for @optUpdatesBody.
  ///
  /// In en, this message translates to:
  /// **'Status updates and EMI reminders on WhatsApp, as well as SMS.'**
  String get optUpdatesBody;

  /// No description provided for @optInsuranceTitle.
  ///
  /// In en, this message translates to:
  /// **'Home-loan protection quote'**
  String get optInsuranceTitle;

  /// No description provided for @optInsuranceBody.
  ///
  /// In en, this message translates to:
  /// **'Share your name, age and loan amount with our insurance partner for a quote. You never have to buy.'**
  String get optInsuranceBody;

  /// No description provided for @getQuote.
  ///
  /// In en, this message translates to:
  /// **'Get a quote'**
  String get getQuote;

  /// No description provided for @manageConsents.
  ///
  /// In en, this message translates to:
  /// **'Manage consents'**
  String get manageConsents;

  /// No description provided for @manageConsentsBody.
  ///
  /// In en, this message translates to:
  /// **'Turn optional consents off at any time. Withdrawing a needed one stops your application, and we delete what we fetched for it.'**
  String get manageConsentsBody;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @consentHistory.
  ///
  /// In en, this message translates to:
  /// **'Consent history'**
  String get consentHistory;

  /// No description provided for @historyGiven.
  ///
  /// In en, this message translates to:
  /// **'{item} given'**
  String historyGiven(String item);

  /// No description provided for @historyWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'{item} withdrawn'**
  String historyWithdrawn(String item);

  /// No description provided for @historyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing yet.'**
  String get historyEmpty;

  /// No description provided for @consentOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get consentOn;

  /// No description provided for @consentOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get consentOff;

  /// No description provided for @withdrawnRequired.
  ///
  /// In en, this message translates to:
  /// **'You withdrew a consent we need, so your application is paused.'**
  String get withdrawnRequired;

  /// No description provided for @checkMatchPending.
  ///
  /// In en, this message translates to:
  /// **'Photo match: done when you upload your Aadhaar or PAN card'**
  String get checkMatchPending;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'as',
    'bn',
    'brx',
    'doi',
    'en',
    'gu',
    'hi',
    'kn',
    'kok',
    'ks',
    'mai',
    'ml',
    'mni',
    'mr',
    'ne',
    'or',
    'pa',
    'sa',
    'sat',
    'sd',
    'ta',
    'te',
    'ur',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'as':
      return AppLocalizationsAs();
    case 'bn':
      return AppLocalizationsBn();
    case 'brx':
      return AppLocalizationsBrx();
    case 'doi':
      return AppLocalizationsDoi();
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'kok':
      return AppLocalizationsKok();
    case 'ks':
      return AppLocalizationsKs();
    case 'mai':
      return AppLocalizationsMai();
    case 'ml':
      return AppLocalizationsMl();
    case 'mni':
      return AppLocalizationsMni();
    case 'mr':
      return AppLocalizationsMr();
    case 'ne':
      return AppLocalizationsNe();
    case 'or':
      return AppLocalizationsOr();
    case 'pa':
      return AppLocalizationsPa();
    case 'sa':
      return AppLocalizationsSa();
    case 'sat':
      return AppLocalizationsSat();
    case 'sd':
      return AppLocalizationsSd();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
