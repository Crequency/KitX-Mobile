import 'package:flutter/material.dart';
import 'package:kitx_mobile_internal_plugins/interface/settings_page.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';
import 'package:kitx_mobile_internal_plugins/plugins/native_async/settings_page.dart';

class NativeAsyncPlugin extends InternalPlugin {
  static final NativeAsyncPlugin _instance = NativeAsyncPlugin._internal()
    ..name = "Native Async"
    ..author = "Crequency"
    ..version = "v1.0.0"
    ..description = "Native Async Plugin for KitX Mobile";

  factory NativeAsyncPlugin.instance() => _instance;

  NativeAsyncPlugin._internal();

  SettingsPage get settingsPage => NativeAsyncSettingsPage(plugin: this);

  @override
  Widget getSettings() => settingsPage;
}
