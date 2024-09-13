import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('General'),
            onTap: () {
              // Navigate to the general settings page
              // You can implement this navigation based on your app structure
              print('Navigate to General Settings');
            },
          ),
          ListTile(
            title: Text('Notifications'),
            onTap: () {
              // Navigate to the notifications settings page
              // You can implement this navigation based on your app structure
              print('Navigate to Notifications Settings');
            },
          ),

          ListTile(
            title: Text('Appearance'),
            onTap: () {
              // Navigate to the appearance settings page
              // You can implement this navigation based on your app structure
              print('Navigate to Appearance Settings');
            },
          ),
          // Add more ListTiles for additional settings
        ],
      ),
    );
  }
}
