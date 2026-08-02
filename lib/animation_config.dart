import 'package:flutter/material.dart';

/// Single source of truth for every animation's timing, intensity, and
/// feel across the whole portfolio. Change a value here and it applies
/// everywhere that animation is used — no need to hunt through
/// individual section files.
class AnimConfig {
  // ---- Scroll-triggered section reveals (RevealOnScroll) ----
  static const Duration revealDuration = Duration(milliseconds: 500);
  static const Curve revealCurve = Curves.easeOut;
  static const double revealSlideOffset = 0.12; // fraction of height
  static const double revealVisibleThreshold = 0.15; // 0.0–1.0

  // ---- Hero name shimmer ----
  static const Duration shimmerDelay = Duration(milliseconds: 800);
  static const Duration shimmerDuration = Duration(milliseconds: 2200);
  static const double shimmerOpacity = 0.7;

  // ---- Hero entrance ----
  static const Duration heroFadeDuration = Duration(milliseconds: 600);
  static const double heroSlideOffset = 0.15;

  // ---- GlassCard: traveling light border ----
  static const Duration borderLightLap = Duration(seconds: 5);
  static const double borderLightIntensityIdle = 0.65;
  static const double borderLightIntensityHover = 1.0;

  // ---- GlassCard: hover lift ----
  static const Duration cardHoverDuration = Duration(milliseconds: 220);
  static const double cardHoverLiftPx = 4;

  // ---- AnimatedBackground: automatic Ken Burns drift ----
  static const Duration backgroundDriftDuration = Duration(seconds: 16);
  static const double backgroundScaleMin = 1.05;
  static const double backgroundScaleMax = 1.12;

  // ---- AnimatedBackground: cursor parallax ----
  static const double pointerParallaxWeight = 0.08;

  // ---- CursorGlow ----
  static const Duration cursorGlowFollowDuration = Duration(milliseconds: 120);
  static const double cursorGlowSize = 360;
  static const double cursorGlowOpacity = 0.10;
}
