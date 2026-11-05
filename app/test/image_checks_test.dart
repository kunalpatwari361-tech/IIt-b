import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:nirnay_app/services/capture.dart';
import 'package:nirnay_app/services/image_checks.dart';

Uint8List jpg(img.Image i) => Uint8List.fromList(img.encodeJpg(i, quality: 92));

void main() {
  final page = img.decodeJpg(sampleDocument())!;

  test('a sharp, evenly lit document passes', () {
    expect(check(sampleDocument()), PhotoProblem.none);
  });

  test('a blurred copy is caught', () {
    expect(check(jpg(img.gaussianBlur(page.clone(), radius: 8))), PhotoProblem.blurry);
    expect(check(jpg(img.gaussianBlur(page.clone(), radius: 1))), PhotoProblem.none); // slight softness is fine
  });

  test('a dark photo is caught', () {
    expect(check(jpg(img.adjustColor(page.clone(), brightness: 0.15))), PhotoProblem.dark);
  });

  test('a bright reflection on grey paper is glare', () {
    final photo = img.adjustColor(page.clone(), brightness: 0.8); // paper comes out grey in a photo
    img.fillCircle(photo, x: 450, y: 300, radius: 190, color: img.ColorRgb8(255, 255, 255));
    expect(check(jpg(photo)), PhotoProblem.glare);
  });

  test('a white scan background is not glare', () {
    final scan = page.clone();
    img.fill(scan, color: img.ColorRgb8(255, 255, 255));
    img.drawString(scan, 'INCOME TAX DEPARTMENT  PERMANENT ACCOUNT NUMBER', font: img.arial24, x: 40, y: 60, color: img.ColorRgb8(0, 0, 0));
    for (var y = 120; y < 560; y += 30) {
      img.drawString(scan, 'NAME RAVI KUMAR  DOB 14/03/1994  PAN ABCPK1234F', font: img.arial24, x: 40, y: y, color: img.ColorRgb8(0, 0, 0));
    }
    expect(check(jpg(scan)), isNot(PhotoProblem.glare));
  });

  test('something that is not an image is unreadable', () {
    expect(check(Uint8List.fromList([1, 2, 3])), PhotoProblem.unreadable);
  });
}
