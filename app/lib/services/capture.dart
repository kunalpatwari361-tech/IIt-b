// Camera, gallery and location for the selfie, documents and property photos.
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:geolocator/geolocator.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

final _picker = ImagePicker();

/// A photo from the camera (front camera for selfies) or the gallery, at most 1600 px wide.
Future<Uint8List?> takePhoto({bool selfie = false, bool gallery = false}) async {
  final file = await _picker.pickImage(
    source: gallery ? ImageSource.gallery : ImageSource.camera,
    preferredCameraDevice: selfie ? CameraDevice.front : CameraDevice.rear,
    maxWidth: 1600,
    imageQuality: 85,
  );
  return file?.readAsBytes();
}

/// The phone's location for a geo-tag, or null if location is off or not allowed.
Future<Position?> currentPosition() async {
  try {
    if (!await Geolocator.isLocationServiceEnabled()) return null;
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) return null;
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high, timeLimit: Duration(seconds: 15)),
    );
  } catch (_) {
    return null;
  }
}

/// Demo only: a sharp, evenly lit "document" so the flow can be tried without a camera.
Uint8List sampleDocument({int seed = 1}) {
  final r = math.Random(seed);
  final page = img.Image(width: 900, height: 600);
  img.fill(page, color: img.ColorRgb8(226, 224, 218));
  img.fillRect(page, x1: 40, y1: 36, x2: 860, y2: 96, color: img.ColorRgb8(30, 60, 110));
  for (var line = 0; line < 14; line++) {
    final y = 130 + line * 32;
    var x = 50;
    while (x < 820) {
      final w = 20 + r.nextInt(70);
      img.fillRect(page, x1: x, y1: y, x2: math.min(x + w, 850), y2: y + 12, color: img.ColorRgb8(25, 25, 25));
      x += w + 12;
    }
  }
  return Uint8List.fromList(img.encodeJpg(page, quality: 90));
}

/// Demo only: a stand-in selfie (a face-shaped image) for trying the flow without a camera.
Uint8List sampleSelfie() {
  final face = img.Image(width: 480, height: 640);
  img.fill(face, color: img.ColorRgb8(196, 214, 230));
  img.fillCircle(face, x: 240, y: 260, radius: 150, color: img.ColorRgb8(205, 160, 125));
  img.fillCircle(face, x: 190, y: 230, radius: 14, color: img.ColorRgb8(40, 30, 25));
  img.fillCircle(face, x: 290, y: 230, radius: 14, color: img.ColorRgb8(40, 30, 25));
  img.fillRect(face, x1: 200, y1: 320, x2: 280, y2: 330, color: img.ColorRgb8(150, 60, 60));
  return Uint8List.fromList(img.encodeJpg(face, quality: 90));
}
