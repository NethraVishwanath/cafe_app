import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helpers/helpers.dart';
import '../../screens/home/home.dart';
import '../../widgets/custom_button.dart';
import '../../controller/login/login_controller.dart';
import '../../services/firestore_service.dart';
import '../detail/widget/success_page.dart';


class LoginViaOtpScreen extends StatefulWidget {
  @override
  _LoginViaOtpScreenState createState() => _LoginViaOtpScreenState();
}

class _LoginViaOtpScreenState extends State<LoginViaOtpScreen>
    with TickerProviderStateMixin {
  late LoginController _controller;
  late TextEditingController phoneController;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _controller = LoginController(this);
    phoneController = TextEditingController();
  }

  void navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  Future<void> _sendOtp() async {
    try {
      setState(() {
        errorMessage = '';
      });

      String phoneNumber = phoneController.text;

      // Check if the phone number is associated with a registered user
      bool isRegistered = await FirestoreService().isPhoneNumberRegistered(phoneNumber);

      if (isRegistered) {
        // Proceed with OTP verification if the user is registered
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // Automatically sign in if verification is completed
            await FirebaseAuth.instance.signInWithCredential(credential);
            navigateToHomeScreen();
          },
          verificationFailed: (FirebaseAuthException e) {
            print('Verification Failed: $e');
          },
          codeSent: (String verificationId, int? resendToken) async {
            // Navigate to the verification code input screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } else {
        // Display an error if the user is not registered
        setState(() {
          errorMessage = 'Phone number is not registered. Please sign up.';
        });
      }
    } catch (e) {
      print('Error sending or verifying OTP: $e');
      setState(() {
        errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login via OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter your phone number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            SizedBox(height: 12),
            CustomButton(
              color: Colors.blue,
              textColor: Colors.white,
              text: 'Send OTP',
              onPress: _sendOtp,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;

  OtpVerificationScreen(this.verificationId);

  @override
  _OtpVerificationScreenState createState() =>
      _OtpVerificationScreenState(verificationId);
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with TickerProviderStateMixin {
  final String verificationId;
  late LoginController _controller;
  late TextEditingController otpController;
  String errorMessage = '';
  String successMessage = '';

  _OtpVerificationScreenState(this.verificationId);

  @override
  void initState() {
    super.initState();
    _controller = LoginController(this);
    otpController = TextEditingController();
  }

  void navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessPage(), // Replace with your actual home screen widget
      ),
    );
  }

  Future<void> _verifyOtp() async {
    try {
      setState(() {
        errorMessage = ''; // Clear previous error messages
        successMessage = ''; // Clear previous success messages
      });

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Set success message
      setState(() {
        successMessage = 'OTP verified successfully!';
      });

      // Delay navigation to give some time for the user to see the success message
      Future.delayed(Duration(seconds: 2), () {
        navigateToHomeScreen();
      });
    } catch (e) {
      print('Error verifying OTP: $e');
      setState(() {
        errorMessage = 'Invalid OTP. Please try again.';
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter the OTP sent to your phone',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            if (successMessage.isNotEmpty)
              Text(
                successMessage,
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            SizedBox(height: 12),
            CustomButton(
              color: Colors.blue,
              textColor: Colors.white,
              text: 'Verify OTP',
              onPress: _verifyOtp,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    otpController.dispose();
    super.dispose();
  }
}
