import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// [LocalDeviceInfo] class
class LocalDeviceInfo {
  /// Device name
  String? deviceName;

  /// Device model
  String? deviceModel;

  /// OS version
  String? osVersion;

  /// OS description
  String? osDescription;

  /// SDK version (only on android)
  int? sdkVersion;

  /// Get an instance for [LocalDeviceInfo] class
  static Future<LocalDeviceInfo> get() async {
    var deviceInfoPlugin = DeviceInfoPlugin();
    var ldi = LocalDeviceInfo();

    ldi.deviceName = await FlutterBluePlus.adapterName;

    if (Platform.isAndroid) {
      var deviceData = await deviceInfoPlugin.androidInfo;
      ldi.deviceModel = deviceData.model.toString();
      ldi.osVersion = deviceData.version.release;
      ldi.sdkVersion = deviceData.version.sdkInt;
      ldi.osDescription = '${ldi.deviceModel} (Android ${ldi.osVersion} SDK ${ldi.sdkVersion})';
    } else if (Platform.isIOS) {
      var deviceData = await deviceInfoPlugin.iosInfo;
      ldi.deviceModel = deviceData.name.toString();
      ldi.osVersion = deviceData.systemVersion;
      ldi.osDescription = '${ldi.deviceModel} (iOS ${ldi.osVersion})';
    }

    return ldi;
  }
}
