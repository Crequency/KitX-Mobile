import 'package:f_logs/model/flog/flog.dart';
import 'package:f_logs/model/flog/flog_config.dart';
import 'package:f_logs/model/flog/log_level.dart';
import 'package:f_logs/utils/formatter/formate_type.dart';
import 'package:f_logs/utils/timestamp/timestamp_format.dart';

var config = LogsConfig()
  ..isDebuggable = true
  ..customOpeningDivider = "["
  ..customClosingDivider = "]"
  ..csvDelimiter = ", "
  // ..isLogEnabled = true
  ..encryptionEnabled = false
  ..encryptionKey = ""
  ..formatType = FormatType.FORMAT_CUSTOM
  ..logLevelsEnabled = [LogLevel.INFO, LogLevel.ERROR]
  ..timestampFormat = TimestampFormat.TIME_FORMAT_FULL_2;

void InitLogger() => FLog.applyConfigurations(config);

class Log {
  static void info(String message) => FLog.info(text: message);
  static void error(String message) => FLog.error(text: message);
  static void warning(String message) => FLog.warning(text: message);
}
