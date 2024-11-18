import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mensa_menu_provider.dart';   // Import the provider
import 'splash_screen.dart';         // Import SplashScreen
// Import the main MenuScreen
// Import OnboardingScreen which includes all onboarding steps

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MensaMenuProvider(),
      child: MaterialApp(
        title: 'Mensa App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),  // Start with SplashScreen
      ),
    );
  }
}
