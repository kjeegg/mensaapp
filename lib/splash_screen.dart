import 'package:flutter/material.dart';
import 'dart:async';
import 'onboarding_screen.dart';  // Import OnboardingScreen

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
      backgroundColor: Color(0xFF004990),
      body: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'My',
                style: TextStyle(
                  color: Color(0xFF4FA5FB),
                  fontSize: 48,
                  fontFamily: 'Fugaz One',
                  letterSpacing: 0.48,
                ),
              ),
              TextSpan(
                text: 'Mensa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontFamily: 'Fugaz One',
                  letterSpacing: 0.48,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
