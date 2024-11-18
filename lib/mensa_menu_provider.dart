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
    await initializeDateFormatting('de_DE', null);

    final response = await http.get(
      Uri.parse('https://www.studierendenwerk-aachen.de/speiseplaene/eupenerstrasse-w.html'),
    );

    if (response.statusCode == 200) {
      print("Данные успешно загружены");

      var document = parse(utf8.decode(response.bodyBytes));

      // Date in Format dd.MM.yyyy
      DateTime now = DateTime.now();
      String currentDate = DateFormat('dd.MM.yyyy', 'de_DE').format(now); // Текущая дата

      print("Сегодняшняя дата: $currentDate");

      menuItems.clear();
      bool isTodaySection = false;

      // Logik fur html trim
      var headers = document.querySelectorAll('h3');
      for (var header in headers) {
        var headerText = header.text?.trim();


        if (header.id != null && header.id.contains("Naechste")) {
          print("Пропускаем следующий заголовок недели: $headerText");
          continue;
        }

        if (headerText != null && headerText.contains(',')) {
          // Trim (например, "Montag, 21.10.2024" -> "21.10.2024")
          var headerDate = headerText.split(',').last.trim();

          if (headerDate == currentDate) {
            isTodaySection = true;
          }

          else if (isTodaySection && headerDate != currentDate) {
            break;
          }
        }


        if (isTodaySection) {
          var table = header.nextElementSibling?.querySelectorAll('tr');
          if (table != null) {
            for (var row in table) {
              var descriptionElement = row.querySelector('.menue-desc');
              var priceElement = row.querySelector('.menue-price');

              if (descriptionElement != null) {
                var category = row.querySelector('.menue-category')?.text?.trim() ?? 'No category';
                var price = priceElement?.text?.trim() ?? 'No price';

                // allergens are in <sup> tags
                var allergenElements = descriptionElement.querySelectorAll('sup');
                var allergens = allergenElements.map((e) => e.text).join(', ');

                // Clear allergens from description
                for (var allergen in allergenElements) {
                  allergen.remove();
                }


                var descriptionText = descriptionElement.text.trim();

                print("Категория: $category, Описание: $descriptionText, Аллергены: $allergens, Цена: $price");

                if (category.contains('Hauptbeilagen') || category.contains('Nebenbeilage')) {
                  price = 'No price';
                }

                menuItems.add(MenuItem(
                  category: category,
                  description: descriptionText,
                  price: price,
                  allergens: allergens.isEmpty ? 'No allergens' : allergens,  // Show 'No allergens' if allergens is empty
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
