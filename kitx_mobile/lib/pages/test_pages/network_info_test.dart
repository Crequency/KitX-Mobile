import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';

/// NetworkInfoTest Page
class NetworkInfoTestPage extends StatefulWidget {
  /// Constructor
  const NetworkInfoTestPage({Key? key}) : super(key: key);

  @override
  _NetworkInfoTestPageState createState() => _NetworkInfoTestPageState();
}

class _NetworkInfoTestPageState extends State<NetworkInfoTestPage> {
  final _networkInfo = NetworkInfo();

  final wifiName = ''.obs;
  final wifiBssid = ''.obs;
  final wifiIPv4 = ''.obs;
  final wifiIPv6 = ''.obs;
  final wifiBroadcast = ''.obs;
  final wifiGateway = ''.obs;
  final wifiSubnetMask = ''.obs;

  static const linePadding = 20.0;

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
              Text('Connection Status', style: TextStyle(fontSize: 32)),
              const SizedBox(height: linePadding * 2),
              Text('Wifi Name: ${wifiName.value}'),
              const SizedBox(height: linePadding),
              Text('Wifi BSSID: ${wifiBssid.value}'),
              const SizedBox(height: linePadding),
              Text('Wifi IPv4: ${wifiIPv4.value}'),
              const SizedBox(height: linePadding),
              Text('Wifi IPv6: ${wifiIPv6.value}'),
              const SizedBox(height: linePadding),
              Text('Wifi Broadcast: ${wifiBroadcast.value}'),
              const SizedBox(height: linePadding),
              Text('Wifi Gateway: ${wifiGateway.value}'),
              const SizedBox(height: linePadding),
              Text('Wifi Subnet mask: ${wifiSubnetMask.value}'),
              const SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _initNetworkInfo() async {
    wifiName.value = await _networkInfo.getWifiName() ?? 'null';
    wifiBssid.value = await _networkInfo.getWifiBSSID() ?? 'null';
    wifiIPv4.value = await _networkInfo.getWifiIP() ?? 'null';
    wifiIPv6.value = await _networkInfo.getWifiIPv6() ?? 'null';
    wifiSubnetMask.value = await _networkInfo.getWifiSubmask() ?? 'null';
    wifiBroadcast.value = await _networkInfo.getWifiBroadcast() ?? 'null';
    wifiGateway.value = await _networkInfo.getWifiGatewayIP() ?? 'null';
  }
}
