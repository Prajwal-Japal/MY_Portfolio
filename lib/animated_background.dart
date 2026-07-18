import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'theme.dart';

/// Full-page background: a deep gradient with 3 large, soft, colored
/// glow blobs that slowly drift, giving the "liquid" ambient feel that
/// the GlassCard panels sit on top of and reflect.
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : MediaQuery.of(context).size.height;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value * 2 * math.pi;
            return Container(
              width: w,
              height: h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.backgroundDeep, AppColors.background],
                ),
              ),
              child: Stack(
                children: [
                  _blob(
                    color: AppColors.glowBlue,
                    size: 480,
                    dx: (0.15 + 0.05 * math.sin(t)) * w,
                    dy: (0.05 + 0.04 * math.cos(t)) * h,
                  ),
                  _blob(
                    color: AppColors.glowPurple,
                    size: 420,
                    dx: (0.75 + 0.04 * math.cos(t * 0.8)) * w,
                    dy: (0.25 + 0.05 * math.sin(t * 0.8)) * h,
                  ),
                  _blob(
                    color: AppColors.glowCyan,
                    size: 380,
                    dx: (0.45 + 0.05 * math.sin(t * 0.6 + 1)) * w,
                    dy: (0.65 + 0.04 * math.cos(t * 0.6 + 1)) * h,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _blob({
    required Color color,
    required double size,
    required double dx,
    required double dy,
  }) {
    return Positioned(
      left: dx - size / 2,
      top: dy - size / 2,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withOpacity(0.35), color.withOpacity(0.0)],
          ),
        ),
      ),
    );
  }
}
