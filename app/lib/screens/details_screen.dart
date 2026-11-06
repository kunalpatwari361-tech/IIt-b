import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../format.dart';
import '../l10n/app_localizations.dart';
import '../policy.dart';
import '../state.dart';
import '../theme.dart';
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
      await state.api.recordConsents(state.session!, state.consentRecord);
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
    final maxYears = Policy.maxTenureYears(state.product);
    if (state.years > maxYears) state.years = maxYears;

    return StepScaffold(
      title: t.detailsTitle,
      step: 3,
      busy: _busy,
      buttonLabel: p == null ? t.fetchDetails : t.continueLabel,
      onPressed: p == null ? _fetch : () => Navigator.pushNamed(context, '/selfie'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Labelled(
            label: t.panLabel,
            child: TextField(
              key: const Key('pan'),
              controller: _pan,
              enabled: p == null,
              textCapitalization: TextCapitalization.characters,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1),
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              decoration: InputDecoration(
                hintText: t.panHint,
                suffixIcon: p != null ? const Icon(Icons.check_circle, color: C.good) : null,
              ),
            ),
          ),
          if (p != null) ...[
            const SizedBox(height: 14),
            Notice(tone: Tone.good, icon: Icons.verified_user_outlined, body: t.fetchedFrom),
            const SizedBox(height: 14),
            SectionCard(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: C.brandTint,
                    child: Text(
                      p.name.characters.first,
                      style: const TextStyle(color: C.brand, fontWeight: FontWeight.w800, fontSize: 17),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                        Text('${t.dobLabel}: ${DateFormat('d MMM y').format(p.dateOfBirth)}', style: const TextStyle(fontSize: 12.5, color: C.muted)),
                        Text('PAN ${p.panMasked} · Aadhaar ${p.aadhaarMasked}', style: const TextStyle(fontSize: 12.5, color: C.muted)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Labelled(
              label: t.employmentLabel,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                decoration: BoxDecoration(
                  color: C.brandTint,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: C.brand, width: 2),
                ),
                child: Text(
                  '${p.employment == Employment.salaried ? t.salaried : t.selfEmployed} · ${p.employer}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: C.brand),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Labelled(
              label: t.incomeLabel,
              child: _MoneyField(
                key: const Key('income'),
                value: state.income,
                verified: state.income == p.monthlyIncome ? t.verified : null,
                onChanged: (v) => state.update(() => state.income = v),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Labelled(
                    label: t.existingEmiLabel,
                    child: _MoneyField(key: const Key('emi'), value: state.existingEmi, onChanged: (v) => state.update(() => state.existingEmi = v)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Labelled(
                    label: t.propertyValueLabel,
                    child: _MoneyField(
                      key: const Key('property-value'),
                      value: state.propertyValue,
                      onChanged: (v) => state.update(() => state.propertyValue = v),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SectionTitle(t.yourLoan),
            SectionCard(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
              child: Column(
                children: [
                  _sliderHead(t.loanAmountLabel, rupeesShort(state.loanAmount, lang: lang)),
                  Slider(
                    key: const Key('loan-slider'),
                    value: state.loanAmount.clamp(5e5, 2e7),
                    min: 5e5,
                    max: 2e7,
                    divisions: 390,
                    label: rupeesShort(state.loanAmount, lang: lang),
                    onChanged: (v) => state.update(() => state.loanAmount = v),
                  ),
                  _sliderHead(t.tenureLabel, t.yearsLabel('${state.years}')),
                  Slider(
                    value: state.years.toDouble(),
                    min: 5,
                    max: maxYears.toDouble(),
                    divisions: maxYears - 5,
                    label: t.yearsLabel('${state.years}'),
                    onChanged: (v) => state.update(() => state.years = v.round()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _EligibilityCard(),
          ],
        ],
      ),
    );
  }

  Widget _sliderHead(String label, String value) => Row(
    children: [
      Expanded(
        child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: C.brand),
      ),
    ],
  );
}

/// The quick eligibility result, in the blue offer-card style of the home screen.
class _EligibilityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final e = state.eligibility;
    final lang = state.locale.languageCode;
    final why = switch (e.limitedBy) {
      'income' => t.limitedByIncome(percent(e.foirCap)),
      'property' => t.limitedByProperty(percent(Policy.ltvCap(state.product, e.loanByProperty))),
      _ => t.limitedByAsked,
    };
    const soft = TextStyle(color: C.onBrandMuted, fontSize: 12.5, height: 1.35);
    return Container(
      key: const Key('eligibility'),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: brandGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x330A2550), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withValues(alpha: 0.08)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.eligibleTitle, style: const TextStyle(color: Colors.white, fontSize: 14)),
                Text(
                  rupees(e.eligible),
                  key: const Key('eligible-amount'),
                  style: serif(32, color: Colors.white),
                ),
                Text(
                  t.emiPerMonth(rupees(e.emi)),
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                ),
                Text(t.rateNote(e.ratePct.toStringAsFixed(2)), style: soft),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(why, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.35)),
                      const SizedBox(height: 4),
                      Text(
                        '${rupeesShort(e.loanByIncome, lang: lang)} · ${rupeesShort(e.loanByProperty, lang: lang)}',
                        style: soft,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(t.eligibilityNote, style: soft),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MoneyField extends StatelessWidget {
  const _MoneyField({super.key, required this.value, required this.onChanged, this.verified});
  final double value;
  final ValueChanged<double> onChanged;
  final String? verified;

  @override
  Widget build(BuildContext context) => TextFormField(
    initialValue: value.round().toString(),
    keyboardType: TextInputType.number,
    style: const TextStyle(fontSize: 15),
    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    decoration: InputDecoration(
      prefixText: '₹ ',
      suffixIcon: verified == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Pill(verified!, tone: Tone.good),
            ),
      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    ),
    onChanged: (s) => onChanged(double.tryParse(s) ?? 0),
  );
}
