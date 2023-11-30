import 'package:flutter/material.dart';
import 'package:se_project/pages/home.dart';
//import 'package:se_project/pages/onboarding.dart';
import 'package:se_project/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      routes: {
        '/onboarding': (context) =>
            const HomeScreen(), // Your Onboarding screen
      },
    );
  }
}
