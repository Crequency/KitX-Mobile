library kitx_moblie.config;

import 'package:flutter_logs/flutter_logs.dart';

import '../models/enums/device_os_type.dart';

class Config {
  static const String WebService_UdpBroadcastAddress = "224.0.0.0";
  static const int WebService_UdpPortReceive = 24040;
  static const int WebService_UdpPortSend = 23404;
  static const int WebService_UdpSendFrequency = 1;
  static const int WebService_DeviceInfoCheckTTLSeconds = 1;
  static const int WebService_DeviceInfoTTLSeconds = 7;
  static const DeviceOSTypeEnum WebService_DeviceOSType = DeviceOSTypeEnum.Android;
  static const List<LogLevel> Log_LogLevelsEnabled= [
    LogLevel.INFO,
    LogLevel.WARNING,
    LogLevel.ERROR,
    LogLevel.SEVERE,
  ];
  static const TimeStampFormat Log_TimeStampFormat = TimeStampFormat.TIME_FORMAT_FULL_2;
  static const DirectoryStructure Log_DirectoryStructure = DirectoryStructure.FOR_DATE;
  static const List<String> Log_LogTypesEnabled = [
    "server",
    "info",
    "errors",
    "warnings",
  ];
  static const LogFileExtension Log_LogFileExtension = LogFileExtension.LOG;
  static const String Log_LogsWriteDirectoryName = "Logs";
  static const String Log_LogsExportDirectoryName = "Logs/Exported";
  static const bool Log_DebugFileOperations = true;
  static const bool Log_IsDebuggable = true;
}
