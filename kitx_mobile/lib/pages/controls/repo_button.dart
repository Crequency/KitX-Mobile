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
    return ElevatedButton(onPressed: () => instances.urlHandler.open(url), child: Text(name));
  }
}
