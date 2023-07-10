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
    var _deviceInfoPlugin = DeviceInfoPlugin();
    var _ldi = LocalDeviceInfo();

    await FlutterBluePlus.instance.name.then((value) {
      _ldi.deviceName = value.toString();
    });

    if (Platform.isAndroid) {
      var deviceData = await _deviceInfoPlugin.androidInfo;
      _ldi.deviceModel = deviceData.model.toString();
      _ldi.osVersion = deviceData.version.release;
      _ldi.sdkVersion = deviceData.version.sdkInt;
      _ldi.osDescription = '${_ldi.deviceModel} (Android ${_ldi.osVersion} SDK ${_ldi.sdkVersion})';
    } else if (Platform.isIOS) {
      var deviceData = await _deviceInfoPlugin.iosInfo;
      _ldi.deviceModel = deviceData.name.toString();
      _ldi.osVersion = deviceData.systemVersion;
      _ldi.osDescription = '${_ldi.deviceModel} (iOS ${_ldi.osVersion})';
    }

    return _ldi;
  }
}
