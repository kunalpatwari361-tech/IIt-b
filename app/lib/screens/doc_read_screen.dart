import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../reasons.dart';
import '../services/models.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// What the engine read from a document photo: a scan passes over the photo, then the document
/// type with how sure the classifier is (model 6), the checks, and the fields it read.
/// Pops true when the customer wants to retake the photo.
class DocReadScreen extends StatefulWidget {
  const DocReadScreen({super.key, required this.slot, required this.bytes, required this.result});
  final DocSlot slot;
  final Uint8List bytes;
  final DocResult result;

  @override
  State<DocReadScreen> createState() => _DocReadScreenState();
}

class _DocReadScreenState extends State<DocReadScreen> with SingleTickerProviderStateMixin {
  late final _scan = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..forward();

  @override
  void dispose() {
    _scan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final r = widget.result;
    final asked = docName(t, widget.slot);
    final seen = DocSlot.values.where((s) => s.name == r.detectedType).firstOrNull;
    final fields = r.fields.entries.where((e) => _label(t, e.key) != null).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context, false)),
        title: Text(t.readingDoc(asked), maxLines: 1, overflow: TextOverflow.ellipsis),
        shape: const Border(bottom: BorderSide(color: C.line)),
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Center(child: Pill(t.documentAi)))],
      ),
      body: SafeArea(
        child: Column(children: [
          const SandboxBanner(),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 24), children: [
                  _photo(),
                  const SizedBox(height: 16),
                  AnimatedBuilder(
                    animation: _scan,
                    builder: (context, child) => AnimatedOpacity(
                      opacity: _scan.isCompleted ? 1 : 0.25,
                      duration: const Duration(milliseconds: 300),
                      child: child,
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      SectionCard(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Row(children: [
                            Expanded(
                              child: Text(
                                r.accepted ? t.docAccepted(seen == null ? asked : docName(t, seen)) : t.docWrong(asked),
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: r.accepted ? C.ink : C.badInk),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Pill(t.sure('${(r.confidence * 100).round()}'), tone: r.accepted ? Tone.good : Tone.warn),
                          ]),
                          const SizedBox(height: 8),
                          CheckRow(ok: r.accepted, label: t.readMatches),
                          CheckRow(ok: true, label: t.readClear),
                        ]),
                      ),
                      if (r.accepted && fields.isNotEmpty) ...[
                        const SizedBox(height: 18),
                        SectionTitle(t.whatWeRead),
                        SectionCard(
                          padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
                          child: Column(children: [
                            for (var i = 0; i < fields.length; i++) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(children: [
                                  Expanded(child: Text(_label(t, fields[i].key)!, style: const TextStyle(fontSize: 13, color: C.muted))),
                                  Flexible(
                                    child: Text(fields[i].value,
                                        textAlign: TextAlign.end, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                                  ),
                                ]),
                              ),
                              if (i < fields.length - 1) const Divider(height: 1),
                            ],
                          ]),
                        ),
                      ],
                    ]),
                  ),
                ]),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: C.card,
              border: Border(top: BorderSide(color: C.line)),
              boxShadow: [BoxShadow(color: Color(0x140F1B2D), blurRadius: 16, offset: Offset(0, -4))],
            ),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  key: const Key('retake'),
                  style: OutlinedButton.styleFrom(minimumSize: const Size(0, 52)),
                  onPressed: () => Navigator.pop(context, true),
                  icon: const Icon(Icons.refresh),
                  label: Text(t.retake),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: FilledButton(
                  key: const Key('looks-right'),
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(r.accepted ? t.looksRight : t.close),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }

  /// The photo with a teal scan line passing over it once, then a teal frame.
  Widget _photo() => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AnimatedBuilder(
          animation: _scan,
          builder: (context, _) => Stack(children: [
            Image.memory(widget.bytes, width: double.infinity, fit: BoxFit.fitWidth, gaplessPlayback: true),
            Positioned.fill(
              child: LayoutBuilder(builder: (context, box) {
                final y = box.maxHeight * Curves.easeInOut.transform(_scan.value);
                return Stack(children: [
                  if (!_scan.isCompleted) ...[
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      height: y,
                      child: Container(color: Aurora.teal.withValues(alpha: 0.10)),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: y - 2,
                      height: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Aurora.teal,
                          boxShadow: [BoxShadow(color: Aurora.teal.withValues(alpha: 0.8), blurRadius: 14, spreadRadius: 2)],
                        ),
                      ),
                    ),
                  ] else
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: widget.result.accepted ? Aurora.teal : C.badInk, width: 3),
                        ),
                      ),
                    ),
                ]);
              }),
            ),
          ]),
        ),
      );

  static String? _label(AppLocalizations t, String key) => switch (key) {
        'name' => t.fieldName,
        'pan' => t.fieldPan,
        'aadhaar' => t.fieldAadhaar,
        'employer' => t.fieldEmployer,
        'netPay' => t.fieldNetPay,
        'period' => t.fieldPeriod,
        'year' => t.fieldYear,
        'income' => t.fieldIncome,
        'business' => t.fieldBusiness,
        'gstin' => t.fieldGstin,
        _ => null,
      };
}
