import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_project/screens/detail/snackdetail.dart';
import '../../../models/snacks.dart';
import '../../constants.dart';
import 'cart_item_provider.dart';
import 'favouritesprovider3.dart';

class SnackItem extends StatefulWidget {
  final Snacks snacks;

  SnackItem(this.snacks, {Key? key}) : super(key: key);

  @override
  _SnackItemState createState() => _SnackItemState();
}

class _SnackItemState extends State<SnackItem> {
  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider3>(context);
    final cartProvider = Provider.of<CartItemProvider>(context);
    bool isFavorite = favoritesProvider.favorites.contains(widget.snacks);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailPage3(snacks: widget.snacks),
            transitionsBuilder: (context, animation, secondaryAnimation,
                child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween = Tween(begin: begin, end: end).chain(
                  CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'coffeeImage${widget.snacks.title}',
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 2),
                      image: DecorationImage(
                        image: AssetImage(widget.snacks.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        favoritesProvider.toggleFavorite(widget.snacks, context);
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.snacks.title,
              style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
            ),
            Text(
              widget.snacks.price,
              style: TextStyle(
                color: pricecolor,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                CartItem cartItem = CartItem(
                  productImageUrl: widget.snacks.imageUrl,
                  productName: widget.snacks.title,
                  productPrice: widget.snacks.price,
                  productQuantity: 1,
                  productId: '',
                );
                cartProvider.addToCart(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to Cart'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: buttoncolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
