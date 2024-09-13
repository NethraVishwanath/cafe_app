import 'package:flutter/material.dart';
import 'package:cafe_project/screens/constants.dart';
import 'package:cafe_project/screens/welcome1.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COFFEE SHOP',
      theme: ThemeData(
        // backgroundColor: Color(0xFFFAFAFA),
        primaryColor: const Color(0xFFFFBD00),
      ),
      home:  const Scaffold(backgroundColor:skyblue, body: Center(child: CircularProgressIndicator(color: Colors.white))),
    );

  }
}