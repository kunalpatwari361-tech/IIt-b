// Sample engine for the demo. It follows the report's three demo cases:
//   Ravi  (98765 00001)  salaried, HL Rs 45 lakh on a Rs 60 lakh flat  -> Approve in both stages
//   Meena (98765 00002)  shop owner, LAP Rs 60 lakh on Rs 1.2 crore    -> Approve in principle, Refer at the property (title gap)
//   Arjun (98765 00003)  salaried, HL Rs 30 lakh, edited salary slip   -> Reject (document failed verification)
// Any other number behaves like a clean salaried applicant. The people are fictional.
import 'dart:math' as math;
import 'dart:typed_data';

import '../format.dart';
import '../policy.dart';
import 'api.dart';
import 'models.dart';

class Persona {
  const Persona({
    required this.phone,
    required this.name,
    required this.dob,
    required this.employment,
    required this.employer,
    required this.income,
    required this.existingEmi,
    required this.score,
    this.editedSalarySlip = false,
    this.titleGap = false,
  });
  final String phone, name, employer;
  final DateTime dob;
  final Employment employment;
  final double income, existingEmi;
  final int? score;
  final bool editedSalarySlip, titleGap;
}

final demoPersonas = <String, Persona>{
  '9876500001': Persona(phone: '9876500001', name: 'Ravi Kumar', dob: DateTime(1994, 3, 14), employment: Employment.salaried,
      employer: 'Nimbus Software Pvt Ltd', income: 100000, existingEmi: 10000, score: 765),
  '9876500002': Persona(phone: '9876500002', name: 'Meena Sharma', dob: DateTime(1981, 7, 2), employment: Employment.selfEmployed,
      employer: 'Sharma Garments (proprietor)', income: 180000, existingEmi: 15000, score: 728, titleGap: true),
  '9876500003': Persona(phone: '9876500003', name: 'Arjun Mehta', dob: DateTime(1997, 11, 21), employment: Employment.salaried,
      employer: 'Coral Retail India Pvt Ltd', income: 62000, existingEmi: 0, score: 742, editedSalarySlip: true),
};

class MockNirnayApi implements NirnayApi {
  MockNirnayApi({this.delay = const Duration(milliseconds: 700)});
  final Duration delay;
  static const demoOtp = '123456';
  final _rng = math.Random(7);
  Persona _persona = demoPersonas['9876500001']!;
  String _pan = 'ABXXX1234X', _aadhaar = 'XXXX XXXX 0000';

  Future<void> _wait() => Future.delayed(delay);

  @override
  Future<void> sendOtp(String phone) async {
    await _wait();
    _persona = demoPersonas[phone] ??
        Persona(phone: phone, name: 'Priya Nair', dob: DateTime(1990, 5, 9), employment: Employment.salaried,
            employer: 'Orchid Health Systems Ltd', income: 85000, existingEmi: 5000, score: 748);
  }

  @override
  Future<Session> verifyOtp(String phone, String otp, String deviceId) async {
    await _wait();
    if (otp != demoOtp) throw ApiException('wrong_otp');
    final id = 'HL-2611-0${4800 + _rng.nextInt(199)}';
    return Session(token: 'demo-token-$deviceId', deviceId: deviceId, applicationId: id);
  }

  ConsentRecord? lastConsent; // the sample engine only keeps the latest choices

  @override
  Future<Uint8List?> sample(Session session, String kind) async => null; // the app's own stand-ins are enough here

  @override
  Future<void> recordConsents(Session session, ConsentRecord consent) async {
    lastConsent = consent;
  }

  @override
  Future<Profile> fetchProfile(Session session, String pan) async {
    await _wait();
    final p = _persona;
    _pan = '${pan.substring(0, 2)}XXX${pan.substring(5, 9)}X';
    _aadhaar = 'XXXX XXXX ${(4000 + _rng.nextInt(5999)).toString()}';
    return Profile(
      name: p.name,
      dateOfBirth: p.dob,
      panMasked: _pan,
      aadhaarMasked: _aadhaar,
      address: 'Flat 304, Lake View Road, Pune, Maharashtra 411038',
      employment: p.employment,
      employer: p.employer,
      monthlyIncome: p.income,
      existingEmi: p.existingEmi,
      bureauScore: p.score,
    );
  }

  @override
  Future<SelfieResult> checkSelfie(Session session, Uint8List jpeg) async {
    await _wait();
    final ok = jpeg.length > 1000; // the real check runs face detection, MiniFASNet liveness and face matching
    return SelfieResult(faceFound: ok, live: ok, livenessScore: ok ? 0.97 : 0.2, faceMatch: ok, matchScore: ok ? 0.91 : 0.0);
  }

  @override
  Future<DocResult> uploadDocument(Session session, DocSlot slot, Uint8List bytes, String fileName) async {
    await _wait();
    // The real engine OCRs the image and runs the document classifier (model 6).
    // Here the "read" fields come from the persona; an edited salary slip shows the inflated pay.
    final p = _persona;
    final pay = rupees(p.editedSalarySlip ? p.income * 1.5 : p.income);
    final fields = switch (slot) {
      DocSlot.pan => {'name': p.name, 'pan': _pan},
      DocSlot.aadhaar => {'name': p.name, 'aadhaar': _aadhaar},
      DocSlot.salarySlip => {'employer': p.employer, 'name': p.name, 'period': 'Oct 2026', 'netPay': pay},
      DocSlot.form16 => {'employer': p.employer, 'name': p.name, 'year': 'FY 2025-26'},
      DocSlot.itr => {'name': p.name, 'year': 'AY 2026-27', 'income': rupees(p.income * 12)},
      DocSlot.gst => {'business': p.employer, 'gstin': '27${_pan.substring(0, 5)}1Z5'},
      _ => <String, String>{},
    };
    return DocResult(slot: slot, detectedType: slot.name, confidence: 0.93 + _rng.nextDouble() * 0.06, accepted: true, fields: fields);
  }

  @override
  Future<Decision> inPrinciple(Session session, LoanRequest request) async {
    await _wait();
    final p = _persona;
    final years = math.min(request.years, Policy.maxTenureYears(request.product));
    final e = checkEligibility(
      product: request.product,
      monthlyIncome: p.income,
      existingEmi: p.existingEmi,
      propertyValue: request.propertyValue,
      asked: request.amount,
      years: years,
    );
    final reasons = <Reason>[];
    var outcome = Outcome.approve;
    void refer(String code) {
      reasons.add(Reason(code: code, positive: false));
      if (outcome == Outcome.approve) outcome = Outcome.refer;
    }

    void reject(String code) {
      reasons.add(Reason(code: code, positive: false));
      outcome = Outcome.reject;
    }

    final age = DateTime.now().difference(p.dob).inDays ~/ 365;
    if (p.editedSalarySlip) reject('R-FRD-03');
    if (age < Policy.minAge) reject('R-POL-01');
    if (age + years > Policy.maxAgeAtEnd(p.employment)) refer('R-POL-02');
    if (p.score == null) {
      refer('R-BUR-04');
    } else if (p.score! < 650) {
      reject('R-BUR-01');
    } else if (p.score! < 700) {
      refer('R-BUR-05');
    }
    if (e.maxEmi <= 0) reject('R-AFF-01');
    if (e.eligible > Policy.autoSanctionLimit) refer('R-AUT-01');

    if (outcome == Outcome.approve) {
      reasons.addAll([
        if (p.score != null) Reason(code: 'OK-SCORE', positive: true, values: {'score': '${p.score}'}),
        Reason(code: 'OK-FOIR', positive: true, values: {'pct': _pct(e.foirAfter), 'cap': _pct(e.foirCap)}),
        Reason(code: 'OK-LTV', positive: true, values: {'pct': _pct(e.ltv), 'cap': _pct(e.ltvCap)}),
      ]);
    }
    return Decision(stage: 'in_principle', outcome: outcome, amount: e.eligible, years: years, ratePct: e.ratePct,
        emi: e.emi, reasons: reasons);
  }

  @override
  Future<Decision> finalSanction(Session session, LoanRequest request, PropertyInput property) async {
    await _wait();
    final first = await inPrinciple(session, request);
    if (first.outcome == Outcome.reject) return first;
    // The real engine runs the valuation model (model 7), the deed reader and the title checks.
    final estimate = property.declaredPrice * 1.02;
    final valuation = Valuation(estimate: estimate, low: estimate * 0.86, high: estimate * 1.10,
        valueForLtv: math.min(property.declaredPrice, estimate));
    final reasons = <Reason>[];
    var outcome = first.outcome;
    if (_persona.titleGap) {
      reasons.add(Reason(code: 'R-PRP-01', positive: false));
      outcome = Outcome.refer;
    }
    if (property.declaredPrice > valuation.high) {
      reasons.add(Reason(code: 'R-PRP-03', positive: false));
      outcome = Outcome.refer;
    }
    if (outcome == Outcome.approve) {
      reasons
        ..addAll(first.reasons)
        ..add(Reason(code: 'OK-VALUE', positive: true, values: {'low': '${valuation.low}', 'high': '${valuation.high}'}))
        ..add(Reason(code: 'OK-TITLE', positive: true));
    }
    return Decision(stage: 'final', outcome: outcome, amount: first.amount, years: first.years, ratePct: first.ratePct,
        emi: first.emi, reasons: reasons, valuation: valuation);
  }

  static String _pct(double x) => '${(x * 100).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}%';
}
