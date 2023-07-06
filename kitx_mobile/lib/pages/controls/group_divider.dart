import 'package:flutter/material.dart';
import 'package:kitx_mobile/pages/controls/gradually_smaller_spacer.dart';

/// Group Divider
class GroupDivider extends GraduallySmallerSpacer {
  /// Constructor
  const GroupDivider({required super.duration, super.curve, super.height, super.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Divider(),
        GraduallySmallerSpacer(duration: duration, curve: curve, height: height, width: width),
        const SizedBox(height: 60),
      ],
    );
  }
}
