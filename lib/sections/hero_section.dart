import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';

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
              Text(
                'PRAJWAL V JAPAL',
                style: Theme.of(context).textTheme.labelLarge,
              ).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 20),
              Text(
                'FULL STACK APP AND WEB DEVELOPER',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isDesktop ? 56 : 34,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 20),
              SizedBox(
                width: isDesktop ? 560 : double.infinity,
                child: Text(
                  'Engineering student, founder, and vibecoder — working across '
                  'startup strategy, Flutter/Node.js development(cross-platform fra), and '
                  'AI tooling. Currently building Pingaksh and exploring '
                  'healthcare tech on the side.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ).animate().fadeIn(duration: 600.ms, delay: 150.ms),
              const SizedBox(height: 36),
              _GlowButton(
                label: 'See my work',
                onPressed: onProjectsPressed,
              ).animate().fadeIn(duration: 700.ms, delay: 300.ms),
            ],
          ),
        );
      },
    );
  }
}

/// A button with a soft glow shadow that intensifies on hover —
/// matches the glass/glow language used across the rest of the page.
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
            colors: [AppColors.glowBlue, AppColors.glowCyan],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.glowCyan.withOpacity(_hovering ? 0.5 : 0.3),
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
