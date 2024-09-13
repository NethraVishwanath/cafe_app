
import 'package:cafe_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'constants.dart';

class SuccessLoginScreen extends StatefulWidget {
  const SuccessLoginScreen({Key? key}) : super(key: key);

  @override
  State<SuccessLoginScreen> createState() => _SuccessLoginScreenState();
}

class _SuccessLoginScreenState extends State<SuccessLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/animations/verified.json",
              height: 200,
              width: 200,
            ),
            SizedBox(height: 10),
            Text(
              "Login Successed!",
              style: TextStyle(
                fontSize: kbigFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              color: kprimaryColor,
              textColor: Colors.white,
              text: "Go to Home Page",
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}