import 'package:flutter/material.dart';
import 'package:kitx_mobile_internal_plugins/interface/settings_page.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';
import 'package:kitx_mobile_internal_plugins/plugins/sensors_data_provider/settings_page.dart';

class SensorsDataProviderPlugin extends InternalPlugin {
  static final SensorsDataProviderPlugin _instance = SensorsDataProviderPlugin._internal()
    ..name = "Sensors Data Provider"
    ..author = "Crequency"
    ..version = "v1.0.0"
    ..description = "Sensors Data Provider Plugin for KitX Mobile";

  factory SensorsDataProviderPlugin.instance() => _instance;

  SensorsDataProviderPlugin._internal();

  SettingsPage get settingsPage => SensorsDataProviderSettingsPage(plugin: this);

  @override
  Widget getSettings() => settingsPage;
}
