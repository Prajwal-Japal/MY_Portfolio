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
    title: 'Pingaksh',
    description:
        'On-demand guard and bouncer booking platform focused on personal '
        'safety in India. Co-founded and built out the product architecture: '
        'a receptionist-operated dashboard, QR-based booking flow, and an '
        'AI voice assistant for inbound calls.',
    stack: ['Flutter', 'Node.js', 'Supabase', 'AI Voice'],
    linkUrl: null,
    linkLabel: 'Read more',
  ),
  Project(
    title: 'Exoplanet Detection Pipeline',
    description:
        'Built for the Bharatiya Antariksh Hackathon 2026 (ISRO + Hack2skill). '
        'An AI-powered pipeline for detecting exoplanets from light-curve '
        'data, using Lightkurve for signal processing and Streamlit for '
        'the interactive interface.',
    stack: ['Python', 'Lightkurve', 'Streamlit', 'Colab'],
    linkUrl: null,
    linkLabel: 'View on GitHub',
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
