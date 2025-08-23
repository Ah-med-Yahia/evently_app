import 'dart:async';

import 'package:evently_app/auth/login_screen.dart';
import 'package:evently_app/auth/register_screen.dart';
import 'package:evently_app/firebase_options.dart';
import 'package:evently_app/providers/events_provider.dart';
import 'package:evently_app/providers/settings_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/screens/create_event_screen.dart';
import 'package:evently_app/screens/home_screen.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => EventsProvider()..getEvents()),
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create:(context)=> SettingsProvider()),
    ], child: const EventlyApp()),
  );
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.ligthTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: Provider.of<SettingsProvider>(context).themeMode,
      title: 'Flutter Demo',
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        CreateEventScreen.routeName: (_) => const CreateEventScreen(),
      },
      initialRoute: home.routeName,
    );
  }
}
