import 'package:flutter/material.dart';
import 'package:kitx_mobile_internal_plugins/interface/settings_page.dart';

class TestSettingsPage extends SettingsPage {
  const TestSettingsPage({super.key, super.onPluginAbilityChangedAction, required super.plugin});

  @override
  Widget buildSettingsContent(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  ListTile(
                    title: Text('Name: ${plugin.name}'),
                    subtitle: Text('Author and version: ${plugin.authorAndVersion}'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
