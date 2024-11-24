import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class MensaMenuProvider with ChangeNotifier {
  List<MenuItem> menuItems = [];
  List<String> selectedAllergens = []; // Список выбранных аллергенов

  /// Обновление выбранных аллергенов
  void updateSelectedAllergens(List<String> allergens) {
    selectedAllergens = allergens.map((e) => e.trim()).toList(); // Удаление пробелов
    print("Provider updated with allergens: $selectedAllergens");
    print("Updating allergen warnings. Menu items count: ${menuItems.length}");
    _updateAllergenWarnings();
    print("Allergen warnings updated");
    notifyListeners();


  }

  /// Обновление флага `containsSelectedAllergens` для пунктов меню
  void _updateAllergenWarnings() {
    for (var item in menuItems) {
      // Разделяем строку аллергенов в список
      final itemAllergens = item.allergens
          .split(',')
          .map((e) => e.trim().toLowerCase()) // Убираем пробелы и переводим в нижний регистр
          .where((e) => e.isNotEmpty) // Исключаем пустые строки
          .toList();
      print("Item: ${item.description}, Allergens: $itemAllergens");
      // Преобразуем выбранные аллергены для сравнения
      final normalizedSelectedAllergens =
      selectedAllergens.map((e) => e.trim().toLowerCase()).toList();

      // Проверяем пересечение между выбранными аллергенами и аллергенами блюда
      item.containsSelectedAllergens = normalizedSelectedAllergens.any(
            (allergen) => itemAllergens.contains(allergen),
      );

      // Лог для отладки
      print(
          "Item: ${item.description}, Allergens: ${itemAllergens}, Selected Allergens: $normalizedSelectedAllergens, containsSelectedAllergens: ${item.containsSelectedAllergens}");
    }
  }


  /// Загрузка меню
  Future<void> fetchMenu() async {
    // Инициализация локализации для формата даты
    await initializeDateFormatting('de_DE', null);

    final response = await http.get(
      Uri.parse(
          'https://www.studierendenwerk-aachen.de/speiseplaene/eupenerstrasse-w.html'),
    );

    if (response.statusCode == 200) {
      print("Data successfully loaded");

      // Парсинг HTML-документа
      var document = parse(utf8.decode(response.bodyBytes));

      // Получение текущей даты в формате 'dd.MM.yyyy'
      DateTime now = DateTime.now();
      String currentDate = '26.11.2024'; // DateFormat('dd.MM.yyyy', 'de_DE').format(now)
      print("Today's date: $currentDate");

      // Очистка предыдущего списка меню
      menuItems.clear();
      bool isTodaySection = false;

      // Получение всех заголовков (h3), предполагаемых как даты
      var headers = document.querySelectorAll('h3');
      for (var header in headers) {
        var headerText = header.text.trim();

        // Пропускаем заголовки следующей недели
        if (header.id.contains("Naechste")) {
          print("Skipping next week's header: $headerText");
          continue;
        }

        // Сравниваем дату из заголовка с текущей
        if (headerText.contains(',')) {
          var headerDate = headerText.split(',').last.trim();
          if (headerDate == currentDate) {
            isTodaySection = true;
          } else if (isTodaySection && headerDate != currentDate) {
            break; // Выходим, если прошли сегодняшнюю секцию
          }
        }

        // Обработка пунктов меню в сегодняшней секции
        if (isTodaySection) {
          var tableRows = header.nextElementSibling?.querySelectorAll('tr');
          if (tableRows != null) {
            for (var row in tableRows) {
              var descriptionElement = row.querySelector('.menue-desc');
              var priceElement = row.querySelector('.menue-price');

              if (descriptionElement != null) {
                // Извлечение категории, описания, цены и аллергенов
                var category = row.querySelector('.menue-category')?.text.trim() ?? 'No category';
                var price = priceElement?.text.trim() ?? 'No price';

                var allergenElements = descriptionElement.querySelectorAll('sup');
                var allergens = allergenElements
                    .map((e) => e.text.trim().toLowerCase()) // Убираем пробелы и приводим к нижнему регистру
                    .where((e) => e.isNotEmpty) // Исключаем пустые строки
                    .join(','); // Соединяем обратно в строку


                // Убираем маркеры аллергенов из текста описания
                for (var allergen in allergenElements) {
                  allergen.remove();
                }

                var descriptionText = descriptionElement.text.trim();

                print(
                    "Category: $category, Description: $descriptionText, Allergens: $allergens, Price: $price");

                // Обозначаем некоторые категории как "No price"
                if (category.contains('Hauptbeilagen') ||
                    category.contains('Nebenbeilage')) {
                  price = 'No price';
                }

                // Добавляем пункт меню в список
                menuItems.add(MenuItem(
                  category: category,
                  description: descriptionText,
                  price: price,
                  allergens: allergens.isEmpty ? 'No allergens' : allergens,
                ));
              }
            }
          }
        }
      }
      print("Menu items loaded: ${menuItems.length}");
      _updateAllergenWarnings();
      // Уведомляем слушателей после загрузки данных
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