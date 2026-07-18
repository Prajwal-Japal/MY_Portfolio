import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../glass_card.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

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
            glowColor: AppColors.glowCyan,
            padding: const EdgeInsets.all(36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CONTACT', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 16),
                Text(
                  'Let\'s talk',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Open to conversations about Pingaksh, collaborations, or '
                  'just talking shop about Flutter and AI tooling.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _ContactButton(
                      label: 'Email',
                      onTap: () => _openLink('mailto:your.email@example.com'),
                    ),
                    _ContactButton(
                      label: 'LinkedIn',
                      onTap: () =>
                          _openLink('https://linkedin.com/in/yourprofile'),
                    ),
                    _ContactButton(
                      label: 'GitHub',
                      onTap: () => _openLink('https://github.com/yourusername'),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                Text(
                  '© 2026 Pajju. Built with Flutter.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0);
      },
    );
  }
}

class _ContactButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _ContactButton({required this.label, required this.onTap});

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.glowCyan.withOpacity(_hovering ? 0.9 : 0.5),
          ),
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: AppColors.glowCyan.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: -4,
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Text(
                widget.label,
                style: const TextStyle(color: AppColors.glowCyan),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
