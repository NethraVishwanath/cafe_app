import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_project/models/bestsell.dart';
import 'package:cafe_project/screens/detail/detail1.dart';
import 'favouriteprovider2.dart';

class PopularItem extends StatefulWidget {
  final BestSellers bestSellers;

  PopularItem(this.bestSellers, {Key? key}) : super(key: key);

  @override
  _PopularItemState createState() => _PopularItemState();
}

class _PopularItemState extends State<PopularItem> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider2 = Provider.of<FavoritesProvider2>(context);
    bool isFavorite = favoritesProvider2.favorites.contains(widget.bestSellers);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailPage1(bestSellers: widget.bestSellers),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'bestSellersImage${widget.bestSellers.title}',
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 130,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(widget.bestSellers.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 15,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          favoritesProvider2.toggleFavorite(widget.bestSellers, context);
                        },
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.bestSellers.title,
                style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
