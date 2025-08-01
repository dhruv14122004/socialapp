import 'package:flutter/material.dart';

class Directmessagemain extends StatefulWidget {
  const Directmessagemain({super.key});

  @override
  State<Directmessagemain> createState() => _DirectmessagemainState();
}

class _DirectmessagemainState extends State<Directmessagemain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Text(
          "Direct Message Page", 
        ),
      )
    );
  }
}