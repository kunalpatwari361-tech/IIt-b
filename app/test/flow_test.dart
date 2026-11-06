// Taps through the whole app for the report's three demo customers, using the sample engine.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nirnay_app/main.dart';
import 'package:nirnay_app/services/mock_api.dart';
import 'package:nirnay_app/state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> tapKey(WidgetTester tester, String key) async {
  await tester.ensureVisible(find.byKey(Key(key)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(key)));
  await tester.pumpAndSettle();
}

/// For taps that start real background work behind a spinner: wait until the spinner is gone.
Future<void> tapAndWait(WidgetTester tester, String key) async {
  await tester.ensureVisible(find.byKey(Key(key)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(key)));
  await tester.pump();
  for (var i = 0; i < 40 && find.byType(CircularProgressIndicator).evaluate().isNotEmpty; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
    await tester.pump();
  }
  await tester.pumpAndSettle();
}

Future<void> settle(WidgetTester tester) async {
  // Lets real work finish (the photo checks run in a background isolate), then redraws.
  await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 400)));
  await tester.pumpAndSettle();
}

/// From the welcome screen to the in-principle decision.
Future<void> applyAs(WidgetTester tester, String phone) async {
  await tester.pumpWidget(NirnayApp(api: MockNirnayApi(delay: Duration.zero)));
  await tester.pumpAndSettle();
  await tapKey(tester, 'persona-$phone');
  await tapKey(tester, 'primary'); // send OTP
  await tester.enterText(find.byKey(const Key('otp')), '123456');
  await tapKey(tester, 'primary'); // verify
  await settle(tester);
  for (final k in ['bureau', 'aa', 'kyc', 'privacy']) {
    await tapKey(tester, 'consent-$k');
  }
  await tapKey(tester, 'primary');
  await tapKey(tester, 'primary'); // fetch details
  await settle(tester);
  expect(find.byKey(const Key('eligibility')), findsOneWidget);
  await tapKey(tester, 'primary'); // continue
  await tapKey(tester, 'sample-selfie');
  await settle(tester);
  await tapKey(tester, 'primary'); // continue
  final slots = phone == '9876500002' ? ['pan', 'aadhaar', 'itr', 'gst'] : ['pan', 'aadhaar', 'salarySlip', 'form16'];
  for (final s in slots) {
    await tapAndWait(tester, 'sample-$s');
    expect(find.textContaining('Recognised'), findsWidgets); // the document AI view
    expect(find.text('What we read'), findsOneWidget);
    await tapKey(tester, 'looks-right');
  }
  await tapAndWait(tester, 'primary'); // get the in-principle offer
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Ravi is approved in principle, then sanctioned', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await applyAs(tester, '9876500001');
    expect(find.byKey(const Key('decision-approve')), findsOneWidget);
    expect(find.text('₹45,00,000'), findsOneWidget);
    expect(find.textContaining('₹39,767'), findsOneWidget);
    expect(find.text('EMIs use 49.8% of income; our limit is 50%'), findsOneWidget);
    expect(find.text('Loan is 75% of the property value; the limit is 80%'), findsOneWidget);
    expect(find.text('Track your application'), findsOneWidget);
    expect(find.text("Add your property's details and photos"), findsOneWidget);
    await tapKey(tester, 'kfs');
    expect(find.text('Key Facts Statement'), findsOneWidget);
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();
    await tapKey(tester, 'primary'); // add property details
    await tapKey(tester, 'primary'); // final sanction
    await settle(tester);
    expect(find.text('Loan sanctioned'), findsOneWidget);
    expect(find.text('Property title and papers checked'), findsOneWidget);
  });

  testWidgets('Meena is approved in principle, then referred for the title', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await applyAs(tester, '9876500002');
    expect(find.byKey(const Key('decision-approve')), findsOneWidget);
    await tapKey(tester, 'primary');
    await tapKey(tester, 'primary');
    await settle(tester);
    expect(find.byKey(const Key('decision-refer')), findsOneWidget);
    expect(find.text('Our lawyer needs to review the property title.'), findsOneWidget);
  });

  testWidgets('Arjun is rejected with the reason, and can ask for a review', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await applyAs(tester, '9876500003');
    expect(find.byKey(const Key('decision-reject')), findsOneWidget);
    expect(find.text('One of your documents failed verification with the issuing authority.'), findsOneWidget);
    expect(find.text('Ask for a review or raise a complaint'), findsOneWidget);
  });

  testWidgets('the EMI calculator on Home works out the monthly payment', (tester) async {
    await tester.pumpWidget(NirnayApp(api: MockNirnayApi(delay: Duration.zero)));
    await tester.pumpAndSettle();
    await tapKey(tester, 'calc-emi');
    expect(find.text('EMI calculator'), findsOneWidget);
    expect(find.text('₹39,767'), findsOneWidget); // Rs 45 lakh over 20 years at 8.75%
  });

  testWidgets('a signed-in customer who goes back Home can resume', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(NirnayApp(api: MockNirnayApi(delay: Duration.zero)));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('resume-card')), findsNothing);
    await tapKey(tester, 'persona-9876500001');
    await tapKey(tester, 'primary'); // send OTP
    await tester.enterText(find.byKey(const Key('otp')), '123456');
    await tapKey(tester, 'primary'); // verify
    await settle(tester);
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('resume-card')), findsOneWidget);
    await tapKey(tester, 'resume');
    expect(find.text('Your consent'), findsOneWidget);
  });

  testWidgets('Ravi shapes a smaller offer, and the final sanction uses it', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await applyAs(tester, '9876500001');
    await tapKey(tester, 'shape-offer');
    expect(find.text('Within your limits'), findsOneWidget);
    expect(find.text('Most you can borrow: ₹45 lakh'), findsOneWidget);
    final slider = find.byKey(const Key('offer-amount-slider'));
    await tester.drag(slider, const Offset(-120, 0));
    await tester.pumpAndSettle();
    await tapKey(tester, 'primary'); // lock this offer
    expect(find.text('Approved up to ₹45,00,000'), findsOneWidget);
    expect(find.textContaining('₹39,767'), findsNothing); // the EMI follows the smaller loan
  });

  testWidgets('every language can be picked from the welcome screen', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(NirnayApp(api: MockNirnayApi(delay: Duration.zero)));
    await tester.pumpAndSettle();
    for (final code in ['en', 'hi', 'bn', 'mr', 'te', 'ta', 'gu', 'ur', 'kn', 'or', 'ml', 'pa', 'as', 'mai', 'sat', 'ks', 'ne', 'kok', 'sd', 'doi', 'mni', 'brx', 'sa']) {
      await tapKey(tester, 'lang-$code');
      expect(tester.takeException(), isNull, reason: code);
      expect(find.byKey(const Key('start')), findsOneWidget, reason: code);
    }
    await tapKey(tester, 'lang-ur');
    expect(Directionality.of(tester.element(find.byKey(const Key('start')))), TextDirection.rtl);
    await tapKey(tester, 'lang-ks');
    expect(Directionality.of(tester.element(find.byKey(const Key('start')))), TextDirection.rtl);
  });

  testWidgets('the customer picks consent options, and sees them in the history', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(NirnayApp(api: MockNirnayApi(delay: Duration.zero)));
    await tester.pumpAndSettle();
    await tapKey(tester, 'persona-9876500001');
    await tapKey(tester, 'primary'); // send OTP
    await tester.enterText(find.byKey(const Key('otp')), '123456');
    await tapKey(tester, 'primary'); // verify
    await settle(tester);
    final state = Provider.of<AppState>(tester.element(find.text('Your consent').first), listen: false);

    await tapKey(tester, 'consent-bureau');
    expect(find.textContaining('valid until'), findsOneWidget);
    await tapKey(tester, 'options-bureau');
    await tapKey(tester, 'recheck');
    await tapKey(tester, 'options-aa');
    await tapKey(tester, 'aa-months-24');
    await tapKey(tester, 'aa-acc-salary'); // untick the only account
    for (final k in ['aa', 'kyc', 'privacy']) {
      await tapKey(tester, 'consent-$k');
    }
    await tapKey(tester, 'primary');
    expect(find.text('Pick at least one account to share.'), findsWidgets);
    await tapKey(tester, 'aa-acc-savings');
    await tapKey(tester, 'options-kyc');
    await tapKey(tester, 'kyc-digilocker');
    await tapKey(tester, 'ckyc');
    await tapKey(tester, 'opt-offersWhatsapp');

    await tapKey(tester, 'manage-consents');
    expect(find.text('Consent history'), findsWidgets);
    expect(find.text('Offers and new products · WhatsApp given'), findsOneWidget);
    await tester.tapAt(const Offset(20, 20)); // close the sheet
    await tester.pumpAndSettle();
    await tapKey(tester, 'primary');
    expect(find.text('Your details'), findsWidgets);

    expect(state.aaMonths, 24);
    expect(state.aaAccounts, {'salary': false, 'savings': true, 'fd': false});
    expect(state.kycMethod, 'digilocker');
    expect(state.useCkyc, isTrue);
    expect(state.recheckBeforePayout, isTrue);
    expect(state.optional['offersWhatsapp'], isTrue);
    expect(state.optional['offersSms'], isFalse); // optional ones stay off unless turned on
  });

  testWidgets('withdrawing a needed consent later stops the application', (tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.reset);
    await applyAs(tester, '9876500001');
    final state = Provider.of<AppState>(tester.element(find.byKey(const Key('decision-approve'))), listen: false);
    await tapKey(tester, 'manage-consents');
    await tapKey(tester, 'withdraw-bureau');
    await tapKey(tester, 'confirm-withdraw');
    expect(find.text('Your consent'), findsWidgets);
    expect(find.text('You withdrew a consent we need, so your application is paused.'), findsOneWidget);
    expect(state.consents['bureau'], isFalse);
    expect(state.profile, isNull);
    expect(state.inPrinciple, isNull);
  });

  testWidgets('the app switches to Hindi', (tester) async {
    await tester.pumpWidget(NirnayApp(api: MockNirnayApi(delay: Duration.zero)));
    await tester.pumpAndSettle();
    expect(find.text('Your home loan decision in minutes'), findsOneWidget);
    await tapKey(tester, 'lang-hi');
    expect(find.text('होम लोन पर फ़ैसला, कुछ ही मिनटों में'), findsOneWidget);
    expect(find.text('आवेदन शुरू करें'), findsOneWidget);
  });
}
