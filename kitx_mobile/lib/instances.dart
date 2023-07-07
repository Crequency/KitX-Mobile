import 'package:flutter/services.dart';
import 'package:kitx_mobile/app_info.dart';
import 'package:kitx_mobile/services/devices_discovery_service.dart';
import 'package:kitx_mobile/services/devices_service.dart';
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

  /// Instance for [DevicesDiscoveryService] class
  var devicesDiscoveryService = DevicesDiscoveryService()
    ..udpPortSend = config.webServiceUdpPortSend
    ..udpPortReceive = config.webServiceUdpPortReceive
    ..udpBroadcastAddress = config.webServiceUdpBroadcastAddress;

  /// Instance for [DeviceService] class
  var devicesService = DeviceService();

  /// Init [Instances] class
  Future<void> initAsync() async {
    appInfo = (await appInfo.init()).updateTheme(useMaterial3: appInfo.material3Enabled);

    // Init WebService
    await devicesDiscoveryService.init();

    // Init DeviceService
    await devicesService.init();
  }

  /// Restart [devicesService] and [devicesDiscoveryService]
  void restartDevicesServer() {
    devicesDiscoveryService.stop(sendExitPackage: false);
    devicesService.stop();

    devicesDiscoveryService.init();
  }

  /// Shutdown [devicesService] and [devicesDiscoveryService]
  void shutdownDevicesServer() {
    devicesDiscoveryService.stop();

    taskHandler.delay(devicesService.stop, 2000);
  }
}

/// Instance of [Instances] class
var instances = Instances();
