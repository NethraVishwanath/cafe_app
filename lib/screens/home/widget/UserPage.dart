import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GestureDetector(
        onTap: (){
          setState(() {

          });
        },
        child: Drawer(),
      ),
    );
  }
}
