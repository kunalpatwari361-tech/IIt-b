import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../format.dart';
import '../l10n/app_localizations.dart';
import '../reasons.dart';
import '../services/models.dart';
import '../state.dart';
import '../widgets/common.dart';

const grievanceOfficer = ('Anita Rao', 'grievance@nirnay.example'); // fictional, for the demo

/// The decision with its reasons, after Stage A (in principle) or Stage B (final sanction).
class DecisionScreen extends StatelessWidget {
  const DecisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final d = state.finalDecision ?? state.inPrinciple!;
    final lang = state.locale.languageCode;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final isFinal = d.stage == 'final';
    final (title, colour, icon) = switch (d.outcome) {
      Outcome.approve => (isFinal ? t.sanctioned : t.approvedInPrinciple, Colors.green.shade700, Icons.verified),
      Outcome.refer => (t.referredTitle, Colors.orange.shade800, Icons.hourglass_top),
      Outcome.reject => (t.rejectedTitle, scheme.error, Icons.info_outline),
    };
    final positives = d.reasons.where((r) => r.positive).toList();
    final negatives = d.reasons.where((r) => !r.positive).toList();

    return StepScaffold(
      title: t.appTitle,
      step: isFinal ? null : 6,
      leading: IconButton(icon: const Icon(Icons.close), onPressed: () => _startOver(context)),
      buttonLabel: d.outcome == Outcome.approve && !isFinal ? t.addProperty : t.startOver,
      onPressed: d.outcome == Outcome.approve && !isFinal ? () => Navigator.pushNamed(context, '/property') : () => _startOver(context),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t.applicationNo(state.session?.applicationId ?? ''), style: text.labelLarge),
        const SizedBox(height: 8),
        Card(
          key: Key('decision-${d.outcome.name}'),
          elevation: 0,
          color: colour.withValues(alpha: 0.08),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: colour.withValues(alpha: 0.4))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(icon, color: colour),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: text.titleLarge?.copyWith(color: colour, fontWeight: FontWeight.w700))),
              ]),
              if (d.outcome != Outcome.reject) ...[
                const SizedBox(height: 8),
                Text(rupees(d.amount), style: text.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
                Text(t.emiLine(rupees(d.emi), '${d.years}', d.ratePct.toStringAsFixed(2))),
              ],
            ]),
          ),
        ),
        const SizedBox(height: 16),
        if (positives.isNotEmpty) ...[
          Text(t.whyOffer, style: text.titleMedium),
          for (final r in positives) CheckRow(ok: true, label: reasonText(t, r, lang)),
        ],
        if (negatives.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(d.outcome == Outcome.reject ? t.whyRejected : t.whyReferred, style: text.titleMedium),
          for (final r in negatives)
            // The reason code itself (for example R-FRD-03) is for staff only: it is not shown to the
            // customer, so a fraud check is never revealed.
            ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.info_outline, color: colour), title: Text(reasonText(t, r, lang))),
          Text(d.outcome == Outcome.reject ? t.rejectBody : t.referBody),
        ],
        const SizedBox(height: 16),
        if (d.outcome == Outcome.approve) OutlinedButton.icon(key: const Key('kfs'), onPressed: () => _showKfs(context, d), icon: const Icon(Icons.article_outlined), label: Text(t.viewKfs)),
        TextButton.icon(onPressed: () => _grievance(context), icon: const Icon(Icons.support_agent), label: Text(t.grievance)),
      ]),
    );
  }

  void _startOver(BuildContext context) {
    context.read<AppState>().reset();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void _grievance(BuildContext context) {
    final t = AppLocalizations.of(context);
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.grievance),
        content: Text(t.officerLine(grievanceOfficer.$1, grievanceOfficer.$2)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(t.close)),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              showError(context, t.complaintSent('GRV-${DateTime.now().millisecondsSinceEpoch % 100000}'));
            },
            child: Text(t.raiseComplaint),
          ),
        ],
      ),
    );
  }

  void _showKfs(BuildContext context, Decision d) {
    final t = AppLocalizations.of(context);
    final k = Kfs.of(d);
    Widget row(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(children: [Expanded(child: Text(label)), Text(value, style: const TextStyle(fontWeight: FontWeight.w600))]),
        );
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.kfsTitle),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            row(t.kfsLoan, rupees(d.amount)),
            row(t.kfsTenure, t.yearsLabel('${d.years}')),
            row(t.kfsRate, '${d.ratePct.toStringAsFixed(2)}% p.a.'),
            row(t.kfsEmi, rupees(d.emi)),
            row(t.kfsInstalments, '${d.years * 12}'),
            row(t.kfsFee, rupees(k.fee)),
            row(t.kfsTotalInterest, rupees(k.totalInterest)),
            row(t.kfsTotalPayable, rupees(k.totalPayable)),
            row(t.kfsApr, '${k.aprPct.toStringAsFixed(2)}%'),
            const Divider(),
            Text(t.kfsCoolingOff),
            const SizedBox(height: 8),
            Text(t.officerLine(grievanceOfficer.$1, grievanceOfficer.$2)),
            const SizedBox(height: 8),
            Text(t.kfsNote, style: Theme.of(context).textTheme.bodySmall),
          ]),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(t.close))],
      ),
    );
  }
}

/// Key Facts Statement maths: processing fee 0.5% + 18% GST (illustrative), and the APR,
/// the yearly rate at which the EMIs repay the amount actually received (loan minus fee).
class Kfs {
  Kfs({required this.fee, required this.totalInterest, required this.totalPayable, required this.aprPct});
  final double fee, totalInterest, totalPayable, aprPct;

  factory Kfs.of(Decision d) {
    final n = d.years * 12;
    final fee = d.amount * 0.005 * 1.18;
    final totalPayable = d.emi * n;
    final received = d.amount - fee;
    // Solve received = EMI x [1 - (1 + i)^-n] / i for the monthly rate i (bisection).
    var lo = 1e-6, hi = 0.05;
    for (var k = 0; k < 100; k++) {
      final mid = (lo + hi) / 2;
      final pv = d.emi * (1 - math.pow(1 + mid, -n)) / mid;
      if (pv > received) {
        lo = mid;
      } else {
        hi = mid;
      }
    }
    return Kfs(fee: fee, totalInterest: totalPayable - d.amount, totalPayable: totalPayable + fee, aprPct: (lo + hi) / 2 * 12 * 100);
  }
}
