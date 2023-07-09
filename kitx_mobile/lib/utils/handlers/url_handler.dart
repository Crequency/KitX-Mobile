import 'package:kitx_mobile/utils/handlers/tasks/delayed_task.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// [UrlHandler] Class
class UrlHandler {
  /// Open an url
  UrlHandler open(
    String url, {
    int delayMilliseconds = 0,
    LaunchMode mode = LaunchMode.externalApplication,
  }) {
    (() => launchUrlString(url, mode: mode)).delay(milliseconds: delayMilliseconds).execute();
    return this;
  }
}
