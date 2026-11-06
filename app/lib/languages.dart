// The languages the app speaks: English and the 22 languages of the Eighth Schedule of the
// Constitution, each named in its own script. Flutter's own widgets (date pickers, the
// back-button label and so on) don't cover nine of them, so those borrow the nearest
// language Flutter does cover; Kashmiri and Sindhi borrow Urdu, which also makes them right-to-left.
//
// The translations were written for this demo and need a native speaker's review before
// real customers use them.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLanguage {
  const AppLanguage(this.code, this.native, this.english);
  final String code, native, english;
}

const appLanguages = [
  AppLanguage('en', 'English', 'English'),
  AppLanguage('hi', 'हिन्दी', 'Hindi'),
  AppLanguage('bn', 'বাংলা', 'Bengali'),
  AppLanguage('mr', 'मराठी', 'Marathi'),
  AppLanguage('te', 'తెలుగు', 'Telugu'),
  AppLanguage('ta', 'தமிழ்', 'Tamil'),
  AppLanguage('gu', 'ગુજરાતી', 'Gujarati'),
  AppLanguage('ur', 'اردو', 'Urdu'),
  AppLanguage('kn', 'ಕನ್ನಡ', 'Kannada'),
  AppLanguage('or', 'ଓଡ଼ିଆ', 'Odia'),
  AppLanguage('ml', 'മലയാളം', 'Malayalam'),
  AppLanguage('pa', 'ਪੰਜਾਬੀ', 'Punjabi'),
  AppLanguage('as', 'অসমীয়া', 'Assamese'),
  AppLanguage('mai', 'मैथिली', 'Maithili'),
  AppLanguage('sat', 'ᱥᱟᱱᱛᱟᱲᱤ', 'Santali'),
  AppLanguage('ks', 'کٲشُر', 'Kashmiri'),
  AppLanguage('ne', 'नेपाली', 'Nepali'),
  AppLanguage('kok', 'कोंकणी', 'Konkani'),
  AppLanguage('sd', 'سنڌي', 'Sindhi'),
  AppLanguage('doi', 'डोगरी', 'Dogri'),
  AppLanguage('mni', 'মৈতৈলোন্', 'Manipuri'),
  AppLanguage('brx', "बर'", 'Bodo'),
  AppLanguage('sa', 'संस्कृतम्', 'Sanskrit'),
];

AppLanguage languageOf(String code) => appLanguages.firstWhere((l) => l.code == code, orElse: () => appLanguages.first);

/// The language Flutter's own widgets use for the nine languages they don't cover.
const _borrowed = {'brx': 'hi', 'doi': 'hi', 'kok': 'hi', 'mai': 'hi', 'sa': 'hi', 'sat': 'hi', 'mni': 'bn', 'ks': 'ur', 'sd': 'ur'};

class _Borrowing<T> extends LocalizationsDelegate<T> {
  const _Borrowing(this.base);
  final LocalizationsDelegate<T> base;

  @override
  bool isSupported(Locale locale) => _borrowed.containsKey(locale.languageCode);

  @override
  Future<T> load(Locale locale) => base.load(Locale(_borrowed[locale.languageCode]!));

  @override
  bool shouldReload(covariant LocalizationsDelegate<T> old) => false;
}

/// Flutter's own translations, plus the borrowed ones for the languages it doesn't cover.
const flutterDelegates = <LocalizationsDelegate<dynamic>>[
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  _Borrowing<MaterialLocalizations>(GlobalMaterialLocalizations.delegate),
  _Borrowing<CupertinoLocalizations>(GlobalCupertinoLocalizations.delegate),
  _Borrowing<WidgetsLocalizations>(GlobalWidgetsLocalizations.delegate),
];

/// Every script the app may need, so any language's text finds its glyphs.
const scriptFonts = [
  'NotoSansDevanagari',
  'NotoSansBengali',
  'NotoSansGujarati',
  'NotoSansGurmukhi',
  'NotoSansKannada',
  'NotoSansMalayalam',
  'NotoSansOriya',
  'NotoSansTamil',
  'NotoSansTelugu',
  'NotoSansOlChiki',
  'NotoNaskhArabic',
];
