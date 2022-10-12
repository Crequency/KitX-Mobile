import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
// import 'package:date_format/date_format.dart';
// import 'package:get_mac/get_mac.dart';
import '../rules/DeviceInfoStruct.dart';

// 本文件可单独运行
// 右键 -> 运行'webServer.dart'

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WebServer server = new WebServer(24040, 23404);
  server.initServer();
}

class WebServer {
  late String _udpBroadcastAddress;
  final int _udpPortReceive;
  final int _udpPortSend;
  late RawDatagramSocket socket;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static final NetworkInfo _networkInfo = NetworkInfo();

  WebServer(this._udpPortReceive, this._udpPortSend);

  Future<void> initServer() async {
    try {
      if (kIsWeb == false && Platform.isAndroid) {
        late String _ipv4, _ipv6;
        // print(await _networkInfo.getWifiIP());
        await _networkInfo.getWifiIP().then((value) {_ipv4 = value.toString();});
        await _networkInfo.getWifiIPv6().then((value) {_ipv6 = value.toString();});
        await _networkInfo.getWifiBroadcast().then((value) {_udpBroadcastAddress = value.toString();});
        if (_udpBroadcastAddress.startsWith("/")) {
          _udpBroadcastAddress = _udpBroadcastAddress.substring(1);
        }
        FlutterLogs.logError("network", "WebServer", "Get network information. Ipv4: $_ipv4 Ipv6: $_ipv6 Broadcast: $_udpBroadcastAddress");
        if ((_ipv4 == "null") || (_ipv6 == "null") || (_udpBroadcastAddress == "null")) { // null.toString() =>"null"
          FlutterLogs.logError("errors", "WebServer", "Can not get network information. Ipv4: $_ipv4 Ipv6: $_ipv6 Broadcast: $_udpBroadcastAddress");
          return ;
        }
        // var _ipv6 = _networkInfo.getWifi_ipv6();
        AndroidDeviceInfo deviceData = await deviceInfoPlugin.androidInfo;
        DeviceInfo deviceInfo = await DeviceInfo(
          deviceName: deviceData.model.toString(),
          deviceOSVersion: "Android ${deviceData.version.release} SDK ${deviceData.version.sdkInt}",
          iPv4: _ipv4,
          iPv6: _ipv6,
          deviceMacAddress: "",
          servingPort: 0,
          pluginsCount: 0,
          sendTime: "",
          isMainDevice: false,
          deviceOSType: 0,
        );
        print(jsonEncode(deviceInfo.toJson()));
        print(_udpBroadcastAddress);
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortReceive)
            .then((RawDatagramSocket socket) {
          socket.broadcastEnabled = true;
          // socket.joinMulticast(InternetAddress(_udpBroadcastAddress));

          Timer.periodic(const Duration(seconds: 2), (time) {
            deviceInfo.sendTime = DateTime.now().toIso8601String()+"+08:00";
            // print(jsonEncode(deviceInfo.toJson()));
            FlutterLogs.logInfo("network", "WebServer", "Send a udp: ${jsonEncode(deviceInfo.toJson())}");
            socket.send(utf8.encode(jsonEncode(deviceInfo.toJson())), InternetAddress(_udpBroadcastAddress), _udpPortReceive);
          });
          print('UDP Echo ready to receive');
        }).catchError((e, stack) {FlutterLogs.logError("errors", "WebServer", "Catch a error: $e $stack");});
      }
    } catch(e, stack) {
      FlutterLogs.logError("errors", "WebServer", "Catch a error: $e On: $stack");
    }
  }
}
