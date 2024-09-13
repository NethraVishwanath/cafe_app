import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cafe_project/models//coffee.dart';

import '../../../models/bestsell.dart';

class DetailAppBar1 extends StatelessWidget{
  final BestSellers bestSellers;


  DetailAppBar1(this.bestSellers);
  final CarouselController _controller = CarouselController();


  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/arrival1.png'),
              fit: BoxFit.fitHeight)
      ),
      child: GestureDetector(
        onTap: (){

        },

      ),
    );

  }

}