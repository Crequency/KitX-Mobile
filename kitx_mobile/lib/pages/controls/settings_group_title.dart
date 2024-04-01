import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Settings Group Title
class SettingsGroupTitle extends StatelessWidget {
  /// Constructor
  const SettingsGroupTitle({required this.titleKey, super.key});

  /// Title Key
  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            titleKey.tr,
            style: TextStyle(fontSize: 28),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
