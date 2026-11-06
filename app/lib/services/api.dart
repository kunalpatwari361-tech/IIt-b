// The calls the app makes to the Nirnay engine. HttpNirnayApi calls the FastAPI engine
// (backend/); MockNirnayApi answers with sample data when no engine URL is set
// (flutter run --dart-define=NIRNAY_API_URL=http://localhost:8000 picks the real one).
import 'dart:typed_data';

import 'models.dart';

abstract class NirnayApi {
  /// Sends a one-time code by SMS.
  Future<void> sendOtp(String phone);

  /// Checks the code and binds this device to the account.
  Future<Session> verifyOtp(String phone, String otp, String deviceId);

  /// Saves the consent choices. The engine fetches nothing until the needed consents are recorded.
  Future<void> recordConsents(Session session, ConsentRecord consent);

  /// PAN + Aadhaar eKYC / DigiLocker + bureau + Account Aggregator, after consent.
  Future<Profile> fetchProfile(Session session, String pan);

  /// Face found, passive liveness and 1:1 match with the eKYC photo.
  Future<SelfieResult> checkSelfie(Session session, Uint8List jpeg);

  /// OCR + document classifier (model 6) + tamper checks.
  Future<DocResult> uploadDocument(Session session, DocSlot slot, Uint8List bytes, String fileName);

  /// Stage A: identity, AML, fraud and documents, policy, risk grade.
  Future<Decision> inPrinciple(Session session, LoanRequest request);

  /// Stage B: property, valuation (model 7), title and the final sanction.
  Future<Decision> finalSanction(Session session, LoanRequest request, PropertyInput property);

  /// Demo only: a sample file for a capture step without a camera. `kind` is a document slot
  /// name or `photo-<label>`. Null means the app uses its own stand-in image.
  Future<Uint8List?> sample(Session session, String kind);
}

class ApiException implements Exception {
  ApiException(this.code);
  final String code; // for example "wrong_otp"
  @override
  String toString() => 'ApiException($code)';
}
