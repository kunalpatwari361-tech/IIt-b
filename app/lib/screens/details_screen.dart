import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../format.dart';
import '../l10n/app_localizations.dart';
import '../policy.dart';
import '../state.dart';
import '../widgets/common.dart';

/// Auto-filled details and the quick eligibility check, before the full application.
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _pan = TextEditingController(text: 'ABCPK1234F');
  bool _busy = false;

  @override
  void dispose() {
    _pan.dispose();
    super.dispose();
  }

  Future<void> _fetch() async {
    final t = AppLocalizations.of(context);
    final state = context.read<AppState>();
    final pan = _pan.text.trim().toUpperCase();
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(pan)) return showError(context, t.invalidPan);
    setState(() => _busy = true);
    try {
      state.update(() => state.pan = pan);
      state.setProfile(await state.api.fetchProfile(state.session!, pan));
    } catch (_) {
      if (mounted) showError(context, t.errorGeneric);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final lang = state.locale.languageCode;
    final p = state.profile;
    final text = Theme.of(context).textTheme;
    final maxYears = Policy.maxTenureYears(state.product);
    if (state.years > maxYears) state.years = maxYears;

    return StepScaffold(
      title: t.detailsTitle,
      step: 3,
      busy: _busy,
      buttonLabel: p == null ? t.fetchDetails : t.continueLabel,
      onPressed: p == null ? _fetch : () => Navigator.pushNamed(context, '/selfie'),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextField(
          key: const Key('pan'),
          controller: _pan,
          enabled: p == null,
          textCapitalization: TextCapitalization.characters,
          inputFormatters: [LengthLimitingTextInputFormatter(10)],
          decoration: InputDecoration(labelText: t.panLabel, hintText: t.panHint, border: const OutlineInputBorder()),
        ),
        if (p != null) ...[
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(p.name, style: text.titleMedium),
                Text('${t.dobLabel}: ${DateFormat('d MMM y').format(p.dateOfBirth)} · PAN ${p.panMasked} · Aadhaar ${p.aadhaarMasked}'),
                Text('${p.employment == Employment.salaried ? t.salaried : t.selfEmployed} · ${p.employer}'),
                const SizedBox(height: 6),
                Text(t.fetchedFrom, style: text.bodySmall),
              ]),
            ),
          ),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _MoneyField(key: const Key('income'), label: t.incomeLabel, value: state.income, onChanged: (v) => state.update(() => state.income = v))),
            const SizedBox(width: 12),
            Expanded(child: _MoneyField(key: const Key('emi'), label: t.existingEmiLabel, value: state.existingEmi, onChanged: (v) => state.update(() => state.existingEmi = v))),
          ]),
          const SizedBox(height: 12),
          _MoneyField(key: const Key('property-value'), label: t.propertyValueLabel, value: state.propertyValue,
              onChanged: (v) => state.update(() => state.propertyValue = v)),
          const SizedBox(height: 16),
          Text('${t.loanAmountLabel}: ${rupeesShort(state.loanAmount, lang: lang)}', style: text.titleSmall),
          Slider(
            key: const Key('loan-slider'),
            value: state.loanAmount.clamp(5e5, 2e7),
            min: 5e5,
            max: 2e7,
            divisions: 390,
            label: rupeesShort(state.loanAmount, lang: lang),
            onChanged: (v) => state.update(() => state.loanAmount = v),
          ),
          Text('${t.tenureLabel}: ${t.yearsLabel('${state.years}')}', style: text.titleSmall),
          Slider(
            value: state.years.toDouble(),
            min: 5,
            max: maxYears.toDouble(),
            divisions: maxYears - 5,
            label: t.yearsLabel('${state.years}'),
            onChanged: (v) => state.update(() => state.years = v.round()),
          ),
          _EligibilityCard(),
        ],
      ]),
    );
  }
}

class _EligibilityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final e = state.eligibility;
    final lang = state.locale.languageCode;
    final text = Theme.of(context).textTheme;
    final why = switch (e.limitedBy) {
      'income' => t.limitedByIncome(percent(e.foirCap)),
      'property' => t.limitedByProperty(percent(Policy.ltvCap(state.product, e.loanByProperty))),
      _ => t.limitedByAsked,
    };
    return Card(
      key: const Key('eligibility'),
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.eligibleTitle, style: text.labelLarge),
          Text(rupees(e.eligible), key: const Key('eligible-amount'), style: text.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
          Text(t.emiPerMonth(rupees(e.emi)), style: text.titleMedium),
          Text(t.rateNote(e.ratePct.toStringAsFixed(2)), style: text.bodySmall),
          const SizedBox(height: 8),
          Text(why),
          Text('${rupeesShort(e.loanByIncome, lang: lang)} · ${rupeesShort(e.loanByProperty, lang: lang)}', style: text.bodySmall),
          const SizedBox(height: 8),
          Text(t.eligibilityNote, style: text.bodySmall),
        ]),
      ),
    );
  }
}

class _MoneyField extends StatelessWidget {
  const _MoneyField({super.key, required this.label, required this.value, required this.onChanged});
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) => TextFormField(
        initialValue: value.round().toString(),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(labelText: label, prefixText: '₹ ', border: const OutlineInputBorder()),
        onChanged: (s) => onChanged(double.tryParse(s) ?? 0),
      );
}
