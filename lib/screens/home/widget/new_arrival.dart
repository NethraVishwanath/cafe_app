import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_project/screens/home/widget/categories_list.dart';
import 'package:cafe_project/models/coffee.dart';
import 'package:cafe_project/screens/home/widget/coffees_item.dart';
import 'categoryitems.dart';
import 'favouriteprovider.dart';

class NewArrival extends StatelessWidget {
  final List<Coffees> coffeesList;

  NewArrival({required this.coffeesList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CategoryItem(),
          CategoriesList(), // Instantiate as a widget
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              final filteredCoffees = favoritesProvider.selectedCategory == 'all'
                  ? coffeesList
                  : coffeesList
                  .where((coffee) => coffee.subtitle == favoritesProvider.selectedCategory)
                  .toList();

              return Container(
                height: 210,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => CoffeesItem(filteredCoffees[index]),
                  separatorBuilder: (_, index) => SizedBox(width: 10,),
                  itemCount: filteredCoffees.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
