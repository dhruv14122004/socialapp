import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const royalBlue = Color(0xFF4169E1);
  static const white = Colors.white;
  static const lightGrey = Color(0xFFF5F5F5);
}

ThemeData buildLightTheme() {
  final base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.royalBlue),
    primaryColor: AppColors.royalBlue,
    scaffoldBackgroundColor: AppColors.lightGrey,
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: AppColors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.poppins(
        textStyle: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.royalBlue,
      foregroundColor: AppColors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.royalBlue,
      unselectedItemColor: Colors.grey,
      backgroundColor: AppColors.white,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
