import 'package:flutter/material.dart';

class AppTheme {
  // ──────────────────────────────────────────────
  // Clinical Atlas - Dark Mode Design Tokens
  // ──────────────────────────────────────────────

  // Core palette
  static const Color background = Color(0xFF0F1419);
  static const Color surface = Color(0xFF1A1F2E);
  static const Color surfaceElevated = Color(0xFF232A3B);
  static const Color primaryCyan = Color(0xFF22D3EE);
  static const Color accent = primaryCyan;
  static const Color secondaryAmber = Color(0xFFF59E0B);
  static const Color accentAmber = secondaryAmber;
  static const Color textPrimary = Color(0xFFE8ECF1);
  static const Color textSecondary = Color(0xFF8899AA);
  static const Color border = Color(0xFF2A3444);
  static const Color successGreen = Color(0xFF34D399);
  static const Color dangerRed = Color(0xFFEF4444);

  // Legacy aliases (keeps existing references compiling)
  static const Color primaryNavy = background;
  static const Color accentTeal = primaryCyan;
  static const Color warningAmber = secondaryAmber;
  static const Color surfaceLight = background;
  static const Color cardBackground = surface;

  // Module-specific colors (vibrant against dark)
  static const Color fundamentalsColor = Color(0xFF60A5FA); // bright blue
  static const Color pathophysColor = Color(0xFFA78BFA); // bright purple
  static const Color classificationColor = Color(0xFF38BDF8); // sky blue
  static const Color imagingColor = Color(0xFF818CF8); // indigo
  static const Color acuteColor = Color(0xFFF87171); // bright red
  static const Color docColor = Color(0xFFC084FC); // violet
  static const Color complicationsColor = Color(0xFFFB923C); // orange
  static const Color pharmacologyColor = Color(0xFF2DD4BF); // teal
  static const Color agitationColor = Color(0xFFFB7185); // rose
  static const Color spasticityColor = Color(0xFF60A5FA); // blue
  static const Color neuroendocrineColor = Color(0xFFE879F9); // fuchsia
  static const Color concussionColor = Color(0xFF34D399); // emerald
  static const Color pediatricColor = Color(0xFFFBBF24); // amber
  static const Color rehabColor = Color(0xFF22D3EE); // cyan

  // Pearl / mnemonic / avoid backgrounds for dark mode
  static const Color pearlBackground = Color(0xFF2A2418);
  static const Color pearlBorder = Color(0xFFF59E0B);
  static const Color mnemonicBackground = Color(0xFF1E1B2E);
  static const Color mnemonicBorder = Color(0xFF7C3AED);
  static const Color avoidBackground = Color(0xFF2A1818);
  static const Color avoidBorder = Color(0xFFEF4444);

  // ──────────────────────────────────────────────
  // ThemeData
  // ──────────────────────────────────────────────

  static ThemeData get lightTheme => darkTheme; // single theme redirect

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: primaryCyan,
        secondary: secondaryAmber,
        surface: surface,
        error: dangerRed,
        onPrimary: Color(0xFF003544),
        onSecondary: Color(0xFF3D2800),
        onSurface: textPrimary,
        onError: Colors.white,
        outline: border,
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: border, width: 1),
        ),
      ),

      // Bottom sheet
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceElevated,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceElevated,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: border,
        thickness: 1,
      ),

      // ListTile
      listTileTheme: const ListTileThemeData(
        textColor: textPrimary,
        iconColor: primaryCyan,
        selectedColor: primaryCyan,
      ),

      // Typography
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -1.5,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -1.0,
          height: 1.2,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
          height: 1.6,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.6,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textSecondary,
          letterSpacing: 2.0,
        ),
      ),

      // Page transitions - smooth slide/fade
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: _FadeThroughPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}

// Custom smooth fade-through transition for Android / desktop
class _FadeThroughPageTransitionsBuilder extends PageTransitionsBuilder {
  const _FadeThroughPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.04),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        )),
        child: child,
      ),
    );
  }
}
