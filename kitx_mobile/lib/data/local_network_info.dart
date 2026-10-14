import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
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
    await requestNetworkRelatedPermissions();

    Future<String> getBackupDeviceIdStringForAndroid() async {
      var deviceInfoPlugin = DeviceInfoPlugin();

      var androidInfo = await deviceInfoPlugin.androidInfo;
      var fingerPrint = androidInfo.fingerprint;
      var display = androidInfo.display;
      // device_info_plus 12 起移除了 AndroidDeviceInfo.serialNumber（受 Google Play 政策限制），
      // 这里改用 Build.ID 作为等价的设备标识来源。
      var buildId = androidInfo.id;

      var deviceId = '$buildId || $fingerPrint || $display';

      var bytes = md5.convert(utf8.encode(deviceId)).bytes;
      var hexString = bytes.sublist(0, 5).map((b) => b.toRadixString(16).padLeft(2, '0')).join(':');

      return 'FO:${hexString.toUpperCase()}';
    }

    Future<String> getBackupDeviceIdStringForIos(String key) async {
      var bytes = utf8.encode(key);
      var hexString = bytes.sublist(0, 5).map((b) => b.toRadixString(16).padLeft(2, '0')).join(':');

      return 'FO:${hexString.toUpperCase()}';
    }

    var networkInfo = NetworkInfo();
    var deviceInfoPlugin = DeviceInfoPlugin();

    late String? ipv4, ipv6, mac;

    ipv4 = await networkInfo.getWifiIP();
    ipv6 = await networkInfo.getWifiIPv6();

    var defaultMac = '00:20:00:00:00:00';
    try {
      if (Platform.isAndroid) {
        var actualMac = '${await instances.channel.invokeMethod('getMAC') ?? ''}';
        mac = actualMac == '' ? await getBackupDeviceIdStringForAndroid() : actualMac;
      } else if (Platform.isIOS) {
        var actualMac = (await deviceInfoPlugin.iosInfo).identifierForVendor ?? '';
        mac = actualMac == '' ? defaultMac : await getBackupDeviceIdStringForIos(actualMac);
      } else {
        mac = defaultMac;
      }
    } catch (e) {
      mac = defaultMac;
    }

    return LocalNetworkInfo()
      ..ipv4 = ipv4
      ..ipv6 = ipv6
      ..mac = mac;
  }
}
