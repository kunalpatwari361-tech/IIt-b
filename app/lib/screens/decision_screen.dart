import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../format.dart';
import '../l10n/app_localizations.dart';
import '../reasons.dart';
import '../services/models.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/consent_sheet.dart';

const grievanceOfficer = ('Anita Rao', 'grievance@nirnay.example'); // fictional, for the demo

/// The decision with its reasons, after Stage A (in principle) or Stage B (final sanction).
class DecisionScreen extends StatelessWidget {
  const DecisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final d = state.finalDecision ?? state.inPrinciple;
    // Gone when a needed consent is withdrawn: this screen is on its way out.
    if (d == null) return const Scaffold();
    final lang = state.locale.languageCode;
    final isFinal = d.stage == 'final';
    final (title, tone, icon, status) = switch (d.outcome) {
      Outcome.approve => (isFinal ? t.sanctioned : t.approvedInPrinciple, Tone.good, Icons.verified_outlined, isFinal ? t.statusSanctioned : t.statusApproved),
      Outcome.refer => (t.referredTitle, Tone.warn, Icons.hourglass_top, t.statusInReview),
      Outcome.reject => (t.rejectedTitle, Tone.bad, Icons.info_outline, t.statusDeclined),
    };
    final positives = d.reasons.where((r) => r.positive).toList();
    final negatives = d.reasons.where((r) => !r.positive).toList();

    return StepScaffold(
      title: t.appTitle,
      step: isFinal ? null : 6,
      leading: IconButton(icon: const Icon(Icons.close), onPressed: () => _startOver(context)),
      buttonLabel: d.outcome == Outcome.approve && !isFinal ? t.addProperty : t.startOver,
      onPressed: d.outcome == Outcome.approve && !isFinal ? () => Navigator.pushNamed(context, '/property') : () => _startOver(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionCard(
            key: Key('decision-${d.outcome.name}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(t.applicationNo(state.session?.applicationId ?? ''), style: const TextStyle(fontSize: 12, color: C.muted)),
                    ),
                    Pill(status, tone: tone),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconBadge(icon, tone: tone, solid: true, size: 36),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(title, style: serif(19, color: tone.ink)),
                    ),
                  ],
                ),
                if (d.outcome != Outcome.reject) ...[
                  const SizedBox(height: 12),
                  Text(rupees(d.amount), style: serif(32)),
                  Text(t.emiLine(rupees(d.emi), '${d.years}', d.ratePct.toStringAsFixed(2)), style: const TextStyle(fontSize: 13, color: C.muted)),
                  if (state.approvedMax != null && state.approvedMax != d.amount)
                    Text(t.approvedUpTo(rupees(state.approvedMax!)), style: const TextStyle(fontSize: 12.5, color: C.goodInk, fontWeight: FontWeight.w600)),
                ],
                if (d.outcome == Outcome.approve && !isFinal) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      key: const Key('shape-offer'),
                      onPressed: () => Navigator.pushNamed(context, '/offer'),
                      icon: const Icon(Icons.tune),
                      label: Text(t.shapeOffer),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (positives.isNotEmpty) ...[
            const SizedBox(height: 20),
            SectionTitle(t.whyOffer),
            SectionCard(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Column(children: [for (final r in positives) CheckRow(ok: true, label: reasonText(t, r, lang))]),
            ),
          ],
          if (negatives.isNotEmpty) ...[
            const SizedBox(height: 20),
            SectionTitle(d.outcome == Outcome.reject ? t.whyRejected : t.whyReferred),
            SectionCard(
              tone: tone,
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final r in negatives)
                    // The reason code itself (for example R-FRD-03) is for staff only: it is not shown to the
                    // customer, so a fraud check is never revealed.
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, color: tone.ink, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(reasonText(t, r, lang), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.35)),
                          ),
                        ],
                      ),
                    ),
                  Text(d.outcome == Outcome.reject ? t.rejectBody : t.referBody, style: const TextStyle(fontSize: 12.5, color: C.muted, height: 1.4)),
                ],
              ),
            ),
          ],
          if (d.outcome != Outcome.reject) ...[
            const SizedBox(height: 20),
            SectionTitle(t.trackTitle),
            SectionCard(child: Timeline(steps: _track(t, d.outcome, isFinal))),
          ],
          if (d.outcome == Outcome.approve) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                key: const Key('kfs'),
                onPressed: () => _showKfs(context, d),
                icon: const Icon(Icons.article_outlined),
                label: Text(t.viewKfs),
              ),
            ),
          ],
          const SizedBox(height: 14),
          SectionCard(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const IconBadge(Icons.support_agent, size: 38),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(t.helpTitle, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                          Text(t.officerLine(grievanceOfficer.$1, grievanceOfficer.$2), style: const TextStyle(fontSize: 12, color: C.muted)),
                        ],
                      ),
                    ),
                  ],
                ),
                TextButton(onPressed: () => _grievance(context), child: Text(t.grievance)),
                TextButton.icon(
                  key: const Key('manage-consents'),
                  onPressed: () => showConsentSheet(context),
                  icon: const Icon(Icons.tune, size: 18),
                  label: Text(t.manageConsents),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Where the application stands, for the track-your-application timeline.
  static List<TimelineStep> _track(AppLocalizations t, Outcome outcome, bool isFinal) {
    const done = TrackState.done, now = TrackState.current, todo = TrackState.todo;
    if (outcome == Outcome.refer && !isFinal) {
      return [
        TimelineStep(t.tlSubmitted, done),
        TimelineStep(t.tlVerified, done),
        TimelineStep(t.tlOfficer, now, detail: t.tlOfficerNext),
        TimelineStep(t.tlInPrinciple, todo),
        TimelineStep(t.tlProperty, todo),
        TimelineStep(t.tlSanction, todo),
        TimelineStep(t.tlDisbursement, todo),
      ];
    }
    if (outcome == Outcome.refer) {
      return [
        TimelineStep(t.tlSubmitted, done),
        TimelineStep(t.tlVerified, done),
        TimelineStep(t.tlInPrinciple, done),
        TimelineStep(t.tlProperty, done),
        TimelineStep(t.tlOfficer, now, detail: t.tlOfficerNext),
        TimelineStep(t.tlSanction, todo),
        TimelineStep(t.tlDisbursement, todo),
      ];
    }
    return [
      TimelineStep(t.tlSubmitted, done),
      TimelineStep(t.tlVerified, done),
      TimelineStep(t.tlInPrinciple, done),
      TimelineStep(t.tlProperty, isFinal ? done : now, detail: isFinal ? null : t.tlPropertyNext),
      TimelineStep(t.tlLegal, isFinal ? done : todo),
      TimelineStep(t.tlSanction, isFinal ? now : todo, detail: isFinal ? t.tlSanctionNext : null),
      TimelineStep(t.tlDisbursement, todo),
    ];
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
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: C.muted)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(t.kfsTitle),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
            ],
          ),
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
