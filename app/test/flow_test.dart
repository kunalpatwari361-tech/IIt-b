// Taps through the whole app for the report's three demo customers, using the sample engine.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nirnay_app/main.dart';
import 'package:nirnay_app/services/mock_api.dart';
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
    expect(find.textContaining('Recognised'), findsWidgets);
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

  testWidgets('the app switches to Hindi', (tester) async {
    await tester.pumpWidget(NirnayApp(api: MockNirnayApi(delay: Duration.zero)));
    await tester.pumpAndSettle();
    expect(find.text('Your home loan decision in minutes'), findsOneWidget);
    await tester.tap(find.text('हिं'));
    await tester.pumpAndSettle();
    expect(find.text('होम लोन पर फ़ैसला, कुछ ही मिनटों में'), findsOneWidget);
    expect(find.text('आवेदन शुरू करें'), findsOneWidget);
  });
}
