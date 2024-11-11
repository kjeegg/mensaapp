import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mensa_menu_provider.dart';   // Import the provider
import 'splash_screen.dart';         // Import SplashScreen
import 'menu_screen.dart';           // Import the main MenuScreen
import 'onboarding_screen.dart';     // Import OnboardingScreen which includes all onboarding steps

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MensaMenuProvider(),
      child: MaterialApp(
        title: 'Mensa App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),  // Start with SplashScreen
      ),
    );
  }
}
