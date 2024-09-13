import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'checkoutpage.dart';

class Order {
  final String productName;
  final String productPrice;
  final int productQuantity;
  final String productImageUrl;

  Order({
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.productImageUrl,
  });

  // Convert Order object to a map
  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'productPrice': productPrice,
      'productQuantity': productQuantity,
      'productImageUrl': productImageUrl,
    };
  }

  // Create Order object from a map
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      productName: map['productName'],
      productPrice: map['productPrice'],
      productQuantity: map['productQuantity'],
      productImageUrl: map['productImageUrl'],
    );
  }
}

class CartItem {
  final String productImageUrl;
  final String productName;
  final String productPrice;
  final int productQuantity;

  CartItem({
    required this.productImageUrl,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required String productId,
  });
}

class CartItemProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;


  // Set user-specific cart items in the provider
  Future<void> setUserCartItems(User? user) async {
    if (user != null) {
      // Retrieve user-specific cart items from Firestore
      CollectionReference userCartCollection =
      FirebaseFirestore.instance.collection('user_carts');

      DocumentSnapshot<Object?> userCart =
      await userCartCollection.doc(user.uid).get();

      if (userCart.exists) {
        // If cart data exists, clear local cart items before updating with data from Firestore
        _cartItems = [];

        // Update _cartItems with data from Firestore
        List<dynamic> cartData = userCart['cart'] ?? [];
        _cartItems = cartData
            .map((item) =>
            CartItem(
              productImageUrl: item['productImageUrl'],
              productName: item['productName'],
              productPrice: item['productPrice'],
              productQuantity: item['productQuantity'],
              productId: '',
            ))
            .toList();
      } else {
        // If cart data doesn't exist, initialize _cartItems to an empty list
        _cartItems = [];
      }
    } else {
      // If the user is null (logged out), clear _cartItems
      _cartItems = [];
    }

    // Notify listeners that the state has changed
    notifyListeners();
  }


  // Clear user-specific cart items when the user logs out
// Clear user-specific cart items when the user logs out
// Clear user-specific cart items when the user logs out
// Clear user-specific cart items when the user logs out
  void clearUserCartItems(User? user) {
    if (user != null) {
      // Clear user-specific cart items
      FirebaseFirestore.instance.collection('user_carts').doc(user.uid).set({'cart': []});
    }

    // Clear local cart items
    _cartItems = [];
    notifyListeners();
  }


  // Add an item to the cart
  void addToCart(CartItem cartItem) {
    if (isLoggedIn()) {
      User? user = FirebaseAuth.instance.currentUser;

      // Save cart item to Firestore
      FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .collection('cart')
          .add({
        'productName': cartItem.productName,
        'productPrice': cartItem.productPrice,
        'productImageUrl': cartItem.productImageUrl,
        'productQuantity': cartItem.productQuantity,
        // Add other properties as needed
      });
    }

    // Add the item to the local cart
    _cartItems.add(cartItem);

    // Notify listeners that the state has changed
    notifyListeners();
  }

  // Remove an item from the cart
  void removeFromCart(CartItem item) {
    int index = _cartItems.indexOf(item);
    if (index != -1) {
      _cartItems.removeAt(index);
      notifyListeners();
    }
  }

  // Decrement the quantity of an item in the cart
  void decrementQuantity(CartItem item) {
    int index = _cartItems.indexOf(item);
    if (index != -1) {
      _cartItems[index] = CartItem(
        productImageUrl: item.productImageUrl,
        productName: item.productName,
        productPrice: item.productPrice,
        productQuantity: item.productQuantity - 1,
        productId: '',
      );
      notifyListeners();
    }
  }

  // Increment the quantity of an item in the cart
  void incrementQuantity(CartItem item) {
    int index = _cartItems.indexOf(item);
    if (index != -1) {
      _cartItems[index] = CartItem(
        productImageUrl: item.productImageUrl,
        productName: item.productName,
        productPrice: item.productPrice,
        productQuantity: item.productQuantity + 1,
        productId: '',
      );
      notifyListeners();
    }
  }

  // Clear all cart items
  void clearCartItems() {
    _cartItems = [];
    notifyListeners();
  }

  Future<void> _loadUserCartItems(User? user) async {
    // Check if the user is not null before proceeding
    if (user != null) {
      // Fetch user's cart items from Firestore
      QuerySnapshot<Map<String, dynamic>> cartItemsQuery =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart').get();

      List<CartItem> userCartItems = cartItemsQuery.docs.map((doc) {
        // Map Firestore document to CartItem object
        return CartItem(
          productImageUrl: '', // Add a default value for productImageUrl
          productName: doc['productName'],
          productPrice: doc['productPrice'],
          productQuantity: 1,
          productId: '', // Add a default value for productQuantity
        );
      }).toList();

      // Update the local cart with user's cart items
      setUserCartItems(user); // Assuming setUserCartItems is a method in your CartItemProvider
    }
  }
  // Calculate the total amount of the items in the cart
  double calculateTotalAmount() {
    double totalAmount = 0.0;

    for (CartItem item in _cartItems) {
      String priceString = item.productPrice.replaceAll('₹', '').trim();
      double price = double.parse(priceString);
      totalAmount += price * item.productQuantity;
    }

    return totalAmount;
  }

  // Save user-specific cart items to Firestore
  // Save user-specific cart items to Firestore
// Save user-specific cart items to Firestore
// Save user-specific cart items to Firestore
  Future<void> saveUserCartItems(User? user) async {
    if (user != null) {
      CollectionReference userCartCollection =
      FirebaseFirestore.instance.collection('user_carts');

      // Fetch existing cart data
      DocumentSnapshot<Object?> userCart =
      await userCartCollection.doc(user.uid).get();

      List<Map<String, dynamic>> cartData = userCart.exists
          ? List<Map<String, dynamic>>.from(userCart['cart'] ?? [])
          : [];

      // Print the existing cart data for debugging
      print('Existing Cart Data: $cartData');

      // Convert _cartItems to a list of Order objects
      List<Order> newOrders = _cartItems.map((item) => Order(
        productName: item.productName,
        productPrice: item.productPrice,
        productQuantity: item.productQuantity,
        productImageUrl: item.productImageUrl,
      )).toList();

      // Append new orders to existing cart data
      cartData.addAll(newOrders.map((order) => order.toMap()));

      try {
        // Save updated cart data to Firestore
        await userCartCollection.doc(user.uid).set({
          'userId': user.uid,
          'cart': cartData,
        });

        print('User Cart Data Saved Successfully');
      } catch (e) {
        print('Error saving user cart data: $e');
        return;
      }

      // Create a separate collection for orders named "user_orders" (individual user folders)
      CollectionReference userOrdersCollection =
      FirebaseFirestore.instance.collection('user_orders').doc(user.uid).collection('orders');

      // Save each item in _cartItems as a separate order document
      for (Order order in newOrders) {
        try {
          await userOrdersCollection.add({
            ...order.toMap(),
          });
        } catch (e) {
          print('Error saving user order data: $e');
        }
      }
    }
  }




}