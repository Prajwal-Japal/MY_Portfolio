import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme.dart';

/// "Water morphism" glass panel: the usual frosted blur + transparent
/// fill, but instead of a static border, a bright comet of light
/// continuously travels around the edge — like light catching the rim
/// of a water droplet or a pool's surface. The static faint border stays
/// underneath for definition when the light comet is elsewhere on the
/// edge.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blurSigma;
  final Color ambientGlowColor;
  final Color borderLightColor;
  final bool interactive;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 20,
    this.blurSigma = 12,
    this.ambientGlowColor = AppColors.glowViolet,
    this.borderLightColor = AppColors.glowViolet,
    this.interactive = false,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard>
    with SingleTickerProviderStateMixin {
  bool _hovering = false;
  late final AnimationController _lightController;

  @override
  void initState() {
    super.initState();
    // One full lap of the light comet around the border every 5s.
    // Speeds up slightly on hover for a responsive feel.
    _lightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _lightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glowOpacity = _hovering ? 0.4 : 0.18;
    final fillTop = _hovering ? 0.10 : 0.05;

    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, _hovering ? -4 : 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: widget.ambientGlowColor.withOpacity(glowOpacity),
            blurRadius: 40,
            spreadRadius: -8,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.blurSigma,
                sigmaY: widget.blurSigma,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: widget.padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(fillTop),
                      Colors.white.withOpacity(0.015),
                    ],
                  ),
                  // Faint static border for definition when the
                  // traveling light comet is on the far side.
                  border: Border.all(
                    color: Colors.white.withOpacity(_hovering ? 0.22 : 0.10),
                    width: 1,
                  ),
                ),
                child: widget.child,
              ),
            ),
          ),
          // The traveling light comet, painted on top, ignoring
          // pointer events so it never blocks taps on the content.
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _lightController,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _LiquidBorderPainter(
                      angle: _lightController.value * 2 * math.pi,
                      borderRadius: widget.borderRadius,
                      glowColor: widget.borderLightColor,
                      intensity: _hovering ? 1.0 : 0.65,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );

    if (!widget.interactive) return card;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: card,
    );
  }
}

class _LiquidBorderPainter extends CustomPainter {
  final double angle;
  final double borderRadius;
  final Color glowColor;
  final double intensity;

  _LiquidBorderPainter({
    required this.angle,
    required this.borderRadius,
    required this.glowColor,
    required this.intensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(0.8),
      Radius.circular(borderRadius),
    );

    // A short bright arc (~14% of the perimeter) that fades to
    // transparent on both sides — reads as a single comet of light
    // traveling around the edge, rather than a full rainbow ring.
    final gradient = SweepGradient(
      transform: GradientRotation(angle),
      colors: [
        Colors.transparent,
        Colors.transparent,
        glowColor.withOpacity(0.0),
        glowColor.withOpacity(0.85 * intensity),
        Colors.white.withOpacity(0.9 * intensity),
        glowColor.withOpacity(0.85 * intensity),
        glowColor.withOpacity(0.0),
        Colors.transparent,
        Colors.transparent,
      ],
      stops: const [0.0, 0.60, 0.66, 0.70, 0.73, 0.76, 0.80, 0.86, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _LiquidBorderPainter oldDelegate) =>
      oldDelegate.angle != angle || oldDelegate.intensity != intensity;
}
