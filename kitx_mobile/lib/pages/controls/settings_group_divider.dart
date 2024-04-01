import 'package:flutter/material.dart';

/// Settings Group Divider
class SettingsGroupDivider extends StatelessWidget {
  /// Constructor
  const SettingsGroupDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Divider(),
      ],
    );
  }
}
