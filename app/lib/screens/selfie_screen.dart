import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config.dart';
import '../l10n/app_localizations.dart';
import '../services/capture.dart';
import '../state.dart';
import '../theme.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Notice(tone: Tone.info, icon: Icons.face_retouching_natural, body: t.selfieBody),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: r == null ? C.brand : (passed ? C.good : C.badInk), width: 3),
              ),
              child: CircleAvatar(
                backgroundColor: C.brandTint,
                backgroundImage: state.selfie != null ? MemoryImage(state.selfie!) : null,
                child: state.selfie == null ? const Icon(Icons.person_outline, size: 84, color: C.brand) : null,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            t.selfieTips,
            style: const TextStyle(fontSize: 12.5, color: C.muted),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              if (r != null)
                OutlinedButton.icon(
                  onPressed: () async => _check(await takePhoto(selfie: true)),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: Text(t.retake),
                ),
              if (demoMode)
                OutlinedButton.icon(
                  key: const Key('sample-selfie'),
                onPressed: () => _check(sampleSelfie()),
                icon: const Icon(Icons.science_outlined, size: 18),
                label: Text(t.useSample),
              ),
            ],
          ),
          if (r != null) ...[
            const SizedBox(height: 16),
            SectionCard(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Column(
                children: [
                  CheckRow(ok: r.faceFound, label: t.checkFace),
                  CheckRow(ok: r.live, label: '${t.checkLive} (${(r.livenessScore * 100).round()}%)'),
                  r.matchPending
                      ? CheckRow(ok: true, label: t.checkMatchPending)
                      : CheckRow(ok: r.faceMatch, label: '${t.checkMatch} (${(r.matchScore * 100).round()}%)'),
                ],
              ),
            ),
            if (!passed) ...[
              const SizedBox(height: 12),
              Notice(tone: Tone.bad, icon: Icons.error_outline, body: t.selfieFailed),
              const SizedBox(height: 4),
              Align(
                child: TextButton(onPressed: () => showError(context, t.videoKycDemo), child: Text(t.videoKyc)),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
