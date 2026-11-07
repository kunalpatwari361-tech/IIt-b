// Everything the customer has entered so far, shared by all the screens.
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'policy.dart';
import 'services/api.dart';
import 'services/models.dart';

class AppState extends ChangeNotifier {
  AppState(this.api);
  final NirnayApi api;

  Locale locale = const Locale('en');
  Product product = Product.homeLoan;
  String phone = '';
  Session? session;
  String? deviceId;
  final consents = <String, bool>{'bureau': false, 'aa': false, 'kyc': false, 'privacy': false};

  // The customer's consent choices: what goes into the consent record the engine keeps.
  // Optional consents start off; the customer turns each one on.
  final optional = <String, bool>{'offersSms': false, 'offersEmail': false, 'offersWhatsapp': false, 'updatesWhatsapp': false, 'insurance': false};
  final consentGivenAt = <String, DateTime>{};
  final consentLog = <ConsentEvent>[];
  int aaMonths = 12; // months of bank statements to share: 6, 12 or 24
  final aaAccounts = <String, bool>{'salary': true, 'savings': false, 'fd': false}; // demo linked accounts
  String kycMethod = 'aadhaarOtp'; // aadhaarOtp, digilocker or videoKyc
  bool useCkyc = false; // fetch the existing Central KYC record instead of doing KYC again
  bool recheckBeforePayout = false; // one more credit report check just before payout
  String pan = '';
  Profile? profile;
  double income = 0, existingEmi = 0, propertyValue = 6000000, loanAmount = 4500000;
  int years = 20;
  Uint8List? selfie;
  SelfieResult? selfieResult;
  final documents = <DocSlot, DocResult>{};
  Decision? inPrinciple;
  Decision? finalDecision;
  PropertyInput? property;
  double? approvedMax; // the in-principle amount, kept once the customer shapes a smaller offer

  void setLocale(Locale l) {
    locale = l;
    notifyListeners();
  }

  void setProduct(Product p) {
    product = p;
    if (p == Product.lap) {
      propertyValue = 12000000;
      loanAmount = 6000000;
      years = 15;
    } else {
      propertyValue = 6000000;
      loanAmount = 4500000;
      years = 20;
    }
    notifyListeners();
  }

  bool get allConsented => consents.values.every((v) => v) && aaAccounts.values.any((v) => v);

  /// How long each needed consent lasts; null means until the customer withdraws it.
  static Duration? validity(String key) => switch (key) {
        'bureau' => const Duration(days: 180),
        'aa' => const Duration(days: 30), // a one-time fetch for this decision
        'kyc' => const Duration(days: 180),
        _ => null,
      };

  void setConsent(String key, bool value) {
    if (consents[key] == value) return;
    consents[key] = value;
    _log(key, value);
    notifyListeners();
  }

  void setOptional(String key, bool value) {
    if (optional[key] == value) return;
    optional[key] = value;
    _log(key, value);
    _syncConsents();
    notifyListeners();
  }

  /// What the engine records as this customer's consent.
  ConsentRecord get consentRecord => ConsentRecord(
        given: Map.of(consents),
        options: {
          'aaMonths': aaMonths,
          'aaAccounts': Map.of(aaAccounts),
          'kycMethod': kycMethod,
          'useCkyc': useCkyc,
          'recheckBeforePayout': recheckBeforePayout,
        },
        optional: Map.of(optional),
      );

  /// Once the engine holds data, every later consent change goes to it straight away.
  void _syncConsents() {
    final s = session;
    if (s == null || profile == null) return;
    api.recordConsents(s, consentRecord).catchError((_) {});
  }

  /// Withdrawing a needed consent stops the application, and what was fetched under it is deleted.
  void withdrawRequired(String key) {
    consents[key] = false;
    _log(key, false);
    _syncConsents();
    profile = null;
    selfie = null;
    selfieResult = null;
    documents.clear();
    inPrinciple = null;
    finalDecision = null;
    property = null;
    approvedMax = null;
    notifyListeners();
  }

  void _log(String key, bool given) {
    final now = DateTime.now();
    if (given) {
      consentGivenAt[key] = now;
    } else {
      consentGivenAt.remove(key);
    }
    consentLog.add(ConsentEvent(key, given, now));
  }

  /// A random id kept on the phone; the engine binds the account to it at sign-in.
  Future<String> ensureDeviceId() async {
    if (deviceId != null) return deviceId!;
    String id;
    try {
      final prefs = await SharedPreferences.getInstance();
      id = prefs.getString('device_id') ?? _newId();
      await prefs.setString('device_id', id);
    } catch (_) {
      id = _newId();
    }
    return deviceId = id;
  }

  static String _newId() {
    final r = math.Random.secure();
    return List.generate(16, (_) => r.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
  }

  void setProfile(Profile p) {
    profile = p;
    income = p.monthlyIncome;
    existingEmi = p.existingEmi;
    notifyListeners();
  }

  void update(VoidCallback change) {
    change();
    notifyListeners();
  }

  Eligibility get eligibility => checkEligibility(
        product: product,
        monthlyIncome: income,
        existingEmi: existingEmi,
        propertyValue: propertyValue,
        asked: loanAmount,
        years: years,
      );

  LoanRequest get request => LoanRequest(product: product, amount: loanAmount, years: years, propertyValue: propertyValue);

  /// Income documents asked for, by type of work. Bank statements come through the Account Aggregator.
  List<DocSlot> get requiredDocs => profile?.requiredDocuments ?? (profile?.employment == Employment.selfEmployed
      ? [DocSlot.pan, DocSlot.aadhaar, DocSlot.itr, DocSlot.gst]
      : [DocSlot.pan, DocSlot.aadhaar, DocSlot.salarySlip, DocSlot.form16]);

  bool get docsComplete => requiredDocs.every((s) => documents[s]?.accepted ?? false);

  /// Keeps the offer the customer shaped: the request for the final sanction uses it.
  void lockOffer(double amount, int years) {
    final d = inPrinciple!;
    approvedMax ??= d.amount;
    loanAmount = amount;
    this.years = years;
    inPrinciple = Decision(
      stage: d.stage,
      outcome: d.outcome,
      amount: amount,
      years: years,
      ratePct: d.ratePct,
      emi: emi(amount, d.ratePct, years * 12),
      reasons: d.reasons,
      valuation: d.valuation,
    );
    notifyListeners();
  }

  void reset() {
    session = null;
    approvedMax = null;
    phone = '';
    consents.updateAll((_, _) => false);
    optional.updateAll((_, _) => false);
    consentGivenAt.clear();
    consentLog.clear();
    aaMonths = 12;
    aaAccounts
      ..updateAll((_, _) => false)
      ..['salary'] = true;
    kycMethod = 'aadhaarOtp';
    useCkyc = false;
    recheckBeforePayout = false;
    pan = '';
    profile = null;
    selfie = null;
    selfieResult = null;
    documents.clear();
    inPrinciple = null;
    finalDecision = null;
    property = null;
    setProduct(Product.homeLoan);
  }
}

/// One line of the consent history: a consent given or withdrawn, and when.
class ConsentEvent {
  const ConsentEvent(this.key, this.given, this.at);
  final String key;
  final bool given;
  final DateTime at;
}
