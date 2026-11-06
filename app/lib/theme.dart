// The look of the app, taken from the market-standard design (Figma page "G · Market standard"):
// a white header, a light grey page, white cards with a thin border, brand blue for
// information and orange only for the one main action on each screen.
import 'package:flutter/material.dart';

import 'languages.dart';

class C {
  static const brand = Color(0xFF123B7A);
  static const brandDark = Color(0xFF0A2550);
  static const brandTint = Color(0xFFE7EDF7);
  static const onBrandMuted = Color(0xFFCAD6EC);
  static const gold = Color(0xFFC9A24A);
  static const goldTint = Color(0xFFF7EFDC);
  static const action = Color(0xFFC2410C);
  static const page = Color(0xFFF4F5F8);
  static const card = Color(0xFFFFFFFF);
  static const line = Color(0xFFE3E7EF);
  static const field = Color(0xFFD5DBE6);
  static const ink = Color(0xFF0F1B2D);
  static const muted = Color(0xFF5B6576);
  static const idle = Color(0xFFC4CBD8);

  static const good = Color(0xFF16A34A);
  static const goodInk = Color(0xFF0B5A37);
  static const goodTint = Color(0xFFE9F7EF);
  static const goodLine = Color(0xFFB7E4C9);

  static const warnInk = Color(0xFF9A3412);
  static const warnTint = Color(0xFFFFF4EC);
  static const warnLine = Color(0xFFFCD9C2);

  static const badInk = Color(0xFFB42318);
  static const badTint = Color(0xFFFEF3F2);
  static const badLine = Color(0xFFFECDCA);
}

const sansFallback = scriptFonts;

/// The classic touch: a serif for headings and amounts, as on a bank statement or sanction letter.
TextStyle serif(double size, {Color color = C.ink, FontWeight weight = FontWeight.w700, double? height}) => TextStyle(
  fontFamily: 'NotoSerif',
  fontFamilyFallback: const ['NotoSerifDevanagari', ...scriptFonts],
  fontSize: size,
  fontWeight: weight,
  color: color,
  height: height,
  letterSpacing: -0.2,
);

/// Soft shadow under cards, so they sit a little above the page.
const cardShadow = [BoxShadow(color: Color(0x0F0F1B2D), blurRadius: 14, offset: Offset(0, 4))];

/// The navy gradient used by the offer and result cards.
const brandGradient = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1A4A92), C.brandDark]);

ThemeData nirnayTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: C.brand).copyWith(
    primary: C.brand,
    onPrimary: Colors.white,
    primaryContainer: C.brandTint,
    onPrimaryContainer: C.brandDark,
    secondary: C.action,
    onSecondary: Colors.white,
    surface: C.card,
    onSurface: C.ink,
    onSurfaceVariant: C.muted,
    outline: C.field,
    outlineVariant: C.line,
    error: C.badInk,
  );
  final base = ThemeData(colorScheme: scheme, useMaterial3: true, fontFamily: 'NotoSans', fontFamilyFallback: sansFallback);
  final text = base.textTheme.apply(bodyColor: C.ink, displayColor: C.ink, fontFamily: 'NotoSans', fontFamilyFallback: sansFallback);
  final radius12 = BorderRadius.circular(12);
  OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
    borderRadius: radius12,
    borderSide: BorderSide(color: c, width: w),
  );

  return base.copyWith(
    scaffoldBackgroundColor: C.page,
    dividerColor: C.line,
    textTheme: text,
    appBarTheme: AppBarTheme(
      backgroundColor: C.card,
      foregroundColor: C.ink,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: text.titleMedium?.copyWith(fontSize: 17, fontWeight: FontWeight.w800, color: C.ink),
    ),
    cardTheme: CardThemeData(
      color: C.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: C.line),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: C.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      border: border(C.field),
      enabledBorder: border(C.field),
      disabledBorder: border(C.line),
      focusedBorder: border(C.brand, 2),
      errorBorder: border(C.badInk),
      hintStyle: const TextStyle(color: C.muted),
      helperStyle: const TextStyle(color: C.muted, fontSize: 12),
      prefixStyle: const TextStyle(color: C.ink, fontSize: 15),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: C.action,
        foregroundColor: Colors.white,
        disabledBackgroundColor: const Color(0xFFE5C9BC),
        disabledForegroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: C.brand,
        backgroundColor: C.card,
        minimumSize: const Size(0, 44),
        side: const BorderSide(color: C.field),
        shape: RoundedRectangleBorder(borderRadius: radius12),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: C.brand,
        minimumSize: const Size(0, 44),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      side: const BorderSide(color: C.idle, width: 2),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: C.brand,
      inactiveTrackColor: C.brandTint,
      thumbColor: C.brand,
      trackHeight: 6,
      showValueIndicator: ShowValueIndicator.onDrag,
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: C.card,
      selectedColor: C.brandTint,
      side: const BorderSide(color: C.field),
      shape: RoundedRectangleBorder(borderRadius: radius12),
      labelStyle: const TextStyle(color: C.ink, fontWeight: FontWeight.w600),
      showCheckmark: false,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: C.card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      titleTextStyle: text.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: C.ink),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: C.card,
      surfaceTintColor: Colors.transparent,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: C.ink,
      shape: RoundedRectangleBorder(borderRadius: radius12),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: C.brand, linearTrackColor: C.brandTint),
  );
}

/// The dark "Aurora" look of the welcome screen: near-black with teal and violet light.
class Aurora {
  static const bg = Color(0xFF0A0B12);
  static const glass = Color(0x0FFFFFFF);
  static const glassLine = Color(0x1FFFFFFF);
  static const text = Color(0xFFF4F6FB);
  static const muted = Color(0xFF9AA3B8);
  static const teal = Color(0xFF2EE6C5);
  static const violet = Color(0xFF7C5CFF);
  static const amber = Color(0xFFF5B649);
  static const action = LinearGradient(colors: [teal, violet]);
  static const card = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3B6CF6), Color(0xFF22C3D6), Color(0xFF7C5CFF)],
    stops: [0, 0.55, 1],
  );
}
