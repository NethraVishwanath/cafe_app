import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cafe_project/screens/home/widget/FavoritesPage.dart';
import 'package:cafe_project/screens/home/widget/cart_item_provider.dart';
import 'package:cafe_project/screens/home/widget/coffee_list_screen.dart';
import 'package:cafe_project/screens/home/widget/custom_app_bar.dart';
import 'package:cafe_project/screens/home/widget/helpandsupport.dart';
import 'package:cafe_project/screens/home/widget/new_arrival.dart';
import 'package:cafe_project/screens/home/widget/newarrival2.dart';
import 'package:cafe_project/screens/home/widget/orders.dart';
import 'package:cafe_project/screens/home/widget/popular.dart';
import 'package:cafe_project/screens/home/widget/settingpage.dart';
import 'package:cafe_project/screens/home/widget/terms_and_conditions.dart';
import 'package:cafe_project/screens/login/login.dart';
import 'package:cafe_project/services/auth_sservice.dart';

import '../../models/coffee.dart';
import '../../models/snacks.dart';
import '../Myaccount.dart';
import '../welcome_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bottomList = ['Home', 'Menu', 'Profile'];
  int selectedTabIndex = 0;
  final List<Coffees> coffeeList = Coffees.generateCoffees();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _authService = AuthService();
  String? displayName;

  @override
  void initState() {
    super.initState();
    _updateDisplayName();
  }

  Future<void> _updateDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.reload();
      user = FirebaseAuth.instance.currentUser;

      // Fetch additional user details from Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

      setState(() {
        displayName = userDoc['username'] ?? 'Guest';
      });

      // Check if the user was a guest before login
      if (wasGuestBeforeLogin) {
        _transferGuestCartToUserCart(user!);
        wasGuestBeforeLogin = false;
      } else {
        _loadUserCartItems(user!);
      }
    } else {
      setState(() {
        displayName = 'Guest';
      });

      Provider.of<CartItemProvider>(context, listen: false).clearCartItems();
    }
  }

  bool wasGuestBeforeLogin = false;

  Future<void> _loadUserCartItems(User user) async {
    if (user != null) {
      QuerySnapshot<Map<String, dynamic>> cartItemsQuery =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart').get();

      List<CartItem> userCartItems = cartItemsQuery.docs.map((doc) {
        return CartItem(
          productImageUrl: '',
          productName: doc['productName'],
          productPrice: doc['productPrice'],
          productQuantity: 1,
          productId: '',
        );
      }).toList();

    }
  }



  Future<void> _transferGuestCartToUserCart(User user) async {
    List<CartItem> guestCartItems = Provider.of<CartItemProvider>(context, listen: false).cartItems;
    for (CartItem cartItem in guestCartItems) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection('cart').add({
        'productName': cartItem.productName,
        'productPrice': cartItem.productPrice,
        'productImageUrl': cartItem.productImageUrl,
        'productQuantity': cartItem.productQuantity,
      });
    }

    Provider.of<CartItemProvider>(context, listen: false).clearCartItems();
  }



  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  Icon getIconForLabel(String label, int index) {
    Color iconColor = selectedTabIndex == index ? Colors.brown : Colors.black;

    switch (label) {
      case 'Home':
        return Icon(Icons.home, size: 25, color: iconColor);
      case 'Menu':
        return Icon(Icons.menu, size: 25, color: iconColor);
      case 'Profile':
        return Icon(Icons.account_circle, size: 25, color: iconColor);
      default:
        return Icon(Icons.error, size: 27, color: iconColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildHomePage();
  }

  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(7),
        //   child: SearchInput(c
        //     coffeesList: coffeeList,
        //     onItemClicked: (selectedCoffee) {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => DetailPage(coffees: selectedCoffee),
        //         ),
        //       );
        //     },
        //   ),
        // ),
        backgroundColor: Colors.brown.shade50,
        toolbarHeight: 90.0,
        title: CustomAppBar(openDrawer: openDrawer),
      ),
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewArrival(coffeesList: Coffees.generateCoffees()),
            NewArrival2(snacksList: Snacks.generateSnacks()), // Pass snacksList here
            Popular(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomList.asMap().entries.map((entry) {
          return BottomNavigationBarItem(
            label: entry.value,
            icon: getIconForLabel(entry.value, entry.key),
          );
        }).toList(),
        currentIndex: selectedTabIndex,
        onTap: (index) {
          setState(() {
            selectedTabIndex = index;
          });

          if (index == bottomList.indexOf('Profile')) {
            openDrawer();
          } else if (index == bottomList.indexOf('Menu')) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CoffeeListScreen()),
            );
          }
        },
      ),
      drawer: Drawer(
        backgroundColor: Colors.yellow.shade50,
        child: SingleChildScrollView(
          child:Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/cafe.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.brown.shade200,
                      BlendMode.modulate,
                    ),
                  ),
                ),
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.account_circle_rounded, color: Colors.grey, size: 100),
                      SizedBox(width: 16, height: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              displayName ?? 'Guest',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          FutureBuilder<User?>(
                            future: FirebaseAuth.instance.authStateChanges().first,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }

                              User? user = snapshot.data;

                              if (user == null) {
                                // Guest user, show Login/Signup option
                                return Row(
                                  children: [
                                    // Icon(Icons.login),
                                    SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SignIn(),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                        // Adjust vertical padding as needed
                                        backgroundColor: Colors.brown.withOpacity(0.8),
                                      ),
                                      child: Text(
                                        'Login/Signup',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {

                                return Text(
                                  user.email ?? "Jnr App Developer",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    displayName == null
                        ? Row(
                      children: [
                        Icon(Icons.login),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Login/Signup',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Row(
                      children: [
                        SizedBox(height: 20),
                        Icon(Icons.home),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.account_circle),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyAccountPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'My Account',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                         ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.favorite),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavouriteScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Text(
                              'Favorites',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.shopping_bag),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrdersPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Text(
                              'Orders',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.help),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HelpAndSupportPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Text(
                              'Help & Support',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(height: 20),
                        Icon(Icons.settings),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 10,
                            ),
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(height: 20),
                        Icon(Icons.help_outline),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermsAndConditionsPage(),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 10,
                            ),
                            child: Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Add Logout button
                    Row(
                      children: [
                        SizedBox(height: 20),
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () async {
                            bool confirmLogout = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Logout'),
                                  content: Text('Are you sure you want to log out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('No'),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmLogout ?? false) {
                              try {
                                await _authService.logout();
                                await _updateDisplayName();
                                Navigator.pop(context); // Close the drawer
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                                );
                              } catch (e) {
                                print('Error during logout: $e');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('An error occurred. Please try again.'),
                                  ),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}