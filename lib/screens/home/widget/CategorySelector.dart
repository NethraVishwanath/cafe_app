import 'package:flutter/material.dart';
import 'package:cafe_project/models/coffee.dart';
import 'coffees_item.dart';

class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Coffees> coffeeItems = Coffees.generateCoffees().where((coffee) => coffee.subtitle == 'coffee').toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('All Coffees'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: coffeeItems.length,
        itemBuilder: (context, index) {
          final coffee = coffeeItems[index];
          return CoffeesItem(coffee);
        },
      ),
    );
  }
}
