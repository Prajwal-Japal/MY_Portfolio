import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../glass_card.dart';
import '../project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static const _glowCycle = [
    AppColors.glowBlue,
    AppColors.glowCyan,
    AppColors.glowPurple,
  ];

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
              Text('PROJECTS', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 16),
              Text(
                'Things I\'ve built',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 40),
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < projects.length; i++)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: _ProjectCard(
                                project: projects[i],
                                onTap: _openLink,
                                glowColor: _glowCycle[i % _glowCycle.length],
                                index: i,
                              ),
                            ),
                          ),
                      ],
                    )
                  : Column(
                      children: [
                        for (int i = 0; i < projects.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _ProjectCard(
                              project: projects[i],
                              onTap: _openLink,
                              glowColor: _glowCycle[i % _glowCycle.length],
                              index: i,
                            ),
                          ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final void Function(String url) onTap;
  final Color glowColor;
  final int index;

  const _ProjectCard({
    required this.project,
    required this.onTap,
    required this.glowColor,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
          interactive: true,
          glowColor: glowColor,
          borderRadius: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.title,
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 12),
              Text(
                project.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.stack
                    .map(
                      (s) => Chip(
                        label: Text(s, style: const TextStyle(fontSize: 12)),
                        backgroundColor: Colors.white.withOpacity(0.08),
                        side: BorderSide(color: Colors.white.withOpacity(0.15)),
                      ),
                    )
                    .toList(),
              ),
              if (project.linkUrl != null) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => onTap(project.linkUrl!),
                  style: TextButton.styleFrom(foregroundColor: glowColor),
                  child: Text(project.linkLabel),
                ),
              ],
            ],
          ),
        )
        .animate(delay: (index * 120).ms)
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.15, end: 0);
  }
}
