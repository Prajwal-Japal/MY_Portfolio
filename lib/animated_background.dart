import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'theme.dart';

/// Full-page background: a real image with a slow automatic Ken Burns
/// drift (scale + pan) as the resting/idle state, PLUS a cursor-tracking
/// parallax shift layered on top — the image subtly leans toward
/// wherever the mouse is, like light catching real glass as you move.
///
/// The pan uses Image's own `alignment` property (built exactly for
/// panning within a BoxFit.cover crop) rather than Transform/Align,
/// which avoids layout-size mismatches that would otherwise make the
/// pan invisible.
class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _autoScale;
  late final Animation<Alignment> _autoAlignment;

  // Pointer position normalized to -1..1 across the widget, (0,0) =
  // center. Mouse events fire continuously as the cursor moves, so
  // this already updates smoothly without needing extra animation.
  Offset _pointer = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat(reverse: true);

    _autoScale = Tween<double>(
      begin: 1.05,
      end: 1.18,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _autoAlignment = AlignmentTween(
      begin: const Alignment(-0.2, -0.3),
      end: const Alignment(0.2, 0.3),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(PointerHoverEvent event, Size size) {
    final dx = ((event.localPosition.dx / size.width) - 0.5) * 2;
    final dy = ((event.localPosition.dy / size.height) - 0.5) * 2;
    setState(() {
      _pointer = Offset(dx.clamp(-1.0, 1.0), dy.clamp(-1.0, 1.0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return MouseRegion(
          onHover: (e) => _handleHover(e, size),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              // Blend the automatic drift with a small pointer-driven
              // offset. Pointer weight kept low so it reads as a
              // gentle lean, not a snap-to-cursor jump.
              const pointerWeight = 0.12;
              final blendedAlignment = Alignment(
                (_autoAlignment.value.x + _pointer.dx * pointerWeight).clamp(
                  -1.0,
                  1.0,
                ),
                (_autoAlignment.value.y + _pointer.dy * pointerWeight).clamp(
                  -1.0,
                  1.0,
                ),
              );

              return Stack(
                fit: StackFit.expand,
                children: [
                  Transform.scale(
                    scale: _autoScale.value,
                    child: Image.asset(
                      'assets/images/background.png',
                      fit: BoxFit.cover,
                      width: size.width,
                      height: size.height,
                      alignment: blendedAlignment,
                    ),
                  ),
                  // Dark overlay so text and glass borders stay
                  // readable over the brighter parts of the image.
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.backgroundDeep.withValues(alpha: 0.55),
                          AppColors.backgroundDeep.withValues(alpha: 0.75),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
