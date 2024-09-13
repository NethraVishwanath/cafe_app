import 'package:flutter/material.dart';
import 'package:cafe_project/screens/home/widget/popularItem.dart';
import '../../../models/bestsell.dart';

class BestSellListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best of All Items'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: BestSellers.generateBestSellers().length,
        itemBuilder: (context, index) {
          final bestSellers = BestSellers.generateBestSellers()[index];
          return PopularItem(bestSellers);
        },
      ),
    );
  }
}
