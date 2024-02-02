import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/utils/handlers/permissions_handlers.dart';
import 'package:network_info_plus/network_info_plus.dart';

/// [LocalNetworkInfo] class
class LocalNetworkInfo {
  /// IPv4 address
  String? ipv4;

  /// IPv6 address
  String? ipv6;

  /// MAC address
  String? mac;

  /// Get an instance for [LocalNetworkInfo] class
  static Future<LocalNetworkInfo> get() async {
    var getBackupDeviceIdStringForAndroid = () async {
      var _deviceInfoPlugin = DeviceInfoPlugin();

      var androidInfo = await _deviceInfoPlugin.androidInfo;
      var fingerPrint = androidInfo.fingerprint;
      var display = androidInfo.display;

      var deviceId = '$fingerPrint || $display';

      var bytes = utf8.encode(deviceId);
      var hexString = bytes.sublist(0, 5).map((b) => b.toRadixString(16).padLeft(2, '0')).join(':');

      return 'FO:${hexString.toUpperCase()}';
    };

    var getBackupDeviceIdStringForIos = (String key) async {
      var bytes = utf8.encode(key);
      var hexString = bytes.sublist(0, 5).map((b) => b.toRadixString(16).padLeft(2, '0')).join(':');

      return 'FO:${hexString.toUpperCase()}';
    };

    var _networkInfo = NetworkInfo();
    var _deviceInfoPlugin = DeviceInfoPlugin();

    late String? _ipv4, _ipv6, _mac;

    await requestNetworkRelatedPermissions();

    _ipv4 = await _networkInfo.getWifiIP();
    _ipv6 = await _networkInfo.getWifiIPv6();

    var defaultMac = '00:20:00:00:00:00';
    try {
      if (Platform.isAndroid) {
        var _actualMac = '${await instances.channel.invokeMethod('getMAC') ?? ''}';
        _mac = _actualMac == '' ? await getBackupDeviceIdStringForAndroid() : _actualMac;
      } else if (Platform.isIOS) {
        var _actualMac = (await _deviceInfoPlugin.iosInfo).identifierForVendor ?? '';
        _mac = _actualMac == '' ? defaultMac : await getBackupDeviceIdStringForIos(_actualMac);
      } else {
        _mac = defaultMac;
      }
    } catch (e) {
      _mac = defaultMac;
    }

    return LocalNetworkInfo()
      ..ipv4 = _ipv4
      ..ipv6 = _ipv6
      ..mac = _mac;
  }
}
