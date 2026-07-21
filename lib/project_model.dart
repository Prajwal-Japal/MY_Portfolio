class Project {
  final String title;
  final String description;
  final List<String> stack;
  final String? linkUrl;
  final String linkLabel;

  const Project({
    required this.title,
    required this.description,
    required this.stack,
    this.linkUrl,
    this.linkLabel = 'View project',
  });
}

/// Your projects live here — edit this list to add/remove/reorder.
const List<Project> projects = [
  Project(
    title: 'Aditi',
    description:
        'A hospital website built to streamline patient-facing information '
        'and services, with a clean, accessible interface designed for '
        'quick navigation across departments and care options.',
    stack: ['Flutter', 'Dart'],
    linkUrl: null, // paste your live link or GitHub repo URL here
    linkLabel: 'View project',
  ),
  Project(
    title: 'WildGuard-RL',
    description:
        'A reinforcement learning environment simulating wildlife corridor '
        'protection — modeling animal movement, poacher threats, and ranger '
        'coordination in Indian national parks. Built for the Meta PyTorch '
        'OpenEnv Hackathon (Code Craft).',
    stack: ['FastAPI', 'Pydantic', 'OpenEnv', 'PyTorch'],
    linkUrl: null,
    linkLabel: 'View on GitHub',
  ),
];
