import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../format.dart';
import '../l10n/app_localizations.dart';
import '../policy.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// After the in-principle approval: drag the amount and tenure within what was approved, and see the
/// EMI, the interest and both policy limits move live. "Lock this offer" carries it to the final sanction.
class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  late double _amount, _max;
  late int _years;

  @override
  void initState() {
    super.initState();
    final s = context.read<AppState>();
    _max = s.approvedMax ?? s.inPrinciple!.amount;
    _amount = s.inPrinciple!.amount;
    _years = s.inPrinciple!.years;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final s = context.watch<AppState>();
    if (s.inPrinciple == null) return const Scaffold(); // a needed consent was withdrawn
    final lang = s.locale.languageCode;
    final rate = s.inPrinciple!.ratePct;
    final maxYears = Policy.maxTenureYears(s.product);
    final months = _years * 12;
    final e = emi(_amount, rate, months);
    final total = e * months;
    final interest = total - _amount;
    final foir = s.income > 0 ? (e + s.existingEmi) / s.income : 0.0;
    final foirCap = Policy.foirCap(s.income);
    final ltv = s.propertyValue > 0 ? _amount / s.propertyValue : 0.0;
    final ltvCap = Policy.ltvCap(s.product, _amount);
    final within = foir <= foirCap + 1e-9 && ltv <= ltvCap + 1e-9;
    final steps = math.max(1, ((_max - 5e5) / 1e5).round());

    return StepScaffold(
      title: t.shapeOffer,
      step: 6,
      footnote: t.shapeOfferSub,
      buttonLabel: t.lockOffer,
      onPressed: within
          ? () {
              s.lockOffer(_amount, _years);
              showError(context, t.offerLocked);
              Navigator.pop(context);
            }
          : null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t.loanAmountLabel, style: const TextStyle(fontSize: 13, color: C.muted)),
        Text(rupees(_amount), key: const Key('offer-amount'), style: serif(34)),
        const SizedBox(height: 6),
        Pill(within ? t.withinLimits : t.aboveLimits, tone: within ? Tone.good : Tone.bad),
        const SizedBox(height: 16),
        SectionCard(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
          child: Column(children: [
            _head(t.loanAmountLabel, rupeesShort(_amount, lang: lang)),
            Slider(
              key: const Key('offer-amount-slider'),
              value: _amount.clamp(5e5, _max),
              min: 5e5,
              max: _max,
              divisions: steps,
              onChanged: (v) => setState(() => _amount = v >= _max - 1 ? _max : (v / 1e5).round() * 1e5),
            ),
            Row(children: [
              Expanded(child: Text(t.mostYouCan(rupeesShort(_max, lang: lang)), style: const TextStyle(fontSize: 12.5, color: C.muted))),
              OutlinedButton(
                key: const Key('use-max'),
                style: OutlinedButton.styleFrom(minimumSize: const Size(0, 36), padding: const EdgeInsets.symmetric(horizontal: 12)),
                onPressed: _amount == _max ? null : () => setState(() => _amount = _max),
                child: Text(t.useMax),
              ),
            ]),
            const SizedBox(height: 10),
            _head(t.tenureLabel, t.yearsLabel('$_years')),
            Slider(
              value: _years.toDouble().clamp(5, maxYears.toDouble()),
              min: 5,
              max: maxYears.toDouble(),
              divisions: maxYears - 5,
              onChanged: (v) => setState(() => _years = v.round()),
            ),
          ]),
        ),
        const SizedBox(height: 14),
        SectionCard(
          child: LayoutBuilder(builder: (context, box) {
            final donut = SizedBox(
              width: 128,
              height: 128,
              child: CustomPaint(
                painter: _Donut(principal: _amount, interest: interest),
                child: Center(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(t.calcEmi, style: const TextStyle(fontSize: 11.5, color: C.muted)),
                    FittedBox(child: Text(rupees(e), key: const Key('offer-emi'), style: serif(18))),
                  ]),
                ),
              ),
            );
            final legend = Column(children: [
              _legend(C.brand, t.principal, rupeesShort(_amount, lang: lang)),
              _legend(C.gold, t.interest, rupeesShort(interest, lang: lang)),
              const Divider(height: 18),
              _legend(null, t.totalRepaid, rupeesShort(total, lang: lang)),
            ]);
            // Side by side on wider phones, stacked on narrow ones.
            return box.maxWidth >= 330
                ? Row(children: [donut, const SizedBox(width: 18), Expanded(child: legend)])
                : Column(children: [donut, const SizedBox(height: 12), legend]);
          }),
        ),
        const SizedBox(height: 14),
        SectionCard(
          child: Column(children: [
            _limitBar(t.emiShareIncome, foir, foirCap),
            const SizedBox(height: 14),
            _limitBar(t.loanShareProperty(rupeesShort(s.propertyValue, lang: lang)), ltv, ltvCap),
          ]),
        ),
      ]),
    );
  }

  Widget _head(String label, String value) => Row(children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: C.brand)),
      ]);

  Widget _legend(Color? dot, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: dot ?? C.idle, borderRadius: BorderRadius.circular(3)),
          ),
          Expanded(child: Text(label, maxLines: 2, style: const TextStyle(fontSize: 13, color: C.muted))),
          const SizedBox(width: 8),
          Flexible(
            child: Text(value, textAlign: TextAlign.end, style: TextStyle(fontSize: 13.5, fontWeight: dot == null ? FontWeight.w800 : FontWeight.w700)),
          ),
        ]),
      );

  /// A bar for one policy limit: how much is used, with a marker where the limit is.
  Widget _limitBar(String label, double used, double cap) {
    final ok = used <= cap + 1e-9;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
        Text.rich(TextSpan(children: [
          TextSpan(text: percent(used), style: TextStyle(fontWeight: FontWeight.w800, color: ok ? C.ink : C.badInk)),
          TextSpan(text: ' / ${percent(cap)}', style: const TextStyle(color: C.muted)),
        ]), style: const TextStyle(fontSize: 13)),
      ]),
      const SizedBox(height: 8),
      LayoutBuilder(builder: (context, box) {
        final w = box.maxWidth;
        return SizedBox(
          height: 14,
          child: Stack(clipBehavior: Clip.none, children: [
            Positioned(top: 4, left: 0, right: 0, child: Container(height: 6, decoration: BoxDecoration(color: C.page, borderRadius: BorderRadius.circular(3)))),
            Positioned(
              top: 4,
              left: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 6,
                width: w * used.clamp(0.0, 1.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: ok ? [C.good, const Color(0xFF4ADE80)] : [C.action, C.badInk]),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            Positioned(left: w * cap.clamp(0.0, 1.0) - 1, top: 0, child: Container(width: 2, height: 14, color: C.ink)),
          ]),
        );
      }),
    ]);
  }
}

class _Donut extends CustomPainter {
  _Donut({required this.principal, required this.interest});
  final double principal, interest;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 14.0;
    final rect = Rect.fromCircle(center: size.center(Offset.zero), radius: size.shortestSide / 2 - stroke / 2);
    final total = principal + interest;
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;
    final share = total > 0 ? principal / total : 1.0;
    const start = -math.pi / 2;
    canvas.drawArc(rect, start, 2 * math.pi * share, false, p..color = C.brand);
    canvas.drawArc(rect, start + 2 * math.pi * share, 2 * math.pi * (1 - share), false, p..color = C.gold);
  }

  @override
  bool shouldRepaint(covariant _Donut old) => old.principal != principal || old.interest != interest;
}
