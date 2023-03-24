﻿// ignore_for_file: non_constant_identifier_names, public_member_api_docs

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
  final acc_x = 0.0.obs, acc_y = 0.0.obs, acc_z = 0.0.obs;

  StreamSubscription<UserAccelerometerEvent>? userAccelerometerDataListener;

  @override
  void initState() {
    userAccelerometerDataListener = userAccelerometerEvents.listen((event) {
      acc_x.value = event.x;
      acc_y.value = event.y;
      acc_z.value = event.z;
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
            () => Text('x: ${acc_x.value}', style: TextStyle(fontSize: 14)),
          ),
          Obx(
            () => Text('y: ${acc_y.value}', style: TextStyle(fontSize: 14)),
          ),
          Obx(
            () => Text('z: ${acc_z.value}', style: TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
