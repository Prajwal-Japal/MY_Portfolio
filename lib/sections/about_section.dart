import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../glass_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            glowColor: AppColors.glowPurple,
            padding: const EdgeInsets.all(36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ABOUT', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 16),
                Text(
                  'From idea to build, fast.',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'I\'m an engineering student and co-founder of Pingaksh, based in '
                  'Bengaluru. Alongside the founding team, I work on strategy, '
                  'operations, and pitching — while staying hands-on with the '
                  'product itself. Outside of that, I build with Flutter, Kotlin, '
                  'and Node.js, experiment with local AI models, and take on '
                  'hackathons whenever I can.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
      },
    );
  }
}
