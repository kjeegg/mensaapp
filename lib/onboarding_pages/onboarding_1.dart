import 'package:flutter/material.dart';

class Onboarding1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: Center(
        child: Container(
          width: 412,
          height: 917,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Color(0xFFF1F4F8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Status bar mockup
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 412,
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '9:30',
                        style: TextStyle(
                          color: Color(0xFF1D1B20),
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.signal_cellular_4_bar, color: Color(0xFF1D1B20), size: 17),
                          const SizedBox(width: 4),
                          Icon(Icons.wifi, color: Color(0xFF1D1B20), size: 17),
                          const SizedBox(width: 4),
                          Icon(Icons.battery_full, color: Color(0xFF1D1B20), size: 17),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Welcome text and description
              Positioned(
                left: 37,
                top: 576,
                child: Column(
                  children: [
                    SizedBox(
                      width: 338,
                      child: Text(
                        'Welcome to MyMensa App!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'Outfit',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 21),
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
              // Illustration
              Positioned(
                left: 56,
                top: 233,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/300/300"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Indicator dots
              Positioned(
                left: 176,
                top: 550,
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 9,
                      decoration: BoxDecoration(
                        color: Color(0xFF4FA5FB),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: Color(0xFFCDCDCD),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: Color(0xFFCDCDCD),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
              // Continue button
              Positioned(
                left: 113,
                top: 790,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF004990), // Updated to `backgroundColor`
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  ),
                  onPressed: () {
                    // Add navigation or other functionality as needed
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}