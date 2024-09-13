import 'package:flutter/material.dart';
import 'allsnacks.dart';
import 'coffee_list_screen.dart';
import 'favouriteprovider.dart';
import 'favouritesprovider3.dart';

class AllSnacksAndCoffeeListScreen extends StatelessWidget {
  final String selectedCategory1;
  final String selectedCategory2;

  AllSnacksAndCoffeeListScreen({
    required this.selectedCategory1,
    required this.selectedCategory2,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('All Items'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Hot drinks'),
              Tab(text: 'Snacks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoffeeListScreen(
              selectedCategory1: selectedCategory1,
              selectedCategory2: selectedCategory2,
            ),
            SnackListScreen(),
          ],
        ),
      ),
    );
  }
}
