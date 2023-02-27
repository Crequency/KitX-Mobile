import 'dart:async';

import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:flutter/material.dart';

class NetworkInfoTestPage extends StatefulWidget {
  const NetworkInfoTestPage({Key? key}) : super(key: key);

  @override
  _NetworkInfoTestPageState createState() => _NetworkInfoTestPageState();
}

class _NetworkInfoTestPageState extends State<NetworkInfoTestPage> {
  final _networkInfo = NetworkInfo();

  final name = "".obs;
  final bssid = "".obs;
  final ipv4 = "".obs;
  final ipv6 = "".obs;
  final broadcast = "".obs;
  final gateway = "".obs;
  final subnetMask = "".obs;

  @override
  void initState() {
    super.initState();
    _initNetworkInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Obx(
          () => ListView(
            children: [
              Text(
                "Connection Status:",
                style: TextStyle(fontSize: 32),
              ),
              Text("Wifi Name: ${name.value}"),
              Text("Wifi BSSID: ${bssid.value}"),
              Text("Wifi IPv4: ${ipv4.value}"),
              Text("Wifi IPv6: ${ipv6.value}"),
              Text("Wifi Broadcast: ${broadcast.value}"),
              Text("Wifi Gateway: ${gateway.value}"),
              Text("Wifi Subnet mask: ${subnetMask.value}"),
              Container(
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initNetworkInfo() async {
    name.value = await _networkInfo.getWifiName() ?? "null";
    bssid.value = await _networkInfo.getWifiBSSID() ?? "null";
    ipv4.value = await _networkInfo.getWifiIP() ?? "null";
    ipv6.value = await _networkInfo.getWifiIPv6() ?? "null";
    subnetMask.value = await _networkInfo.getWifiSubmask() ?? "null";
    broadcast.value = await _networkInfo.getWifiBroadcast() ?? "null";
    gateway.value = await _networkInfo.getWifiGatewayIP() ?? "null";
  }
}
