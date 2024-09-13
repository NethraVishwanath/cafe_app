import 'package:flutter/material.dart';
import 'BestSellListScreen.dart';

class Bestselling extends StatelessWidget {
  final String title;

  Bestselling({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Container(

                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BestSellListScreen()),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(51),
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
