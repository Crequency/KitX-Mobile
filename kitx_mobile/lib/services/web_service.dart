import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/services/public/service_status.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/global.dart';
import 'package:kitx_mobile/utils/log.dart';
import 'package:kitx_mobile/utils/permissions_helper.dart';
import 'package:network_info_plus/network_info_plus.dart';

/// 本文件可单独运行
/// 右键 -> 运行 'WebService.dart'

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var server = WebService()
    ..udpPortSend = 23404
    ..udpPortReceive = 24040
    ..udpBroadcastAddress = '224.0.0.0';

  server.initService();
}

/// WebService
class WebService {
  var _udpPortSend = Config.WebService_UdpPortSend;
  var _udpPortReceive = Config.WebService_UdpPortReceive;
  var _udpBroadcastAddress = Config.WebService_UdpBroadcastAddress;

  var _sendExitPackage = false;

  /// Web Service Status
  var webServiceStatus = ServiceStatus.pending.obs;

  /// Web Service Error Message
  String? webServiceErrorMessage;

  /// Socket Object
  late RawDatagramSocket socket;

  static DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static NetworkInfo _networkInfo = NetworkInfo();
  static FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  /// Set UdpPortSend
  set udpPortSend(int value) => _udpPortSend = value;

  /// Set UdpPortReceive
  set udpPortReceive(int value) => _udpPortReceive = value;

  /// Set UdpBroadcastAddress
  set udpBroadcastAddress(String value) => _udpBroadcastAddress = value;

  /// Get Device Version String
  Future<String> getDeviceVersionString() async {
    if (Platform.isAndroid) {
      var deviceData = await _deviceInfoPlugin.androidInfo;
      var deviceName = deviceData.model.toString();
      var systemVersion = deviceData.version.release;
      var sdkVersion = deviceData.version.sdkInt;
      return '$deviceName (Android $systemVersion SDK $sdkVersion)';
    } else if (Platform.isIOS) {
      var deviceData = await _deviceInfoPlugin.iosInfo;
      var deviceName = deviceData.name.toString();
      var systemVersion = deviceData.systemVersion;
      return '$deviceName (iOS $systemVersion)';
    } else {
      return 'Unknown';
    }
  }

  /// Get Backup Device ID String
  Future<String> getBackupDeviceIdString() async {
    var androidInfo = await _deviceInfoPlugin.androidInfo;
    var fingerPrint = androidInfo.fingerprint;
    var display = androidInfo.display;

    var deviceId = '$fingerPrint || $display';

    var bytes = utf8.encode(deviceId);
    var hexString = bytes.sublist(0, 5).map((b) => b.toRadixString(16).padLeft(2, '0')).join(':');

    return 'FO:${hexString.toUpperCase()}';
  }

  /// Get Network Information
  Future<List<String>?> getNetworkInfo() async {
    late String? _ipv4, _ipv6, _mac;

    await requestNetworkRelatedPermissions();

    _ipv4 = await _networkInfo.getWifiIP();
    _ipv6 = await _networkInfo.getWifiIPv6();

    var defaultMac = '00:20:00:00:00:00';
    try {
      if (Platform.isAndroid) {
        var _actualMac = '${await Global.channel.invokeMethod('getMAC') ?? ''}';
        _mac = _actualMac == '' ? await getBackupDeviceIdString() : _actualMac;
      } else if (Platform.isIOS) {
        var _actualMac = (await _deviceInfoPlugin.iosInfo).identifierForVendor ?? '';
        _mac = _actualMac == '' ? defaultMac : _actualMac;
      } else {
        _mac = defaultMac;
      }
    } catch (e) {
      _mac = defaultMac;
    }

    await _flutterBlue.name.then((value) {
      Global.deviceName = value.toString();
    });

    Log.info('Get network information: IPv4: $_ipv4, IPv6: $_ipv6, MAC: $_mac');

    var logInfo = '';

    if (_ipv4 == null) {
      Log.error('Can not get IPv4. Try to restart the service in 5 seconds.');
      Future.delayed(const Duration(seconds: 5), () => initService());
      return null;
    }

    if (_ipv6 == null) {
      logInfo += 'Can not get IPv6, but WebService will still start.\n';
      _ipv6 = '';
    }

    if (logInfo != '') Log.warning(logInfo);

    return [_ipv4, _ipv6, _mac];
  }

  /// 停止服务
  Future<void> stopService({bool sendExitPackage = true}) async {
    void stopAction() {
      sendTimer?.cancel();
      sendTimer = null;

      receiveSocket?.close();

      sendSocket?.close();

      receiveSocket = null;
      sendSocket = null;

      webServiceStatus.value = ServiceStatus.pending;
    }

    Global.deviceService.deviceServiceStatus = ServiceStatus.pending;
    Global.deviceService.deviceInfoList.clear();

    webServiceStatus.value = ServiceStatus.stopping;

    if (sendExitPackage) {
      _sendExitPackage = true;

      Global.delay(stopAction, 1500);
    } else {
      stopAction();
    }
  }

  /// 发送及接收定时器的指针
  late Timer? sendTimer;

  /// 发送及接收套接字的指针
  late RawDatagramSocket? sendSocket, receiveSocket;

  /// 初始化服务
  Future<void> initService() async {
    webServiceStatus.value = ServiceStatus.starting;

    _sendExitPackage = false;

    Global.deviceService.deviceServiceStatus = ServiceStatus.running;

    try {
      if (kIsWeb) {
        Log.info('This is a web application, WebService will not start.');
        return;
      }

      // 获取设备信息
      late String _ipv4, _ipv6, _mac, deviceOSVersion;

      var networkInfo = await getNetworkInfo();

      if (networkInfo == null) {
        return;
      } else {
        _ipv4 = networkInfo[0];
        _ipv6 = networkInfo[1];
        _mac = networkInfo[2];
      }

      deviceOSVersion = await getDeviceVersionString();

      // deviceInfo 初始值
      var deviceInfo = DeviceInfoStruct(
        ((b) => b
          ..deviceName = Global.deviceName
          ..deviceOSVersion = deviceOSVersion
          ..iPv4 = _ipv4
          ..iPv6 = _ipv6
          ..deviceMacAddress = _mac
          ..pluginServerPort = 0
          ..pluginsCount = 0
          ..sendTime = DateTime.now().toUtc()
          ..isMainDevice = false
          ..deviceServerPort = 0
          ..deviceServerBuildTime = DateTime.now().toUtc()
          ..deviceOSType = Config.WebService_DeviceOSType),
      );

      Log.info('Get device info: ${deviceInfo.toString()}');

      // 启动 UDP 服务

      // UDP 发送
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortSend).then(
        (socket) {
          sendSocket = socket;

          socket.broadcastEnabled = true;
          socket.joinMulticast(InternetAddress(_udpBroadcastAddress));

          Timer.periodic(Duration(seconds: Config.WebService_UdpSendFrequency), (timer) {
            sendTimer = timer;

            try {
              deviceInfo = deviceInfo.rebuild((b) => b..sendTime = DateTime.now().toUtc());

              if (_sendExitPackage) {
                deviceInfo = deviceInfo.rebuild(
                  (b) => b..sendTime = DateTime.now().add(Duration(seconds: -20)).toUtc(),
                );
              }

              var _data = deviceInfo.toString();
              // Log.info('UDP send: $_data');
              socket.send(utf8.encode(_data), InternetAddress(_udpBroadcastAddress), _udpPortReceive);
            } catch (e, stack) {
              timer.cancel();
              socket.close();
              Log.info('UDP send error: $e $stack. Try to restart the service in 5 seconds.');
              Future.delayed(const Duration(seconds: 5), () => initService());
            }
          });
          Log.info('UDP send service started.');
        },
      ).catchError(
        (e, stack) {
          Log.error('Catch an error: $e $stack');
          webServiceStatus.value = ServiceStatus.error;
        },
      );

      // UDP 接收
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortReceive, ttl: 1).then(
        (socket) {
          receiveSocket = socket;

          // socket.broadcastEnabled = true;
          socket.joinMulticast(InternetAddress(_udpBroadcastAddress));

          socket.listen(
            (event) async {
              var d = socket.receive();
              if (d == null) return;

              var _data = utf8.decode(d.data);
              Log.info('UDP receive: $_data');

              try {
                var _deviceInfo = DeviceInfoStruct.fromString(_data);
                if (_deviceInfo != null) await Global.deviceService.addDevice(_deviceInfo);
              } catch (e, stack) {
                Log.error('Can not deserialize device info pack: `$_data`. Error: $e $stack');
              }
            },
          );
        },
      ).catchError(
        (e, stack) {
          Log.error('Catch an error: $e $stack');
          webServiceStatus.value = ServiceStatus.error;
        },
      );

      Global.delay(() => webServiceStatus.value = ServiceStatus.running, 500);
    } catch (e, stack) {
      Log.error('Catch an error: $e On: $stack');
      webServiceStatus.value = ServiceStatus.error;
      webServiceErrorMessage = e.toString();
      _networkInfo = NetworkInfo();
    }
  }
}
