import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:mac_address/mac_address.dart';

import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/utils/log.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/global.dart';

/// 本文件可单独运行
/// 右键 -> 运行 'WebService.dart'

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  var server = WebService()
    ..UdpPortSend = 23404
    ..UdpPortReceive = 24040
    ..UdpBroadcastAddress = '224.0.0.0';

  server.initService();
}

class WebService {
  var _udpPortSend = Config.WebService_UdpPortSend;
  var _udpPortReceive = Config.WebService_UdpPortReceive;
  var _udpBroadcastAddress = Config.WebService_UdpBroadcastAddress;

  late RawDatagramSocket socket;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static NetworkInfo _networkInfo = NetworkInfo();
  static final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  set UdpPortSend(int value) => _udpPortSend = value;

  set UdpPortReceive(int value) => _udpPortReceive = value;

  set UdpBroadcastAddress(String value) => _udpBroadcastAddress = value;

  // WebService(this._udpPortReceive, this._udpPortSend, this._udpBroadcastAddress);

  Future<String> GetDeviceVersionString() async {
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

  Future<List<String>?> GetNetworkInfos() async {
    late String _ipv4, _ipv6, _mac;

    await _networkInfo.getWifiIP().then((value) {
      _ipv4 = value.toString();
    });

    await _networkInfo.getWifiIPv6().then((value) {
      _ipv6 = value.toString();
    });

    await _flutterBlue.name.then((value) {
      Global.deviceName = value.toString();
    });

    // await _networkInfo.getWifiBroadcast().then((value) {_udpBroadcastAddress = value.toString();});

    await GetMac.macAddress.then((value) {
      _mac = value.toString();
    });

    Log.info('Get network information. Ipv4: $_ipv4 Ipv6: $_ipv6 Mac: $_mac');

    var logInfo = '';

    if (_ipv4 == 'null') {
      Log.error('Can not get IPv4. Try to restart the service in 5 seconds.');
      Future.delayed(const Duration(seconds: 5), () => initService());
      return null;
    }

    if (_ipv6 == 'null') {
      logInfo += 'Can not get IPv6, but WebService will still start.\n';
      _ipv6 = '';
    }

    if (_mac == 'null') {
      logInfo += 'Can not get MAC Address, but WebService will still start.\n';
      _mac = '';
    }

    if (logInfo != '') Log.warning(logInfo);

    return [_ipv4, _ipv6, _mac];
  }

  /// 初始化服务
  Future<void> initService() async {
    try {
      if (kIsWeb) {
        Log.info('This is a web application, WebService will not start.');
        return;
      }

      // 获取设备信息
      late String _ipv4, _ipv6, _mac, deviceOSVersion;

      var networkInfos = await GetNetworkInfos();

      if (networkInfos == null)
        return;
      else {
        _ipv4 = networkInfos[0];
        _ipv6 = networkInfos[1];
        _mac = networkInfos[2];
      }

      deviceOSVersion = await GetDeviceVersionString();

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
          socket.broadcastEnabled = true;
          socket.joinMulticast(InternetAddress(_udpBroadcastAddress));

          Timer.periodic(const Duration(seconds: Config.WebService_UdpSendFrequency), (timer) {
            try {
              deviceInfo = deviceInfo.rebuild((b) => b..sendTime = DateTime.now().toUtc());
              var _data = deviceInfo.toString();
              // Log.info('UDP send: $_data');
              socket.send(utf8.encode(_data), InternetAddress(_udpBroadcastAddress), _udpPortReceive);
            } catch (e, stack) {
              socket.close();
              timer.cancel();
              Log.info('UDP send error: $e $stack. Try to restart the service in 5 seconds.');
              Future.delayed(const Duration(seconds: 5), () => initService());
            }
          });
          Log.info('UDP send service started.');
        },
      ).catchError(
        (e, stack) {
          Log.error('Catch an error: $e $stack');
        },
      );

      // UDP 接收
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortReceive, ttl: 1).then(
        (socket) {
          // socket.broadcastEnabled = true;
          socket.joinMulticast(InternetAddress(_udpBroadcastAddress));
          socket.listen(
            (event) {
              var d = socket.receive();
              if (d == null) return;

              var _data = utf8.decode(d.data);
              Log.info('UDP receive: $_data');

              try {
                var _deviceInfo = DeviceInfoStruct.fromString(_data);
                if (_deviceInfo != null) Global.devices.addDevice(_deviceInfo);
              } catch (e, stack) {
                Log.error('Can not deserialize deviceinfopack: '$_data'. Error: $e $stack');
              }
            },
          );
        },
      ).catchError(
        (e, stack) {
          Log.error('Catch an error: $e $stack');
        },
      );
    } catch (e, stack) {
      Log.error('Catch an error: $e On: $stack');
      _networkInfo = NetworkInfo();
    }
  }
}
