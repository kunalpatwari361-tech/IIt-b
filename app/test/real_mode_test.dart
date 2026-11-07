// Real mode only. Run with: flutter test test/real_mode_test.dart --dart-define=NIRNAY_REAL=true
// In a normal `flutter test` run these tests skip themselves (the build has no real-mode flag).
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nirnay_app/config.dart';
import 'package:nirnay_app/main.dart';
import 'package:nirnay_app/services/api.dart';
import 'package:nirnay_app/services/models.dart';
import 'package:nirnay_app/state.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Answers like the engine in real mode and keeps what the app sent.
class FakeRealEngine implements NirnayApi {
  Declaration? declared;
  String? pan;
  int codesSent = 0;

  @override
  Future<String?> sendOtp(String phone) async {
    codesSent++;
    return 'console'; // a test server that prints the code instead of texting it
  }

  @override
  Future<Session> verifyOtp(String phone, String otp, String deviceId) async =>
      Session(token: 't', deviceId: deviceId, applicationId: 'HL-2611-10001');

  @override
  Future<void> recordConsents(Session session, ConsentRecord consent) async {}

  @override
  Future<Profile> fetchProfile(Session session, String pan, {Declaration? declared}) async {
    this.pan = pan;
    this.declared = declared;
    return Profile(
      name: declared!.name,
      dateOfBirth: declared.dateOfBirth,
      panMasked: '${pan.substring(0, 2)}XXX${pan.substring(5, 9)}X',
      aadhaarMasked: '',
      address: declared.address ?? '',
      employment: declared.employment,
      employer: declared.employer,
      monthlyIncome: declared.monthlyIncome,
      existingEmi: declared.existingEmi,
      bureauScore: declared.creditScore,
      requiredDocuments: [DocSlot.pan, DocSlot.aadhaar, DocSlot.salarySlip, DocSlot.form16, DocSlot.bankStatement],
      selfDeclared: true,
    );
  }

  @override
  Future<SelfieResult> checkSelfie(Session session, Uint8List jpeg) => throw UnimplementedError();
  @override
  Future<DocResult> uploadDocument(Session session, DocSlot slot, Uint8List bytes, String fileName) => throw UnimplementedError();
  @override
  Future<Decision> inPrinciple(Session session, LoanRequest request) => throw UnimplementedError();
  @override
  Future<Decision> finalSanction(Session session, LoanRequest request, PropertyInput property) => throw UnimplementedError();
  @override
  Future<Uint8List?> sample(Session session, String kind) async => null;
  @override
  Future<DecisionLetter> decisionLetter(Session session, String lang) => throw UnimplementedError();
  @override
  Future<AssistantAnswer> ask(Session session, String question, String lang) => throw UnimplementedError();
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('no demo people, demo code or demo banner', (tester) async {
    await tester.pumpWidget(NirnayApp(api: FakeRealEngine()));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('persona-9876500001')), findsNothing);
    expect(find.textContaining('Demo mode'), findsNothing);
    expect(find.textContaining('Ravi'), findsNothing);
  }, skip: !realMode);

  testWidgets('a test server prints the code: the app says where it is, and a new code can be sent', (tester) async {
    final engine = FakeRealEngine();
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(NirnayApp(api: engine));
    await tester.pumpAndSettle();
    tester.state<NavigatorState>(find.byType(Navigator).first).pushNamed('/sign-in');
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('phone')), '9302100000');
    await tester.tap(find.byKey(const Key('primary')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('otp-on-server')), findsOneWidget);
    expect(find.textContaining('server window'), findsOneWidget);
    expect(find.textContaining('We sent a 6-digit code'), findsNothing);
    await tester.tap(find.byKey(const Key('resend-otp')));
    await tester.pumpAndSettle();
    expect(engine.codesSent, 2);
    expect(find.text('New code sent.'), findsOneWidget);
  }, skip: !realMode);

  testWidgets('the customer types their own details, and they go to the engine', (tester) async {
    final engine = FakeRealEngine();
    tester.view.physicalSize = const Size(1080, 2400); // a phone, so the date picker fits
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);
    final state = AppState(engine)..session = Session(token: 't', deviceId: 'd', applicationId: 'HL-2611-10001');
    await tester.pumpWidget(NirnayApp(api: engine, state: state));
    await tester.pumpAndSettle();
    final nav = tester.state<NavigatorState>(find.byType(Navigator).first);
    nav.pushNamed('/details');
    await tester.pumpAndSettle();
    expect(find.text('ABCPK1234F'), findsNothing); // no demo PAN
    Future<void> type(String key, String text) async {
      await tester.ensureVisible(find.byKey(Key(key)));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(Key(key)), text);
      await tester.pumpAndSettle();
    }

    await type('pan', 'AKVPR4821K');
    await type('decl-name', 'Kavya Rao');
    await tester.tap(find.byKey(const Key('primary')));
    await tester.pumpAndSettle();
    expect(find.textContaining('Please fill in'), findsOneWidget); // no date of birth yet
    await tester.ensureVisible(find.byKey(const Key('decl-dob')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('decl-dob')));
    await tester.pumpAndSettle();
    // Flutter's own date picker: press its OK (keeps the initial date, 30 years ago).
    tester.widget<TextButton>(find.widgetWithText(TextButton, 'OK')).onPressed!();
    await tester.pumpAndSettle();
    await type('decl-employer', 'Lotus Analytics Pvt Ltd');
    await type('decl-income', '95000');
    await type('decl-emi', '8000');
    await type('decl-score', '772');
    await tester.pump(const Duration(seconds: 5)); // let the earlier "Please fill in" message go away
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('primary')));
    await tester.pumpAndSettle();
    final d = engine.declared!;
    expect(engine.pan, 'AKVPR4821K');
    expect((d.name, d.employer, d.monthlyIncome, d.existingEmi, d.creditScore), ('Kavya Rao', 'Lotus Analytics Pvt Ltd', 95000.0, 8000.0, 772));
    expect(d.toJson()['employment'], 'salaried');
    expect(find.textContaining('You entered these details'), findsOneWidget);
    expect(find.text('Verified'), findsNothing); // self-declared income isn't shown as verified
    expect(state.requiredDocs, contains(DocSlot.bankStatement));
  }, skip: !realMode);
}
