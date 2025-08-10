import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  const RoundButton({super.key});

  @override
  State<RoundButton> createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
         
      ),
    );
  }
}
