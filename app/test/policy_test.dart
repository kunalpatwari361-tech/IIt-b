import 'package:flutter_test/flutter_test.dart';
import 'package:nirnay_app/policy.dart';
import 'package:nirnay_app/services/models.dart';

void main() {
  test("the report's worked example: Ravi, Rs 45 lakh on a Rs 60 lakh flat", () {
    final e = checkEligibility(
        product: Product.homeLoan, monthlyIncome: 100000, existingEmi: 10000, propertyValue: 6000000, asked: 4500000, years: 20);
    expect(e.maxEmi, 40000);
    expect(e.loanByIncome / 1e5, closeTo(45.26, 0.01));
    expect(e.loanByProperty, 4800000);
    expect(e.eligible, 4500000);
    expect(e.emi.round(), 39767);
    expect((e.foirAfter * 1000).round() / 10, 49.8);
    expect(e.ltv, 0.75);
    expect(e.ltvCap, 0.80);
    expect(e.limitedBy, 'asked');
  });

  test('FOIR caps follow income bands', () {
    expect(Policy.foirCap(50000), 0.45);
    expect(Policy.foirCap(50001), 0.50);
    expect(Policy.foirCap(150000), 0.50);
    expect(Policy.foirCap(150001), 0.60);
  });

  test('Home Loan LTV tiers: the loan sits in the tier its own size falls in', () {
    expect(Policy.loanByProperty(Product.homeLoan, 3000000), 2700000); // 90% of Rs 30 lakh
    expect(Policy.loanByProperty(Product.homeLoan, 3500000), 3000000); // 90% is capped at Rs 30 lakh; 80% is less
    expect(Policy.loanByProperty(Product.homeLoan, 12000000), 9000000); // 75% of Rs 1.2 crore
    expect(Policy.loanByProperty(Product.lap, 12000000), 7200000); // LAP 60%
  });

  test('income limits a big ask', () {
    final e = checkEligibility(
        product: Product.homeLoan, monthlyIncome: 60000, existingEmi: 0, propertyValue: 9000000, asked: 7000000, years: 20);
    expect(e.limitedBy, 'income');
    expect(e.eligible, lessThan(7000000));
    expect(e.emi, lessThanOrEqualTo(60000 * 0.5 + 1));
  });

  test('KFS: the APR is above the interest rate because of the fee', () {
    final k = KeyFacts.compute(4500000, emi(4500000, 8.75, 240), 20);
    expect(k.fee, 22500); // 0.5%
    expect(k.gst, 4050); // 18% GST on the fee, as the engine does
    expect(k.aprPct, greaterThan(8.75));
    expect(k.aprPct, lessThan(8.9));
  });
}
