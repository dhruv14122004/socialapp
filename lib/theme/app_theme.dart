import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Aqua Color Scheme
  static const lightAquaWhite = Color(0xFFE5FCFC);
  static const paleAqua = Color(0xFFC7F1F4);
  static const softAquaBlue = Color(0xFFA7E4E8);
  static const mediumAquaTeal = Color(0xFF6DCAD0);

  // Text Colors
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF4F4F4F);

  // System Colors
  static const dividerColor = Color(0xFFD0E6E8);
  static const white = Colors.white;

  // Interaction Colors (slightly darker shades for hover/tap)
  static const mediumAquaTealDark = Color(0xFF5BB0B6);
  static const softAquaBlueDark = Color(0xFF8DCDD2);
}

// Cache the text theme for better performance
TextTheme? _cachedPoppinsTheme;
TextTheme get poppinsTextTheme {
  return _cachedPoppinsTheme ??= GoogleFonts.poppinsTextTheme();
}

ThemeData buildLightTheme() {
  final base = ThemeData.light(useMaterial3: true);

  // Use cached Poppins text theme for better performance
  final poppinsTheme = poppinsTextTheme;

  final textTheme = poppinsTheme.copyWith(
    // Large app titles
    displayLarge: const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    // Screen titles (Headline6/titleLarge equivalent)
    titleLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),
    // Post subtitles / usernames (Subtitle1 equivalent)
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    ),
    // Timestamps / light labels
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    ),
    // Main post text (BodyText1 equivalent)
    bodyLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    ),
    // Comment text (BodyText2 equivalent)
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: AppColors.textSecondary,
    ),
    // Button text
    labelLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );

  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.mediumAquaTeal,
      brightness: Brightness.light,
    ),
    primaryColor: AppColors.mediumAquaTeal,
    scaffoldBackgroundColor: AppColors.lightAquaWhite,

    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: AppColors.lightAquaWhite,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: GoogleFonts.poppins(
        textStyle: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    textTheme: GoogleFonts.poppinsTextTheme(textTheme),

    // Primary buttons (#6DCAD0 background with white text)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            backgroundColor: AppColors.mediumAquaTeal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            textStyle: textTheme.labelLarge,
            elevation: 0,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(AppColors.mediumAquaTealDark),
          ),
    ),

    // FilledButton theme for primary actions
    filledButtonTheme: FilledButtonThemeData(
      style:
          FilledButton.styleFrom(
            backgroundColor: AppColors.mediumAquaTeal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            textStyle: textTheme.labelLarge,
            elevation: 0,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(AppColors.mediumAquaTealDark),
          ),
    ),

    // Secondary buttons
    outlinedButtonTheme: OutlinedButtonThemeData(
      style:
          OutlinedButton.styleFrom(
            backgroundColor: AppColors.softAquaBlue,
            foregroundColor: AppColors.textPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            side: const BorderSide(color: AppColors.softAquaBlue),
            elevation: 0,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(AppColors.softAquaBlueDark),
          ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.mediumAquaTeal,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: CircleBorder(),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.dividerColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.mediumAquaTeal, width: 2),
      ),
      hintStyle: const TextStyle(color: AppColors.textSecondary),
    ),

    cardTheme: CardThemeData(
      color: AppColors.paleAqua,
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    // Modern floating bottom navigation bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.mediumAquaTeal,
      selectedItemColor: Colors.white,
      unselectedItemColor: AppColors.softAquaBlue,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 12,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(size: 28),
      unselectedIconTheme: IconThemeData(size: 24),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.dividerColor,
      thickness: 1,
    ),
  );
}
