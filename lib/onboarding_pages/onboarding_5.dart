import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../mensa_menu_provider.dart';
import 'onboarding_6.dart';

class Onboarding5 extends StatefulWidget {
  const Onboarding5({super.key});

  // Публичный метод для вызова savePreferencesAndContinue
  void savePreferencesAndContinue(BuildContext context) {
    // Находим состояние и вызываем метод
    final state = context.findAncestorStateOfType<Onboarding5State>();
    state?.savePreferencesAndContinue(context);
  }

  @override
  Onboarding5State createState() => Onboarding5State();
}

class Onboarding5State extends State<Onboarding5> {
  List<String> selectedAllergens = [];

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
    "I3": "Walнüsse",
    "I4": "Kaschunüsse",
    "I5": "Pecannüsse",
    "I6": "Paranüsse",
    "I7": "Pistазии",
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
    Provider.of<MensaMenuProvider>(context, listen: false).updateSelectedAllergens(selectedAllergens);
  }


  void savePreferencesAndContinue(BuildContext context) {
    final mensaMenuProvider = Provider.of<MensaMenuProvider>(context, listen: false);

    // Сохраняем данные в провайдер
    mensaMenuProvider.updateSelectedAllergens(selectedAllergens);

    print("Allergens saved to provider: ${mensaMenuProvider.selectedAllergens}");

    // Переход на следующий экран
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Onboarding6()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Let us know your dietary preferences!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

            ],
          ),
        ),
      ),
    );
  }
}
