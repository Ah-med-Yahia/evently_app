import 'dart:async';
import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/auth/register_screen.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/onboarding/onBoarding_screen.dart';
import 'package:evently_app/onboarding/welcome_screen.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/screens/create_event_screen.dart';
import 'package:evently_app/screens/home_screen.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => EventsProvider()..getEvents()),
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ],
        child: EventlyApp(
          seenOnboarding: prefs.getBool('onboarding_done') ?? false,
        )),
  );
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key, required this.seenOnboarding});

  final bool seenOnboarding;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.ligthTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Provider.of<SettingsProvider>(context).currentThemeMode,
      title: 'Flutter Demo',
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        CreateEventScreen.routeName: (_) => const CreateEventScreen(),
        WelcomeScreen.routeName: (_) => const WelcomeScreen(),
        OnboardingScreen.routeName: (_) => const OnboardingScreen(),
      },
      initialRoute:
          seenOnboarding ? LoginScreen.routeName : WelcomeScreen.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(Provider.of<SettingsProvider>(context).languageCode),
    );
  }
}
