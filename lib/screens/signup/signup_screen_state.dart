// signup_screen_state.dart

import 'package:flutter/material.dart';

abstract class SignupScreenState extends TickerProvider {
  void setState(void Function() fn);
  BuildContext get context;
}
