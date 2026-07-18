import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme.dart';

/// A frosted-glass panel: blurred background, translucent gradient fill,
/// a light top-edge border, and a soft outer glow. Optionally reacts to
/// mouse hover with a subtle lift + brighter glow.
class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double blurSigma;
  final Color glowColor;
  final bool interactive;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = 20,
    this.blurSigma = 18,
    this.glowColor = AppColors.glowBlue,
    this.interactive = false,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final glowOpacity = _hovering ? 0.45 : 0.22;
    final fillTop = _hovering ? 0.14 : 0.08;

    // The glow shadow must live OUTSIDE the ClipRRect/BackdropFilter,
    // otherwise the clip would cut the glow off at the card's edge.
    final card = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      transform: Matrix4.translationValues(0, _hovering ? -4 : 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: widget.glowColor.withOpacity(glowOpacity),
            blurRadius: 40,
            spreadRadius: -8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blurSigma,
            sigmaY: widget.blurSigma,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(fillTop),
                  Colors.white.withOpacity(0.03),
                ],
              ),
              border: Border.all(
                color: Colors.white.withOpacity(_hovering ? 0.35 : 0.18),
                width: 1,
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );

    if (!widget.interactive) return card;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: card,
    );
  }
}
