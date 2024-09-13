import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favouriteprovider.dart';
import 'favouritesprovider3.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoritesProvider2 = Provider.of<FavoritesProvider3>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(height: 80),
          InkWell(
            onTap: () {
              favoritesProvider.setSelectedCategory('all');
              favoritesProvider2.setSelectedCategory('all');
              // Remove the line below to include 'Snacks' in 'All Categories'
              // favoritesProvider2.setSelectedCategory('all');
            },
            child: buildCategoryContainer(
              context,
              'All Categories',
              favoritesProvider.selectedCategory == 'all' &&
                  favoritesProvider2.selectedCategory == 'all',
              favoritesProvider.selectedCategoryColor,
            ),
          ),

          SizedBox(width: 20),
          InkWell(
            onTap: () {
              favoritesProvider.setSelectedCategory('coffee');
              favoritesProvider2.setSelectedCategory('');
            },
            child: buildCategoryContainer(
              context,
              'Coffee',
              favoritesProvider.selectedCategory == 'coffee',
              favoritesProvider.selectedCategoryColor,
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              favoritesProvider.setSelectedCategory('tea');
              favoritesProvider2.setSelectedCategory('');
            },
            child: buildCategoryContainer(
              context,
              'Tea',
              favoritesProvider.selectedCategory == 'tea',
              favoritesProvider.selectedCategoryColor,
            ),
          ),
          SizedBox(width: 20),
      InkWell(
        onTap: () {
          favoritesProvider.setSelectedCategory('snack');
          favoritesProvider2.setSelectedCategory('snack');
        },
        child: Container(
          width: 80,
          height: 30,
            child: buildCategoryContainer(
              context,
              'Snacks',
              favoritesProvider2.selectedCategory == 'snack',
              favoritesProvider2.selectedCategoryColor,
            ),
          ),
      ),],
      ),
    );
  }

  Widget buildCategoryContainer(
      BuildContext context,
      String text,
      bool isSelected,
      Color selectedColor,
      ) {
    return Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
        ),
        color: isSelected ? selectedColor : Colors.transparent,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

