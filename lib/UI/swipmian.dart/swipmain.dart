import 'package:flutter/material.dart';

class Swipmain extends StatefulWidget {
  const Swipmain({super.key});

  @override
  State<Swipmain> createState() => _SwipmainState();
}

class _SwipmainState extends State<Swipmain> {
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