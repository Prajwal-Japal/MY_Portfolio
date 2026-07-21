import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../glass_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const skillGroups = {
    'Mobile & Frontend': ['Flutter', 'Dart', 'Node.js'],
    'Backend': ['Node.js', 'dart', 'Supabase'],
    'Data & AI': [
      'Supabase',
      'Firebase',
      'MongoDB',
      'Local LLMs (Ollama, LM Studio)',
    ],
  };

  static const _glowCycle = [
    AppColors.glowBlue,
    AppColors.glowCyan,
    AppColors.glowPurple,
  ];

  @override
  Widget build(BuildContext context) {
    final entries = skillGroups.entries.toList();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: Spacing.pageHorizontal(constraints),
            vertical: Spacing.sectionVertical,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SKILLS', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 16),
              Text(
                'Tools I build with',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 32),
              for (int i = 0; i < entries.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child:
                      GlassCard(
                            borderRadius: 16,
                            glowColor: _glowCycle[i % _glowCycle.length],
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entries[i].key,
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color:
                                            _glowCycle[i % _glowCycle.length],
                                      ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: entries[i].value
                                      .map(
                                        (s) => Chip(
                                          label: Text(s),
                                          backgroundColor: Colors.white
                                              .withOpacity(0.08),
                                          side: BorderSide(
                                            color: Colors.white.withOpacity(
                                              0.15,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          )
                          .animate(delay: (i * 120).ms)
                          .fadeIn(duration: 500.ms)
                          .slideY(begin: 0.1, end: 0),
                ),
            ],
          ),
        );
      },
    );
  }
}
