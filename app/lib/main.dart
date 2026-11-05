import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'screens/consent_screen.dart';
import 'screens/decision_screen.dart';
import 'screens/details_screen.dart';
import 'screens/documents_screen.dart';
import 'screens/property_screen.dart';
import 'screens/selfie_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/welcome_screen.dart';
import 'services/api.dart';
import 'services/mock_api.dart';
import 'state.dart';

void main() => runApp(NirnayApp(api: MockNirnayApi()));

class NirnayApp extends StatelessWidget {
  const NirnayApp({super.key, required this.api});
  final NirnayApi api;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(api),
      child: Builder(builder: (context) {
        final locale = context.watch<AppState>().locale;
        return MaterialApp(
          title: 'Nirnay',
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0B5D7A)),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (_) => const WelcomeScreen(),
            '/sign-in': (_) => const SignInScreen(),
            '/consent': (_) => const ConsentScreen(),
            '/details': (_) => const DetailsScreen(),
            '/selfie': (_) => const SelfieScreen(),
            '/documents': (_) => const DocumentsScreen(),
            '/decision': (_) => const DecisionScreen(),
            '/property': (_) => const PropertyScreen(),
          },
        );
      }),
    );
  }
}
