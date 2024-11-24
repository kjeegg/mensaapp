import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mensa_menu_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<MensaMenuProvider>(context, listen: false).fetchMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensa Menu'),
        backgroundColor: Colors.blue,
      ),
      body: Consumer<MensaMenuProvider>(
        builder: (context, menuProvider, _) {
          if (menuProvider.menuItems.isEmpty) {
            return const Center(
              child: Text('No menu items available. Please try again later.'),
            );
          }

          return ListView.builder(
            itemCount: menuProvider.menuItems.length,
            itemBuilder: (context, index) {
              final item = menuProvider.menuItems[index];

              // Лог для проверки флага containsSelectedAllergens
              print("MenuItem: ${item.description}, containsSelectedAllergens: ${item.containsSelectedAllergens}");

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    item.description,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Category: ${item.category}'),
                      Text('Allergens: ${item.allergens}'),
                    ],
                  ),
                  trailing: item.containsSelectedAllergens
                      ? const Icon(Icons.warning, color: Colors.red)
                      : Text(item.price),
                ),
              );
            },
          );
        },
      ),
    );
  }
}