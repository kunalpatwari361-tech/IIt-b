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

  bool get allConsented => consents.values.every((v) => v);

  void setConsent(String key, bool value) {
    consents[key] = value;
    notifyListeners();
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
  List<DocSlot> get requiredDocs => profile?.employment == Employment.selfEmployed
      ? [DocSlot.pan, DocSlot.aadhaar, DocSlot.itr, DocSlot.gst]
      : [DocSlot.pan, DocSlot.aadhaar, DocSlot.salarySlip, DocSlot.form16];

  bool get docsComplete => requiredDocs.every((s) => documents[s]?.accepted ?? false);

  void reset() {
    session = null;
    phone = '';
    consents.updateAll((_, _) => false);
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
