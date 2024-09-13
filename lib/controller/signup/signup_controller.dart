import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helpers/helpers.dart';
import '../../screens/detail/widget/success_page.dart';
import '../../screens/home/home.dart';
import '../../screens/signup/signup_screen_state.dart';
import '../../services/auth_sservice.dart';
import '../../services/firestore_service.dart';
import '../../utils/signup_validation.dart';

class SignupController {
  final AuthService authService;
  final FirestoreService firestoreService;

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _cardSlideAnimation;
  late Animation<Offset> _imageSlideAnimation;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _usernameError;
  String? _emailError;
  String? _phonenumberError;
  String? _passwordError;

  late SignupScreenState _state;
  final SignupValidation _validation = SignupValidation();

  SignupController(
      this._state,
      this.authService,
      this.firestoreService,
      );

  void initAnimations() {
    _controller = AnimationController(
      vsync: _state,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _cardSlideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _imageSlideAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  Animation<double> getOpacityAnimation() => _opacityAnimation;

  Animation<Offset> getCardSlideAnimation() => _cardSlideAnimation;

  Animation<Offset> getImageSlideAnimation() => _imageSlideAnimation;

  String? getPasswordError() => _passwordError;

  String? getUsernameError() => _usernameError;

  String? getEmailError() => _emailError;

  String? getPhoneNumberError() => _phonenumberError;

  // Inside SignupController
  Future<bool> validateInputs() async {
    _state.setState(() {
      _usernameError = _validation.validateUsername(usernameController.text);
      _emailError = _validation.validateEmail(emailController.text);
      _phonenumberError =
          _validation.validatePhoneNumber(phoneController.text);
    });

    if (_usernameError == null &&
        _emailError == null &&
        _phonenumberError == null) {
      showLoader(_state.context);

      try {
        // Create the user with email and password
        final UserCredential userCredential =
        await authService.signUp(
          emailController.text,
          phoneController.text,
          passwordController.text,
        );

        // Add user to Firestore
        await firestoreService.addUser(
          userCredential.user!.uid,
          usernameController.text,
          emailController.text,
          phoneController.text,
        );

        hideLoader(_state.context);

        // Navigate directly to the login screen
        Navigator.push(
          _state.context,
          MaterialPageRoute(
            builder: (BuildContext context) => SuccessPage(),
          ),
        );

        return true; // Return true if validation and sign-up are successful
      } catch (e) {
        hideLoader(_state.context);
        showErrorSnackBar(_state.context, 'Error creating account: $e');
      }
    } else {
      hideLoader(_state.context);
      showErrorSnackBar(_state.context, 'Please fix the validation errors');
    }

    return false; // Return false if validation fails
  }


  Future<void> logout() async {
    try {
      await authService.logout();
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  void dispose() {
    _controller.dispose();
  }
}