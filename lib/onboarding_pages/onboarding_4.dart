import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mensaBG,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height:150,),
              Container(
                alignment: Alignment.center,
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("lib/assets/images/onboarding_4.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              const Positioned(
                left: 37,
                top: 576,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 300,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Find Nearby Mensas Fast',
                                style: TextStyle(
                                  color: mensaText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0.48,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign
                              .center, // Align the text within its container
                        ),
                      ),
                    ),
                    SizedBox(height: 21),
                    SizedBox(
                      width: 320,
                      child: Text(
                        'Enable location services so we can show you the nearest mensa locations, complete with directions, hours, and accessibility details. Perfect for when you’re on the go and need a quick meal nearby!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: mensaText,
                          fontSize: 16,
                          fontFamily: 'Outfit',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}