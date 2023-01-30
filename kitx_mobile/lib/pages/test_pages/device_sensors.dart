import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/test_pages/sensors_display_stands/gyroscope_display_stand.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'sensors_display_stands/vibration_display_stand.dart';

class DeviceSensorsPage extends StatefulWidget {
  @override
  _DeviceSensorsPage createState() => _DeviceSensorsPage();
}

class _DeviceSensorsPage extends State<DeviceSensorsPage> {
  final acc_x = 0.0.obs, acc_y = 0.0.obs, acc_z = 0.0.obs;

  @override
  void initState() {
    userAccelerometerEvents.listen((event) {
      print(event);

      acc_x.value = event.x;
      acc_y.value = event.y;
      acc_z.value = event.z;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: ListView(children: [
            GyroscopeDisplayStand(),
            Text("Acceleration Data", style: TextStyle(fontSize: 32)),
            Obx(
              () => Text("x: ${acc_x.value}", style: TextStyle(fontSize: 14)),
            ),
            Obx(
              () => Text("y: ${acc_y.value}", style: TextStyle(fontSize: 14)),
            ),
            Obx(
              () => Text("z: ${acc_z.value}", style: TextStyle(fontSize: 14)),
            ),
            VibrationDisplayStand(),
          ])),
    );
  }
}
