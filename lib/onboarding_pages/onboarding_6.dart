import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../mensa_menu_provider.dart';
import '../menu_screen.dart';  // Replace with the actual screen after onboarding

class Onboarding6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the selected allergens from the provider
    final selectedAllergens = Provider.of<MensaMenuProvider>(context).selectedAllergens;
    final allergenNames = {
      "1": "Farbstoff",
      "2": "Konservierungsstoff",
      "3": "Antioxidationsmittel",
      "4": "Geschmacksverstärker",
      "5": "geschwefelt",
      "6": "geschwärzt",
      "7": "gewachst",
      "8": "Phosphat",
      "9": "Süßungsmittel",
      "10": "enthält eine Phenylalaninquelle",
      "A": "Gluten",
      "A1": "Weizen",
      "A2": "Roggen",
      "A3": "Gerste",
      "A4": "Hafer",
      "A5": "Dinkel",
      "B": "Sellerie",
      "C": "Krebstiere",
      "D": "Eier",
      "E": "Fische",
      "F": "Erdnüsse",
      "G": "Sojabohnen",
      "H": "Milch",
      "I": "Schalenfrüchte",
      "I1": "Mandeln",
      "I2": "Haselnüsse",
      "I3": "Walnüsse",
      "I4": "Kaschunüsse",
      "I5": "Pecannüsse",
      "I6": "Paranüsse",
      "I7": "Pistazien",
      "I8": "Macadamianüsse",
      "J": "Senf",
      "K": "Sesamsamen",
      "L": "Schwefeldioxid oder Sulfite",
      "M": "Lupinen",
      "N": "Weichtiere",
    };

    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Confirmation message
            Text(
              'Got it!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your dietary restrictions have been saved. You can always change this whenever you want in the settings menu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Outfit',
              ),
            ),
            const SizedBox(height: 24),
            // Display selected allergens
            if (selectedAllergens.isNotEmpty)
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: selectedAllergens.map((code) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      allergenNames[code] ?? code,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  );
                }).toList(),
              )
            else
              Text(
                "No allergens selected.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: 'Outfit',
                ),
              ),
            const SizedBox(height: 24),
            // Continue button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF004990),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                // Navigate to the main screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()), // Replace with your main app screen
                );
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
          ],
        ),
      ),
    );
  }
}
