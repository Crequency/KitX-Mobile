class DeviceInfo {
  late String deviceName;
  late String deviceOSVersion;
  late String iPv4;
  late String iPv6;
  late String deviceMacAddress;
  late int servingPort;
  late int pluginsCount;
  late String sendTime;
  late bool isMainDevice=false;
  late String serverAddress;
  late String serverBuildTime;
  late int deviceOSType;

  DeviceInfo(
      {required this.deviceName,
        required this.deviceOSVersion,
        required this.iPv4,
        required this.iPv6,
        required this.deviceMacAddress,
        required this.servingPort,
        required this.pluginsCount,
        required this.sendTime,
        required this.isMainDevice,
        required this.serverAddress,
        required this.serverBuildTime,
        required this.deviceOSType});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceName = json['DeviceName'];
    deviceOSVersion = json['DeviceOSVersion'];
    iPv4 = json['IPv4'];
    iPv6 = json['IPv6'];
    deviceMacAddress = json['DeviceMacAddress'];
    servingPort = json['ServingPort'];
    pluginsCount = json['PluginsCount'];
    sendTime = json['SendTime'];
    isMainDevice = json['IsMainDevice'];
    serverAddress = json['ServerAddress'];
    serverBuildTime = json['ServerBuildTime'];
    deviceOSType = json['DeviceOSType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeviceName'] = this.deviceName;
    data['DeviceOSVersion'] = this.deviceOSVersion;
    data['IPv4'] = this.iPv4;
    data['IPv6'] = this.iPv6;
    data['DeviceMacAddress'] = this.deviceMacAddress;
    data['ServingPort'] = this.servingPort;
    data['PluginsCount'] = this.pluginsCount;
    data['SendTime'] = this.sendTime;
    data['IsMainDevice'] = this.isMainDevice;
    data['ServerAddress'] = this.serverAddress;
    data['ServerBuildTime'] = this.serverBuildTime;
    data['DeviceOSType'] = this.deviceOSType;
    return data;
  }
}
