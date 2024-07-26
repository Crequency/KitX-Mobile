import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';
import 'package:kitx_mobile_internal_plugins/plugins/test/settings_page.dart';

class TestPlugin extends InternalPlugin {
  static final TestPlugin _instance = TestPlugin._internal()
    ..name = "Test"
    ..author = "Crequency"
    ..version = "v0.0.1"
    ..description = "Test Plugin for KitX Mobile"
    ..executeInterval = const Duration(milliseconds: 50);

  factory TestPlugin.instance() => _instance;

  TestPlugin._internal();

  var count = 0.obs;

  var updatedTime = DateTime.now().obs;

  @override
  Widget getSettings({Function(bool)? onPluginAbilityChangedAction}) => TestSettingsPage(
        plugin: this,
        onPluginAbilityChangedAction: onPluginAbilityChangedAction,
      );

  @override
  void execute() {
    super.execute();

    count.value++;
    updatedTime.value = DateTime.now();
  }
}
