import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../mensa_menu_provider.dart';
import 'onboarding_6.dart'; // Import the next onboarding screen

class Onboarding5 extends StatefulWidget {
  @override
  _Onboarding5State createState() => _Onboarding5State();
}

class _Onboarding5State extends State<Onboarding5> {
  List<String> selectedAllergens = [];

  // Original allergens dictionary with codes and names
  final Map<String, String> allergens = {
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


  void _toggleAllergenSelection(String allergenCode) {
    setState(() {
      if (selectedAllergens.contains(allergenCode)) {
        selectedAllergens.remove(allergenCode);
      } else {
        selectedAllergens.add(allergenCode);
      }
    });
  }

  void _savePreferencesAndContinue(BuildContext context) {
    // Save the selected allergens to the provider
    Provider.of<MensaMenuProvider>(context, listen: false).updateSelectedAllergens(selectedAllergens);

    // Navigate to the next onboarding screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Onboarding6()), // Replace with your actual next screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let us know your dietary preferences!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Select any food allergies or restrictions you have. This will help us filter the menu for you.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: allergens.entries.map((entry) {
                final allergenCode = entry.key;
                final allergenName = entry.value;
                final isSelected = selectedAllergens.contains(allergenCode);

                return GestureDetector(
                  onTap: () => _toggleAllergenSelection(allergenCode),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      allergenName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF004990),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () => _savePreferencesAndContinue(context),
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
