// Credit policy used for the quick eligibility check, from the Nirnay report
// (Requirement 2, "Policy parameters"). Only the Home Loan LTV tiers come from
// regulation (RBI). Every other value is illustrative; the engine's policy
// studio holds the real, versioned tables, and its decision is the one that counts.
import 'dart:math' as math;

enum Product { homeLoan, lap }

enum Employment { salaried, selfEmployed }

class Policy {
  static const minAge = 21;
  static int maxAgeAtEnd(Employment e) => e == Employment.salaried ? 65 : 70;
  static int maxTenureYears(Product p) => p == Product.homeLoan ? 30 : 15;
  static double ratePct(Product p) => p == Product.homeLoan ? 8.75 : 10.50;
  static const autoSanctionLimit = 1e7; // Rs 1 crore; above this a senior officer decides

  /// FOIR cap by net monthly income: 45% up to Rs 50,000; 50% up to Rs 1,50,000; 60% above.
  static double foirCap(double monthlyIncome) =>
      monthlyIncome <= 50000 ? 0.45 : monthlyIncome <= 150000 ? 0.50 : 0.60;

  /// LTV cap for a loan amount. Home Loan: RBI tiers 90% up to Rs 30 lakh,
  /// 80% up to Rs 75 lakh, 75% above. LAP: 60% (illustrative).
  static double ltvCap(Product p, double loan) {
    if (p == Product.lap) return 0.60;
    if (loan <= 30e5) return 0.90;
    if (loan <= 75e5) return 0.80;
    return 0.75;
  }

  /// The largest loan the property supports, respecting the tier the loan falls in.
  static double loanByProperty(Product p, double propertyValue) {
    if (p == Product.lap) return 0.60 * propertyValue;
    final tiers = [(0.90, 30e5), (0.80, 75e5), (0.75, double.infinity)];
    var best = 0.0;
    var lower = 0.0;
    for (final (cap, upper) in tiers) {
      final loan = math.min(cap * propertyValue, upper);
      if (loan > lower) best = math.max(best, loan);
      lower = upper;
    }
    return best;
  }
}

double emi(double principal, double annualRatePct, int months) {
  final r = annualRatePct / 12 / 100;
  if (r == 0) return principal / months;
  final f = math.pow(1 + r, months);
  return principal * r * f / (f - 1);
}

/// Loan that a monthly EMI supports: EMI x [1 - (1 + r)^-n] / r.
double loanForEmi(double monthlyEmi, double annualRatePct, int months) {
  final r = annualRatePct / 12 / 100;
  return monthlyEmi * (1 - math.pow(1 + r, -months)) / r;
}

class Eligibility {
  Eligibility({
    required this.maxEmi,
    required this.loanByIncome,
    required this.loanByProperty,
    required this.eligible,
    required this.emi,
    required this.foirAfter,
    required this.ltv,
    required this.ltvCap,
    required this.foirCap,
    required this.ratePct,
    required this.limitedBy,
  });

  final double maxEmi, loanByIncome, loanByProperty, eligible, emi, foirAfter, ltv, ltvCap, foirCap, ratePct;
  final String limitedBy; // "asked", "income", "property", "product"
}

/// Eligible loan = the lowest of: loan by income, loan by property, product limit, amount asked.
Eligibility checkEligibility({
  required Product product,
  required double monthlyIncome,
  required double existingEmi,
  required double propertyValue,
  required double asked,
  required int years,
}) {
  final rate = Policy.ratePct(product);
  final months = years * 12;
  final foir = Policy.foirCap(monthlyIncome);
  final maxEmi = math.max(0.0, monthlyIncome * foir - existingEmi);
  final byIncome = loanForEmi(maxEmi, rate, months);
  final byProperty = Policy.loanByProperty(product, propertyValue);
  final candidates = {'asked': asked, 'income': byIncome, 'property': byProperty};
  final limit = candidates.entries.reduce((a, b) => a.value <= b.value ? a : b);
  final eligible = (limit.value / 1000).floorToDouble() * 1000;
  final e = emi(eligible, rate, months);
  return Eligibility(
    maxEmi: maxEmi,
    loanByIncome: byIncome,
    loanByProperty: byProperty,
    eligible: eligible,
    emi: e,
    foirAfter: monthlyIncome > 0 ? (e + existingEmi) / monthlyIncome : 0,
    ltv: propertyValue > 0 ? eligible / propertyValue : 0,
    ltvCap: Policy.ltvCap(product, eligible),
    foirCap: foir,
    ratePct: rate,
    limitedBy: limit.key,
  );
}
