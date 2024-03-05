import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// AccelerationDisplayStand
class AccelerationDisplayStand extends StatefulWidget {
  @override
  AccelerationDisplayStandState createState() => AccelerationDisplayStandState();
}

/// AccelerationDisplayStandState
class AccelerationDisplayStandState extends State<AccelerationDisplayStand> {
  /// Acceleration x-axis, y-axis, z-axis
  final accX = 0.0.obs, accY = 0.0.obs, accZ = 0.0.obs;

  /// User accelerometer sensor data listener
  StreamSubscription<UserAccelerometerEvent>? userAccelerometerDataListener;

  @override
  void initState() {
    userAccelerometerDataListener = userAccelerometerEventStream(samplingPeriod: Duration(milliseconds: 50)).listen((event) {
      accX.value = event.x;
      accY.value = event.y;
      accZ.value = event.z;
    });
    super.initState();
  }

  @override
  void dispose() {
    userAccelerometerDataListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Acceleration Data', style: TextStyle(fontSize: 32)),
          Obx(
            () => Text('x: ${accX.value}', style: TextStyle(fontSize: 14)),
          ),
          Obx(
            () => Text('y: ${accY.value}', style: TextStyle(fontSize: 14)),
          ),
          Obx(
            () => Text('z: ${accZ.value}', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
