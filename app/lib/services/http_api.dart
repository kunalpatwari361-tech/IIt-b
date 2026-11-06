// Calls the Nirnay decision engine (backend/, FastAPI) over HTTPS. Same interface as the sample engine.
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../policy.dart';
import 'api.dart';
import 'models.dart';

class HttpNirnayApi implements NirnayApi {
  HttpNirnayApi(String baseUrl, {http.Client? client, this.timeout = const Duration(seconds: 120)})
      : _base = Uri.parse(baseUrl.endsWith('/') ? baseUrl : '$baseUrl/'),
        _http = client ?? http.Client();

  final Uri _base;
  final http.Client _http;
  final Duration timeout; // documents are OCR'd while the customer waits

  Uri _u(String path) => _base.resolve(path);

  Map<String, String> _auth(Session s, {bool json = true}) => {
        'Authorization': 'Bearer ${s.token}',
        'X-Device-Id': s.deviceId,
        if (json) 'Content-Type': 'application/json',
      };

  String _app(Session s, String path) => 'v1/applications/${Uri.encodeComponent(s.applicationId)}$path';

  Future<dynamic> _send(Future<http.Response> call) async {
    final http.Response r;
    try {
      r = await call.timeout(timeout);
    } catch (_) {
      throw ApiException('network');
    }
    if (r.statusCode == 204) return null;
    dynamic body;
    try {
      body = jsonDecode(utf8.decode(r.bodyBytes));
    } catch (_) {
      body = null;
    }
    if (r.statusCode >= 400) {
      final code = body is Map ? (body['error'] ?? body['detail']) : null;
      throw ApiException(code is String ? code : 'http_${r.statusCode}');
    }
    return body;
  }

  Future<dynamic> _multipart(http.MultipartRequest req) async {
    try {
      final streamed = await _http.send(req).timeout(timeout);
      return await _send(http.Response.fromStream(streamed));
    } on ApiException {
      rethrow;
    } catch (_) {
      throw ApiException('network');
    }
  }

  @override
  Future<void> sendOtp(String phone) async {
    await _send(_http.post(_u('v1/otp/send'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({'phone': phone})));
  }

  @override
  Future<Session> verifyOtp(String phone, String otp, String deviceId) async {
    final j = await _send(_http.post(_u('v1/otp/verify'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode({'phone': phone, 'otp': otp, 'deviceId': deviceId})));
    return Session(token: j['token'] as String, deviceId: j['deviceId'] as String, applicationId: j['applicationId'] as String);
  }

  @override
  Future<void> recordConsents(Session session, ConsentRecord consent) async {
    await _send(_http.put(_u(_app(session, '/consents')), headers: _auth(session), body: jsonEncode(consent.toJson())));
  }

  @override
  Future<Profile> fetchProfile(Session session, String pan) async {
    final j = await _send(_http.post(_u(_app(session, '/profile')), headers: _auth(session), body: jsonEncode({'pan': pan})));
    return Profile(
      name: j['name'] as String,
      dateOfBirth: DateTime.parse(j['dateOfBirth'] as String),
      panMasked: j['panMasked'] as String,
      aadhaarMasked: j['aadhaarMasked'] as String,
      address: j['address'] as String,
      employment: j['employment'] == 'selfEmployed' ? Employment.selfEmployed : Employment.salaried,
      employer: j['employer'] as String,
      monthlyIncome: (j['monthlyIncome'] as num).toDouble(),
      existingEmi: (j['existingEmi'] as num).toDouble(),
      bureauScore: (j['bureauScore'] as num?)?.toInt(),
    );
  }

  @override
  Future<SelfieResult> checkSelfie(Session session, Uint8List jpeg) async {
    final req = http.MultipartRequest('POST', _u(_app(session, '/selfie')))
      ..headers.addAll(_auth(session, json: false))
      ..files.add(http.MultipartFile.fromBytes('file', jpeg, filename: 'selfie.jpg'));
    final j = await _multipart(req);
    return SelfieResult(
      faceFound: j['faceFound'] as bool,
      live: j['live'] as bool,
      livenessScore: (j['livenessScore'] as num).toDouble(),
      faceMatch: j['faceMatch'] as bool,
      matchScore: (j['matchScore'] as num).toDouble(),
      matchPending: j['matchPending'] as bool? ?? false,
    );
  }

  @override
  Future<DocResult> uploadDocument(Session session, DocSlot slot, Uint8List bytes, String fileName) async {
    final req = http.MultipartRequest('POST', _u(_app(session, '/documents')))
      ..headers.addAll(_auth(session, json: false))
      ..fields['slot'] = slot.name
      ..files.add(http.MultipartFile.fromBytes('file', bytes, filename: fileName));
    final j = await _multipart(req);
    return DocResult(
      slot: slot,
      detectedType: j['detectedType'] as String,
      confidence: (j['confidence'] as num).toDouble(),
      accepted: j['accepted'] as bool,
      reasonCode: j['reasonCode'] as String?,
      fields: (j['fields'] as Map).map((k, v) => MapEntry(k as String, '$v')),
    );
  }

  @override
  Future<Uint8List?> sample(Session session, String kind) async {
    try {
      final r = await _http.get(_u(_app(session, '/samples/${Uri.encodeComponent(kind)}')), headers: _auth(session, json: false)).timeout(timeout);
      return r.statusCode == 200 ? r.bodyBytes : null;
    } catch (_) {
      return null;
    }
  }

  Map<String, Object> _request(LoanRequest r) => {
        'product': r.product == Product.lap ? 'lap' : 'homeLoan',
        'amount': r.amount,
        'years': r.years,
        'propertyValue': r.propertyValue,
      };

  @override
  Future<Decision> inPrinciple(Session session, LoanRequest request) async {
    final j = await _send(_http.post(_u(_app(session, '/in-principle')), headers: _auth(session), body: jsonEncode(_request(request))));
    return decisionFromJson(j as Map<String, dynamic>);
  }

  @override
  Future<Decision> finalSanction(Session session, LoanRequest request, PropertyInput property) async {
    final req = http.MultipartRequest('POST', _u(_app(session, '/final')))
      ..headers.addAll(_auth(session, json: false))
      ..fields['request'] = jsonEncode(_request(request))
      ..fields['property'] = jsonEncode({
        'city': property.city,
        'locality': property.locality,
        'society': property.society,
        'areaSqft': property.areaSqft,
        'bhk': property.bhk,
        'declaredPrice': property.declaredPrice,
        'isNew': property.isNew,
      })
      ..fields['photos_meta'] = jsonEncode([
        for (final p in property.photos)
          {
            'label': p.label,
            'takenAt': p.takenAt.toUtc().toIso8601String(),
            'latitude': p.latitude,
            'longitude': p.longitude,
            'accuracyM': p.accuracyM,
          }
      ]);
    for (final p in property.photos) {
      req.files.add(http.MultipartFile.fromBytes('photos', p.bytes, filename: '${p.label}.jpg'));
    }
    return decisionFromJson(await _multipart(req) as Map<String, dynamic>);
  }
}

Decision decisionFromJson(Map<String, dynamic> j) {
  final v = j['valuation'] as Map<String, dynamic>?;
  return Decision(
    stage: j['stage'] as String,
    outcome: Outcome.values.byName(j['outcome'] as String),
    amount: (j['amount'] as num).toDouble(),
    years: (j['years'] as num).toInt(),
    ratePct: (j['ratePct'] as num).toDouble(),
    emi: (j['emi'] as num).toDouble(),
    reasons: [
      for (final r in j['reasons'] as List)
        Reason(
          code: r['code'] as String,
          positive: r['positive'] as bool,
          values: (r['values'] as Map? ?? {}).map((k, v) => MapEntry(k as String, '$v')),
        )
    ],
    valuation: v == null
        ? null
        : Valuation(
            estimate: (v['estimate'] as num).toDouble(),
            low: (v['low'] as num).toDouble(),
            high: (v['high'] as num).toDouble(),
            valueForLtv: (v['valueForLtv'] as num).toDouble(),
          ),
  );
}
