import 'package:flutter/material.dart';

/// Group items
Widget group(
  Widget header,
  Widget content,
  Widget divider, {
  Widget? spacer = const SizedBox(height: 30),
}) =>
    Column(
      children: [
        header,
        spacer ?? SizedBox(),
        content,
        divider,
      ],
    );
