import 'package:flutter/material.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';
import 'package:kitx_mobile_internal_plugins/plugins/test/settings_page.dart';

class TestPlugin extends InternalPlugin {
  static final TestPlugin _instance = TestPlugin._internal()
    ..name = "Test"
    ..author = "Crequency"
    ..version = "v0.0.1"
    ..description = "Test Plugin for KitX Mobile";

  factory TestPlugin.instance() => _instance;

  TestPlugin._internal();

  @override
  Widget getSettings({Function(bool)? onPluginAbilityChangedAction}) => TestSettingsPage(
        plugin: this,
        onPluginAbilityChangedAction: onPluginAbilityChangedAction,
      );
}
