import 'package:flutter/material.dart';
import '../constants/colors.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

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
                    image: AssetImage("lib/assets/images/onboarding_1.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 9,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4FA5FB),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Color(0xFFCDCDCD),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Color(0xFFCDCDCD),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
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
                                text: 'Welcome to MyMensa App',
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
                        'Find daily menus, locate the nearest mensa, and make informed choices based on your dietary needs - all in one app!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
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