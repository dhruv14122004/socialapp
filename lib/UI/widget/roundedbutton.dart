import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const Roundedbutton({super.key, required this.title, required this.ontap, this.loading= false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading==true ? CircularProgressIndicator(color: Colors.white, strokeWidth: 3,) : Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
