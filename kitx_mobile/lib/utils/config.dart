library kitx_moblie.config;

import 'package:cherrilog/cherrilog.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/utils/extensions/int_ext.dart';
import 'package:kitx_mobile/utils/extensions/theme_mode_ext.dart';
import 'package:kitx_shared_dart/kitx_shared_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [Config] class
class Config {
  /// WebService udp broadcast address
  var webServiceUdpBroadcastAddress = '224.0.0.0';

  /// WebService udp port for receiving
  var webServiceUdpPortReceive = 24040;

  /// WebService udp port for sending
  var webServiceUdpPortSend = 23404;

  /// WebService udp send seconds per package
  var webServiceUdpSendFrequency = 1;

  /// WebService device info check timer
  var webServiceDeviceInfoCheckTTLSeconds = 1;

  /// WebService device info TTL seconds
  var webServiceDeviceInfoTTLSeconds = 7;

  /// WebService local device os type
  var webServiceDeviceOSType = OperatingSystems.android;

  /// Delay open page in home page
  var delayOpenPageInHomePage = false.obs;

  /// Load all configurations
  Future<void> loadAsync() async {
    final prefs = await SharedPreferences.getInstance();

    {
      webServiceUdpBroadcastAddress = prefs.getString('WebService_UdpBroadcastAddress') ?? '224.0.0.0';
      webServiceUdpPortReceive = prefs.getInt('WebService_UdpPortReceive') ?? 24040;
      webServiceUdpPortSend = prefs.getInt('WebService_UdpPortSend') ?? 23404;
      webServiceUdpSendFrequency = prefs.getInt('WebService_UdpSendFrequency') ?? 1;
      webServiceDeviceInfoCheckTTLSeconds = prefs.getInt('WebService_DeviceInfoCheckTTLSeconds') ?? 1;
      webServiceDeviceInfoTTLSeconds = prefs.getInt('WebService_DeviceInfoTTLSeconds') ?? 7;
    }

    {
      var langCode = prefs.getString('AppLanguageCode') ?? 'null';

      instances.appInfo.languageCode = langCode == 'null' ? null : langCode;
      instances.appInfo.themeMode = (prefs.getInt('AppThemeMode') ?? 0).toThemeMode();
      instances.appInfo.material3Enabled = prefs.getBool('material3Enabled') ?? true;
      instances.appInfo.animationEnabled.value = prefs.getBool('AnimationEnabled') ?? true;
    }

    {
      delayOpenPageInHomePage.value = prefs.getBool('delayOpenPageInHomePage') ?? false;
    }

    {
      var levelRangeString = prefs.getString('logLevelRange') ?? (kDebugMode ? 'fatal,debug' : 'fatal,warning');
      var levelRangeStringSplit = levelRangeString.split(',');
      var levelRange = (
        CherriLogLevel.order
                .where(
                  (e) => e.name.toLowerCase() == levelRangeStringSplit[0].toLowerCase(),
                )
                .firstOrNull ??
            CherriLogLevel.fatal,
        CherriLogLevel.order
                .where(
                  (e) => e.name.toLowerCase() == levelRangeStringSplit[1].toLowerCase(),
                )
                .firstOrNull ??
            CherriLogLevel.warning,
      );

      CherriLog.instance = CherriLog.instance!
        ..withOptions(CherriLog.instance!.options..logLevelRange = levelRange)
        ..logTo(CherriLog.instance!.logger);
    }
  }

  /// Save all configurations
  Future<void> saveAsync() async {
    final prefs = await SharedPreferences.getInstance();

    {
      await prefs.setString('WebService_UdpBroadcastAddress', webServiceUdpBroadcastAddress);
      await prefs.setInt('WebService_UdpPortReceive', webServiceUdpPortReceive);
      await prefs.setInt('WebService_UdpPortSend', webServiceUdpPortSend);
      await prefs.setInt('WebService_UdpSendFrequency', webServiceUdpSendFrequency);
      await prefs.setInt('WebService_DeviceInfoCheckTTLSeconds', webServiceDeviceInfoCheckTTLSeconds);
      await prefs.setInt('WebService_DeviceInfoTTLSeconds', webServiceDeviceInfoTTLSeconds);
    }

    {
      await prefs.setString('AppLanguageCode', instances.appInfo.languageCode ?? 'null');
      await prefs.setInt('AppThemeMode', instances.appInfo.themeMode.toInt());
      await prefs.setBool('material3Enabled', instances.appInfo.material3Enabled);
      await prefs.setBool('AnimationEnabled', instances.appInfo.animationEnabled.value);
    }

    {
      await prefs.setBool('delayOpenPageInHomePage', delayOpenPageInHomePage.value);
    }

    {
      await prefs.setString(
        'logLevelRange',
        '${CherriLog.instance!.options.logLevelRange.$1.name},${CherriLog.instance!.options.logLevelRange.$2.name}',
      );
    }
  }
}

/// Default Config
var config = Config();
