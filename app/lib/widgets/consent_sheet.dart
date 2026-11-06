import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../state.dart';
import '../theme.dart';
import 'common.dart';

final _when = DateFormat('dd/MM/yyyy, HH:mm');
final _day = DateFormat('dd/MM/yyyy');

/// The customer-facing name of a consent, needed or optional.
String consentName(AppLocalizations t, String key) => switch (key) {
      'bureau' => t.consentBureauTitle,
      'aa' => t.consentAaTitle,
      'kyc' => t.consentKycTitle,
      'privacy' => t.consentPrivacyTitle,
      'offersSms' => '${t.optOffersTitle} · ${t.channelSms}',
      'offersEmail' => '${t.optOffersTitle} · ${t.channelEmail}',
      'offersWhatsapp' => '${t.optOffersTitle} · ${t.channelWhatsapp}',
      'updatesWhatsapp' => t.optUpdatesTitle,
      'insurance' => t.optInsuranceTitle,
      _ => key,
    };

/// "Given 06/11/2026 · valid until 05/05/2027", or "until you withdraw it".
String? consentValidity(AppLocalizations t, AppState s, String key) {
  final given = s.consentGivenAt[key];
  if (given == null) return null;
  final valid = AppState.validity(key);
  return valid == null ? t.consentUntilWithdrawn(_day.format(given)) : t.consentValidUntil(_day.format(given), _day.format(given.add(valid)));
}

/// Manage consents: switch optional ones off (or on), withdraw a needed one, and see the history.
Future<void> showConsentSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheet) => ConstrainedBox(
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.85),
      child: const _ConsentSheet(),
    ),
  );
}

class _ConsentSheet extends StatelessWidget {
  const _ConsentSheet();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final s = context.watch<AppState>();
    final history = s.consentLog.reversed.toList();

    Widget required(String key) {
      final on = s.consents[key] ?? false;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(consentName(t, key), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              Text(on ? (consentValidity(t, s, key) ?? t.consentOn) : t.consentOff, style: const TextStyle(fontSize: 12, color: C.muted)),
            ]),
          ),
          if (on)
            TextButton(key: Key('withdraw-$key'), onPressed: () => _withdraw(context, key), child: Text(t.withdraw))
          else
            Pill(t.consentOff, tone: Tone.warn),
        ]),
      );
    }

    Widget optional(String key) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(children: [
            Expanded(child: Text(consentName(t, key), style: const TextStyle(fontSize: 14))),
            Switch(key: Key('manage-$key'), value: s.optional[key] ?? false, onChanged: (v) => s.setOptional(key, v)),
          ]),
        );

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.manageConsents, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(t.manageConsentsBody, style: const TextStyle(fontSize: 12.5, color: C.muted, height: 1.4)),
          const SizedBox(height: 14),
          SectionTitle(t.consentSectionRequired),
          for (final k in s.consents.keys) required(k),
          const SizedBox(height: 14),
          SectionTitle(t.consentSectionOptional),
          for (final k in s.optional.keys) optional(k),
          const SizedBox(height: 14),
          SectionTitle(t.consentHistory),
          if (history.isEmpty)
            Text(t.historyEmpty, style: const TextStyle(fontSize: 13, color: C.muted))
          else
            for (final e in history)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Icon(e.given ? Icons.check_circle_outline : Icons.remove_circle_outline, size: 18, color: e.given ? C.good : C.badInk),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(e.given ? t.historyGiven(consentName(t, e.key)) : t.historyWithdrawn(consentName(t, e.key)),
                        style: const TextStyle(fontSize: 13)),
                  ),
                  const SizedBox(width: 8),
                  Text(_when.format(e.at), style: const TextStyle(fontSize: 11.5, color: C.muted)),
                ]),
              ),
        ]),
      ),
    );
  }

  Future<void> _withdraw(BuildContext context, String key) async {
    final t = AppLocalizations.of(context);
    final s = context.read<AppState>();
    final nav = Navigator.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: Text('${t.withdraw}: ${consentName(t, key)}'),
        content: Text(t.manageConsentsBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(d, false), child: Text(t.close)),
          FilledButton(key: const Key('confirm-withdraw'), onPressed: () => Navigator.pop(d, true), child: Text(t.withdraw)),
        ],
      ),
    );
    if (ok != true) return;
    s.withdrawRequired(key);
    nav.pop(); // the sheet
    // Back to the consent step: the application can't go on without it.
    nav.popUntil((r) => r.settings.name == '/consent' || r.isFirst);
    if (context.mounted) showError(context, t.withdrawnRequired);
  }
}
