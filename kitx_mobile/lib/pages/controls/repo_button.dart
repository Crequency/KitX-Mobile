import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:kitx_mobile/instances.dart';

/// Repo Button
class RepoButton extends StatelessWidget {
  /// Constructor
  const RepoButton({required this.name, required this.url, super.key});

  /// Display Name and URL
  final String name, url;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => instances.urlHandler.open(url),
      label: Text(name),
      icon: name == 'GitHub' ? const Icon(CommunityMaterialIcons.github) : const Icon(CommunityMaterialIcons.git),
    );
  }
}
