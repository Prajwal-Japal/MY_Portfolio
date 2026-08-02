import 'package:flutter/material.dart';
import 'theme.dart';
import 'animation_config.dart';

/// A soft glowing orb that follows the cursor across the entire page,
/// sitting above all content but ignoring pointer events so it never
/// blocks clicks. Blends additively with the glass cards it passes over
/// for a premium, "light source in the room" feel.
class CursorGlow extends StatefulWidget {
  final Widget child;
  const CursorGlow({super.key, required this.child});

  @override
  State<CursorGlow> createState() => _CursorGlowState();
}

class _CursorGlowState extends State<CursorGlow> {
  Offset? _position;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => _position = event.position),
      onExit: (_) => setState(() => _position = null),
      child: Stack(
        children: [
          widget.child,
          if (_position != null)
            IgnorePointer(
              child: AnimatedPositioned(
                duration: AnimConfig.cursorGlowFollowDuration,
                curve: Curves.easeOut,
                left: _position!.dx - AnimConfig.cursorGlowSize / 2,
                top: _position!.dy - AnimConfig.cursorGlowSize / 2,
                child: Container(
                  width: AnimConfig.cursorGlowSize,
                  height: AnimConfig.cursorGlowSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.glowEmerald.withValues(
                          alpha: AnimConfig.cursorGlowOpacity,
                        ),
                        AppColors.glowViolet.withValues(
                          alpha: AnimConfig.cursorGlowOpacity * 0.4,
                        ),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
