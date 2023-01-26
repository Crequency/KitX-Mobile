import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'test_pages/device_info_test.dart';
import 'test_pages/device_sensors.dart';
import 'test_pages/network_info_test.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("TestPage_Title".tr),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: "Device Info",
                icon: Icon(Icons.devices),
              ),
              Tab(
                text: "Device Sensors",
                icon: Icon(Icons.sensors),
              ),
              Tab(
                text: "Network Info",
                icon: Icon(Icons.wifi),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(
              child: DeviceInfoTestPage(),
            ),
            Center(
              child: DeviceSensorsPage(),
            ),
            Center(
              child: NetworkInfoTestPage(),
            ),
          ],
        ),
      ),
    );
  }
}
