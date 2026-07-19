import 'package:flutter/material.dart';
import 'theme.dart';

/// Full-page background using a real image instead of procedural
/// gradients/blobs. A slow, continuous scale + position drift (a
/// "Ken Burns" effect) keeps it feeling alive without being distracting,
/// and gives the glass panels genuine texture and color to reveal as
/// you scroll.
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<Alignment> _alignment;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 1.05,
      end: 1.18,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _alignment = AlignmentTween(
      begin: const Alignment(-0.2, -0.3),
      end: const Alignment(0.2, 0.3),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              scale: _scale.value,
              alignment: _alignment.value,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            // Dark overlay so text and glass borders stay readable
            // over the brighter parts of the image.
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.backgroundDeep.withOpacity(0.55),
                    AppColors.backgroundDeep.withOpacity(0.75),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
