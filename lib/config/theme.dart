import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpeedEcoColors {
  static const Color primary = Color(0xFF00C853);
  static const Color primaryDark = Color(0xFF009624);
  static const Color primaryLight = Color(0xFF5EFC82);
  static const Color secondary = Color(0xFF00B8D4);
  static const Color secondaryDark = Color(0xFF0088A3);
  static const Color accent = Color(0xFFFFD600);
  static const Color background = Color(0xFF0A1628);
  static const Color surface = Color(0xFF132240);
  static const Color surfaceLight = Color(0xFF1C3158);
  static const Color card = Color(0xFF162B4D);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textMuted = Color(0xFF78909C);
  static const Color success = Color(0xFF00E676);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFFF5252);
  static const Color divider = Color(0xFF263B5E);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [background, Color(0xFF0D1F3C)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [surface, card],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class SpeedEcoTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: SpeedEcoColors.primary,
        secondary: SpeedEcoColors.secondary,
        surface: SpeedEcoColors.surface,
        error: SpeedEcoColors.error,
      ),
      scaffoldBackgroundColor: SpeedEcoColors.background,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: SpeedEcoColors.textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: SpeedEcoColors.textPrimary,
          letterSpacing: -0.3,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: SpeedEcoColors.textPrimary,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: SpeedEcoColors.textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: SpeedEcoColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: SpeedEcoColors.textSecondary,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: SpeedEcoColors.textSecondary,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: SpeedEcoColors.textMuted,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: SpeedEcoColors.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: SpeedEcoColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: SpeedEcoColors.textPrimary,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SpeedEcoColors.surface,
        selectedItemColor: SpeedEcoColors.primary,
        unselectedItemColor: SpeedEcoColors.textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SpeedEcoColors.primary,
          foregroundColor: SpeedEcoColors.background,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SpeedEcoColors.primary,
          side: const BorderSide(color: SpeedEcoColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
