import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
// import 'package:intl/intl.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:date_format/date_format.dart';
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
  late final String _udpBroadcastAddress;
  final int _udpPortReceive;
  final int _udpPortSend;
  late RawDatagramSocket socket;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static final NetworkInfo _networkInfo = NetworkInfo();

  WebServer(this._udpPortReceive, this._udpPortSend);

  Future<void> initServer() async {
    try {
      if (kIsWeb == false && Platform.isAndroid) {
        var ipv4, ipv6;
        // print(await _networkInfo.getWifiIP());
        _networkInfo.getWifiIP().then((value) {ipv4 = value.toString();});
        _networkInfo.getWifiIPv6().then((value) {ipv6 = value.toString();});
        _networkInfo.getWifiBroadcast().then((value) {_udpBroadcastAddress = value.toString();});
        // var ipv6 = _networkInfo.getWifiIPv6();
        AndroidDeviceInfo deviceData = await deviceInfoPlugin.androidInfo;
        DeviceInfo deviceInfo = await DeviceInfo(
          deviceName: deviceData.model.toString(),
          deviceOSVersion: "Android ${deviceData.version.release} SDK ${deviceData.version.sdkInt}",
          iPv4: ipv4,
          iPv6: ipv6,
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
            print(deviceInfo.toJson().toString());
            socket.send(utf8.encode(jsonEncode(deviceInfo.toJson())), InternetAddress(_udpBroadcastAddress), _udpPortReceive);
          });
          print('UDP Echo ready to receive');
        }).catchError((e, stack) {print(e);print(stack);});
      }
    } catch(e, stack) {
      print(e);
      print(stack);
    }
  }
}
