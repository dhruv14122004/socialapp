import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const Roundedbutton({super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
