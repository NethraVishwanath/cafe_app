import 'package:flutter/material.dart';

import '../../../models/bestsell.dart';


class FavoritesProvider2 extends ChangeNotifier {
  Set<BestSellers> _favorites = {};

  Set<BestSellers> get favorites => _favorites;

  void toggleFavorite(BestSellers bestSellers, BuildContext context) {
    if (_favorites.contains(bestSellers)) {
      _favorites.remove(bestSellers);
    } else {
      _favorites.add(bestSellers);
      _showSnackBar(context, '${bestSellers.title} added to Favorites');
    }
    notifyListeners();
  }



  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
   }
}