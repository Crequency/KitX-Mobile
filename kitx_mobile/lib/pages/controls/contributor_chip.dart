﻿import 'package:flutter/material.dart';
import 'package:kitx_mobile/instances.dart';

/// Contributor Chip
class ContributorChip extends StatelessWidget {
  /// Constructor
  const ContributorChip({required this.name, required this.url, super.key});

  /// Name and URL
  final String name, url;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(name),
      deleteIcon: const Icon(Icons.open_in_new),
      onDeleted: () => instances.urlHandler.open(url),
      deleteButtonTooltipMessage: '',
    );
  }
}
