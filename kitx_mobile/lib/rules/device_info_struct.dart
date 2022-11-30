import 'dart:convert';

import '../utils/datetime_format.dart';

/// 基于 https://jsontodart.com/ 工具更改而来


class DeviceInfo {
  late String deviceName;
  late String deviceOSVersion;
  late String iPv4;
  late String iPv6;
  late String deviceMacAddress;
  late int pluginServerPort;
  late int pluginsCount;
  late DateTime sendTime;
  late bool isMainDevice;
  late int deviceServerPort;
  late DateTime deviceServerBuildTime;
  late int deviceOSType;

  DeviceInfo(
      {required this.deviceName,
        required this.deviceOSVersion,
        required this.iPv4,
        required this.iPv6,
        required this.deviceMacAddress,
        required this.pluginServerPort,
        required this.pluginsCount,
        required this.sendTime,
        required this.isMainDevice,
        required this.deviceServerPort,
        required this.deviceServerBuildTime,
        required this.deviceOSType});

  DeviceInfo.fromString(str) {
    final Map<String, dynamic> json = jsonDecode(str);
    deviceName = json['DeviceName'];
    deviceOSVersion = json['DeviceOSVersion'];
    iPv4 = json['IPv4'];
    iPv6 = json['IPv6'];
    deviceMacAddress = json['DeviceMacAddress'];
    pluginServerPort = json['PluginServerPort'];
    pluginsCount = json['PluginsCount'];
    sendTime = DateTime.parse(json['SendTime']);
    isMainDevice = json['IsMainDevice'];
    deviceServerPort = json['DeviceServerPort'];
    deviceServerBuildTime = DateTime.parse(json['DeviceServerBuildTime']);
    deviceOSType = json['DeviceOSType'];
  }

  String toString() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeviceName'] = this.deviceName;
    data['DeviceOSVersion'] = this.deviceOSVersion;
    data['IPv4'] = this.iPv4;
    data['IPv6'] = this.iPv6;
    data['DeviceMacAddress'] = this.deviceMacAddress;
    data['PluginServerPort'] = this.pluginServerPort;
    data['PluginsCount'] = this.pluginsCount;
    data['SendTime'] = datetimeToIso8601(this.sendTime);
    data['IsMainDevice'] = this.isMainDevice;
    data['DeviceServerPort'] = this.deviceServerPort;
    data['DeviceServerBuildTime'] = datetimeToIso8601(this.deviceServerBuildTime);
    data['DeviceOSType'] = this.deviceOSType;
    return jsonEncode(data);
  }
}
