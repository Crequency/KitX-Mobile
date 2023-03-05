// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:network_info_plus/network_info_plus.dart';

/// NetworkInfoTest Page
class NetworkInfoTestPage extends StatefulWidget {
  // ignore: public_member_api_docs
  const NetworkInfoTestPage({Key? key}) : super(key: key);

  @override
  _NetworkInfoTestPageState createState() => _NetworkInfoTestPageState();
}

class _NetworkInfoTestPageState extends State<NetworkInfoTestPage> {
  final _networkInfo = NetworkInfo();

  final wifi_name = ''.obs;
  final wifi_bssid = ''.obs;
  final wifi_ipv4 = ''.obs;
  final wifi_ipv6 = ''.obs;
  final wifi_broadcast = ''.obs;
  final wifi_gateway = ''.obs;
  final wifi_subnetMask = ''.obs;

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
                'Connection Status:',
                style: TextStyle(fontSize: 32),
              ),
              Text('Wifi Name: ${wifi_name.value}'),
              Text('Wifi BSSID: ${wifi_bssid.value}'),
              Text('Wifi IPv4: ${wifi_ipv4.value}'),
              Text('Wifi IPv6: ${wifi_ipv6.value}'),
              Text('Wifi Broadcast: ${wifi_broadcast.value}'),
              Text('Wifi Gateway: ${wifi_gateway.value}'),
              Text('Wifi Subnet mask: ${wifi_subnetMask.value}'),
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
    wifi_name.value = await _networkInfo.getWifiName() ?? 'null';
    wifi_bssid.value = await _networkInfo.getWifiBSSID() ?? 'null';
    wifi_ipv4.value = await _networkInfo.getWifiIP() ?? 'null';
    wifi_ipv6.value = await _networkInfo.getWifiIPv6() ?? 'null';
    wifi_subnetMask.value = await _networkInfo.getWifiSubmask() ?? 'null';
    wifi_broadcast.value = await _networkInfo.getWifiBroadcast() ?? 'null';
    wifi_gateway.value = await _networkInfo.getWifiGatewayIP() ?? 'null';
  }
}
