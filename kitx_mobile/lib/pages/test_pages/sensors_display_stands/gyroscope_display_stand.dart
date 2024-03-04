import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/pages/test_pages/sensors_display_stands/device_rotation_display_stand.dart';

import 'package:sensors_plus/sensors_plus.dart';

/// GyroscopeDisplayStand
class GyroscopeDisplayStand extends StatefulWidget {
  @override
  GyroscopeDisplayStandState createState() => GyroscopeDisplayStandState();
}

/// GyroscopeDisplayStandState
class GyroscopeDisplayStandState extends State<GyroscopeDisplayStand> {
  /// Gyroscope x-axis, y-axis, z-axis
  final dirX = 0.0.obs, dirY = 0.0.obs, dirZ = 0.0.obs;

  /// Gyroscope direction x, y, z
  final directionX = 'none'.obs, directionY = 'none'.obs, directionZ = 'none'.obs;

  /// Gyroscope sensor data listener
  StreamSubscription<GyroscopeEvent>? gyroscopeDataListener;

  @override
  void initState() {
    gyroscopeDataListener = gyroscopeEventStream(samplingPeriod: Duration(microseconds: 50)).listen((event) {
      dirX.value = event.x;
      dirY.value = event.y;
      dirZ.value = event.z;

      if (dirX >= 0) {
        directionX.value = 'back';
      } else {
        directionX.value = 'forward';
      }

      if (dirY >= 0) {
        directionY.value = 'right';
      } else {
        directionY.value = 'left';
      }

      if (dirZ >= 0) {
        directionZ.value = '👈';
      } else {
        directionZ.value = '👉';
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    gyroscopeDataListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gyroscope Data', style: TextStyle(fontSize: 32)),
          DeviceRotationDisplayStand(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Obx(
                () => Text(
                  directionX.value,
                  style: TextStyle(fontSize: 26),
                ),
              ),
              Obx(
                () => Text(
                  directionY.value,
                  style: TextStyle(fontSize: 26),
                ),
              ),
              Obx(
                () => Text(
                  directionZ.value,
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ],
          ),
          Obx(
            () => Text('x: ${dirX.value}', style: TextStyle(fontSize: 14)),
          ),
          Obx(
            () => Text('y: ${dirY.value}', style: TextStyle(fontSize: 14)),
          ),
          Obx(
            () => Text('z: ${dirZ.value}', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
