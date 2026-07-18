import 'package:flutter/material.dart';
import 'theme.dart';
import 'animated_background.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pajju — Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();

  void _scrollToProjects() {
    final ctx = _projectsKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background sits fixed behind everything, filling the full
          // viewport regardless of how tall the scrollable content is.
          const Positioned.fill(child: AnimatedBackground()),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(onProjectsPressed: _scrollToProjects),
                const AboutSection(),
                Container(key: _projectsKey, child: const ProjectsSection()),
                const SkillsSection(),
                const ContactSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
