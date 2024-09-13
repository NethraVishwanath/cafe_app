import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cafe_project/models//coffee.dart';

class DetailAppBar extends StatelessWidget{
  final Coffees coffees;


  DetailAppBar(this.coffees);
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