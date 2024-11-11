import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MensaMenuProvider with ChangeNotifier {
  List<MenuItem> menuItems = [];

  List<String> selectedAllergens = []; // List to store selected allergens

  // Method to update the selected allergens
  void updateSelectedAllergens(List<String> allergens) {
  selectedAllergens = allergens;
  _updateAllergenWarnings();
  notifyListeners();
  }

  // Private method to check each menu item for selected allergens
  void _updateAllergenWarnings() {
  for (var item in menuItems) {
  item.containsSelectedAllergens = selectedAllergens.any(
  (allergen) => item.allergens.contains(allergen),
  );
  }
  }

  Future<void> fetchMenu() async {
    // Initialize date formatting for the locale
    await initializeDateFormatting('de_DE', null);

    final response = await http.get(
      Uri.parse('https://www.studierendenwerk-aachen.de/speiseplaene/eupenerstrasse-w.html'),
    );

    if (response.statusCode == 200) {
      print("Data successfully loaded");

      // Parse the HTML document
      var document = parse(utf8.decode(response.bodyBytes));

      // Get today's date in 'dd.MM.yyyy' format
      DateTime now = DateTime.now();
      String currentDate = DateFormat('dd.MM.yyyy', 'de_DE').format(now);
      print("Today's date: $currentDate");

      // Clear previous menu items to avoid duplication
      menuItems.clear();
      bool isTodaySection = false;

      // Get all header elements (assumed to represent dates or categories)
      var headers = document.querySelectorAll('h3');
      for (var header in headers) {
        var headerText = header.text?.trim();

        // Skip headers that indicate the next week's menu
        if (header.id != null && header.id.contains("Naechste")) {
          print("Skipping next week's header: $headerText");
          continue;
        }

        // Extract and match the date from the header text
        if (headerText != null && headerText.contains(',')) {
          // e.g., "Montag, 21.10.2024" -> "21.10.2024"
          var headerDate = headerText.split(',').last.trim();

          if (headerDate == currentDate) {
            isTodaySection = true;
          } else if (isTodaySection && headerDate != currentDate) {
            // Break the loop once we move past today's section
            break;
          }
        }

        // Process menu items if within today's section
        if (isTodaySection) {
          var tableRows = header.nextElementSibling?.querySelectorAll('tr');
          if (tableRows != null) {
            for (var row in tableRows) {
              var descriptionElement = row.querySelector('.menue-desc');
              var priceElement = row.querySelector('.menue-price');

              if (descriptionElement != null) {
                // Extract category, description, price, and allergens
                var category = row.querySelector('.menue-category')?.text?.trim() ?? 'No category';
                var price = priceElement?.text?.trim() ?? 'No price';

                // Parse allergens from <sup> elements within the description
                var allergenElements = descriptionElement.querySelectorAll('sup');
                var allergens = allergenElements.map((e) => e.text).join(', ');

                // Remove allergen markers from description text
                for (var allergen in allergenElements) {
                  allergen.remove();
                }

                var descriptionText = descriptionElement.text.trim();

                print("Category: $category, Description: $descriptionText, Allergens: $allergens, Price: $price");

                // Mark certain categories as "No price"
                if (category.contains('Hauptbeilagen') || category.contains('Nebenbeilage')) {
                  price = 'No price';
                }

                // Add the parsed item to the menu list
                menuItems.add(MenuItem(
                  category: category,
                  description: descriptionText,
                  price: price,
                  allergens: allergens.isEmpty ? 'No allergens' : allergens,  // Show 'No allergens' if allergens are empty
                ));
              }
            }
          }
        }
      }

      // Notify listeners to update the UI after data is loaded
      notifyListeners();
    } else {
      print('Loading error: ${response.statusCode}');
      throw Exception('Failed to load menu');
    }
  }
}

class MenuItem {
  final String category;
  final String description;
  final String price;
  final String allergens;
  bool containsSelectedAllergens;

  MenuItem({
    required this.category,
    required this.description,
    required this.price,
    required this.allergens,
    this.containsSelectedAllergens = false,
  });
}
