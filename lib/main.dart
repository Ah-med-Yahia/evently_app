import 'package:evently_app/home_screen.dart';
import 'package:evently_app/utils/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EventlyApp());
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
      themeMode: ThemeMode.light,
      title: 'Flutter Demo',
      routes: {
        HomeScreen.routeName:(_)=> const HomeScreen()
      },
    );
  }
}
