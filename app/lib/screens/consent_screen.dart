import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/consent_sheet.dart';

/// Plain-language consent for each data pull, and the DPDP privacy notice. Nothing is fetched before this.
/// Each needed consent has its own options; the optional ones start off and the customer turns them on.
class ConsentScreen extends StatefulWidget {
  const ConsentScreen({super.key});

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  final _open = <String>{};

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final s = context.watch<AppState>();
    final noAccount = !s.aaAccounts.values.any((v) => v);

    return StepScaffold(
      title: t.consentTitle,
      step: 2,
      buttonLabel: t.agreeAndContinue,
      onPressed: () {
        if (noAccount) return showError(context, t.aaAccountNeeded);
        s.allConsented ? Navigator.pushNamed(context, '/details') : showError(context, t.consentNeeded);
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Notice(tone: Tone.good, icon: Icons.verified_user_outlined, body: t.consentIntro),
        const SizedBox(height: 18),
        SectionTitle(t.consentSectionRequired),
        _required('bureau', Icons.query_stats, t.consentBureauTitle, t.consentBureauBody, [
          _switch('recheck', t.recheckTitle, t.recheckBody, s.recheckBeforePayout, (v) => s.update(() => s.recheckBeforePayout = v)),
        ]),
        _required('aa', Icons.account_balance, t.consentAaTitle, t.consentAaBody, [
          _label(t.aaMonthsLabel),
          Wrap(spacing: 8, children: [
            for (final m in [6, 12, 24])
              _choice(Key('aa-months-$m'), t.monthsN('$m'), s.aaMonths == m, () => s.update(() => s.aaMonths = m)),
          ]),
          const SizedBox(height: 12),
          _label(t.aaAccountsLabel),
          for (final (k, label) in [('salary', t.accountSavingsSalary), ('savings', t.accountSavings), ('fd', t.accountFd)])
            CheckboxListTile(
              key: Key('aa-acc-$k'),
              dense: true,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              value: s.aaAccounts[k],
              title: Text(label, style: const TextStyle(fontSize: 13.5)),
              onChanged: (v) => s.update(() => s.aaAccounts[k] = v ?? false),
            ),
          if (noAccount) Text(t.aaAccountNeeded, style: const TextStyle(fontSize: 12, color: C.badInk)),
        ]),
        _required('kyc', Icons.badge_outlined, t.consentKycTitle, t.consentKycBody, [
          _label(t.kycMethodLabel),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final (k, label) in [('aadhaarOtp', t.kycAadhaarOtp), ('digilocker', t.kycDigilocker), ('videoKyc', t.kycVideo)])
              _choice(Key('kyc-$k'), label, s.kycMethod == k, () => s.update(() => s.kycMethod = k)),
          ]),
          const SizedBox(height: 8),
          _switch('ckyc', t.useCkycTitle, t.useCkycBody, s.useCkyc, (v) => s.update(() => s.useCkyc = v)),
        ]),
        _required('privacy', Icons.privacy_tip_outlined, t.consentPrivacyTitle, t.consentPrivacyBody, const []),
        const SizedBox(height: 12),
        SectionTitle(t.consentSectionOptional),
        _optionalCard(Icons.campaign_outlined, t.optOffersTitle, t.optOffersBody, [
          for (final (k, label) in [('offersSms', t.channelSms), ('offersEmail', t.channelEmail), ('offersWhatsapp', t.channelWhatsapp)])
            _switch('opt-$k', label, null, s.optional[k] ?? false, (v) => s.setOptional(k, v)),
        ]),
        _optionalCard(Icons.chat_outlined, t.optUpdatesTitle, t.optUpdatesBody, [
          _switch('opt-updatesWhatsapp', t.channelWhatsapp, null, s.optional['updatesWhatsapp'] ?? false, (v) => s.setOptional('updatesWhatsapp', v)),
        ]),
        _optionalCard(Icons.health_and_safety_outlined, t.optInsuranceTitle, t.optInsuranceBody, [
          _switch('opt-insurance', t.getQuote, null, s.optional['insurance'] ?? false, (v) => s.setOptional('insurance', v)),
        ]),
        const SizedBox(height: 4),
        Center(
          child: TextButton.icon(
            key: const Key('manage-consents'),
            onPressed: () => showConsentSheet(context),
            icon: const Icon(Icons.tune),
            label: Text('${t.manageConsents} · ${t.consentHistory}'),
          ),
        ),
      ]),
    );
  }

  /// A needed consent: tick to agree; its options fold out underneath.
  Widget _required(String key, IconData icon, String title, String body, List<Widget> options) {
    final t = AppLocalizations.of(context);
    final s = context.watch<AppState>();
    final on = s.consents[key] ?? false;
    final open = _open.contains(key);
    final validity = consentValidity(t, s, key);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), boxShadow: cardShadow),
        child: Material(
          color: C.card,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: on ? C.brand : C.line, width: on ? 1.5 : 1)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            InkWell(
              key: Key('consent-$key'),
              onTap: () => s.setConsent(key, !on),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 8, 10),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  IconBadge(icon),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Expanded(child: Text(title, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700))),
                        Pill(t.consentRequired, tone: Tone.warn),
                      ]),
                      const SizedBox(height: 4),
                      Text(body, style: const TextStyle(fontSize: 12.5, height: 1.4, color: C.muted)),
                      if (validity != null) ...[
                        const SizedBox(height: 6),
                        Row(children: [
                          const Icon(Icons.event_available, size: 14, color: C.goodInk),
                          const SizedBox(width: 4),
                          Expanded(child: Text(validity, style: const TextStyle(fontSize: 11.5, color: C.goodInk, fontWeight: FontWeight.w600))),
                        ]),
                      ],
                    ]),
                  ),
                  Checkbox(value: on, onChanged: (v) => s.setConsent(key, v ?? false)),
                ]),
              ),
            ),
            if (options.isNotEmpty) ...[
              const Divider(height: 1),
              InkWell(
                key: Key('options-$key'),
                onTap: () => setState(() => open ? _open.remove(key) : _open.add(key)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(children: [
                    const Icon(Icons.tune, size: 18, color: C.brand),
                    const SizedBox(width: 8),
                    Expanded(child: Text(t.advancedOptions, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: C.brand))),
                    Icon(open ? Icons.expand_less : Icons.expand_more, color: C.brand),
                  ]),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.topCenter,
                child: open
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: options),
                      )
                    : const SizedBox(width: double.infinity),
              ),
            ],
          ]),
        ),
      ),
    );
  }

  /// An optional consent group: off unless the customer turns it on.
  Widget _optionalCard(IconData icon, String title, String body, List<Widget> switches) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SectionCard(
          padding: const EdgeInsets.fromLTRB(14, 14, 10, 8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconBadge(icon, tone: Tone.good),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(body, style: const TextStyle(fontSize: 12.5, height: 1.4, color: C.muted)),
                ]),
              ),
            ]),
            const SizedBox(height: 4),
            Padding(padding: const EdgeInsets.only(left: 52), child: Column(children: switches)),
          ]),
        ),
      );

  Widget _switch(String key, String title, String? body, bool value, ValueChanged<bool> onChanged) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
              if (body != null) Text(body, style: const TextStyle(fontSize: 12, color: C.muted, height: 1.35)),
            ]),
          ),
          Switch(key: Key(key), value: value, onChanged: onChanged),
        ]),
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 8),
        child: Text(text, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
      );

  Widget _choice(Key key, String label, bool on, VoidCallback onTap) => Material(
        color: on ? C.brandTint : C.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: on ? C.brand : C.field, width: on ? 1.6 : 1)),
        child: InkWell(
          key: key,
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Text(label, style: TextStyle(fontSize: 13, fontWeight: on ? FontWeight.w800 : FontWeight.w500, color: on ? C.brand : C.ink)),
          ),
        ),
      );
}
