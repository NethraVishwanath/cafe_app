import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/snacks.dart';
import 'coffees_item.dart';
import 'favouriteprovider.dart';
import 'package:cafe_project/models/coffee.dart';

import 'favouritesprovider3.dart';

class CoffeeListScreen extends StatelessWidget {
  final String selectedCategory1;
  final String selectedCategory2;

  // Provide default values for the parameters
  CoffeeListScreen({this.selectedCategory1 = '', this.selectedCategory2 = ''});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Coffees'),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final List<Coffees> coffeesList = Coffees.generateCoffees();
          List<Coffees> filteredCoffees = selectedCategory1 == 'all'
              ? coffeesList
              : coffeesList.where((coffee) => coffee.subtitle == selectedCategory1).toList();


              return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: filteredCoffees.length,
            itemBuilder: (context, index) {
              return CoffeesItem(filteredCoffees[index]);
            },
          );
        },
      ),
    );
  }
}
