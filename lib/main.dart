import 'package:flutter/material.dart';
import 'package:se_project/pages/onboarding.dart';
//import 'package:se_project/pages/onboarding.dart';
import 'package:se_project/pages/splash.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Set status bar color to transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/onboarding': (context) =>
            const Onboarding(), // Your Onboarding screen
      },
    );
  }
}
