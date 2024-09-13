import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Your App Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              // Navigate to the home screen or perform some action
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Profile'),
            leading: Icon(Icons.person),
            onTap: () {
              // Navigate to the profile screen or perform some action
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Settings'),
            leading: Icon(Icons.settings),
            onTap: () {
              // Navigate to the settings screen or perform some action
              Navigator.pop(context); // Close the drawer
            },
          ),
          Divider(), // A divider to separate menu items
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              // Perform logout action
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
