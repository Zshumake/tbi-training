import 'package:flutter/material.dart';

class AppTheme {
  // TBI Training uses a clinical neuroscience-inspired palette
  // Deep navy + clinical teal + warm amber accents
  static const Color primaryNavy = Color(0xFF1B2A4A);
  static const Color accentTeal = Color(0xFF0D9488);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color dangerRed = Color(0xFFDC2626);
  static const Color successGreen = Color(0xFF16A34A);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);

  // Module-specific colors
  static const Color fundamentalsColor = Color(0xFF3B82F6);
  static const Color pathophysColor = Color(0xFF8B5CF6);
  static const Color classificationColor = Color(0xFF0EA5E9);
  static const Color imagingColor = Color(0xFF6366F1);
  static const Color acuteColor = Color(0xFFDC2626);
  static const Color docColor = Color(0xFF7C3AED);
  static const Color complicationsColor = Color(0xFFEA580C);
  static const Color pharmacologyColor = Color(0xFF0D9488);
  static const Color agitationColor = Color(0xFFE11D48);
  static const Color spasticityColor = Color(0xFF2563EB);
  static const Color neuroendocrineColor = Color(0xFF9333EA);
  static const Color concussionColor = Color(0xFF059669);
  static const Color pediatricColor = Color(0xFFF97316);
  static const Color rehabColor = Color(0xFF0891B2);

  // Pearl colors
  static const Color pearlBackground = Color(0xFFFEF3C7);
  static const Color pearlBorder = Color(0xFFF59E0B);
  static const Color mnemonicBackground = Color(0xFFEDE9FE);
  static const Color mnemonicBorder = Color(0xFF7C3AED);
  static const Color avoidBackground = Color(0xFFFEE2E2);
  static const Color avoidBorder = Color(0xFFDC2626);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryNavy,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: surfaceLight,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          height: 1.5,
          color: textSecondary,
        ),
      ),
    );
  }
}
