
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../reasons.dart';
import '../services/capture.dart';
import '../services/image_checks.dart' as checks;
import '../services/models.dart';
import '../state.dart';
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
    try {
      final problem = await compute(checks.check, bytes);
      if (problem != checks.PhotoProblem.none) {
        _problems[slot] = switch (problem) {
          checks.PhotoProblem.blurry => t.tooBlurry,
          checks.PhotoProblem.glare => t.tooMuchGlare,
          checks.PhotoProblem.dark => t.tooDark,
          _ => t.docUnreadable,
        };
        return;
      }
      final result = await state.api.uploadDocument(state.session!, slot, bytes, '${slot.name}.jpg');
      if (!result.accepted) {
        _problems[slot] = result.reasonCode == 'R-DOC-02' ? t.docUnreadable : t.docWrong(docName(t, slot));
      }
      state.update(() => state.documents[slot] = result);
    } catch (_) {
      _problems[slot] = t.errorGeneric;
    } finally {
      if (mounted) setState(() => _busy.remove(slot));
    }
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
    return StepScaffold(
      title: t.docsTitle,
      step: 5,
      busy: _deciding,
      buttonLabel: state.docsComplete ? t.getOffer : t.docsMissing('$missing'),
      onPressed: state.docsComplete ? _decide : null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t.docsBody),
        const SizedBox(height: 12),
        for (final slot in state.requiredDocs) _docCard(context, slot),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).dividerColor)),
          child: ListTile(
            leading: const Icon(Icons.account_balance),
            title: Text(t.docBankStatement),
            subtitle: Text(t.bankViaAa),
            trailing: Icon(Icons.check_circle, color: Colors.green.shade700),
          ),
        ),
      ]),
    );
  }

  Widget _docCard(BuildContext context, DocSlot slot) {
    final t = AppLocalizations.of(context);
    final result = context.watch<AppState>().documents[slot];
    final problem = _problems[slot];
    final busy = _busy.contains(slot);
    final ok = result?.accepted ?? false;
    final status = busy
        ? t.checking
        : problem ?? (ok ? '${t.docAccepted(docName(t, slot))} · ${(result!.confidence * 100).round()}%' : null);
    return Card(
      key: Key('doc-${slot.name}'),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).dividerColor)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Icon(ok ? Icons.check_circle : Icons.description_outlined, color: ok ? Colors.green.shade700 : null),
            const SizedBox(width: 12),
            Expanded(child: Text(docName(t, slot), style: const TextStyle(fontWeight: FontWeight.w600))),
            if (busy) const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
          ]),
          if (status != null)
            Padding(
              padding: const EdgeInsets.only(left: 36, top: 4),
              child: Text(status, style: TextStyle(color: problem != null ? Theme.of(context).colorScheme.error : null)),
            ),
          Wrap(spacing: 4, children: [
            TextButton.icon(onPressed: busy ? null : () => _add(slot, () => takePhoto()), icon: const Icon(Icons.photo_camera_outlined), label: Text(t.camera)),
            TextButton.icon(onPressed: busy ? null : () => _add(slot, () => takePhoto(gallery: true)), icon: const Icon(Icons.photo_library_outlined), label: Text(t.gallery)),
            TextButton.icon(
                key: Key('sample-${slot.name}'),
                onPressed: busy ? null : () => _add(slot, () async => sampleDocument(seed: slot.index)),
                icon: const Icon(Icons.science_outlined),
                label: Text(t.useSample)),
          ]),
        ]),
      ),
    );
  }
}
