import 'package:flutter/material.dart';

class Searchmain extends StatefulWidget {
  const Searchmain({super.key});

  @override
  State<Searchmain> createState() => _SearchmainState();
}

class _SearchmainState extends State<Searchmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Text(
          "Search Page", 
        ),
      )
    );
  }
}