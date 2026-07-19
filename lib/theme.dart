import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Neutral dark palette: true charcoal/near-black background (no blue
/// tint), with violet / emerald / amber as the glow accent trio.
class AppColors {
  static const background = Color(0xFF0B0B0D);
  static const backgroundDeep = Color(0xFF050506);

  static const glowViolet = Color(0xFF8B5CF6);
  static const glowEmerald = Color(0xFF34D399);
  static const glowAmber = Color(0xFFF59E0B);

  static const textPrimary = Colors.white;
  static const textMuted = Color(0xFFA8A8AD);

  // Backwards-compat aliases so older code referencing these names
  // still compiles — now pointing at the neutral/violet scheme.
  static const navy = background;
  static const navyLight = Color(0xFF1A1A1E);
  static const gold = glowAmber;
  static const goldLight = glowAmber;
  static const surface = Color(0xFF141416);
  static const glowBlue = glowViolet;
  static const glowCyan = glowEmerald;
  static const glowPurple = glowViolet;
}

class AppTheme {
  static ThemeData get theme {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.glowEmerald,
        secondary: AppColors.glowViolet,
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
          color: AppColors.glowEmerald,
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
