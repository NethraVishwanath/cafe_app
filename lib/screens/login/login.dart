import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/login/login_controller.dart';
import '../../helpers/helpers.dart';
import '../../utils/login_validation.dart';
import '../../widgets/custom_button.dart';
import '../constants.dart';
import '../detail/widget/success_page.dart';
import '../forgotpassword.dart';
import '../home/home.dart';
import '../signup/signup_screen.dart';
import 'package:cafe_project/screens/login/LoginViaOtpScreen.dart';



class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe Registration',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  late LoginController _controller;
  final LoginValidation _validation = LoginValidation();
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _controller = LoginController(this);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  String? _validateEmail(String? value) {
    return _validation.validateEmail(value);
  }

  String? _validatePassword(String? value) {
    return _validation.validatePassword(value);
  }

// ...

  Future<void> _validateInputs() async {
    String? emailError = _validateEmail(emailController.text);
    String? passwordError = _validatePassword(passwordController.text);

    if (emailError == null && passwordError == null) {
      try {
        _controller.showLoader(context);

        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        _controller.hideLoader(context);
        print('User signed in successfully: ${userCredential.user?.email}');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool initialLogin = prefs.getBool('initialLogin') ?? false;

        if (initialLogin) {
          // This is the initial login during the current session, navigate to home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SuccessPage()),
          );
        } else {
          // This is a subsequent login during the current session, navigate to success page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } catch (e) {
        _controller.hideLoader(context);
        print('Error signing in: $e');
        showErrorSnackBar(context, 'Invalid email or password');
      }
    } else {
      showErrorSnackBar(context, 'Please fix the validation errors');
    }
  }


// ...


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SlideTransition(
              position: _controller.getImageSlideAnimation(),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/cafe1.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: FractionallySizedBox(
                  heightFactor: 0.7,
                  widthFactor: 0.9,
                  child: SlideTransition(
                    position: _controller.getCardSlideAnimation(),
                    child: FadeTransition(
                      opacity: _controller.getOpacityAnimation(),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            autovalidateMode: AutovalidateMode
                                .onUserInteraction,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: kbigFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(15.0),
                                      ),
                                      child: TextFormField(
                                        controller: emailController,
                                        focusNode: emailFocusNode,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                        ),
                                        keyboardType:
                                        TextInputType.emailAddress,
                                        validator: (value) =>
                                        emailFocusNode.hasFocus
                                            ? _validateEmail(value)
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Password',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              controller: passwordController,
                                              focusNode: passwordFocusNode,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                              ),
                                              obscureText: !passwordVisible, // Toggle visibility
                                              validator: (value) =>
                                              passwordFocusNode.hasFocus ? _validatePassword(value) : null,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                passwordVisible = !passwordVisible;
                                              });
                                            },
                                            child: Icon(
                                              passwordVisible ? Icons.visibility : Icons.visibility_off,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "New user? Create account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          rememberMe = value ?? false;
                                        });
                                      },
                                    ),
                                    Text('Remember me'),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: 100,
                                  child: CustomButton(
                                    color: kprimaryColor,
                                    textColor: Colors.white,
                                    text: 'Next',
                                    onPress: _validateInputs,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //        ,
                                      //   ),
                                      // );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(color: Colors.blue),
                                    ),

                                  ),


                                ),
                                SizedBox(height: 7),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoginViaOtpScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Login via otp',
                                      style: TextStyle(color: Colors.blue),
                                    ),

                                  ),


                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}