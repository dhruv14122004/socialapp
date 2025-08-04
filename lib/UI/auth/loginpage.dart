import 'package:campusconnect/UI/auth/signuppage.dart';
import 'package:campusconnect/UI/widget/roundedbutton.dart';
import 'package:campusconnect/app.dart';
import 'package:campusconnect/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepOrange.shade100,
                  hintText: "Email",
                  prefixIcon: Icon(Icons.mail_rounded),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.deepOrange.shade100,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Password';
                  }
                  return null;
                },
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepOrange.shade100,
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.deepOrange.shade100,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Roundedbutton(
                title: "Login",
                loading: loading,
                ontap: () {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    _auth
                        .signInWithEmailAndPassword(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString(),
                        )
                        .then((value) {
                          Utils().error(value.user!.email.toString());
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) {
                                return App();
                              },
                            ),
                          );
                          setState(() {
                            loading = true;
                          });
                        })
                        .onError((error, StackTrace) {
                          Utils().error(error.toString());
                          setState(() {
                            loading = true;
                          });
                        });
                  }
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Dont have an Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) {
                            return Signuppage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.deepOrange),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
