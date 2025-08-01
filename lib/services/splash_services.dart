import 'dart:async';

import 'package:campusconnect/UI/auth/loginpage.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      ),
    );
  }
}
