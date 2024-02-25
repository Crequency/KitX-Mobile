library kitx_moblie.config;

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

  /// Load all configurations
  Future<void> loadAsync() async {
    final prefs = await SharedPreferences.getInstance();

    webServiceUdpBroadcastAddress = prefs.getString('WebService_UdpBroadcastAddress') ?? '224.0.0.0';
    webServiceUdpPortReceive = prefs.getInt('WebService_UdpPortReceive') ?? 24040;
    webServiceUdpPortSend = prefs.getInt('WebService_UdpPortSend') ?? 23404;
    webServiceUdpSendFrequency = prefs.getInt('WebService_UdpSendFrequency') ?? 1;
    webServiceDeviceInfoCheckTTLSeconds = prefs.getInt('WebService_DeviceInfoCheckTTLSeconds') ?? 1;
    webServiceDeviceInfoTTLSeconds = prefs.getInt('WebService_DeviceInfoTTLSeconds') ?? 7;

    var langCode = prefs.getString('AppLanguageCode') ?? 'null';

    instances.appInfo.languageCode = langCode == 'null' ? null : langCode;
    instances.appInfo.themeMode = (prefs.getInt('AppThemeMode') ?? 0).toThemeMode();
    instances.appInfo.material3Enabled = prefs.getBool('material3Enabled') ?? true;
    instances.appInfo.animationEnabled.value = prefs.getBool('AnimationEnabled') ?? true;
  }

  /// Save all configurations
  Future<void> saveAsync() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('WebService_UdpBroadcastAddress', webServiceUdpBroadcastAddress);
    await prefs.setInt('WebService_UdpPortReceive', webServiceUdpPortReceive);
    await prefs.setInt('WebService_UdpPortSend', webServiceUdpPortSend);
    await prefs.setInt('WebService_UdpSendFrequency', webServiceUdpSendFrequency);
    await prefs.setInt('WebService_DeviceInfoCheckTTLSeconds', webServiceDeviceInfoCheckTTLSeconds);
    await prefs.setInt('WebService_DeviceInfoTTLSeconds', webServiceDeviceInfoTTLSeconds);

    await prefs.setString('AppLanguageCode', instances.appInfo.languageCode ?? 'null');
    await prefs.setInt('AppThemeMode', instances.appInfo.themeMode.toInt());
    await prefs.setBool('material3Enabled', instances.appInfo.material3Enabled);
    await prefs.setBool('AnimationEnabled', instances.appInfo.animationEnabled.value);
  }
}

/// Default Config
var config = Config();
