import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../animation_config.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onProjectsPressed;
  const HeroSection({super.key, required this.onProjectsPressed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = Breakpoints.isDesktop(constraints);
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.pageHorizontal(constraints),
            vertical: Spacing.sectionVertical,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Small role/eyebrow tag above the name — kept minimal so
              // the name below is clearly the visual anchor.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.glowEmerald.withOpacity(0.4),
                  ),
                ),
                child: Text(
                  'FULL STACK APP & WEB DEVELOPER',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: 28),

              // The name is now the largest, most dominant element on
              // the page — with a continuous shimmer sweep so it feels
              // alive rather than static.
              Text(
                    'Prajwal V Japal',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: isDesktop ? 96 : 48,
                      height: 1.0,
                      letterSpacing: -1.5,
                    ),
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .shimmer(
                    delay: AnimConfig.shimmerDelay,
                    duration: AnimConfig.shimmerDuration,
                    color: AppColors.glowEmerald.withOpacity(
                      AnimConfig.shimmerOpacity,
                    ),
                  )
                  .animate() // separate, one-shot entrance animation
                  .fadeIn(duration: AnimConfig.heroFadeDuration)
                  .slideY(begin: AnimConfig.heroSlideOffset, end: 0),

              const SizedBox(height: 24),

              SizedBox(
                width: isDesktop ? 620 : double.infinity,
                child: Text(
                  'Engineering student, founder-minded builder, and vibecoder — '
                  'working across startup strategy, cross-platform development '
                  'with Flutter and Node.js, and AI tooling. Currently building '
                  'Pingaksh and exploring healthcare tech on the side.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 200.ms),

              const SizedBox(height: 40),

              _GlowButton(
                label: 'See my work',
                onPressed: onProjectsPressed,
              ).animate().fadeIn(duration: 700.ms, delay: 350.ms),
            ],
          ),
        );
      },
    );
  }
}

/// A button with a soft glow shadow that intensifies on hover.
class _GlowButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  const _GlowButton({required this.label, required this.onPressed});

  @override
  State<_GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<_GlowButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_hovering ? 1.03 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [AppColors.glowViolet, AppColors.glowEmerald],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.glowEmerald.withOpacity(_hovering ? 0.5 : 0.3),
              blurRadius: _hovering ? 28 : 18,
              spreadRadius: -4,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
              child: Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
