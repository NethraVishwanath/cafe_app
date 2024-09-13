import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_project/screens/home/widget/snackitem.dart';
import '../../../models/snacks.dart';
import 'favouritesprovider3.dart';

class SnackListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Snacks'),
      ),
      body: Consumer<FavoritesProvider3>(
        builder: (context, favoritesProvider, child) {
          final List<Snacks> snacksList = Snacks.generateSnacks(); // Correct variable name
          List<Snacks> filteredSnacks = favoritesProvider.selectedCategory == 'all'
              ? snacksList
              : snacksList
              .where((snacks) => snacks.subtitle == favoritesProvider.selectedCategory)
              .toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: filteredSnacks.length,
            itemBuilder: (context, index) {
              return SnackItem(filteredSnacks[index]);
            },
          );
        },
      ),
    );
  }
}
