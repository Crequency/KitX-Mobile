import 'dart:async';

import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/flog_config.dart';
import 'package:f_logs/model/flog/log_level.dart';
import 'package:f_logs/utils/formatter/formate_type.dart';
import 'package:f_logs/utils/timestamp/timestamp_format.dart';

var _config = LogsConfig()
  ..isDebuggable = true
  ..customOpeningDivider = '['
  ..customClosingDivider = ']'
  ..csvDelimiter = ', '
  ..encryptionEnabled = false
  ..encryptionKey = ''
  ..formatType = FormatType.FORMAT_CUSTOM
  ..logLevelsEnabled = [LogLevel.INFO, LogLevel.WARNING, LogLevel.ERROR]
  ..timestampFormat = TimestampFormat.TIME_FORMAT_FULL_2;

/// Initialize the logger.
void initLogger() {
  FLog.applyConfigurations(_config);

  Timer.periodic(const Duration(minutes: 10), (timer) async {
    await FLog.exportLogs();
    await FLog.clearLogs();
  });
}

/// Log
class Log {
  /// Log a message at level [LogLevel.INFO].
  static void info(String message) => FLog.info(text: message);

  /// Log a message at level [LogLevel.ERROR].
  static void error(String message) => FLog.error(text: message);

  /// Log a message at level [LogLevel.WARNING].
  static void warning(String message) => FLog.warning(text: message);
}
