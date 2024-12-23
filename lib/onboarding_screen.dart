import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'onboarding_pages/onboarding_1.dart';  // Import all onboarding screens
import 'onboarding_pages/onboarding_2.dart';
import 'onboarding_pages/onboarding_3.dart';
import 'onboarding_pages/onboarding_4.dart';
import 'onboarding_pages/onboarding_5.dart';
import 'onboarding_pages/onboarding_6.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Onboarding1(),
    const Onboarding2(),
    const Onboarding3(),
    const Onboarding4(),
    const Onboarding5(),
    const Onboarding6(),
  ];

  void _goToNextPage() {
    if (_currentIndex < _pages.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.jumpToPage(_currentIndex);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Non-swipeable PageView
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),  // Disables swipe gestures
            itemCount: _pages.length,
            itemBuilder: (context, index) => _pages[index],
          ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Show Skip only on Onboarding5
                if (_currentIndex == 4)
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MenuScreen()),
                      );
                    },
                    child: const Text("Skip", style: TextStyle(color: Colors.grey)),
                  )
                else
                  const SizedBox(width: 48),  // Empty space placeholder for alignment

                // Indicator dots
                Row(
                  children: List.generate(_pages.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentIndex == index ? 30 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _currentIndex == index ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  }),
                ),

                // Continue Button
                TextButton(
                  onPressed: _goToNextPage,
                  child: const Text(
                    "Continue",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
