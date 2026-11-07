import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import '../format.dart';
import '../l10n/app_localizations.dart';
import '../policy.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Welcome, in the dark "Aurora" look: a 3D loan card, live checks once signed in, every language,
/// the calculators and the demo customers. The rest of the app keeps the classic look.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final resume = _resumePoint(state);
    final p = state.profile;
    final hour = DateTime.now().hour;
    final greeting = hour < 12 ? t.greetMorning : (hour < 17 ? t.greetAfternoon : t.greetEvening);
    const white = TextStyle(color: Aurora.text);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Aurora.bg,
        body: Stack(children: [
          const Positioned.fill(child: _AuroraGlow()),
          Positioned.fill(
            child: SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: ListView(padding: const EdgeInsets.fromLTRB(16, 10, 16, 28), children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      _Header(initials: p == null ? null : _initials(p.name)),
                      const SizedBox(height: 10),
                      if (demoMode) ...[_DemoNote(text: t.sandboxBanner), const SizedBox(height: 16)],
                      Text(greeting, style: const TextStyle(color: Aurora.muted, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text(p == null ? t.welcomeHeadline : t.nearlyThere(p.name.split(' ').first),
                          style: white.copyWith(fontSize: 24, fontWeight: FontWeight.w800, height: 1.2)),
                      if (p == null) ...[
                        const SizedBox(height: 6),
                        Text(t.welcomeBody, style: const TextStyle(color: Aurora.muted, fontSize: 13, height: 1.4)),
                      ],
                      const SizedBox(height: 22),
                      const _LoanCard3D(),
                      const SizedBox(height: 18),
                      Row(children: [
                        Expanded(child: _ProductChip(product: Product.homeLoan, icon: Icons.home_outlined, label: t.productHomeLoan)),
                        const SizedBox(width: 8),
                        Expanded(child: _ProductChip(product: Product.lap, icon: Icons.domain_outlined, label: t.productLap)),
                      ]),
                      const SizedBox(height: 16),
                      if (resume == null)
                        _GradientButton(key: const Key('start'), label: t.startApplication, onTap: () => Navigator.pushNamed(context, '/sign-in'))
                      else ...[
                        _Progress(step: resume.step),
                        const SizedBox(height: 16),
                        _label(t.liveChecks),
                        const _LiveChecks(),
                        const SizedBox(height: 14),
                        _ResumeCard(point: resume),
                      ],
                      const SizedBox(height: 26),
                      _label(t.chooseLanguage),
                      const LanguageGrid(onDark: true),
                      const SizedBox(height: 26),
                      _label(t.calculators),
                      Row(children: [
                        Expanded(child: _GlassTile(key: const Key('calc-emi'), title: t.calcEmi, sub: t.calcEmiSub, onTap: () => _emiSheet(context))),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _GlassTile(
                              key: const Key('calc-eligibility'), title: t.calcEligibility, sub: t.calcEligibilitySub, onTap: () => _eligibilitySheet(context)),
                        ),
                      ]),
                      if (demoMode) ...[
                        const SizedBox(height: 26),
                        _label(t.demoCustomers),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(t.demoCustomersBody, style: const TextStyle(fontSize: 12.5, color: Aurora.muted)),
                        ),
                        _Persona(phone: '9876500001', label: t.personaRavi, product: Product.homeLoan),
                        _Persona(phone: '9876500002', label: t.personaMeena, product: Product.lap),
                        _Persona(phone: '9876500003', label: t.personaArjun, product: Product.homeLoan),
                      ],
                    ]),
                  ]),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  static String _initials(String name) => name.split(' ').where((w) => w.isNotEmpty).take(2).map((w) => w.characters.first).join().toUpperCase();

  /// Where a signed-in customer who came back should continue, which step that is, and how far along they are.
  static ({String route, int step, double done})? _resumePoint(AppState s) {
    if (s.session == null || s.finalDecision != null) return null;
    if (!s.allConsented) return (route: '/consent', step: 2, done: 0.15);
    if (s.profile == null) return (route: '/details', step: 3, done: 0.3);
    if (!(s.selfieResult?.passed ?? false)) return (route: '/selfie', step: 4, done: 0.45);
    if (s.inPrinciple != null) return (route: '/decision', step: 6, done: 0.8);
    return (route: '/documents', step: 5, done: 0.6);
  }
}

Widget _label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text.toUpperCase(), style: const TextStyle(color: Aurora.muted, fontSize: 11.5, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
    );

BoxDecoration _glass({double radius = 16, Color? border}) => BoxDecoration(
      color: Aurora.glass,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: border ?? Aurora.glassLine),
    );

/// Soft teal, violet and magenta light behind the content.
class _AuroraGlow extends StatelessWidget {
  const _AuroraGlow();

  @override
  Widget build(BuildContext context) {
    Widget glow(Color c, double size) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [c.withValues(alpha: 0.32), c.withValues(alpha: 0)])),
        );
    return IgnorePointer(
      child: Stack(clipBehavior: Clip.hardEdge, children: [
        Positioned(top: -120, left: -100, child: glow(Aurora.teal, 380)),
        Positioned(top: 160, right: -140, child: glow(Aurora.violet, 420)),
        Positioned(bottom: -160, left: -60, child: glow(const Color(0xFFD946EF), 380)),
      ]),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({this.initials});
  final String? initials;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(children: [
      Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: Aurora.action, borderRadius: BorderRadius.circular(9)),
        child: const Text('N', style: TextStyle(color: Aurora.bg, fontWeight: FontWeight.w800, fontSize: 15)),
      ),
      const SizedBox(width: 10),
      Expanded(child: Text(t.appTitle, style: const TextStyle(color: Aurora.text, fontSize: 17, fontWeight: FontWeight.w800))),
      const LanguageToggle(onDark: true),
      if (initials != null)
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Aurora.glass, border: Border.all(color: Aurora.glassLine)),
          child: Text(initials!, style: const TextStyle(color: Aurora.text, fontSize: 12, fontWeight: FontWeight.w800)),
        ),
    ]);
  }
}

class _DemoNote extends StatelessWidget {
  const _DemoNote({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: Aurora.amber.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.science_outlined, size: 14, color: Aurora.amber),
          const SizedBox(width: 6),
          Flexible(child: Text(text, style: const TextStyle(color: Aurora.amber, fontSize: 11.5, fontWeight: FontWeight.w600))),
        ]),
      );
}

/// The loan as a card you can tilt: drag (or move the mouse over it) and it leans in 3D, with a moving shine.
class _LoanCard3D extends StatefulWidget {
  const _LoanCard3D();

  @override
  State<_LoanCard3D> createState() => _LoanCard3DState();
}

class _LoanCard3DState extends State<_LoanCard3D> {
  static const _rest = Offset(-0.16, 0.10); // a slight lean, as in the design
  Offset _tilt = _rest;

  void _lean(Offset local, Size size) {
    final dx = (local.dx / size.width - 0.5).clamp(-0.5, 0.5);
    final dy = (local.dy / size.height - 0.5).clamp(-0.5, 0.5);
    setState(() => _tilt = Offset(dx * 0.7, -dy * 0.6));
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final d = state.finalDecision ?? state.inPrinciple;
    final amount = d?.amount ?? state.loanAmount;
    final product = (state.product == Product.homeLoan ? t.productHomeLoan : t.productLap).toUpperCase();
    final left = state.session?.applicationId ?? t.ratePa(Policy.ratePct(state.product).toStringAsFixed(2));
    final right = state.profile?.name.toUpperCase() ?? t.yearsLabel('${state.years}').toUpperCase();

    return LayoutBuilder(builder: (context, box) {
      final size = Size(box.maxWidth, box.maxWidth / 1.7);
      return MouseRegion(
        onHover: (e) => _lean(e.localPosition, size),
        onExit: (_) => setState(() => _tilt = _rest),
        child: GestureDetector(
          onPanUpdate: (e) => _lean(e.localPosition, size),
          onPanEnd: (_) => setState(() => _tilt = _rest),
          child: TweenAnimationBuilder<Offset>(
            key: const Key('loan-card'),
            tween: Tween(begin: const Offset(-0.5, 0.35), end: _tilt),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            builder: (context, tilt, _) => Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0011)
                ..rotateX(tilt.dy)
                ..rotateY(tilt.dx)
                ..rotateZ(-0.03),
              child: Container(
                width: size.width,
                height: size.height,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  gradient: Aurora.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                  boxShadow: [
                    BoxShadow(color: Aurora.teal.withValues(alpha: 0.30), blurRadius: 40, offset: Offset(tilt.dx * -30, 18)),
                    BoxShadow(color: Aurora.violet.withValues(alpha: 0.25), blurRadius: 30, offset: const Offset(0, 10)),
                  ],
                ),
                child: Stack(children: [
                  // The shine moves against the tilt.
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(-1 + tilt.dx * 2, -1),
                          end: Alignment(1 + tilt.dx * 2, 1),
                          colors: [Colors.white.withValues(alpha: 0), Colors.white.withValues(alpha: 0.22), Colors.white.withValues(alpha: 0)],
                          stops: const [0.25, 0.45, 0.65],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Expanded(
                          child: Text(product,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w700, letterSpacing: 2)),
                        ),
                        Transform.rotate(angle: math.pi / 2, child: const Icon(Icons.wifi, color: Colors.white70, size: 20)),
                      ]),
                      const SizedBox(height: 14),
                      const _Chip(),
                      const Spacer(),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(rupees(amount),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                              shadows: [Shadow(color: Color(0x55000000), blurRadius: 8, offset: Offset(0, 2))],
                            )),
                      ),
                      const SizedBox(height: 6),
                      Row(children: [
                        Expanded(
                          child: Text(left, style: const TextStyle(color: Colors.white70, fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w600)),
                        ),
                        Flexible(
                          child: Text(right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 11.5, letterSpacing: 1.4, fontWeight: FontWeight.w700)),
                        ),
                      ]),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _Chip extends StatelessWidget {
  const _Chip();

  @override
  Widget build(BuildContext context) => Container(
        width: 40,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: const LinearGradient(colors: [Color(0xFFF6E3A1), Color(0xFFC9A24A), Color(0xFFF1D67E)]),
        ),
        child: CustomPaint(painter: _ChipLines()),
      );
}

class _ChipLines extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()
      ..color = const Color(0x667A5A12)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, s.height / 3), Offset(s.width, s.height / 3), p);
    canvas.drawLine(Offset(0, s.height * 2 / 3), Offset(s.width, s.height * 2 / 3), p);
    canvas.drawLine(Offset(s.width / 2, 0), Offset(s.width / 2, s.height), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _ProductChip extends StatelessWidget {
  const _ProductChip({required this.product, required this.icon, required this.label});
  final Product product;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final on = state.product == product;
    return Material(
      color: on ? Colors.white.withValues(alpha: 0.14) : Aurora.glass,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: on ? Aurora.teal : Aurora.glassLine, width: on ? 1.6 : 1)),
      child: InkWell(
        key: Key('product-${product.name}'),
        borderRadius: BorderRadius.circular(14),
        onTap: () => state.setProduct(product),
        child: Container(
          constraints: const BoxConstraints(minHeight: 48),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(children: [
            Icon(icon, size: 18, color: on ? Aurora.teal : Aurora.muted),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label,
                  maxLines: 2, style: TextStyle(color: on ? Aurora.text : Aurora.muted, fontSize: 13, fontWeight: on ? FontWeight.w800 : FontWeight.w600)),
            ),
          ]),
        ),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({super.key, required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          gradient: Aurora.action,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Aurora.teal.withValues(alpha: 0.30), blurRadius: 22, offset: const Offset(0, 8))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onTap,
            child: SizedBox(
              height: 54,
              width: double.infinity,
              child: Center(child: Text(label, style: const TextStyle(color: Aurora.bg, fontSize: 16, fontWeight: FontWeight.w800))),
            ),
          ),
        ),
      );
}

/// "Step 4 of 7 · KYC" with a segmented bar, as in the design.
class _Progress extends StatelessWidget {
  const _Progress({required this.step});
  final int step;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final stages = [t.stageSignIn, t.stageDetails, t.stageKyc, t.stageOffer, t.stageProperty];
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: _glass(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
            child: Text('${t.stepOf('$step', '7')} · ${stages[FlowStepper.stageOf(step)]}',
                style: const TextStyle(color: Aurora.text, fontSize: 13.5, fontWeight: FontWeight.w700)),
          ),
          Text(t.minutesLeft('${(8 - step).clamp(1, 7)}'), style: const TextStyle(color: Aurora.muted, fontSize: 12)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          for (var i = 1; i <= 7; i++) ...[
            Expanded(
              child: Container(
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: i < step ? Aurora.teal : (i == step ? Aurora.teal.withValues(alpha: 0.45) : Colors.white.withValues(alpha: 0.12)),
                ),
              ),
            ),
            if (i < 7) const SizedBox(width: 4),
          ],
        ]),
      ]),
    );
  }
}

/// What the engine has checked so far, from the app's own state.
class _LiveChecks extends StatelessWidget {
  const _LiveChecks();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final s = context.watch<AppState>();
    final p = s.profile;
    final done = s.requiredDocs.where((d) => s.documents[d]?.accepted ?? false).length;
    final total = s.requiredDocs.length;
    final tiles = [
      (t.checkBureau, p == null ? t.checkPending : (p.bureauScore == null ? t.checkNoHistory : t.checkScore('${p.bureauScore}')), p == null ? null : Aurora.teal),
      (t.checkBank, p == null ? t.checkPending : t.checkBankRead, p == null ? null : Aurora.teal),
      (t.checkKyc, (s.selfieResult?.passed ?? false) ? t.verified : t.checkPending, (s.selfieResult?.passed ?? false) ? Aurora.teal : null),
      (t.checkDocs, t.countOf('$done', '$total'), done == total ? Aurora.teal : (done > 0 ? Aurora.amber : null)),
    ];
    return LayoutBuilder(builder: (context, box) {
      final w = (box.maxWidth - 8) / 2;
      return Wrap(spacing: 8, runSpacing: 8, children: [
        for (final (label, value, dot) in tiles)
          Container(
            width: w,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
            decoration: _glass(radius: 14, border: dot == Aurora.amber ? Aurora.amber.withValues(alpha: 0.4) : null),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 5, right: 8),
                decoration: BoxDecoration(shape: BoxShape.circle, color: dot ?? Colors.white.withValues(alpha: 0.25)),
              ),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(label, style: const TextStyle(color: Aurora.muted, fontSize: 11.5)),
                  Text(value, style: const TextStyle(color: Aurora.text, fontSize: 13.5, fontWeight: FontWeight.w800)),
                ]),
              ),
            ]),
          ),
      ]);
    });
  }
}

class _ResumeCard extends StatelessWidget {
  const _ResumeCard({required this.point});
  final ({String route, int step, double done}) point;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final pct = (point.done * 100).round();
    return Container(
      key: const Key('resume-card'),
      decoration: _glass(border: Aurora.violet.withValues(alpha: 0.45)).copyWith(
        gradient: LinearGradient(colors: [Aurora.violet.withValues(alpha: 0.20), Aurora.teal.withValues(alpha: 0.10)]),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: const Key('resume'),
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.pushNamed(context, point.route),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
            child: Row(children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(t.continueApplication, style: const TextStyle(color: Aurora.text, fontSize: 15, fontWeight: FontWeight.w800)),
                  Text(t.resumeBody('$pct'), style: const TextStyle(color: Aurora.muted, fontSize: 12)),
                ]),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(gradient: Aurora.action, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.arrow_forward, color: Aurora.bg),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _GlassTile extends StatelessWidget {
  const _GlassTile({super.key, required this.title, required this.sub, required this.onTap});
  final String title, sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
        color: Aurora.glass,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Aurora.glassLine)),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: Aurora.teal.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.calculate_outlined, size: 19, color: Aurora.teal),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: const TextStyle(color: Aurora.text, fontSize: 13.5, fontWeight: FontWeight.w700)),
                  Text(sub, style: const TextStyle(color: Aurora.muted, fontSize: 11.5), maxLines: 2),
                ]),
              ),
            ]),
          ),
        ),
      );
}

class _Persona extends StatelessWidget {
  const _Persona({required this.phone, required this.label, required this.product});
  final String phone, label;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Aurora.glass,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Aurora.glassLine)),
        child: InkWell(
          key: Key('persona-$phone'),
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            state.setProduct(product);
            state.update(() => state.phone = phone);
            Navigator.pushNamed(context, '/sign-in');
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
            child: Row(children: [
              Container(
                width: 38,
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Aurora.violet.withValues(alpha: 0.22)),
                child: Text(label.characters.first, style: const TextStyle(color: Aurora.text, fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(label, style: const TextStyle(color: Aurora.text, fontSize: 14, fontWeight: FontWeight.w600)),
                  Text('+91 $phone', style: const TextStyle(color: Aurora.muted, fontSize: 12)),
                ]),
              ),
              const Icon(Icons.chevron_right, color: Aurora.muted),
            ]),
          ),
        ),
      ),
    );
  }
}

/// A labelled slider row for the calculators.
Widget _slider(String label, String value, double v, double min, double max, int divisions, ValueChanged<double> onChanged) =>
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: C.brand)),
      ]),
      Slider(value: v.clamp(min, max), min: min, max: max, divisions: divisions, onChanged: onChanged),
    ]);

Widget _result(String label, String amount, List<String> lines) => SectionCard(
      tone: Tone.info,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontSize: 12.5, color: C.brandDark)),
        Text(amount, style: serif(30, color: C.brandDark)),
        for (final l in lines) Text(l, style: const TextStyle(fontSize: 12.5, color: C.muted)),
      ]),
    );

void _emiSheet(BuildContext context) {
  final t = AppLocalizations.of(context);
  final state = context.read<AppState>();
  final lang = state.locale.languageCode;
  final rate = Policy.ratePct(state.product);
  final maxYears = Policy.maxTenureYears(state.product);
  var amount = state.loanAmount;
  var years = state.years.clamp(5, maxYears);
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => StatefulBuilder(builder: (context, set) {
      final e = emi(amount, rate, years * 12);
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.emiCalcTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          _slider(t.loanAmountLabel, rupeesShort(amount, lang: lang), amount, 5e5, 2e7, 390, (v) => set(() => amount = (v / 1e5).round() * 1e5)),
          _slider(t.tenureLabel, t.yearsLabel('$years'), years.toDouble(), 5, maxYears.toDouble(), maxYears - 5, (v) => set(() => years = v.round())),
          const SizedBox(height: 8),
          _result(t.calcEmiSub, rupees(e), [t.totalInterest(rupees(e * years * 12 - amount)), t.rateNote(rate.toStringAsFixed(2))]),
        ]),
      );
    }),
  );
}

void _eligibilitySheet(BuildContext context) {
  final t = AppLocalizations.of(context);
  final state = context.read<AppState>();
  final lang = state.locale.languageCode;
  final rate = Policy.ratePct(state.product);
  final maxYears = Policy.maxTenureYears(state.product);
  var income = 100000.0, existing = 0.0;
  var years = state.years.clamp(5, maxYears);
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => StatefulBuilder(builder: (context, set) {
      final maxEmi = (income * Policy.foirCap(income) - existing).clamp(0, double.infinity).toDouble();
      final loan = (loanForEmi(maxEmi, rate, years * 12) / 1000).floorToDouble() * 1000;
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.eligibilityCalcTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          _slider(t.incomeLabel, rupees(income), income, 15000, 500000, 97, (v) => set(() => income = (v / 5000).round() * 5000)),
          _slider(t.existingEmiLabel, rupees(existing), existing, 0, 150000, 60, (v) => set(() => existing = (v / 2500).round() * 2500)),
          _slider(t.tenureLabel, t.yearsLabel('$years'), years.toDouble(), 5, maxYears.toDouble(), maxYears - 5, (v) => set(() => years = v.round())),
          const SizedBox(height: 8),
          _result(t.eligibleTitle, rupeesShort(loan, lang: lang), [t.emiPerMonth(rupees(emi(loan, rate, years * 12))), t.calcIncomeOnly]),
        ]),
      );
    }),
  );
}
