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


  static const Color background = Color(0xFFF0F1F5);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1C1917);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);

  // Status
  static const Color greenBg = Color(0xFFDCFCE7);
  static const Color greenText = Color(0xFF15803D);
  static const Color blueBg = Color(0xFFDBEAFE);
  static const Color blueText = Color(0xFF1D4ED8);
  static const Color yellowBg = Color(0xFFFEF3C7);
  static const Color yellowText = Color(0xFFB45309);
  static const Color grayBg = Color(0xFFF3F4F6);
  static const Color grayText = Color(0xFF6B7280);
  static const Color redBg = Color(0xFFFEE2E2);
  static const Color redText = Color(0xFFB91C1C);
  static const Color purpleBg = Color(0xFFEDE9FE);
  static const Color purpleText = Color(0xFF6D28D9);

  // Material/Labour
  static const Color matBg = Color(0xFFFEF9C3);
  static const Color matText = Color(0xFF854D0E);
  static const Color labBg = Color(0xFFDCFCE7);
  static const Color labText = Color(0xFF15803D);
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


String formatCurrency(double amount) {
  if (amount >= 100000) {
    double lakh = amount / 100000;
    if (lakh == lakh.floor()) {
      return '₹${lakh.floor()}L';
    }
    return '₹${lakh.toStringAsFixed(1)}L';
  }
  if (amount >= 1000) {
    return '₹${(amount / 1000).toStringAsFixed(0)}K';
  }
  return '₹${amount.toStringAsFixed(0)}';
}

String formatCurrencyFull(double amount) {
  final parts = amount.toStringAsFixed(0).split('').reversed.toList();
  final result = <String>[];
  for (int i = 0; i < parts.length; i++) {
    if (i == 3 && i < parts.length - 1) result.add(',');
    if (i > 3 && (i - 3) % 2 == 0 && i < parts.length - 1) result.add(',');
    result.add(parts[i]);
  }
  return '₹${result.reversed.join()}';
}