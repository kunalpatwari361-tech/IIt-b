import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import '../l10n/app_localizations.dart';
import '../reasons.dart';
import 'doc_read_screen.dart';
import '../services/capture.dart';
import '../services/image_checks.dart' as checks;
import '../services/models.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Income and KYC papers. Each photo is checked on the phone for blur, glare and darkness
/// before it is sent; the engine then reads it (OCR) and checks it's the right document (model 6).
class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final _busy = <DocSlot>{};
  final _problems = <DocSlot, String>{};
  bool _deciding = false;

  Future<void> _add(DocSlot slot, Future<Uint8List?> Function() source) async {
    final t = AppLocalizations.of(context);
    final state = context.read<AppState>();
    final bytes = await source();
    if (bytes == null) return;
    setState(() {
      _busy.add(slot);
      _problems.remove(slot);
    });
    DocResult? read;
    try {
      // Blur, glare and darkness are photo problems; a PDF goes straight to the engine.
      final pdf = isPdf(bytes);
      final problem = pdf ? checks.PhotoProblem.none : await compute(checks.check, bytes);
      if (problem != checks.PhotoProblem.none) {
        _problems[slot] = switch (problem) {
          checks.PhotoProblem.blurry => t.tooBlurry,
          checks.PhotoProblem.glare => t.tooMuchGlare,
          checks.PhotoProblem.dark => t.tooDark,
          _ => t.docUnreadable,
        };
        return;
      }
      final result = await state.api.uploadDocument(state.session!, slot, bytes, '${slot.name}.${pdf ? 'pdf' : 'jpg'}');
      if (!result.accepted) {
        _problems[slot] = result.reasonCode == 'R-DOC-02' ? t.docUnreadable : t.docWrong(docName(t, slot));
      }
      state.update(() => state.documents[slot] = result);
      read = result;
    } catch (_) {
      _problems[slot] = t.errorGeneric;
    } finally {
      if (mounted) setState(() => _busy.remove(slot));
    }
    // Show what the engine read; the customer can retake the photo from there.
    if (read == null || !mounted) return;
    final retake = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => DocReadScreen(slot: slot, bytes: bytes, result: read!)),
    );
    if (retake == true && mounted) await _add(slot, source);
  }

  Future<void> _decide() async {
    final state = context.read<AppState>();
    setState(() => _deciding = true);
    try {
      final d = await state.api.inPrinciple(state.session!, state.request);
      state.update(() => state.inPrinciple = d);
      if (mounted) Navigator.pushNamed(context, '/decision');
    } catch (_) {
      if (mounted) showError(context, AppLocalizations.of(context).errorGeneric);
    } finally {
      if (mounted) setState(() => _deciding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final missing = state.requiredDocs.where((s) => !(state.documents[s]?.accepted ?? false)).length;
    final done = state.requiredDocs.length - missing;
    final total = state.requiredDocs.length;
    return StepScaffold(
      title: t.docsTitle,
      step: 5,
      busy: _deciding,
      buttonLabel: state.docsComplete ? t.getOffer : t.docsMissing('$missing'),
      onPressed: state.docsComplete ? _decide : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(t.docsProgress('$done', '$total'), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                    ),
                    Pill(missing == 0 ? t.verified : t.docsMissing('$missing'), tone: missing == 0 ? Tone.good : Tone.warn),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(value: total == 0 ? 0 : done / total, minHeight: 8),
                ),
                const SizedBox(height: 10),
                Text(t.docsBody, style: const TextStyle(fontSize: 12.5, color: C.muted)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          for (final slot in state.requiredDocs) _docCard(context, slot),
          SectionCard(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                const IconBadge(Icons.account_balance_outlined, tone: Tone.good),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.docBankStatement, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700)),
                      Text(t.bankViaAa, style: const TextStyle(fontSize: 12.5, color: C.muted)),
                    ],
                  ),
                ),
                Pill(t.fetched, tone: Tone.good),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _docCard(BuildContext context, DocSlot slot) {
    final t = AppLocalizations.of(context);
    final result = context.watch<AppState>().documents[slot];
    final problem = _problems[slot];
    final busy = _busy.contains(slot);
    final ok = result?.accepted ?? false;
    final status = busy ? t.checking : problem ?? (ok ? '${t.docAccepted(docName(t, slot))} · ${(result!.confidence * 100).round()}%' : null);
    final (pill, tone) = busy
        ? (t.checking, Tone.info)
        : problem != null
        ? (t.docTryAgain, Tone.bad)
        : ok
        ? (t.verified, Tone.good)
        : (t.docNeeded, Tone.warn);
    return Padding(
      key: Key('doc-${slot.name}'),
      padding: const EdgeInsets.only(bottom: 10),
      child: SectionCard(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconBadge(ok ? Icons.task_alt : Icons.description_outlined, tone: ok ? Tone.good : (problem != null ? Tone.bad : Tone.info)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(docName(t, slot), style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700)),
                ),
                if (busy) const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) else Pill(pill, tone: tone),
              ],
            ),
            if (status != null)
              Padding(
                padding: const EdgeInsets.only(left: 52, top: 4),
                child: Text(status, style: TextStyle(fontSize: 12.5, color: problem != null ? C.badInk : C.muted)),
              ),
            if (!ok) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: busy ? null : () => _add(slot, () => takePhoto()),
                      icon: const Icon(Icons.photo_camera_outlined, size: 18),
                      label: Text(t.camera, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: busy ? null : () => _add(slot, () => takePhoto(gallery: true)),
                      icon: const Icon(Icons.photo_library_outlined, size: 18),
                      label: Text(t.gallery, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ],
            Wrap(
              alignment: WrapAlignment.end,
              children: [
                // ID cards are photographed: the engine needs the face on them, and e-Aadhaar PDFs are locked.
                if (!ok && slot != DocSlot.pan && slot != DocSlot.aadhaar)
                  TextButton.icon(
                    key: Key('pdf-${slot.name}'),
                    onPressed: busy ? null : () => _add(slot, pickPdf),
                    icon: const Icon(Icons.picture_as_pdf_outlined, size: 18),
                    label: Text(t.uploadPdf),
                  ),
                if (demoMode)
                  TextButton.icon(
                    key: Key('sample-${slot.name}'),
                    onPressed: busy
                        ? null
                        : () => _add(slot, () async {
                              final s = context.read<AppState>();
                              return await s.api.sample(s.session!, slot.name) ?? sampleDocument(seed: slot.index);
                            }),
                    icon: const Icon(Icons.science_outlined, size: 18),
                    label: Text(t.useSample),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
