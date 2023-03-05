import 'package:flutter/material.dart';

import 'package:kitx_mobile/pages/test_pages/sensors_display_stands/acceleration_display_stand.dart';
import 'package:kitx_mobile/pages/test_pages/sensors_display_stands/gyroscope_display_stand.dart';
import 'package:kitx_mobile/pages/test_pages/sensors_display_stands/vibration_display_stand.dart';

/// DeviceSensors Page
class DeviceSensorsPage extends StatefulWidget {
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
