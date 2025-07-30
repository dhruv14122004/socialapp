import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: App(),
      theme: ThemeData(useMaterial3: true).copyWith(
        appBarTheme: AppBarTheme(
          color: Color(0xFFFAFAFA),
          titleTextStyle: TextStyle(color: Color(0xFF2D3748)),
          iconTheme: IconThemeData(color: Color(0xFF4A5568)),
          actionsIconTheme: IconThemeData(color: Color(0xFF4A5568)),
        ),
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          titleLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 25,
            color: Color(0xFF2D3748),
          ),
          titleMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF4A5568),
          ),
          titleSmall: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF2D3748),
          ),
        ),
        scaffoldBackgroundColor: Colors.grey.shade300,
        iconTheme: IconThemeData(color: Color(0xFF4A5568)),
      ),
    );
  }
}
