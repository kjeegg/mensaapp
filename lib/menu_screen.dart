import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mensa_menu_provider.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mensa Menu')),
      body: Consumer<MensaMenuProvider>(
        builder: (context, menuProvider, _) {
          if (menuProvider.menuItems.isEmpty) {
            return Center(child: CircularProgressIndicator());
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
                    ? Icon(Icons.warning, color: Colors.red) // Shows warning icon if item contains selected allergens
                    : Text(item.price),
              );
            },
          );
        },
      ),
    );
  }
}
