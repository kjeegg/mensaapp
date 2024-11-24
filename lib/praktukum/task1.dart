import 'dart:io';

// Enum for meal categories
enum MealCategory { mainCourse, dessert, salad }

/// Base class for meals
class Meal {
  final String name;
  final MealCategory category;
  final double price;
  final List<String> allergens;

  Meal(this.name, this.category, this.price, this.allergens);

  String getDetails() {
    return '''
Name: $name
Category: ${category.name}
Price: \$${price.toStringAsFixed(2)}
Allergens: ${allergens.isEmpty ? 'None' : allergens.join(', ')}
''';
  }
}

/// Subclass for Desserts
class Dessert extends Meal {
  final bool isVegetarian;

  Dessert(String name, double price, List<String> allergens, this.isVegetarian)
      : super(name, MealCategory.dessert, price, allergens);

  @override
  String getDetails() {
    return super.getDetails() + 'Vegetarian: ${isVegetarian ? 'Yes' : 'No'}\n';
  }
}

/// Subclass for Salads
class Salad extends Meal {
  final String dressing;

  Salad(String name, double price, List<String> allergens, this.dressing)
      : super(name, MealCategory.salad, price, allergens);

  @override
  String getDetails() {
    return super.getDetails() + 'Dressing: $dressing\n';
  }
}

void main() {
  // Static menu
  final menu = [
    Meal('Pasta Bolognese', MealCategory.mainCourse, 5.99, ['Gluten']),
    Dessert('Chocolate Cake', 3.50, ['Gluten', 'Eggs'], true),
    Salad('Caesar Salad', 4.50, ['Eggs', 'Fish'], 'Caesar Dressing'),
    Meal('Grilled Chicken', MealCategory.mainCourse, 6.99, ['None']),
  ];

  // Display menu
  print('Welcome to Mensa!\nToday\'s Menu:\n');
  for (var i = 0; i < menu.length; i++) {
    print('${i + 1}. ${menu[i].name} (${menu[i].category.name})');
  }

  // User interaction
  print('\nEnter the number of the meal for details, or 0 to exit:');
  while (true) {
    final input = stdin.readLineSync();
    final index = int.tryParse(input ?? '') ?? -1;
    if (index == 0) {
      print('Goodbye!');
      break;
    } else if (index > 0 && index <= menu.length) {
      print('\n${menu[index - 1].getDetails()}');
    } else {
      print('Invalid input. Try again.');
    }
  }
}
