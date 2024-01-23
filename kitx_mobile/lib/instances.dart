import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:kitx_mobile/data/app_info.dart';
import 'package:kitx_mobile/data/local_device_info.dart';
import 'package:kitx_mobile/data/local_network_info.dart';
import 'package:kitx_mobile/services/devices_discovery_service.dart';
import 'package:kitx_mobile/services/devices_service.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/handlers/tasks/delayed_task.dart';
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

  /// Instance for [LocalDeviceInfo] class
  var deviceInfo = LocalDeviceInfo();

  /// Instance for [LocalNetworkInfo] class
  var networkInfo = LocalNetworkInfo();

  /// Instance for [PackageInfo] class
  var packageInfo = PackageInfo.fromPlatform();

  /// Instance for [UrlHandler] class
  var urlHandler = UrlHandler();

  /// Instance for [Connectivity] class
  var connectivity = Connectivity();

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
    deviceInfo = await LocalDeviceInfo.get();
    networkInfo = await LocalNetworkInfo.get();

    connectivity.onConnectivityChanged.listen(
      (result) async => {
        instances.deviceInfo = await LocalDeviceInfo.get(),
        instances.networkInfo = await LocalNetworkInfo.get(),
        restartDevicesServer(),
      },
    );

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
    devicesService.init();
  }

  /// Shutdown [devicesService] and [devicesDiscoveryService]
  void shutdownDevicesServer() {
    devicesDiscoveryService.stop();

    devicesService.stop.delay(milliseconds: 2000).execute();
  }
}

/// Instance of [Instances] class
var instances = Instances();
