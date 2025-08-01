import 'package:flutter/material.dart';

class Gangsmain extends StatefulWidget {
  const Gangsmain({super.key});

  @override
  State<Gangsmain> createState() => _GangsmainState();
}

class _GangsmainState extends State<Gangsmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Text(
          "Gangs Page", 
        ),
      )
    );
  }
}