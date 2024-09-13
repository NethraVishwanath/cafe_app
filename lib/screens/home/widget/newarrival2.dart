import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_project/screens/home/widget/snackitem.dart';
import '../../../models/snacks.dart';
import 'categories_list.dart';
import 'categoryitems.dart';
import 'favouritesprovider3.dart';

class NewArrival2 extends StatelessWidget {
  final List<Snacks> snacksList;

  NewArrival2({required this.snacksList});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          Consumer<FavoritesProvider3>(
            builder: (context, favoritesProvider, child) {
              final filteredSnacks = favoritesProvider.selectedCategory == 'all'
                  ? snacksList
                  : snacksList
                  .where((snacks) => snacks.subtitle == favoritesProvider.selectedCategory)
                  .toList();

              return Container(
                height: 200,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => SnackItem(filteredSnacks[index]),
                  separatorBuilder: (_, index) => SizedBox(width: 10,),
                  itemCount: filteredSnacks.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}