import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cafe_project/screens/home/home.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  OtpVerificationScreen({
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  Future<void> _verifyOTP() async {
    try {
      setState(() {
        isLoading = true;
      });

      // Create PhoneAuthCredential using the verification ID and entered OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text,
      );

      // Sign in with the PhoneAuthCredential
      await FirebaseAuth.instance.signInWithCredential(credential).then((userCredential) {
        // Handle successful verification, e.g., navigate to the home page
        print('OTP verification successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } catch (e) {
      // Handle OTP verification failure
      print('Error verifying OTP: $e');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('OTP verification failed: $e')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _verifyOTP,
              child: Text('Verify OTP'),
            ),
            if (isLoading) CircularProgressIndicator(), // Show loading indicator while verifying
          ],
        ),
      ),
    );
  }
}
