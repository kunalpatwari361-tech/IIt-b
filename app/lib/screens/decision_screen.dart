import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../config.dart';
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
      Outcome.refer => (t.referredTitle, Tone.warn, Icons.hourglass_top, t.statusPending),
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
                if (d.reference != null)
                  Text(t.decisionRef(d.reference!), key: const Key('decision-ref'), style: const TextStyle(fontSize: 11.5, color: C.muted)),
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
          if (d.score != null) ...[
            const SizedBox(height: 20),
            SectionTitle(t.scoreTitle),
            _ScorePanel(score: d.score!),
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
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  key: const Key('letter'),
                  onPressed: () => _showLetter(context),
                  icon: const Icon(Icons.description_outlined, size: 18),
                  label: Text(t.viewLetter, overflow: TextOverflow.ellipsis),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  key: const Key('ask'),
                  onPressed: () => _showAssistant(context),
                  icon: const Icon(Icons.chat_bubble_outline, size: 18),
                  label: Text(t.askTitle, overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
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
    final engine = d.keyFacts;
    final k = engine != null && engine.loanAmount == d.amount ? engine : KeyFacts.compute(d.amount, d.emi, d.years);
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
              row(t.kfsFeeBase, rupees(k.fee)),
              row(t.kfsGst, rupees(k.gst)),
              row(t.kfsTotalInterest, rupees(k.totalInterest)),
              row(t.kfsTotalPayable, rupees(k.totalPayable)),
              row(t.kfsApr, '${k.aprPct.toStringAsFixed(2)}%'),
              const Divider(),
              Text(t.kfsCoolingOff),
              const SizedBox(height: 8),
              Text(t.officerLine(grievanceOfficer.$1, grievanceOfficer.$2)),
              const SizedBox(height: 8),
              Text(demoMode ? t.kfsNote : t.kfsNoteEngine, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(t.close))],
      ),
    );
  }
}

/// How model 1 (the credit scorecard) reached the score: start, points per factor, score and grade.
class _ScorePanel extends StatelessWidget {
  const _ScorePanel({required this.score});
  final ScoreBreakdown score;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    String label(String input) => switch (input) {
          'bureau_score' => t.factorBureau,
          'credit_history_years' => t.factorHistory,
          'ltv' => t.factorLtv,
          'loan_amount' => t.factorLoanAmount,
          _ => input,
        };
    final good = score.grade == 'A' || score.grade == 'B';
    return SectionCard(
      key: const Key('score-panel'),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${score.score}', style: serif(30)),
              const SizedBox(width: 8),
              Expanded(child: Text(t.scoreOutOf, style: const TextStyle(fontSize: 13, color: C.muted))),
              Pill(t.gradeLabel(score.grade), tone: good ? Tone.good : Tone.warn),
            ],
          ),
          const SizedBox(height: 6),
          Text(t.scoreStart('${score.base}'), style: const TextStyle(fontSize: 12.5, color: C.muted)),
          const Divider(height: 18),
          for (final f in score.factors)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(label(f.input), style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                        Text(_range(t, f),
                            style: const TextStyle(fontSize: 12, color: C.muted)),
                      ],
                    ),
                  ),
                  Text(
                    f.points > 0 ? '+${f.points}' : '${f.points}',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w800, color: f.points > 0 ? C.goodInk : f.points < 0 ? C.badInk : C.muted),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 6),
          Text(t.scoreNote, style: const TextStyle(fontSize: 12, color: C.muted, height: 1.35)),
        ],
      ),
    );
  }
}

/// The scorecard's range for one input ("below 418", "53.5 to 62.2", "738 or more") in the app's language.
String _range(AppLocalizations t, ScoreFactor f) {
  if (f.bin == 'missing' || f.bin == 'unknown value') return t.factorMissing;
  final unit = f.input == 'ltv' ? '%' : '';
  final below = RegExp(r'^below (.+)$').firstMatch(f.bin);
  if (below != null) return t.rangeBelow('${below[1]}$unit');
  final more = RegExp(r'^(.+) or more$').firstMatch(f.bin);
  if (more != null) return t.rangeAtLeast('${more[1]}$unit');
  final between = RegExp(r'^(.+) to (.+)$').firstMatch(f.bin);
  if (between != null) return t.rangeBetween('${between[1]}$unit', '${between[2]}$unit');
  return f.bin;
}

/// The decision letter from the engine (template + the LLM's plain words, translated).
Future<void> _showLetter(BuildContext context) async {
  final t = AppLocalizations.of(context);
  final state = context.read<AppState>();
  final future = state.api.decisionLetter(state.session!, state.locale.languageCode);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheet) => FractionallySizedBox(
      heightFactor: 0.85,
      child: FutureBuilder<DecisionLetter>(
        future: future,
        builder: (context, snap) {
          if (snap.hasError) return Center(child: Text(t.errorGeneric));
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final letter = snap.data!;
          final text = letter.lines.join('\n\n');
          return ListView(
            key: const Key('letter-sheet'),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              Text(t.letterTitle, style: serif(20)),
              if (letter.untranslated > 0) ...[
                const SizedBox(height: 8),
                Notice(tone: Tone.info, icon: Icons.translate, body: t.letterPartlyEnglish),
              ],
              const SizedBox(height: 12),
              SelectableText(text, style: const TextStyle(fontSize: 14, height: 1.5)),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: text));
                  if (sheet.mounted) showError(sheet, t.copied);
                },
                icon: const Icon(Icons.copy, size: 18),
                label: Text(t.copyText),
              ),
            ],
          );
        },
      ),
    ),
  );
}

/// The help assistant: questions about this application, answered by the engine in the customer's language.
Future<void> _showAssistant(BuildContext context) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: const FractionallySizedBox(heightFactor: 0.8, child: _AssistantSheet()),
      ),
    );

class _AssistantSheet extends StatefulWidget {
  const _AssistantSheet();

  @override
  State<_AssistantSheet> createState() => _AssistantSheetState();
}

class _AssistantSheetState extends State<_AssistantSheet> {
  final _question = TextEditingController();
  final _talk = <(String, AssistantAnswer?)>[];
  bool _busy = false;

  @override
  void dispose() {
    _question.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final q = _question.text.trim();
    if (q.isEmpty || _busy) return;
    final t = AppLocalizations.of(context);
    final state = context.read<AppState>();
    setState(() {
      _busy = true;
      _talk.add((q, null));
      _question.clear();
    });
    try {
      final a = await state.api.ask(state.session!, q, state.locale.languageCode);
      setState(() => _talk[_talk.length - 1] = (q, a));
    } catch (_) {
      setState(() => _talk[_talk.length - 1] = (q, AssistantAnswer(answer: t.errorGeneric, handoff: false)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.askTitle, style: serif(20)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              key: const Key('ask-answers'),
              children: [
                for (final (q, a) in _talk) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(top: 8, left: 40),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: C.brandTint, borderRadius: BorderRadius.circular(12)),
                      child: Text(q),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8, right: 40),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: C.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: C.field)),
                    child: a == null
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(a.answer),
                              if (a.handoff) ...[
                                const SizedBox(height: 6),
                                Text(t.askHuman, style: const TextStyle(fontSize: 12, color: C.muted)),
                              ],
                            ],
                          ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key('ask-question'),
                  controller: _question,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _send(),
                  decoration: InputDecoration(hintText: t.askHint),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                key: const Key('ask-send'),
                style: FilledButton.styleFrom(minimumSize: const Size(72, 48)), // the theme's buttons are full width
                onPressed: _busy ? null : _send,
                child: Text(t.askSend),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
