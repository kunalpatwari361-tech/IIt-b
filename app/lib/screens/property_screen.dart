
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../services/capture.dart';
import '../services/models.dart';
import '../state.dart';
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
      _photos[label] = GeoPhoto(label: label, bytes: bytes, takenAt: DateTime.now(),
          latitude: pos?.latitude, longitude: pos?.longitude, accuracyM: pos?.accuracy);
    });
  }

  Future<void> _submit() async {
    final t = AppLocalizations.of(context);
    final state = context.read<AppState>();
    final area = double.tryParse(_area.text), price = double.tryParse(_price.text);
    if (_city.text.trim().isEmpty || _locality.text.trim().isEmpty || area == null || price == null) {
      return showError(context, t.fillAll);
    }
    final property = PropertyInput(city: _city.text.trim(), locality: _locality.text.trim(), society: _society.text.trim(),
        areaSqft: area, bhk: _bhk, declaredPrice: price, isNew: _isNew, photos: _photos.values.toList());
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
    InputDecoration box(String label) => InputDecoration(labelText: label, border: const OutlineInputBorder());
    final digits = [FilteringTextInputFormatter.digitsOnly];
    return StepScaffold(
      title: t.propertyTitle,
      step: 7,
      busy: _busy,
      buttonLabel: t.submitProperty,
      onPressed: _submit,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: TextField(controller: _city, decoration: box(t.cityLabel))),
          const SizedBox(width: 12),
          Expanded(child: TextField(controller: _locality, decoration: box(t.localityLabel))),
        ]),
        const SizedBox(height: 12),
        TextField(controller: _society, decoration: box(t.societyLabel)),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: TextField(controller: _area, keyboardType: TextInputType.number, inputFormatters: digits, decoration: box(t.areaLabel))),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(key: const Key('declared-price'), controller: _price, keyboardType: TextInputType.number,
                inputFormatters: digits, decoration: box(t.declaredPriceLabel).copyWith(prefixText: '₹ ')),
          ),
        ]),
        const SizedBox(height: 12),
        Text(t.bhkLabel),
        Wrap(spacing: 8, children: [
          for (final n in [1, 2, 3, 4, 5]) ChoiceChip(label: Text('$n BHK'), selected: _bhk == n, onSelected: (_) => setState(() => _bhk = n)),
        ]),
        const SizedBox(height: 12),
        SegmentedButton<bool>(
          segments: [ButtonSegment(value: true, label: Text(t.newProperty)), ButtonSegment(value: false, label: Text(t.resale))],
          selected: {_isNew},
          onSelectionChanged: (s) => setState(() => _isNew = s.first),
        ),
        const SizedBox(height: 20),
        Text(t.photosTitle, style: Theme.of(context).textTheme.titleMedium),
        Text(t.photosBody, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 8),
        for (final (key, label) in [('front', t.photoFront), ('inside', t.photoInside), ('view', t.photoView)]) _photoTile(key, label),
      ]),
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Theme.of(context).dividerColor)),
      child: ListTile(
        leading: photo != null
            ? ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.memory(photo.bytes, width: 48, height: 48, fit: BoxFit.cover))
            : const Icon(Icons.add_a_photo_outlined),
        title: Text(label),
        subtitle: busy ? Text(t.pleaseWait) : (where != null ? Text(where) : null),
        trailing: Wrap(children: [
          IconButton(tooltip: t.camera, onPressed: busy ? null : () => _photo(key, () => takePhoto()), icon: const Icon(Icons.photo_camera_outlined)),
          IconButton(tooltip: t.useSample, onPressed: busy ? null : () => _photo(key, () async => sampleDocument(seed: 40 + key.length)),
              icon: const Icon(Icons.science_outlined)),
        ]),
      ),
    );
  }
}
