import 'dart:async';

import 'package:campusconnect/UI/auth/loginpage.dart';
import 'package:campusconnect/UI/postpage/postmain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null ){
      Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return Postmain();
          },
        ),
      ),
    );
    }else{
      Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      ),
    );}
  }
}
