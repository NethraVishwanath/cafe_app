import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'AllSnacksAndCoffeeListScreen.dart';
import 'allsnacks.dart';
import 'coffee_list_screen.dart';
import 'favouriteprovider.dart';
import 'favouritesprovider3.dart';

class CategoriesList extends StatelessWidget {
  final String selectedCategory1;
  final String selectedCategory2;

  // Provide default values for the parameters
  CategoriesList({this.selectedCategory1 = '', this.selectedCategory2 = ''});

  @override
  Widget build(BuildContext context) {
    // Obtain favoritesProvider from the nearest ancestor widget
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoritesProvider2 = Provider.of<FavoritesProvider3>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'categories', // Replace with your actual title or remove if not needed
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(
                child: TextButton(
                  onPressed: () {
                    String selectedCategory = favoritesProvider.selectedCategory;

                    if (selectedCategory == 'all') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllSnacksAndCoffeeListScreen(
                            selectedCategory1: favoritesProvider.selectedCategory,
                            selectedCategory2: favoritesProvider2.selectedCategory,
                          ),
                        ),
                      );
                    } else if (selectedCategory == 'snack') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SnackListScreen(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CoffeeListScreen(
                            selectedCategory1: favoritesProvider.selectedCategory,
                            selectedCategory2: favoritesProvider2.selectedCategory,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),


              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                ),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
