import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../config.dart';

import '../l10n/app_localizations.dart';
import '../services/api.dart';
import '../state.dart';
import '../theme.dart';
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
  String? _delivery; // how the engine sent the code: "console" means it's in the server's window

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
        _delivery = await state.api.sendOtp(phone);
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
      if (mounted) showError(context, _otpError(t, e.code));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  /// A fresh code, for one that expired, was used up, or never arrived.
  Future<void> _resend() async {
    final t = AppLocalizations.of(context);
    final state = context.read<AppState>();
    setState(() => _busy = true);
    try {
      _delivery = await state.api.sendOtp(_phone.text.trim());
      _otp.clear();
      if (mounted) showError(context, t.newOtpSent);
    } on ApiException catch (e) {
      if (mounted) showError(context, _otpError(t, e.code));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  static String _otpError(AppLocalizations t, String code) => switch (code) {
        'wrong_otp' => t.wrongOtp,
        'expired_otp' => t.otpExpired,
        'too_many_attempts' => t.otpTooManyTries,
        'too_many_requests' => t.otpTooManySends,
        _ => t.errorGeneric,
      };

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return StepScaffold(
      title: t.signInTitle,
      step: 1,
      buttonLabel: _sent ? t.verify : t.sendOtp,
      busy: _busy,
      onPressed: _submit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Labelled(
            label: t.mobileLabel,
            child: TextField(
              key: const Key('phone'),
              controller: _phone,
              enabled: !_sent,
              keyboardType: TextInputType.phone,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
              decoration: InputDecoration(
                hintText: t.mobileHint,
                prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 14, right: 8),
                child: Text('+91', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: C.muted)),
              ),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                suffixIcon: _sent ? const Icon(Icons.check_circle, color: C.good) : null,
              ),
            ),
          ),
          if (_sent) ...[
            const SizedBox(height: 16),
            if (_delivery == 'console')
              Notice(key: const Key('otp-on-server'), tone: Tone.warn, icon: Icons.computer_outlined, body: t.otpOnServer('+91 ${_phone.text}'))
            else
              Notice(tone: Tone.good, icon: Icons.sms_outlined, body: t.otpSentTo('+91 ${_phone.text}')),
            const SizedBox(height: 16),
            Labelled(
              label: t.otpLabel,
              helper: demoMode ? t.demoOtp : null,
              child: TextField(
                key: const Key('otp'),
                controller: _otp,
                autofocus: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: 10),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                decoration: const InputDecoration(hintText: '••••••'),
                onSubmitted: (_) => _submit(),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                key: const Key('resend-otp'),
                onPressed: _busy ? null : _resend,
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(t.resendOtp),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
