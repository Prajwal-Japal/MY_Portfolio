import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'animation_config.dart';

/// Wraps any section so its entrance animation plays only the first
/// time it scrolls into view — not immediately on page load regardless
/// of scroll position. Makes every section feel like it's "arriving"
/// as you scroll, rather than having already finished animating before
/// you ever saw it.
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final String revealKey;

  const RevealOnScroll({
    super.key,
    required this.child,
    required this.revealKey,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.revealKey),
      onVisibilityChanged: (info) {
        if (!_visible &&
            info.visibleFraction > AnimConfig.revealVisibleThreshold) {
          setState(() => _visible = true);
        }
      },
      child: _visible
          ? widget.child
                .animate()
                .fadeIn(duration: AnimConfig.revealDuration)
                .slideY(
                  begin: AnimConfig.revealSlideOffset,
                  end: 0,
                  curve: AnimConfig.revealCurve,
                )
          : Opacity(opacity: 0, child: widget.child),
    );
  }
}
