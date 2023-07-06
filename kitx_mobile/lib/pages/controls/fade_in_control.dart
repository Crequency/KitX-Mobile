import 'package:flutter/material.dart';

/// Fade In Control
class FadeInControl extends StatelessWidget {
  /// Constructor
  const FadeInControl({
    required this.opacity,
    this.duration = 300,
    this.child = const SizedBox(),
    this.curve = Curves.easeInCubic,
    super.key,
  });

  /// Duration
  final int duration;

  /// Opacity Target
  final double opacity;

  /// Child Widget
  final Widget child;

  /// Curve
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: duration),
      opacity: opacity,
      curve: Curves.easeInCubic,
      child: child,
    );
  }
}
