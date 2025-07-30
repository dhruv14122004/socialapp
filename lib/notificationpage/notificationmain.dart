import 'package:flutter/material.dart';

class Notificationmain extends StatefulWidget {
  const Notificationmain({super.key});

  @override
  State<Notificationmain> createState() => _NotificationmainState();
}

class _NotificationmainState extends State<Notificationmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Text(
          "Notification Page", 
        ),
      )
    );
  }
}