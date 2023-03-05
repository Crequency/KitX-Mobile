import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/pages/test_pages/device_info_test.dart';
import 'package:kitx_mobile/pages/test_pages/device_sensors.dart';
import 'package:kitx_mobile/pages/test_pages/network_info_test.dart';

/// Test Page
class TestPage extends StatefulWidget {
  // ignore: public_member_api_docs
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text('TestPage_Title'.tr),
            pinned: true,
            snap: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            bottom: TabBar(
              controller: _tabController,
              tabs: <Tab>[
                Tab(
                  text: 'Device Info',
                  icon: Icon(Icons.devices),
                ),
                Tab(
                  text: 'Device Sensors',
                  icon: Icon(Icons.sensors),
                ),
                Tab(
                  text: 'Network Info',
                  icon: Icon(Icons.wifi),
                ),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            DeviceInfoTestPage(),
            DeviceSensorsPage(),
            NetworkInfoTestPage(),
          ],
        ),
      ),
    );
  }
}
