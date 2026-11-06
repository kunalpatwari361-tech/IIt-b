import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nirnay_app/policy.dart';
import 'package:nirnay_app/services/api.dart';
import 'package:nirnay_app/services/http_api.dart';
import 'package:nirnay_app/services/models.dart';

// The JSON the FastAPI engine sends (backend/app.py), checked against the app's models.
void main() {
  final session = Session(token: 'tok', deviceId: 'dev1', applicationId: 'HL-2611-12345');
  final seen = <http.BaseRequest>[];
  final bodies = <String>[];

  HttpNirnayApi api(Map<String, (int, Object?)> routes) => HttpNirnayApi('http://engine.test',
          client: MockClient((req) async {
        seen.add(req);
        bodies.add(req.body);
        final hit = routes['${req.method} ${req.url.path}'];
        if (hit == null) return http.Response(jsonEncode({'error': 'not_found'}), 404);
        return http.Response(hit.$2 == null ? '' : jsonEncode(hit.$2), hit.$1, headers: {'content-type': 'application/json'});
      }));

  setUp(() {
    seen.clear();
    bodies.clear();
  });

  test('sign-in, consent and profile', () async {
    final a = api({
      'POST /v1/otp/send': (204, null),
      'POST /v1/otp/verify': (200, {'token': 'tok', 'deviceId': 'dev1', 'applicationId': 'HL-2611-12345'}),
      'PUT /v1/applications/HL-2611-12345/consents': (200, {'given': {}}),
      'POST /v1/applications/HL-2611-12345/profile': (200, {
        'name': 'Ravi Kumar', 'dateOfBirth': '1994-03-14', 'panMasked': 'ABXXX1234X', 'aadhaarMasked': 'XXXX XXXX 2336',
        'address': 'Pune', 'employment': 'salaried', 'employer': 'Nimbus', 'monthlyIncome': 100000.0,
        'existingEmi': 10000, 'bureauScore': 765,
      }),
    });
    await a.sendOtp('9876500001');
    final s = await a.verifyOtp('9876500001', '123456', 'dev1');
    expect(s.applicationId, 'HL-2611-12345');
    await a.recordConsents(s, ConsentRecord(given: {'bureau': true}, options: {'aaMonths': 12}, optional: {}));
    final p = await a.fetchProfile(s, 'ABCPK1234K');
    expect(p.name, 'Ravi Kumar');
    expect(p.dateOfBirth, DateTime(1994, 3, 14));
    expect(p.employment, Employment.salaried);
    expect(p.bureauScore, 765);
    final profileCall = seen.last;
    expect(profileCall.headers['Authorization'], 'Bearer tok');
    expect(profileCall.headers['X-Device-Id'], 'dev1');
    expect(jsonDecode(bodies[2])['options']['aaMonths'], 12);
  });

  test('engine errors become ApiException codes', () async {
    final a = api({'POST /v1/otp/verify': (401, {'error': 'wrong_otp'})});
    expect(() => a.verifyOtp('9876500001', '000000', 'd'), throwsA(isA<ApiException>().having((e) => e.code, 'code', 'wrong_otp')));
    final b = api({});
    expect(() => b.fetchProfile(session, 'ABCPK1234K'), throwsA(isA<ApiException>().having((e) => e.code, 'code', 'not_found')));
  });

  test('selfie and documents are sent as uploads', () async {
    final a = api({
      'POST /v1/applications/HL-2611-12345/selfie': (200, {
        'faceFound': true, 'live': true, 'livenessScore': 0.9999, 'faceMatch': true, 'matchScore': 0.0, 'matchPending': true,
      }),
      'POST /v1/applications/HL-2611-12345/documents': (200, {
        'slot': 'salarySlip', 'detectedType': 'salarySlip', 'confidence': 0.97, 'accepted': true, 'reasonCode': null,
        'fields': {'netPay': '1,00,000.00', 'name': 'Ravi Kumar'},
      }),
    });
    final s = await a.checkSelfie(session, Uint8List.fromList([1, 2, 3]));
    expect(s.passed, isTrue);
    expect(s.matchPending, isTrue);
    final d = await a.uploadDocument(session, DocSlot.salarySlip, Uint8List.fromList([4, 5]), 'slip.jpg');
    expect(d.accepted, isTrue);
    expect(d.fields['netPay'], '1,00,000.00');
    // MockClient hands over the encoded multipart body, so check what goes over the wire.
    expect(seen.last.headers['content-type'], startsWith('multipart/form-data'));
    expect(bodies.last, contains('name="slot"\r\n\r\nsalarySlip'));
    expect(bodies.last, contains('name="file"; filename="slip.jpg"'));
    expect(bodies[0], contains('name="file"; filename="selfie.jpg"'));
  });

  test('sandbox samples: bytes from the engine, or null so the app uses its own', () async {
    final a = api({'GET /v1/applications/HL-2611-12345/samples/pan': (200, null)});
    expect(await a.sample(session, 'pan'), isNotNull);
    expect(await a.sample(session, 'photo-front'), isNull);
  });

  test('decisions parse, including valuation and reasons', () async {
    final decision = {
      'stage': 'final', 'outcome': 'refer', 'amount': 6000000.0, 'years': 15, 'ratePct': 10.5, 'emi': 66323.94,
      'reasons': [
        {'code': 'R-PRP-01', 'positive': false, 'values': {}},
      ],
      'valuation': {'estimate': 16501000.0, 'low': 12456000.0, 'high': 20413000.0, 'valueForLtv': 12000000.0},
      'kfs': {'apr_pct': 10.6}, 'record': {'seq': 4, 'hash': 'abc'},
    };
    final a = api({
      'POST /v1/applications/HL-2611-12345/in-principle': (200, {...decision, 'stage': 'in_principle', 'outcome': 'approve', 'valuation': null}),
      'POST /v1/applications/HL-2611-12345/final': (200, decision),
    });
    final req = LoanRequest(product: Product.lap, amount: 6000000, years: 15, propertyValue: 12000000);
    final ip = await a.inPrinciple(session, req);
    expect(ip.outcome, Outcome.approve);
    expect(jsonDecode(bodies.last)['product'], 'lap');
    final fin = await a.finalSanction(
        session,
        req,
        PropertyInput(city: 'Pune', locality: 'Baner', areaSqft: 1800, bhk: 3, declaredPrice: 12000000, isNew: false, photos: [
          GeoPhoto(label: 'front', bytes: Uint8List.fromList([9]), takenAt: DateTime.utc(2026, 11, 5), latitude: 18.5, longitude: 73.9),
        ]));
    expect(fin.outcome, Outcome.refer);
    expect(fin.reasons.single.code, 'R-PRP-01');
    expect(fin.valuation!.valueForLtv, 12000000);
    final body = bodies.last;
    expect(body, contains('"locality":"Baner"'));
    expect(body, contains('"latitude":18.5'));
    expect(body, contains('name="photos"; filename="front.jpg"'));
    expect(body, contains('"product":"lap"'));
  });
}
