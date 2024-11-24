import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart';  // Import OnboardingScreen
import '../constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer for splash screen delay before going to onboarding
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: mensaPrimary,
      body: Center(
        child: Image(
          image: AssetImage('lib/assets/images/logo_mymensa.png'),
        ),
      ),
    );
  }
}
