import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_project/screens/home/widget/popularItem.dart';
import '../../../models/bestsell.dart';
import '../../../models/coffee.dart';
import 'favouriteprovider.dart';
import 'favouriteprovider2.dart';
import 'coffees_item.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoritesProvider2 = Provider.of<FavoritesProvider2>(context);

    List<Coffees> coffeeFavorites = favoritesProvider.favorites.toList();
    List<BestSellers> bestSellersFavorites = favoritesProvider2.favorites.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite items'),
        centerTitle: true,
      ),
      body: (coffeeFavorites.isEmpty && bestSellersFavorites.isEmpty)
          ? Center(
        child: Text('No favorite items yet.'),
      )
          : ListView.builder(
        itemCount: coffeeFavorites.length + bestSellersFavorites.length,
        itemBuilder: (context, index) {
          if (index < coffeeFavorites.length) {
            return CoffeesItem(coffeeFavorites[index]);
          } else {
            BestSellers bestSellers =
            bestSellersFavorites[index - coffeeFavorites.length];
            return PopularItem(bestSellers);
          }
        },
      ),
    );
  }
}