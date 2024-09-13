import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String phoneNumber, String password) async {
    try {
      // Create the user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send OTP to the user's phone number and return verificationId
      String verificationId = await sendOtp(phoneNumber);

      return userCredential;
    } catch (e) {
      print("Error signing up: $e");
      rethrow;
    }
  }


  Future<void> _changePassword(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Implement your logic to get the new password from the user
        String newPassword = "new_password";

        // Prompt the user to re-enter their password
        String currentPassword = await _showPasswordPrompt(context);

        // Reauthenticate the user with their current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        await user.reauthenticateWithCredential(credential);

        // Now you can change the password
        await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password changed successfully.'),
          ),
        );
      } else {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found. Please sign in again.',
        );
      }
    } catch (e) {
      print('Error changing password: $e');

      // Cast the exception to FirebaseAuthException
      if (e is FirebaseAuthException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error changing password. Please try again.'),
        ),
      );
    }
  }

  Future<String> _showPasswordPrompt(BuildContext context) async {
    // Implement your logic to show a dialog or prompt for the current password
    // For example, you can use the showDialog function to create a password input dialog
    return "current_password"; // Replace with the actual implementation
  }


  Future<String> sendOtp(String phoneNumber) async {
    try {
      String verificationId = "";

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          // This callback will be invoked if the auto-detection is successful.
          // You can use credential.verificationId here.
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          print("Error sending OTP: $e");
        },
        codeSent: (String id, int? resendToken) {
          // Save the verificationId and use it when needed.
          verificationId = id;
          print('Verification ID: $verificationId');
        },
        codeAutoRetrievalTimeout: (String id) {
          // Save the verificationId and use it when needed.
          verificationId = id;
          print('Verification ID: $verificationId');
        },
      );

      return verificationId;
    } catch (e) {
      print("Error sending OTP: $e");
      rethrow;
    }
  }

  Future<void> updatePhoneNumberWithOtp(String verificationId, String smsCode) async {
    try {
      // Use the verification ID and SMS code obtained during phone number verification
      await _auth.currentUser?.updatePhoneNumber(PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      ));
    } catch (e) {
      print("Error updating phone number: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error during logout: $e");
      rethrow;
    }
  }
}