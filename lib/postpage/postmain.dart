import 'package:flutter/material.dart';

class Postmain extends StatefulWidget {
  const Postmain({super.key});

  @override
  State<Postmain> createState() => _SearchMainState();
}

class _SearchMainState extends State<Postmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Post Page", 
        ),
      )
    );
  }
}
