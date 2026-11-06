import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/capture.dart';
import '../services/models.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Stage B: property details and geo-tagged photos, then the final sanction.
class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key});

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  final _city = TextEditingController(text: 'Pune');
  final _locality = TextEditingController(text: 'Kharadi');
  final _society = TextEditingController(text: 'Palm Meadows');
  final _area = TextEditingController(text: '1050');
  late final TextEditingController _price;
  int _bhk = 2;
  bool _isNew = true, _busy = false;
  final _photos = <String, GeoPhoto>{};
  final _taking = <String>{};

  @override
  void initState() {
    super.initState();
    _price = TextEditingController(text: context.read<AppState>().propertyValue.round().toString());
  }

  @override
  void dispose() {
    for (final c in [_city, _locality, _society, _area, _price]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _photo(String label, Future<Uint8List?> Function() source) async {
    final bytes = await source();
    if (bytes == null) return;
    setState(() => _taking.add(label));
    final pos = await currentPosition();
    setState(() {
      _taking.remove(label);
      _photos[label] = GeoPhoto(
        label: label,
        bytes: bytes,
        takenAt: DateTime.now(),
        latitude: pos?.latitude,
        longitude: pos?.longitude,
        accuracyM: pos?.accuracy,
      );
    });
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    final state = context.read<AppState>();
    final area = double.tryParse(_area.text), price = double.tryParse(_price.text);
    if (_city.text.trim().isEmpty || _locality.text.trim().isEmpty || area == null || price == null) {
      return showError(context, t.fillAll);
    }
    final property = PropertyInput(
      city: _city.text.trim(),
      locality: _locality.text.trim(),
      society: _society.text.trim(),
      areaSqft: area,
      bhk: _bhk,
      declaredPrice: price,
      isNew: _isNew,
      photos: _photos.values.toList(),
    );
    setState(() => _busy = true);
    try {
      final d = await state.api.finalSanction(state.session!, state.request, property);
      state.update(() {
        state.property = property;
        state.finalDecision = d;
      });
      if (mounted) Navigator.pushNamed(context, '/decision');
    } catch (_) {
      if (mounted) showError(context, t.errorGeneric);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final digits = [FilteringTextInputFormatter.digitsOnly];
    Widget field(String label, TextEditingController c, {Key? key, bool number = false, String? prefix}) => Labelled(
      label: label,
      child: TextField(
        key: key,
        controller: c,
        keyboardType: number ? TextInputType.number : TextInputType.text,
        inputFormatters: number ? digits : null,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(prefixText: prefix),
      ),
    );
    Widget choice(String label, bool on, VoidCallback onTap) => Material(
      color: on ? C.brandTint : C.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: on ? C.brand : C.field, width: on ? 2 : 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 46, minWidth: 56),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: on ? FontWeight.w800 : FontWeight.w500, color: on ? C.brand : C.ink),
          ),
        ),
      ),
    );
    return StepScaffold(
      title: t.propertyTitle,
      step: 7,
      busy: _busy,
      buttonLabel: t.submitProperty,
      onPressed: _submit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: field(t.cityLabel, _city)),
              const SizedBox(width: 12),
              Expanded(child: field(t.localityLabel, _locality)),
            ],
          ),
          const SizedBox(height: 14),
          field(t.societyLabel, _society),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: field(t.areaLabel, _area, number: true)),
              const SizedBox(width: 12),
              Expanded(
                child: field(t.declaredPriceLabel, _price, key: const Key('declared-price'), number: true, prefix: '₹ '),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Labelled(
            label: t.bhkLabel,
            child: Row(
              children: [
                for (final n in [1, 2, 3, 4, 5]) ...[
                  Expanded(child: choice('$n BHK', _bhk == n, () => setState(() => _bhk = n))),
                  if (n < 5) const SizedBox(width: 6),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          Labelled(
            label: t.propertyType,
            child: Row(
              children: [
                Expanded(child: choice(t.newProperty, _isNew, () => setState(() => _isNew = true))),
                const SizedBox(width: 8),
                Expanded(child: choice(t.resale, !_isNew, () => setState(() => _isNew = false))),
              ],
            ),
          ),
          const SizedBox(height: 22),
          SectionTitle(t.photosTitle),
          Notice(tone: Tone.info, icon: Icons.location_on_outlined, body: t.photosBody),
          const SizedBox(height: 10),
          for (final (key, label) in [('front', t.photoFront), ('inside', t.photoInside), ('view', t.photoView)]) _photoTile(key, label),
        ],
      ),
    );
  }

  Widget _photoTile(String key, String label) {
    final t = AppLocalizations.of(context);
    final photo = _photos[key];
    final busy = _taking.contains(key);
    final where = photo == null
        ? null
        : photo.geoTagged
        ? t.geoTagged(photo.latitude!.toStringAsFixed(5), photo.longitude!.toStringAsFixed(5))
        : t.noLocation;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SectionCard(
        padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: photo != null
                  ? Image.memory(photo.bytes, width: 52, height: 52, fit: BoxFit.cover)
                  : Container(
                      width: 52,
                      height: 52,
                      color: C.brandTint,
                      child: const Icon(Icons.add_a_photo_outlined, color: C.brand),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700)),
                  if (busy || where != null)
                    Text(busy ? t.pleaseWait : where!, style: TextStyle(fontSize: 12, color: photo != null && photo.geoTagged ? C.goodInk : C.muted)),
                ],
              ),
            ),
            IconButton(
              tooltip: t.camera,
              onPressed: busy ? null : () => _photo(key, () => takePhoto()),
              icon: const Icon(Icons.photo_camera_outlined, color: C.brand),
            ),
            IconButton(
              tooltip: t.useSample,
              onPressed: busy
                  ? null
                  : () => _photo(key, () async {
                        final s = context.read<AppState>();
                        return await s.api.sample(s.session!, 'photo-$key') ?? sampleDocument(seed: 40 + key.length);
                      }),
              icon: const Icon(Icons.science_outlined, color: C.brand),
            ),
          ],
        ),
      ),
    );
  }
}
