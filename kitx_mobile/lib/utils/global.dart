import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kitx_mobile/app_info.dart';
import 'package:kitx_mobile/services/device_service.dart';
import 'package:kitx_mobile/services/web_service.dart';
import 'package:kitx_mobile/themes/dark_theme.dart';
import 'package:kitx_mobile/themes/light_theme.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/task_handler.dart';
import 'package:kitx_mobile/utils/url_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';

class _Global {
  static final _Global _singleton = _Global._internal();

  var channel = MethodChannel('com.crequency.kitx.mobile/channel');

  var appInfo = AppInfo();
  var packageInfo = PackageInfo.fromPlatform();

  var taskHandler = TaskHandler();
  var urlHandler = UrlHandler();

  var webService = WebService()
    ..udpPortSend = Config.WebService_UdpPortSend
    ..udpPortReceive = Config.WebService_UdpPortReceive
    ..udpBroadcastAddress = Config.WebService_UdpBroadcastAddress;

  var deviceService = DeviceService();

  Future<void> initAsync() async {
    appInfo.init();

    updateTheme(useMaterial3: appInfo.material3Enabled);

    // 初始化 WebService
    await webService.initService();

    // 初始化 DeviceService
    await deviceService.initService();
  }

  void updateTheme({bool useMaterial3 = true}) {
    appInfo.material3Enabled = useMaterial3;

    lightThemeData.value = ThemeData(
      useMaterial3: useMaterial3,
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    );
    darkThemeData.value = ThemeData(
      useMaterial3: useMaterial3,
      primarySwatch: Colors.blueGrey,
      brightness: Brightness.dark,
    );
  }

  void restartDevicesServer() {
    webService.stopService(sendExitPackage: false);
    deviceService.stopService();

    webService.initService();
  }

  void shutdownDevicesServer() {
    webService.stopService();

    taskHandler.delay(deviceService.stopService, 2000);
  }

  factory _Global() {
    return _singleton;
  }

  _Global._internal();
}

// ignore: non_constant_identifier_names, public_member_api_docs
var Global = _Global();
