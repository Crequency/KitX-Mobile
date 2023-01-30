import 'package:flutter_logs/flutter_logs.dart';

import '../config.dart';

Future<String> InitLogger() => FlutterLogs.initLogs(
  logLevelsEnabled: Config.Log_LogLevelsEnabled, // Log 等级
  timeStampFormat: Config.Log_TimeStampFormat, // 时间戳格式
  directoryStructure: Config.Log_DirectoryStructure, // 日志目录结构
  logTypesEnabled: Config.Log_LogTypesEnabled, // 日志类型
  logFileExtension: Config.Log_LogFileExtension, // 日志文件扩展名
  logsWriteDirectoryName: Config.Log_LogsWriteDirectoryName, // 日志写入目录名
  logsExportDirectoryName: Config.Log_LogsExportDirectoryName, // 日志导出目录名
  debugFileOperations: Config.Log_DebugFileOperations, // 调试文件操作
  isDebuggable: Config.Log_IsDebuggable, // 是否调试
);