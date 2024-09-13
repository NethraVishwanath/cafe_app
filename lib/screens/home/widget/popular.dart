import 'package:flutter/material.dart';
import 'package:cafe_project/screens/home/widget/popularItem.dart';

import '../../../models/bestsell.dart';
import 'best_sell.dart';

class Popular extends StatelessWidget{
  final popularCoffee = BestSellers.generateBestSellers();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Bestselling(title: 'Popular Coffee'),
          Container(
            height: 210,
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index) => PopularItem(popularCoffee[index]),
                separatorBuilder: (_,index) => SizedBox(width: 10,),
                itemCount: popularCoffee.length
            ),
          ),
        ],
      ),
    );
  }

}