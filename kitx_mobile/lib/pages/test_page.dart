import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/test_pages/device_info_test.dart';
import 'package:kitx_mobile/pages/test_pages/device_sensors.dart';
import 'package:kitx_mobile/pages/test_pages/network_info_test.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// [TestPage] Class
class TestPage extends StatefulWidget {
  /// Constructor for [TestPage]
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
            actions: [
              PopupMenuButton(
                tooltip: '',
                padding: EdgeInsets.all(0),
                icon: const Icon(Icons.handyman),
                position: PopupMenuPosition.under,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text('Enable awaker'),
                    onTap: () => WakelockPlus.enable(),
                  ),
                  PopupMenuItem(
                    child: const Text('Disable awaker'),
                    onTap: () => WakelockPlus.disable(),
                  ),
                ],
              ),
              const SizedBox(width: 10),
            ],
            pinned: true,
            snap: true,
            floating: true,
            forceElevated: innerBoxIsScrolled,
            bottom: TabBar(
              controller: _tabController,
              tabs: <Tab>[
                Tab(text: 'Device Info', icon: Icon(Icons.devices)),
                Tab(text: 'Device Sensors', icon: Icon(Icons.sensors)),
                Tab(text: 'Network Info', icon: Icon(Icons.wifi)),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [DeviceInfoTestPage(), DeviceSensorsPage(), NetworkInfoTestPage()],
        ),
      ),
    );
  }
}
