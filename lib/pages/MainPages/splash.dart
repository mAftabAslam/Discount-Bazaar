import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Example: Navigate to Onboarding after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Full-screen background
      body: SizedBox.expand(
        child: Image.asset(
          'lib/assets/Splash.png', // Replace with your SVG file path
          fit: BoxFit.cover, // Adjust the fit based on your needs
        ),
      ),
    );
  }
}
