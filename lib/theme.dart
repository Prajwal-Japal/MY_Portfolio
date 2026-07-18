import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Glow palette for the liquid-glass look: deep space background
/// with electric blue / cyan / purple accents.
class AppColors {
  static const background = Color(0xFF0A0E1A);
  static const backgroundDeep = Color(0xFF060911);

  static const glowBlue = Color(0xFF3B82F6);
  static const glowCyan = Color(0xFF22D3EE);
  static const glowPurple = Color(0xFF8B5CF6);

  static const textPrimary = Colors.white;
  static const textMuted = Color(0xFFAAB4C5);

  // Kept for backwards-compat with earlier navy/gold references —
  // point them at the new glow colors so old code still compiles.
  static const navy = background;
  static const navyLight = Color(0xFF141B2E);
  static const gold = glowCyan;
  static const goldLight = glowBlue;
  static const surface = Color(0xFF0F1524);
}

class AppTheme {
  static ThemeData get theme {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.glowCyan,
        secondary: AppColors.glowPurple,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          fontSize: 56,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          height: 1.1,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          fontSize: 36,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 18,
          color: AppColors.textMuted,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 15,
          color: AppColors.textMuted,
          height: 1.5,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.glowCyan,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class Breakpoints {
  static bool isDesktop(BoxConstraints c) => c.maxWidth > 900;
}

class Spacing {
  static double pageHorizontal(BoxConstraints c) =>
      Breakpoints.isDesktop(c) ? 96 : 24;
  static const sectionVertical = 100.0;
}
