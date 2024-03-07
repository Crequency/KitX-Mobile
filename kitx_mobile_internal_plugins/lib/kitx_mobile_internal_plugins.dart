library kitx_mobile_internal_plugins;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile_internal_plugins/interface/internal_plugin.dart';
import 'package:kitx_mobile_internal_plugins/plugins/native_async/native_async.dart';
import 'package:kitx_mobile_internal_plugins/plugins/notification_service_provider/notification_service_provider.dart';
import 'package:kitx_mobile_internal_plugins/plugins/sensors_data_provider/sensors_data_provider.dart';

export 'package:kitx_mobile_internal_plugins/interface/interface.dart';

class InternalPluginsManager {
  static InternalPluginsManager? _instance;

  static InternalPluginsManager instance() => _instance ??= InternalPluginsManager();

  static List<InternalPlugin> get plugins => [
        NativeAsyncPlugin.instance(),
        NotificationServiceProviderPlugin.instance(),
        SensorsDataProviderPlugin.instance(),
      ];

  static int get length => plugins.length;

  static int get enabledLength => plugins.where((plugin) => plugin.isEnabled.value).length;

  List<Widget> getList({ShapeBorder? shape}) {
    return plugins
        .map(
          (plugin) => ListTile(
            title: Text(plugin.name),
            subtitle: Text(plugin.authorAndVersion),
            trailing: Obx(
              () => Switch(
                value: plugin.isEnabled.value,
                onChanged: (value) => plugin.isEnabled.value = value,
              ),
            ),
            shape: shape,
            onTap: () => Get.to(plugin.getSettings()),
          ),
        )
        .toList();
  }
}
