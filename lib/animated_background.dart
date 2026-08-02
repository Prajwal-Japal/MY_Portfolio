import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'theme.dart';
import 'animation_config.dart';

/// Full-page background: your image, desaturated and darkened so it
/// reads as a true black theme (not just "dark purple"), with a slow
/// automatic Ken Burns drift plus a cursor-tracking parallax lean.
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

  Offset _pointer = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AnimConfig.backgroundDriftDuration,
    )..repeat(reverse: true);

    _autoScale = Tween<double>(
      begin: AnimConfig.backgroundScaleMin,
      end: AnimConfig.backgroundScaleMax,
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
              final pointerWeight = AnimConfig.pointerParallaxWeight;
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
                    child: ColorFiltered(
                      // Desaturate + darken the source image so the
                      // whole page reads as black/charcoal rather than
                      // "dark purple." Values below 1.0 on the diagonal
                      // pull down brightness; the matrix pulls color
                      // channels toward gray before that.
                      colorFilter: const ColorFilter.matrix(<double>[
                        0.55,
                        0.25,
                        0.20,
                        0,
                        -20,
                        0.20,
                        0.55,
                        0.25,
                        0,
                        -20,
                        0.20,
                        0.25,
                        0.55,
                        0,
                        -20,
                        0,
                        0,
                        0,
                        1,
                        0,
                      ]),
                      child: Image.asset(
                        'assets/images/background.png',
                        fit: BoxFit.cover,
                        width: size.width,
                        height: size.height,
                        alignment: blendedAlignment,
                      ),
                    ),
                  ),
                  // Heavier dark overlay than before — this is the main
                  // lever for "black theme, not purple theme."
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.backgroundDeep.withValues(alpha: 0.72),
                          AppColors.backgroundDeep.withValues(alpha: 0.88),
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
