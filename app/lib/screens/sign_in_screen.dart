import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/api.dart';
import '../state.dart';
import '../widgets/common.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _phone;
  final _otp = TextEditingController();
  bool _sent = false, _busy = false;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(text: context.read<AppState>().phone);
  }

  @override
  void dispose() {
    _phone.dispose();
    _otp.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    final state = context.read<AppState>();
    final phone = _phone.text.trim();
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(phone)) return showError(context, t.invalidMobile);
    setState(() => _busy = true);
    try {
      if (!_sent) {
        await state.api.sendOtp(phone);
        state.update(() => state.phone = phone);
        setState(() => _sent = true);
      } else {
        final device = await state.ensureDeviceId();
        final session = await state.api.verifyOtp(phone, _otp.text.trim(), device);
        state.update(() => state.session = session);
        if (!mounted) return;
        showError(context, t.deviceBound);
        Navigator.pushNamed(context, '/consent');
      }
    } on ApiException catch (e) {
      if (mounted) showError(context, e.code == 'wrong_otp' ? t.wrongOtp : t.errorGeneric);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return StepScaffold(
      title: t.signInTitle,
      step: 1,
      buttonLabel: _sent ? t.verify : t.sendOtp,
      busy: _busy,
      onPressed: _submit,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextField(
          key: const Key('phone'),
          controller: _phone,
          enabled: !_sent,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
          decoration: InputDecoration(labelText: t.mobileLabel, hintText: t.mobileHint, prefixText: '+91 ', border: const OutlineInputBorder()),
        ),
        if (_sent) ...[
          const SizedBox(height: 16),
          Text(t.otpSentTo('+91 ${_phone.text}')),
          const SizedBox(height: 12),
          TextField(
            key: const Key('otp'),
            controller: _otp,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
            decoration: InputDecoration(labelText: t.otpLabel, border: const OutlineInputBorder(), helperText: t.demoOtp),
            onSubmitted: (_) => _submit(),
          ),
        ],
      ]),
    );
  }
}
