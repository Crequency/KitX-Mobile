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


import '../utils/config.dart';
import '../utils/global.dart' as global;
import '../rules/device_info_struct.dart';


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
            if (kIsWeb == false && Platform.isAndroid) {
                late String _ipv4, _ipv6, _mac;
                await _networkInfo.getWifiIP().then((value) {_ipv4 = value.toString();});
                await _networkInfo.getWifiIPv6().then((value) {_ipv6 = value.toString();});
                await _flutterBlue.name.then((value) {global.DeviceName = value.toString();});
                // await _networkInfo.getWifiBroadcast().then((value) {_udpBroadcastAddress = value.toString();});
                await GetMac.macAddress.then((value) {_mac = value.toString();});
                FlutterLogs.logInfo("server", "WebService", "Get network information. Ipv4: $_ipv4 Ipv6: $_ipv6 Mac: $_mac");
                if (_ipv4 == "null") {
                    FlutterLogs.logError("errors", "WebService", "Can not get IPv4. Try to restart the service in 5 seconds.");
                    Future.delayed(const Duration(seconds: 5), (){
                        initService();
                    });
                }
                if (_ipv6 == "null") {
                    FlutterLogs.logWarn("warnings", "WebService", "Can not get IPv6, but WebService will still start.");
                    _ipv6 = "";
                }
                if (_mac == "null") {
                    FlutterLogs.logWarn("warnings", "WebService", "Can not get MAC Address, but WebService will still start.");
                    _mac = "";
                }
                AndroidDeviceInfo deviceData = await _deviceInfoPlugin.androidInfo;
                DeviceInfo deviceInfo = await DeviceInfo(
                    deviceName: global.DeviceName,
                    deviceOSVersion: "${deviceData.model.toString()} (Android ${deviceData.version.release} SDK ${deviceData.version.sdkInt})",
                    iPv4: _ipv4,
                    iPv6: _ipv6,
                    deviceMacAddress: _mac,
                    pluginServerPort: 0,
                    pluginsCount: 0,
                    sendTime: DateTime.now(),
                    isMainDevice: false,
                    deviceServerPort: 0,
                    deviceServerBuildTime: DateTime.now(),
                    deviceOSType: Config.WebService_DeviceOSType,
                );
                FlutterLogs.logInfo("server", "WebService", "Get device info: ${deviceInfo.toString()}");
                await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortSend)
                        .then((RawDatagramSocket socket) {
                            socket.broadcastEnabled = true;
                            socket.joinMulticast(InternetAddress(_udpBroadcastAddress));
                            Timer.periodic(const Duration(seconds: 2), (timer) {
                                try {
                                    deviceInfo.sendTime = DateTime.now();
                                    // deviceInfo.deviceServerBuildTime = datetimeToIso8601(DateTime.now()); // Not necessary
                                    String _data = deviceInfo.toString();
                                    // FlutterLogs.logInfo("server", "WebService", "UDP send: $_data");
                                    socket.send(
                                            utf8.encode(_data), InternetAddress(_udpBroadcastAddress),
                                            _udpPortReceive);
                                }
                                catch (ex) {
                                    socket.close();
                                    timer.cancel();

                                    Future.delayed(const Duration(seconds: 5), (){
                                        initService();
                                    });
                                }
                            });
                            print('UDP Echo ready to receive');
                }).catchError((e, stack) {FlutterLogs.logError("errors", "WebService", "Catch an error: ${e.toString()} $stack");});

                await RawDatagramSocket.bind(InternetAddress.anyIPv4, _udpPortReceive, ttl: 2)
                        .then((RawDatagramSocket socket) {
                            // socket.broadcastEnabled = true;
                            socket.joinMulticast(InternetAddress(_udpBroadcastAddress));
                            socket.listen((RawSocketEvent event) {
                                Datagram? d = socket.receive();
                                if (d == null) return;
                                String _data = utf8.decode(d.data);
                                // FlutterLogs.logInfo("server", "WebService", "UDP receive: $_data");
                                DeviceInfo _deviceInfo = DeviceInfo.fromString(_data);
                                global.devices.addDevice(_deviceInfo);
                            });
                }).catchError((e, stack) {FlutterLogs.logError("errors", "WebService", "Catch an error: $e $stack");});
            }
        } catch (e, stack) {
            FlutterLogs.logError("errors", "WebService", "Catch an error: $e On: $stack");
            _networkInfo = NetworkInfo();
        }
    }
}
