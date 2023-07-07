import 'package:flutter/services.dart';
import 'package:kitx_mobile/app_info.dart';
import 'package:kitx_mobile/services/device_service.dart';
import 'package:kitx_mobile/services/web_service.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/handlers/task_handler.dart';
import 'package:kitx_mobile/utils/handlers/url_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// [Instances] class
class Instances {
  static final Instances _singleton = Instances._internal();

  /// Factory function for [Instances] class
  factory Instances() {
    return _singleton;
  }

  Instances._internal();

  /// Instance for [MethodChannel] class
  var channel = MethodChannel('com.crequency.kitx.mobile/channel');

  /// Instance for [AppInfo] class
  var appInfo = AppInfo();

  /// Instance for [PackageInfo] class
  var packageInfo = PackageInfo.fromPlatform();

  /// Instance for [TaskHandler] class
  var taskHandler = TaskHandler();

  /// Instance for [UrlHandler] class
  var urlHandler = UrlHandler();

  /// Instance for [WebService] class
  var webService = WebService()
    ..udpPortSend = config.webServiceUdpPortSend
    ..udpPortReceive = config.webServiceUdpPortReceive
    ..udpBroadcastAddress = config.webServiceUdpBroadcastAddress;

  /// Instance for [DeviceService] class
  var deviceService = DeviceService();

  /// Init [Instances] class
  Future<void> initAsync() async {
    appInfo = (await appInfo.init()).updateTheme(useMaterial3: appInfo.material3Enabled);

    // Init WebService
    await webService.init();

    // Init DeviceService
    await deviceService.init();
  }

  /// Restart [deviceService] and [webService]
  void restartDevicesServer() {
    webService.stop(sendExitPackage: false);
    deviceService.stop();

    webService.init();
  }

  /// Shutdown [deviceService] and [webService]
  void shutdownDevicesServer() {
    webService.stop();

    taskHandler.delay(deviceService.stop, 2000);
  }
}

/// Instance of [Instances] class
var instances = Instances();
