import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile_internal_plugins/interface/settings_page.dart';
import 'package:kitx_mobile_internal_plugins/plugins/test/test.dart';

class TestSettingsPage extends SettingsPage {
  const TestSettingsPage(
      {super.key, super.onPluginAbilityChangedAction, required super.plugin});

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
                    subtitle:
                        Text('Author and version: ${plugin.authorAndVersion}'),
                  ),
                  ListTile(
                    title: Obx(
                      () =>
                          Text('Count: ${(plugin as TestPlugin).count.value}'),
                    ),
                    subtitle: Obx(
                      () => Text(
                          'Updated time: ${(plugin as TestPlugin).updatedTime.value.toIso8601String()}'),
                    ),
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
