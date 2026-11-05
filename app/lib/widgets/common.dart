import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../state.dart';

/// English / Hindi switch shown on every screen.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: SegmentedButton<String>(
        key: const Key('language'),
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: const [
          ButtonSegment(value: 'en', label: Text('EN')),
          ButtonSegment(value: 'hi', label: Text('हिं')),
        ],
        selected: {state.locale.languageCode},
        onSelectionChanged: (s) => state.setLocale(Locale(s.first)),
      ),
    );
  }
}

class SandboxBanner extends StatelessWidget {
  const SandboxBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      color: scheme.tertiaryContainer,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(AppLocalizations.of(context).sandboxBanner,
          style: TextStyle(color: scheme.onTertiaryContainer, fontSize: 12), textAlign: TextAlign.center),
    );
  }
}

/// A screen in the application flow: title, step progress, content and one main button.
class StepScaffold extends StatelessWidget {
  const StepScaffold({
    super.key,
    required this.title,
    required this.child,
    this.step,
    this.total = 7,
    this.buttonLabel,
    this.onPressed,
    this.busy = false,
    this.leading,
  });

  final String title;
  final Widget child;
  final int? step;
  final int total;
  final String? buttonLabel;
  final VoidCallback? onPressed;
  final bool busy;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title), leading: leading, actions: const [LanguageToggle()]),
      body: SafeArea(
        child: Column(children: [
          const SandboxBanner(),
          if (step != null) ...[
            LinearProgressIndicator(value: step! / total, minHeight: 3),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(t.stepOf('$step', '$total'), style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: ListView(padding: const EdgeInsets.fromLTRB(16, 12, 16, 24), children: [child]),
              ),
            ),
          ),
          if (buttonLabel != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    key: const Key('primary'),
                    onPressed: busy ? null : onPressed,
                    child: busy
                        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5))
                        : Text(buttonLabel!),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}

/// A tick or cross with a label, for check results.
class CheckRow extends StatelessWidget {
  const CheckRow({super.key, required this.ok, required this.label});
  final bool ok;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(ok ? Icons.check_circle : Icons.cancel, color: ok ? Colors.green.shade700 : scheme.error, size: 20),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
      ]),
    );
  }
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
