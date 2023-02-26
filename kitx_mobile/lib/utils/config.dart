library kitx_moblie.config;

import '../models/enums/device_os_type.dart';

class Config {
  static const String WebService_UdpBroadcastAddress = "224.0.0.0";
  static const int WebService_UdpPortReceive = 24040;
  static const int WebService_UdpPortSend = 23404;
  static const int WebService_UdpSendFrequency = 1;
  static const int WebService_DeviceInfoCheckTTLSeconds = 1;
  static const int WebService_DeviceInfoTTLSeconds = 7;
  static const DeviceOSTypeEnum WebService_DeviceOSType = DeviceOSTypeEnum.Android;
}
