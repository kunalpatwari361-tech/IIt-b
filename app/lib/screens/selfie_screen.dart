import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/capture.dart';
import '../state.dart';
import '../widgets/common.dart';

/// Selfie for eKYC: the engine checks liveness and matches it 1:1 with the Aadhaar photo.
class SelfieScreen extends StatefulWidget {
  const SelfieScreen({super.key});

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  bool _busy = false;

  Future<void> _check(Uint8List? bytes) async {
    if (bytes == null) return;
    final state = context.read<AppState>();
    setState(() => _busy = true);
    try {
      final result = await state.api.checkSelfie(state.session!, bytes);
      state.update(() {
        state.selfie = bytes;
        state.selfieResult = result;
      });
    } catch (_) {
      if (mounted) showError(context, AppLocalizations.of(context).errorGeneric);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final state = context.watch<AppState>();
    final r = state.selfieResult;
    final passed = r?.passed ?? false;
    return StepScaffold(
      title: t.selfieTitle,
      step: 4,
      busy: _busy,
      buttonLabel: passed ? t.continueLabel : t.takeSelfie,
      onPressed: passed ? () => Navigator.pushNamed(context, '/documents') : () async => _check(await takePhoto(selfie: true)),
      child: Column(children: [
        Text(t.selfieBody),
        const SizedBox(height: 16),
        CircleAvatar(
          radius: 84,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          backgroundImage: state.selfie != null ? MemoryImage(state.selfie!) : null,
          child: state.selfie == null ? const Icon(Icons.face_retouching_natural, size: 72) : null,
        ),
        const SizedBox(height: 8),
        Text(t.selfieTips, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
        if (r != null) ...[
          const SizedBox(height: 16),
          CheckRow(ok: r.faceFound, label: t.checkFace),
          CheckRow(ok: r.live, label: '${t.checkLive} (${(r.livenessScore * 100).round()}%)'),
          CheckRow(ok: r.faceMatch, label: '${t.checkMatch} (${(r.matchScore * 100).round()}%)'),
          if (!passed) ...[
            const SizedBox(height: 8),
            Text(t.selfieFailed, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            TextButton(onPressed: () => showError(context, t.videoKycDemo), child: Text(t.videoKyc)),
          ],
        ],
        const SizedBox(height: 8),
        Wrap(spacing: 8, alignment: WrapAlignment.center, children: [
          if (r != null) OutlinedButton.icon(onPressed: () async => _check(await takePhoto(selfie: true)), icon: const Icon(Icons.refresh), label: Text(t.retake)),
          TextButton.icon(
              key: const Key('sample-selfie'),
              onPressed: () => _check(sampleSelfie()),
              icon: const Icon(Icons.science_outlined),
              label: Text(t.useSample)),
        ]),
      ]),
    );
  }
}
