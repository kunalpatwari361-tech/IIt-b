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
  Future<String?> sendOtp(String phone) async {
    await _wait();
    _persona = demoPersonas[phone] ??
        Persona(phone: phone, name: 'Priya Nair', dob: DateTime(1990, 5, 9), employment: Employment.salaried,
            employer: 'Orchid Health Systems Ltd', income: 85000, existingEmi: 5000, score: 748);
    return 'sandbox';
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
  Future<Profile> fetchProfile(Session session, String pan, {Declaration? declared}) async {
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
    return _last = Decision(stage: 'in_principle', outcome: outcome, amount: e.eligible, years: years, ratePct: e.ratePct,
        emi: e.emi, reasons: reasons, keyFacts: KeyFacts.compute(e.eligible, e.emi, years),
        score: scorecard(p.score, _historyYears[p.phone] ?? 6, e.eligible / request.propertyValue * 100), reference: _ref());
  }

  /// Years since the first loan for the demo customers (the bureau report would say).
  static const _historyYears = {'9876500001': 8.0, '9876500002': 12.0, '9876500003': 3.0};
  int _records = 0;
  String _ref() => '#SBX-${++_records} · sample engine';

  /// The sample engine's copy of model 1: the same point ranges the trained scorecard uses
  /// (models/credit_scorecard), for the inputs the demo customers have. Starts at 650.
  static ScoreBreakdown scorecard(int? bureau, double history, double ltvPct) {
    (String, int) band(double v, List<(double, String, int)> bands, (String, int) top) {
      for (final (upTo, label, pts) in bands) {
        if (v < upTo) return (label, pts);
      }
      return top;
    }

    final b = bureau == null
        ? ('missing', -7)
        : band(bureau.toDouble(), [(418, 'below 418', -29), (616, '418 to 616', -13), (682, '616 to 682', 12), (738, '682 to 738', 22)],
            ('738 or more', 38));
    final h = band(history, [(0.208, 'below 0.208', -5), (0.792, '0.208 to 0.792', 3), (2.88, '0.792 to 2.88', 4), (4.54, '2.88 to 4.54', 8)],
        ('4.54 or more', 17));
    final l = band(ltvPct, [
      (53.5, 'below 53.5', 38), (62.2, '53.5 to 62.2', 29), (66.8, '62.2 to 66.8', 21), (69.3, '66.8 to 69.3', 11),
      (72.9, '69.3 to 72.9', 8), (74.3, '72.9 to 74.3', 3), (78.5, '74.3 to 78.5', 3), (83.4, '78.5 to 83.4', -8),
      (84.6, '83.4 to 84.6', -17), (89.2, '84.6 to 89.2', -18)
    ], ('89.2 or more', -19));
    final factors = [
      ScoreFactor(input: 'bureau_score', bin: b.$1, points: b.$2),
      ScoreFactor(input: 'credit_history_years', bin: h.$1, points: h.$2),
      ScoreFactor(input: 'loan_amount', bin: 'missing', points: 0),
      ScoreFactor(input: 'ltv', bin: l.$1, points: l.$2),
    ];
    final score = (650 + factors.fold<int>(0, (a, f) => a + f.points)).clamp(300, 900);
    final grade = score >= 760 ? 'A' : score >= 700 ? 'B' : score >= 650 ? 'C' : score >= 600 ? 'D' : 'E';
    return ScoreBreakdown(score: score, grade: grade, base: 650, factors: factors);
  }

  Decision? _last;

  @override
  Future<DecisionLetter> decisionLetter(Session session, String lang) async {
    await _wait();
    final d = _last;
    final lines = [
      'Nirnay Housing Finance (sample engine)',
      'Application number: ${session.applicationId}',
      'Dear ${_persona.name},',
      if (d == null) 'There is no decision yet.',
      if (d != null && d.outcome == Outcome.approve) 'We are pleased to share your loan offer of ${rupees(d.amount)}.',
      if (d != null && d.outcome == Outcome.refer) 'Your application needs a short review by our team before we can decide.',
      if (d != null && d.outcome == Outcome.reject) 'We are sorry that we cannot offer this loan at present.',
      'This decision was made by our automated underwriting engine. You can ask for a review by a person.',
    ];
    return DecisionLetter(lines: lines, untranslated: lang == 'en' ? 0 : lines.length);
  }

  @override
  Future<AssistantAnswer> ask(Session session, String question, String lang) async {
    await _wait();
    final q = question.toLowerCase();
    if (q.contains('next') || q.contains('status')) {
      return AssistantAnswer(answer: 'Your application is with us. We will update you in the app and by SMS.', handoff: false);
    }
    return AssistantAnswer(answer: "I'm not sure about that. I can connect you to our support team.", handoff: true);
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
    return _last = Decision(stage: 'final', outcome: outcome, amount: first.amount, years: first.years, ratePct: first.ratePct,
        emi: first.emi, reasons: reasons, valuation: valuation, keyFacts: first.keyFacts, score: first.score, reference: _ref());
  }

  static String _pct(double x) => '${(x * 100).toStringAsFixed(1).replaceAll(RegExp(r'\.0$'), '')}%';
}
