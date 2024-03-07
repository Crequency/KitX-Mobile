import 'package:flutter/material.dart';
import 'package:kitx_mobile_internal_plugins/interface/settings_page.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';
import 'package:kitx_mobile_internal_plugins/plugins/notification_service_provider/settings_page.dart';

class NotificationServiceProviderPlugin extends InternalPlugin {
  static final NotificationServiceProviderPlugin _instance = NotificationServiceProviderPlugin._internal()
    ..name = "Notification Service Provider"
    ..author = "Crequency"
    ..version = "v1.0.0"
    ..description = "Notification Service Provider Plugin for KitX Mobile";

  factory NotificationServiceProviderPlugin.instance() => _instance;

  NotificationServiceProviderPlugin._internal();

  SettingsPage get settingsPage => NotificationServiceProviderSettingsPage(plugin: this);

  @override
  Widget getSettings() => settingsPage;
}
