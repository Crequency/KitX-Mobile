import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_logs/flutter_logs.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:mac_address/mac_address.dart';


import '../utils/datetime_format.dart';
import '../utils/config.dart';
import '../utils/global.dart' as global;
import '../rules/device_info_struct.dart';


/// 本文件可单独运行
/// 右键 -> 运行 'webServer.dart'

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WebServer server = new WebServer(24040, 23404, "224.0.0.0");
  server.initServer();
}

class WebServer {
  String _udpBroadcastAddress;
  final int _udpPortReceive;
  final int _udpPortSend;
  late RawDatagramSocket socket;
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static final NetworkInfo _networkInfo = NetworkInfo();
  static final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;

  WebServer(this._udpPortReceive, this._udpPortSend, this._udpBroadcastAddress);

  Future<void> initServer() async {
    try {
      if (kIsWeb == false && Platform.isAndroid) {
        late String _ipv4, _ipv6, _mac, _name;
        // print(await _networkInfo.getWifiIP());
        await _networkInfo.getWifiIP().then((value) {_ipv4 = value.toString();});
        await _networkInfo.getWifiIPv6().then((value) {_ipv6 = value.toString();});
        await _flutterBlue.name.then((value) {_name = value.toString();});
        // await _networkInfo.getWifiBroadcast().then((value) {_udpBroadcastAddress = value.toString();});
        await GetMac.macAddress.then((value) {_mac = value.toString();});
        if (_mac == "null") {
          _mac = "";
        }
        FlutterLogs.logInfo("network", "WebServer", "Get network information. Ipv4: $_ipv4 Ipv6: $_ipv6 Broadcast: $_udpBroadcastAddress Mac: $_mac");
        if ((_ipv4 == "null") || (_ipv6 == "null") || (_udpBroadcastAddress == "null")) { // null.toString() =>"null"
          FlutterLogs.logError("errors", "WebServer", "Can not get network information. Ipv4: $_ipv4 Ipv6: $_ipv6 Broadcast: $_udpBroadcastAddress Mac: $_mac");
          return ;
        }
        // var _ipv6 = _networkInfo.getWifi_ipv6();
        AndroidDeviceInfo deviceData = await _deviceInfoPlugin.androidInfo;
        DeviceInfo deviceInfo = await DeviceInfo(
          deviceName: _name,
          deviceOSVersion: "${deviceData.model.toString()} (Android ${deviceData.version.release} SDK ${deviceData.version.sdkInt})",
          iPv4: _ipv4,
          iPv6: _ipv6,
          deviceMacAddress: _mac,
          pluginServerPort: 0,
          pluginsCount: 0,
          sendTime: datetimeToIso8601(DateTime.now()),
          isMainDevice: false,
          deviceServerPort: 0,
          deviceServerBuildTime: datetimeToIso8601(DateTime.now()),
          deviceOSType: Config.WebServer_DeviceOSType,
        );
        FlutterLogs.logInfo("network", "WebServer", "Get device info: ${jsonEncode(deviceInfo.toJson())}");
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortSend)
            .then((RawDatagramSocket socket) {
              socket.broadcastEnabled = true;
              socket.joinMulticast(InternetAddress(_udpBroadcastAddress));
              Timer.periodic(const Duration(seconds: 2), (_) {
                deviceInfo.sendTime = datetimeToIso8601(DateTime.now());
                deviceInfo.deviceServerBuildTime = datetimeToIso8601(DateTime.now());
                String _data = jsonEncode(deviceInfo.toJson());
                FlutterLogs.logInfo("network", "WebServer", "UDP send: $_data");
                socket.send(utf8.encode(_data), InternetAddress(_udpBroadcastAddress), _udpPortReceive);
              });
              print('UDP Echo ready to receive');
        }).catchError((e, stack) {FlutterLogs.logError("errors", "WebServer", "Catch a error: ${e.toString()} $stack");});

        await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortReceive, ttl: 2)
            .then((RawDatagramSocket socket) {
              // socket.broadcastEnabled = true;
              socket.joinMulticast(InternetAddress(_udpBroadcastAddress));
              socket.listen((RawSocketEvent event) {
                Datagram? d = socket.receive();
                if (d == null) return;
                String _data = utf8.decode(d.data);
                FlutterLogs.logInfo("network", "WebServer", "UDP receive: $_data");
                DeviceInfo _deviceInfo = DeviceInfo.fromJson(jsonDecode(_data));
                global.devices.addDevice(_deviceInfo);
              });
        }).catchError((e, stack) {FlutterLogs.logError("errors", "WebServer", "Catch a error: $e $stack");});
      }
    } catch (e, stack) {
      FlutterLogs.logError("errors", "WebServer", "Catch a error: $e On: $stack");
    }
  }
}
