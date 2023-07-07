import 'package:kitx_mobile/instances.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// [UrlHandler] Class
class UrlHandler {
  /// Open an url
  UrlHandler open(
    String url, {
    int delayMilliseconds = 0,
    LaunchMode mode = LaunchMode.externalApplication,
  }) {
    instances.taskHandler.delay(() => launchUrlString(url, mode: mode), delayMilliseconds);
    return this;
  }
}
