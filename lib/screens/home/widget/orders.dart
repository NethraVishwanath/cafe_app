import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe_project/screens/welcome_screen.dart';

import '../home.dart';



class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  User? _currentUser; // Change the type to User?
  late CollectionReference _userOrdersCollection;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    if (_currentUser != null) {
      _userOrdersCollection =
          FirebaseFirestore.instance.collection('user_orders').doc(_currentUser!.uid).collection('orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: _currentUser != null
          ? StreamBuilder<QuerySnapshot>(
        stream: _userOrdersCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No orders yet.'),

                  SizedBox(height: 8),
                  Image.asset(
                    'assets/images/wait.jpeg', // Replace with the path to your image
                    width: 200, // Set the width as needed
                    height: 200, // Set the height as needed
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(),
                          )
                      );
                    },
                    child: Text('Place an Order'),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                // Customize the UI for each order
                Map<String, dynamic> orderData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(orderData['productName']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${orderData['productPrice']}'),
                        Text('Quantity: ${orderData['productQuantity']}'),
                      ],
                    ),
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(orderData['productImageUrl']),
                        ),
                      ),
                    ),
                    // Add more details as needed
                  ),
                );
              },
            );
          }
        },
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please log in to Place your orders.',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            SizedBox(height: 8),
            Image.asset(
              'assets/gifs/1.gif', // Replace with the path to your image
              width: 200, // Set the width as needed
              height: 200, // Set the height as needed
              fit: BoxFit.contain,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.8), // Set transparent brown background
              ),
              child: Text('Login/Signup',style:TextStyle(color:Colors.white ),),
            ),



          ],
        ),
      ),
    );
  }
}