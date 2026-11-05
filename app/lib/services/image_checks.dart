// On-phone photo checks before a document is uploaded: blur, glare and darkness.
// They run in pure Dart (the `image` package), so they work the same on Android, iOS and web.
import 'dart:typed_data';

import 'package:image/image.dart' as img;

enum PhotoProblem { none, blurry, glare, dark, unreadable }

class PhotoQuality {
  PhotoQuality({required this.sharpness, required this.glareShare, required this.brightness, required this.median});

  /// Variance of the Laplacian on a 512-px grey copy. Sharp text gives high values.
  final double sharpness;

  /// Share of pixels that are almost pure white (light reflected off the paper or laminate).
  final double glareShare;

  /// Mean and median brightness, 0 to 255.
  final double brightness, median;

  // Sharp text photographed at 1600 px and checked at 512 px scores in the hundreds to thousands;
  // a gaussian blur of radius 8 brings a page down to about 90.
  static const minSharpness = 120.0;
  static const maxGlare = 0.12;
  static const minBrightness = 50.0;

  PhotoProblem get problem {
    if (brightness < minBrightness) return PhotoProblem.dark;
    // A scan or a PDF page has a pure-white background, which is not glare. In a photo the paper
    // comes out grey (median under about 200), so a patch of pure white there is a reflection.
    if (median < 200 && glareShare > maxGlare) return PhotoProblem.glare;
    if (sharpness < minSharpness) return PhotoProblem.blurry;
    return PhotoProblem.none;
  }
}

PhotoQuality? measure(Uint8List bytes) {
  final decoded = img.decodeImage(bytes);
  if (decoded == null) return null;
  final small = decoded.width > 512 ? img.copyResize(decoded, width: 512) : decoded;
  final w = small.width, h = small.height;
  final grey = List<double>.filled(w * h, 0);
  final histogram = List<int>.filled(256, 0);
  var sum = 0.0, bright = 0;
  for (var y = 0; y < h; y++) {
    for (var x = 0; x < w; x++) {
      final p = small.getPixel(x, y);
      final v = 0.299 * p.r + 0.587 * p.g + 0.114 * p.b;
      grey[y * w + x] = v.toDouble();
      sum += v;
      histogram[v.round().clamp(0, 255)]++;
      if (v >= 250) bright++;
    }
  }
  var seen = 0, median = 0;
  while (median < 255 && (seen += histogram[median]) < w * h / 2) {
    median++;
  }
  // Laplacian: 4*centre - up - down - left - right
  var n = 0;
  var mean = 0.0, m2 = 0.0;
  for (var y = 1; y < h - 1; y++) {
    for (var x = 1; x < w - 1; x++) {
      final i = y * w + x;
      final lap = 4 * grey[i] - grey[i - 1] - grey[i + 1] - grey[i - w] - grey[i + w];
      n++;
      final d = lap - mean;
      mean += d / n;
      m2 += d * (lap - mean);
    }
  }
  return PhotoQuality(
    sharpness: n > 1 ? m2 / (n - 1) : 0,
    glareShare: bright / (w * h),
    brightness: sum / (w * h),
    median: median.toDouble(),
  );
}

PhotoProblem check(Uint8List bytes) => measure(bytes)?.problem ?? PhotoProblem.unreadable;
