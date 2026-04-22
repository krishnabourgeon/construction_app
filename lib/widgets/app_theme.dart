import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color amber = Color(0xFFF59E0B);
  static const Color amberLight = Color(0xFFFEF3C7);
  static const Color amberDark = Color(0xFFB45309);
  static const Color orange = Color(0xFFEA580C);
  static const Color orangeLight = Color(0xFFFED7AA);
  static const Color navy = Color(0xFF1A1A2E);
  static const Color dark = Color(0xFF1C1917);
  static const Color grey = Color(0xFF6B7280);
  static const Color greyLight = Color(0xFF9CA3AF);
  static const Color greyBg = Color(0xFFF0F1F5);
  static const Color white = Color(0xFFFFFFFF);
  static const Color redLight = Color(0xFFFEE2E2);
  static const Color red = Color(0xFFB91C1C);
  static const Color blueLight = Color(0xFFDBEAFE);
  static const Color blue = Color(0xFF1D4ED8);
  static const Color greenLight = Color(0xFFDCFCE7);
  static const Color green = Color(0xFF15803D);
  static const Color border = Color(0xFFE5E7EB);
  static const Color scaffoldBg = Color(0xFFE8E9ED);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.greyBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.amber,
        primary: AppColors.amber,
        secondary: AppColors.orange,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.navy,
        foregroundColor: AppColors.white,
        elevation: 0,
        titleTextStyle: GoogleFonts.poppins(
          color: AppColors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.amber, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        labelStyle: GoogleFonts.poppins(color: AppColors.grey, fontSize: 13),
        hintStyle: GoogleFonts.poppins(color: AppColors.greyLight, fontSize: 13),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.amber,
          foregroundColor: AppColors.dark,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
