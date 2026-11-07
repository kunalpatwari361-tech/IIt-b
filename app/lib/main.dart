import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'l10n/app_localizations.dart';
import 'languages.dart';
import 'screens/consent_screen.dart';
import 'screens/decision_screen.dart';
import 'screens/details_screen.dart';
import 'screens/documents_screen.dart';
import 'screens/offer_screen.dart';
import 'screens/property_screen.dart';
import 'screens/selfie_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/welcome_screen.dart';
import 'services/api.dart';
import 'services/http_api.dart';
import 'services/mock_api.dart';
import 'state.dart';
import 'theme.dart';

void main() => runApp(NirnayApp(api: engineUrl.isEmpty ? MockNirnayApi() : HttpNirnayApi(engineUrl)));

class NirnayApp extends StatelessWidget {
  const NirnayApp({super.key, required this.api, this.state});
  final NirnayApi api;
  final AppState? state; // tests can start from a prepared state

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => state ?? AppState(api),
      child: Builder(builder: (context) {
        final locale = context.watch<AppState>().locale;
        return MaterialApp(
          title: 'Nirnay',
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [AppLocalizations.delegate, ...flutterDelegates],
          theme: nirnayTheme(),
          initialRoute: '/',
          routes: {
            '/': (_) => const WelcomeScreen(),
            '/sign-in': (_) => const SignInScreen(),
            '/consent': (_) => const ConsentScreen(),
            '/details': (_) => const DetailsScreen(),
            '/selfie': (_) => const SelfieScreen(),
            '/documents': (_) => const DocumentsScreen(),
            '/decision': (_) => const DecisionScreen(),
            '/offer': (_) => const OfferScreen(),
            '/property': (_) => const PropertyScreen(),
          },
        );
      }),
    );
  }
}
