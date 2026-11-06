// What the app sends to and gets from the Nirnay engine.
import 'dart:typed_data';

import '../policy.dart';

class Session {
  Session({required this.token, required this.deviceId, required this.applicationId});
  final String token;
  final String deviceId;
  final String applicationId;
}

/// Filled from PAN, Aadhaar eKYC / DigiLocker and the Account Aggregator, so the customer types little.
class Profile {
  Profile({
    required this.name,
    required this.dateOfBirth,
    required this.panMasked,
    required this.aadhaarMasked,
    required this.address,
    required this.employment,
    required this.employer,
    required this.monthlyIncome,
    required this.existingEmi,
    required this.bureauScore,
  });
  final String name, panMasked, aadhaarMasked, address, employer;
  final DateTime dateOfBirth;
  final Employment employment;
  final double monthlyIncome, existingEmi;
  final int? bureauScore; // null: no credit history

  int ageOn(DateTime day) {
    var age = day.year - dateOfBirth.year;
    if (day.month < dateOfBirth.month || (day.month == dateOfBirth.month && day.day < dateOfBirth.day)) age--;
    return age;
  }
}

class SelfieResult {
  SelfieResult({
    required this.faceFound,
    required this.live,
    required this.livenessScore,
    required this.faceMatch,
    required this.matchScore,
    this.matchPending = false,
  });
  final bool faceFound, live, faceMatch;
  final double livenessScore, matchScore;
  // No ID photo to compare with yet: the engine matches the selfie when the Aadhaar or PAN card arrives.
  final bool matchPending;
  bool get passed => faceFound && live && faceMatch;
}

/// The customer's consent choices, sent to the engine before any data is fetched (DPDP Act 2023).
class ConsentRecord {
  ConsentRecord({required this.given, required this.options, required this.optional});
  final Map<String, bool> given; // bureau, aa, kyc, privacy
  final Map<String, Object> options; // aaMonths, aaAccounts, kycMethod, useCkyc, recheckBeforePayout
  final Map<String, bool> optional; // offers by channel, WhatsApp updates, insurance quote

  Map<String, Object> toJson() => {'given': given, 'options': options, 'optional': optional};
}

enum DocSlot { pan, aadhaar, salarySlip, form16, itr, gst, bankStatement, saleDeed, allotmentLetter, encumbrance, propertyTax }

class DocResult {
  DocResult({required this.slot, required this.detectedType, required this.confidence, required this.accepted, this.reasonCode, this.fields = const {}});
  final DocSlot slot;
  final String detectedType; // what model 6 says it is
  final double confidence;
  final bool accepted;
  final String? reasonCode; // R-DOC-01 wrong document, R-DOC-02 unreadable
  final Map<String, String> fields; // what OCR read: name, pan, employer, netPay, period, year, income, business, gstin
}

class PropertyInput {
  PropertyInput({
    required this.city,
    required this.locality,
    required this.areaSqft,
    required this.bhk,
    required this.declaredPrice,
    required this.isNew,
    this.society,
    this.photos = const [],
  });
  final String city, locality;
  final String? society;
  final double areaSqft, declaredPrice;
  final int bhk;
  final bool isNew;
  final List<GeoPhoto> photos;
}

class GeoPhoto {
  GeoPhoto({required this.label, required this.bytes, required this.takenAt, this.latitude, this.longitude, this.accuracyM});
  final String label;
  final Uint8List bytes;
  final DateTime takenAt;
  final double? latitude, longitude, accuracyM;
  bool get geoTagged => latitude != null && longitude != null;
}

enum Outcome { approve, refer, reject }

class Reason {
  Reason({required this.code, required this.positive, this.values = const {}});
  final String code; // a reason code (R-...) or an offer fact (OK-...)
  final bool positive;
  final Map<String, String> values;
}

class Decision {
  Decision({
    required this.stage,
    required this.outcome,
    required this.amount,
    required this.years,
    required this.ratePct,
    required this.emi,
    required this.reasons,
    this.valuation,
  });
  final String stage; // "in_principle" or "final"
  final Outcome outcome;
  final double amount, ratePct, emi;
  final int years;
  final List<Reason> reasons;
  final Valuation? valuation;
}

class Valuation {
  Valuation({required this.estimate, required this.low, required this.high, required this.valueForLtv});
  final double estimate, low, high, valueForLtv;
}

class LoanRequest {
  LoanRequest({required this.product, required this.amount, required this.years, required this.propertyValue});
  final Product product;
  final double amount, propertyValue;
  final int years;
}
