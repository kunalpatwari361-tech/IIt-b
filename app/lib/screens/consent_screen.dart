import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../state.dart';
import '../widgets/common.dart';

/// Plain-language consent for each data pull, and the DPDP privacy notice. Nothing is fetched before this.
class ConsentScreen extends StatelessWidget {
  const ConsentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    Widget item(String key, IconData icon, String title, String body) => Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).dividerColor)),
          child: CheckboxListTile(
            key: Key('consent-$key'),
            value: state.consents[key],
            onChanged: (v) => state.setConsent(key, v ?? false),
            secondary: Icon(icon),
            isThreeLine: true,
            title: Row(children: [
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
              Text(t.consentRequired, style: Theme.of(context).textTheme.labelSmall),
            ]),
            subtitle: Padding(padding: const EdgeInsets.only(top: 4), child: Text(body)),
          ),
        );
    return StepScaffold(
      title: t.consentTitle,
      step: 2,
      buttonLabel: t.agreeAndContinue,
      onPressed: () => state.allConsented ? Navigator.pushNamed(context, '/details') : showError(context, t.consentNeeded),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t.consentIntro),
        const SizedBox(height: 12),
        item('bureau', Icons.query_stats, t.consentBureauTitle, t.consentBureauBody),
        item('aa', Icons.account_balance, t.consentAaTitle, t.consentAaBody),
        item('kyc', Icons.badge_outlined, t.consentKycTitle, t.consentKycBody),
        item('privacy', Icons.privacy_tip_outlined, t.consentPrivacyTitle, t.consentPrivacyBody),
      ]),
    );
  }
}
