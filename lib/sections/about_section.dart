import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../glass_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const _roles = ['Engineering Student', 'Founder', 'Builder'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.pageHorizontal(constraints),
            vertical: Spacing.sectionVertical,
          ),
          child: GlassCard(
            borderRadius: 24,
            ambientGlowColor: AppColors.glowEmerald,
            borderLightColor: AppColors.glowEmerald,
            padding: const EdgeInsets.all(36),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Decorative accent bar — small visual anchor that ties
                // the section together and echoes the glow palette.
                Container(
                  width: 4,
                  height: 120,
                  margin: const EdgeInsets.only(right: 28, top: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.glowEmerald, AppColors.glowViolet],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ABOUT',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'From idea to build, fast.',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 20),

                      // Quick-scan role badges — gives visual texture
                      // and a faster read than a wall of text alone.
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _roles
                            .map(
                              (r) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white.withOpacity(0.05),
                                  border: Border.all(
                                    color: AppColors.glowEmerald.withOpacity(
                                      0.35,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  r,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.glowEmerald,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),

                      const SizedBox(height: 24),
                      Text(
                        'I\'m an engineering student and founder-minded builder based in '
                        'Bengaluru, working at the intersection of product strategy and '
                        'hands-on development. Outside of coursework, I spend my time '
                        'building with Flutter, Kotlin, and Node.js, experimenting with '
                        'local AI models, and competing in hackathons. I care about '
                        'turning ideas into working products fast — and learning by '
                        'shipping rather than just studying.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
      },
    );
  }
}
