import 'package:flutter/material.dart';
import 'package:cafe_project/models/snacks.dart';

import '../../../models/coffee.dart';
import '../../constants.dart';

class FavoritesProvider3 extends ChangeNotifier {
  Set<Snacks> _favorites = {};
  String _selectedCategory = 'all';
  Color _selectedCategoryColor =categoriecolor;

  Set<Snacks> get favorites => _favorites;

  String get selectedCategory => _selectedCategory;
  Color get selectedCategoryColor => _selectedCategoryColor;

  void toggleFavorite(Snacks snacks, BuildContext context) {
    if (_favorites.contains(snacks)) {
      _favorites.remove(snacks);
    } else {
      _favorites.add(snacks);
      _showSnackBar(context, '${snacks.title} added to Favorites');
    }
    notifyListeners();
  }

  void setSelectedCategory(String category) {
    if (_selectedCategory != category) {
      _selectedCategory = category;
      _selectedCategoryColor = categoriecolor;
      notifyListeners();
    }
  }

  void setDefaultCategory(List<Snacks> snacks) {
    if (snacks.isNotEmpty) {
      _selectedCategory = 'all';
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}