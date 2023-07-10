import 'package:flutter/material.dart';

/// Gradually Smaller Spacer
class GraduallySmallerSpacer extends StatelessWidget {
  /// Constructor
  const GraduallySmallerSpacer({
    required this.duration,
    this.curve = Curves.easeInOutCubicEmphasized,
    this.height,
    this.width,
    super.key,
  });

  /// Duration
  final int duration;

  /// Curve
  final Curve curve;

  /// Height
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: duration),
      curve: curve,
      width: width,
      height: height,
    );
  }
}
