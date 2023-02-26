import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:mac_address/mac_address.dart';

import '../models/device_info.dart';
import '../utils/log.dart';
import '../utils/config.dart';
import '../utils/global.dart';

/// 本文件可单独运行
/// 右键 -> 运行 'WebService.dart'

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WebService server = WebService(24040, 23404, "224.0.0.0");
  server.initService();
}

class WebService {
  String _udpBroadcastAddress;
  final int _udpPortReceive;
  final int _udpPortSend;
  late RawDatagramSocket socket;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static NetworkInfo _networkInfo = NetworkInfo();
  static final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  WebService(this._udpPortReceive, this._udpPortSend, this._udpBroadcastAddress);

  /// 初始化服务
  Future<void> initService() async {
    try {
      if (kIsWeb) {
        Log.info("This is a web application, WebService will not start.");
        return;
      }
      // 获取设备信息
      late String _ipv4, _ipv6, _mac, deviceOSVersion;
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
      Log.info("Get network information. Ipv4: $_ipv4 Ipv6: $_ipv6 Mac: $_mac");
      if (_ipv4 == "null") {
        Log.error("Can not get IPv4. Try to restart the service in 5 seconds.");
        Future.delayed(const Duration(seconds: 5), () {
          initService();
        });
        return;
      }
      if (_ipv6 == "null") {
        Log.error("Can not get IPv6, but WebService will still start.");
        _ipv6 = "";
      }
      if (_mac == "null") {
        Log.error("Can not get MAC Address, but WebService will still start.");
        _mac = "";
      }
      // 分平台获取 deviceOSVersion
      if (Platform.isAndroid) {
        AndroidDeviceInfo deviceData = await _deviceInfoPlugin.androidInfo;
        deviceOSVersion =
            "${deviceData.model.toString()} (Android ${deviceData.version.release} SDK ${deviceData.version.sdkInt})";
      } else if (Platform.isIOS) {
        IosDeviceInfo deviceData = await _deviceInfoPlugin.iosInfo;
        deviceOSVersion = "${deviceData.name.toString()} (iOS ${deviceData.systemVersion})";
      } else {
        deviceOSVersion = "Unknown";
      }
      // deviceInfo 初始值
      DeviceInfoStruct deviceInfo = DeviceInfoStruct(((b) => b
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
        ..deviceOSType = Config.WebService_DeviceOSType));
      Log.info("Get device info: ${deviceInfo.toString()}");
      // 启动 UDP 服务
      // UDP 发送
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortSend).then((RawDatagramSocket socket) {
        socket.broadcastEnabled = true;
        socket.joinMulticast(InternetAddress(_udpBroadcastAddress));
        Timer.periodic(const Duration(seconds: Config.WebService_UdpSendFrequency), (timer) {
          try {
            deviceInfo = deviceInfo.rebuild((b) => b..sendTime = DateTime.now().toUtc());
            String _data = deviceInfo.toString();
            // Log.info("UDP send: $_data");
            socket.send(utf8.encode(_data), InternetAddress(_udpBroadcastAddress), _udpPortReceive);
          } catch (e, stack) {
            socket.close();
            timer.cancel();
            Log.info("UDP send error: $e $stack. Try to restart the service in 5 seconds.");
            Future.delayed(const Duration(seconds: 5), () {
              initService();
            });
          }
        });
        Log.info("UDP send service started.");
      }).catchError((e, stack) {
        Log.error("Catch an error: $e $stack");
      });

      // UDP 接收
      await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortReceive, ttl: 1)
          .then((RawDatagramSocket socket) {
        // socket.broadcastEnabled = true;
        socket.joinMulticast(InternetAddress(_udpBroadcastAddress));
        socket.listen((RawSocketEvent event) {
          Datagram? d = socket.receive();
          if (d == null) return;
          String _data = utf8.decode(d.data);
          Log.info("UDP receive: $_data");
          try {
            DeviceInfoStruct? _deviceInfo = DeviceInfoStruct.fromString(_data);
            if (_deviceInfo != null) Global.devices.addDevice(_deviceInfo);
          } catch (e, stack) {
            Log.error("Can not deserialize deviceinfopack: '$_data'. Error: $e $stack");
          }
        });
      }).catchError((e, stack) {
        Log.error("Catch an error: $e $stack");
      });
    } catch (e, stack) {
      Log.error("Catch an error: $e On: $stack");
      _networkInfo = NetworkInfo();
    }
  }
}
