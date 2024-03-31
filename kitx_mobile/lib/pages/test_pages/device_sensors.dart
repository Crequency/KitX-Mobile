import 'package:flutter/material.dart';
import 'package:kitx_mobile/pages/pages.dart';

import 'package:kitx_mobile/pages/test_pages/sensors_display_stands/acceleration_display_stand.dart';
import 'package:kitx_mobile/pages/test_pages/sensors_display_stands/gyroscope_display_stand.dart';
import 'package:kitx_mobile/pages/test_pages/sensors_display_stands/vibration_display_stand.dart';

/// DeviceSensors Page
class DeviceSensorsPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/test/device_sensors';

  /// Get Page
  static Widget Function() getPage() => () => const DeviceSensorsPage();

  /// Constructor
  const DeviceSensorsPage({Key? key}) : super(key: key);

  @override
  _DeviceSensorsPage createState() => _DeviceSensorsPage();
}

class _DeviceSensorsPage extends State<DeviceSensorsPage> {
  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            GyroscopeDisplayStand(),
            AccelerationDisplayStand(),
            VibrationDisplayStand(),
            Container(
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
