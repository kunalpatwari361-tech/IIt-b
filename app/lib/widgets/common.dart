import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../languages.dart';
import '../state.dart';
import '../theme.dart';

/// The language button in every header: shows the current language and opens the picker.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key, this.onDark = false});
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final lang = languageOf(state.locale.languageCode);
    final fg = onDark ? Colors.white : C.brand;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Center(
        child: Material(
          color: onDark ? Colors.white.withValues(alpha: 0.12) : C.page,
          shape: StadiumBorder(side: BorderSide(color: onDark ? Colors.white.withValues(alpha: 0.24) : C.line)),
          child: InkWell(
            key: const Key('language'),
            customBorder: const StadiumBorder(),
            onTap: () => showLanguagePicker(context),
            child: Container(
              height: 34,
              constraints: const BoxConstraints(maxWidth: 130),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.translate, size: 16, color: fg),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(lang.native,
                      maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: fg)),
                ),
                Icon(Icons.expand_more, size: 16, color: fg),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

/// A grid of all the languages, each in its own script, for the welcome screen and the picker.
class LanguageGrid extends StatelessWidget {
  const LanguageGrid({super.key, this.onDark = false, this.onPicked});
  final bool onDark;
  final VoidCallback? onPicked;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final current = state.locale.languageCode;
    return LayoutBuilder(builder: (context, box) {
      final columns = box.maxWidth > 480 ? 4 : 3;
      const gap = 8.0;
      final w = (box.maxWidth - gap * (columns - 1)) / columns;
      return Wrap(spacing: gap, runSpacing: gap, children: [
        for (final l in appLanguages)
          SizedBox(
            width: w,
            child: _LanguageChip(
              language: l,
              selected: l.code == current,
              onDark: onDark,
              onTap: () {
                state.setLocale(Locale(l.code));
                onPicked?.call();
              },
            ),
          ),
      ]);
    });
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({required this.language, required this.selected, required this.onDark, required this.onTap});
  final AppLanguage language;
  final bool selected, onDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? (onDark ? Colors.white.withValues(alpha: 0.16) : C.brandTint) : (onDark ? Colors.white.withValues(alpha: 0.05) : C.card);
    final border = selected ? (onDark ? Aurora.teal : C.brand) : (onDark ? Colors.white.withValues(alpha: 0.10) : C.line);
    return Material(
      color: bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: border, width: selected ? 1.6 : 1)),
      child: InkWell(
        key: Key('lang-${language.code}'),
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(children: [
            Text(language.native,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: onDark ? Colors.white : (selected ? C.brand : C.ink))),
            Text(language.english,
                maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10.5, color: onDark ? Aurora.muted : C.muted)),
          ]),
        ),
      ),
    );
  }
}

Future<void> showLanguagePicker(BuildContext context) {
  final t = AppLocalizations.of(context);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheet) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheet).height * 0.8),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.chooseLanguage, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const SizedBox(height: 4),
            Text(t.languageNote, style: const TextStyle(fontSize: 12, color: C.muted)),
            const SizedBox(height: 14),
            LanguageGrid(onPicked: () => Navigator.pop(sheet)),
          ]),
        ),
      ),
    ),
  );
}

class SandboxBanner extends StatelessWidget {
  const SandboxBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: C.warnTint,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Text(
        AppLocalizations.of(context).sandboxBanner,
        style: const TextStyle(color: C.warnInk, fontSize: 11.5, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// The five stages of the journey, with the current one highlighted. Steps 1-7 of the flow map onto them.
class FlowStepper extends StatelessWidget {
  const FlowStepper({super.key, required this.step});
  final int step;

  static int stageOf(int step) => const {1: 0, 2: 0, 3: 1, 4: 2, 5: 2, 6: 3, 7: 4}[step] ?? 0;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final labels = [t.stageSignIn, t.stageDetails, t.stageKyc, t.stageOffer, t.stageProperty];
    final current = stageOf(step);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(child: Container(height: 2, color: i == 0 ? Colors.transparent : (i <= current ? C.brand : C.field))),
                            Expanded(child: Container(height: 2, color: i == labels.length - 1 ? Colors.transparent : (i < current ? C.brand : C.field))),
                          ],
                        ),
                        _dot(i, current),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: i == current ? FontWeight.w800 : (i < current ? FontWeight.w600 : FontWeight.w400),
                      color: i == current ? C.brand : (i < current ? C.ink : C.muted),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _dot(int i, int current) {
    if (i < current) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(color: C.brand, shape: BoxShape.circle),
        child: const Icon(Icons.check_rounded, size: 15, color: Colors.white),
      );
    }
    final on = i == current;
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: C.card,
        shape: BoxShape.circle,
        border: Border.all(color: on ? C.brand : C.idle, width: 2),
      ),
      child: Text(
        '${i + 1}',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: on ? C.brand : C.muted),
      ),
    );
  }
}

/// A screen in the application flow: header with the stage stepper, content, and one main button at the bottom.
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
    this.footnote,
  });

  final String title;
  final Widget child;
  final int? step;
  final int total;
  final String? buttonLabel;
  final VoidCallback? onPressed;
  final bool busy;
  final Widget? leading;
  final String? footnote;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final note = footnote ?? (step != null ? t.stepOf('$step', '$total') : null);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: leading,
        actions: const [LanguageToggle()],
        shape: const Border(bottom: BorderSide(color: C.line)),
        bottom: step == null
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(52),
                child: FlowStepper(step: step!),
              ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SandboxBanner(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 24), children: [child]),
                ),
              ),
            ),
            if (buttonLabel != null)
              Container(
                decoration: const BoxDecoration(
                  color: C.card,
                  border: Border(top: BorderSide(color: C.line)),
                  boxShadow: [BoxShadow(color: Color(0x140F1B2D), blurRadius: 16, offset: Offset(0, -4))],
                ),
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            key: const Key('primary'),
                            onPressed: busy ? null : onPressed,
                            child: busy
                                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                                : Text(buttonLabel!, textAlign: TextAlign.center),
                          ),
                        ),
                        if (note != null) ...[const SizedBox(height: 8), Text(note, style: const TextStyle(fontSize: 12, color: C.muted))],
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

enum Tone { info, good, warn, bad }

extension ToneColours on Tone {
  Color get ink => switch (this) {
    Tone.info => C.brand,
    Tone.good => C.goodInk,
    Tone.warn => C.warnInk,
    Tone.bad => C.badInk,
  };
  Color get tint => switch (this) {
    Tone.info => C.brandTint,
    Tone.good => C.goodTint,
    Tone.warn => C.warnTint,
    Tone.bad => C.badTint,
  };
  Color get line => switch (this) {
    Tone.info => const Color(0xFFC9D6F0),
    Tone.good => C.goodLine,
    Tone.warn => C.warnLine,
    Tone.bad => C.badLine,
  };
  Color get solid => switch (this) {
    Tone.info => C.brand,
    Tone.good => C.good,
    Tone.warn => C.action,
    Tone.bad => C.badInk,
  };
}

/// A white card with a thin border, the basic block of every screen.
class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.tone});
  final Widget child;
  final EdgeInsets padding;
  final Tone? tone;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: padding,
    decoration: BoxDecoration(
      color: tone?.tint ?? C.card,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: tone?.line ?? C.line),
      boxShadow: tone == null ? cardShadow : null,
    ),
    child: child,
  );
}

/// A tinted strip with an icon: what we filled in for you, what's needed, what went wrong.
class Notice extends StatelessWidget {
  const Notice({super.key, required this.tone, required this.icon, required this.body, this.title, this.trailing});
  final Tone tone;
  final IconData icon;
  final String? title;
  final String body;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: tone.tint,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: tone.line),
    ),
    child: Row(
      children: [
        Icon(icon, color: tone.ink, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: tone == Tone.info ? C.ink : tone.ink),
                ),
              Text(body, style: TextStyle(fontSize: 13, height: 1.35, color: title == null ? tone.ink : C.muted)),
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    ),
  );
}

/// A small status label, like "Verified" or "In progress".
class Pill extends StatelessWidget {
  const Pill(this.text, {super.key, this.tone = Tone.info});
  final String text;
  final Tone tone;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: tone.tint, borderRadius: BorderRadius.circular(6)),
    child: Text(
      text,
      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: tone.ink),
    ),
  );
}

/// An icon in a tinted rounded square.
class IconBadge extends StatelessWidget {
  const IconBadge(this.icon, {super.key, this.tone = Tone.info, this.size = 40, this.solid = false});
  final IconData icon;
  final Tone tone;
  final double size;
  final bool solid;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: solid ? tone.solid : tone.tint, borderRadius: BorderRadius.circular(size * 0.3)),
    child: Icon(icon, size: size * 0.55, color: solid ? Colors.white : tone.ink),
  );
}

/// A heading above a group of cards.
class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Container(
          width: 3,
          height: 16,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(color: C.gold, borderRadius: BorderRadius.circular(2)),
        ),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
        ),
        ?trailing,
      ],
    ),
  );
}

/// A form field with its label above it, as in the market-standard forms.
class Labelled extends StatelessWidget {
  const Labelled({super.key, required this.label, required this.child, this.helper});
  final String label;
  final Widget child;
  final String? helper;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
      const SizedBox(height: 6),
      child,
      if (helper != null) ...[const SizedBox(height: 6), Text(helper!, style: const TextStyle(fontSize: 12, color: C.muted))],
    ],
  );
}

/// A tick or cross with a label, for check results.
class CheckRow extends StatelessWidget {
  const CheckRow({super.key, required this.ok, required this.label});
  final bool ok;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(color: ok ? C.good : C.badInk, shape: BoxShape.circle),
            child: Icon(ok ? Icons.check_rounded : Icons.close_rounded, size: 15, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(label, style: const TextStyle(fontSize: 14, height: 1.35)),
            ),
          ),
        ],
      ),
    );
  }
}

enum TrackState { done, current, todo }

/// One row of the track-your-application timeline.
class TimelineStep {
  const TimelineStep(this.title, this.state, {this.detail});
  final String title;
  final String? detail;
  final TrackState state;
}

class Timeline extends StatelessWidget {
  const Timeline({super.key, required this.steps});
  final List<TimelineStep> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < steps.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    _marker(steps[i].state),
                    if (i < steps.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          constraints: const BoxConstraints(minHeight: 18),
                          color: steps[i].state == TrackState.done ? (steps[i + 1].state == TrackState.todo ? C.field : C.good) : C.field,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: i < steps.length - 1 ? 14 : 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: switch (steps[i].state) {
                              TrackState.done => FontWeight.w700,
                              TrackState.current => FontWeight.w800,
                              _ => FontWeight.w400,
                            },
                            color: switch (steps[i].state) {
                              TrackState.current => C.brand,
                              TrackState.todo => C.muted,
                              _ => C.ink,
                            },
                          ),
                        ),
                        if (steps[i].detail != null) Text(steps[i].detail!, style: const TextStyle(fontSize: 12, color: C.muted)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _marker(TrackState s) => switch (s) {
    TrackState.done => Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(color: C.good, shape: BoxShape.circle),
      child: const Icon(Icons.check_rounded, size: 14, color: Colors.white),
    ),
    TrackState.current => Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: C.card,
        shape: BoxShape.circle,
        border: Border.all(color: C.brand, width: 3),
      ),
    ),
    TrackState.todo => Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: C.idle, width: 2),
      ),
    ),
  };
}

void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

/// The Nirnay mark: a serif N under a gold roof line, on white (navy header) or navy (white header).
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 36, this.onDark = false});
  final double size;
  final bool onDark;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: onDark ? Colors.white : C.brand, borderRadius: BorderRadius.circular(size * 0.28), boxShadow: onDark ? null : cardShadow),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: size * 0.14,
          child: CustomPaint(size: Size(size * 0.5, size * 0.16), painter: _RoofPainter()),
        ),
        Padding(
          padding: EdgeInsets.only(top: size * 0.18),
          child: Text('N', style: serif(size * 0.5, color: onDark ? C.brand : Colors.white, height: 1)),
        ),
      ],
    ),
  );
}

class _RoofPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = C.gold
      ..strokeWidth = size.height * 0.45
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height)
        ..lineTo(size.width / 2, 0)
        ..lineTo(size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
