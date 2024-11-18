import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mensa_menu_provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mensa Menu')),
      body: FutureBuilder(
        future: Provider.of<MensaMenuProvider>(context, listen: false).fetchMenu(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Consumer<MensaMenuProvider>(
              builder: (context, menuProvider, _) {
                if (menuProvider.menuItems.isEmpty) {
                  return const Center(child: Text('No menu items available.'));
                }
                return ListView.builder(
                  itemCount: menuProvider.menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuProvider.menuItems[index];
                    return ListTile(
                      title: Text(item.description),
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
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

}

