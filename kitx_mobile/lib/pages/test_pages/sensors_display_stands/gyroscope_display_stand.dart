import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'device_rotation_display_stand.dart';

class GyroscopeDisplayStand extends StatefulWidget{
  @override
  GyroscopeDisplayStandState createState() => GyroscopeDisplayStandState();
}

class GyroscopeDisplayStandState extends State<GyroscopeDisplayStand>{
  final dir_x = 0.0.obs, dir_y = 0.0.obs, dir_z = 0.0.obs;
  final direction_x = "none".obs, direction_y = "none".obs, direction_z = "none".obs;

  @override
  void initState(){
    gyroscopeEvents.listen((event) {
      print(event);

      dir_x.value = event.x;
      dir_y.value = event.y;
      dir_z.value = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orientation
      if (dir_x >= 0) direction_x.value = "back";
      else direction_x.value = "forward";

      if (dir_y >= 0) direction_y.value = "right";
      else direction_y.value = "left";

      if (dir_z >= 0) direction_z.value = "👈";
      else direction_z.value = "👉";
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gyroscope Data", style: TextStyle(fontSize: 32)),
        DeviceRotationDisplayStand(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(() => Text(
              direction_x.value,
              style: TextStyle(fontSize: 26),
            )),
            Obx(() => Text(
              direction_y.value,
              style: TextStyle(fontSize: 26),
            )),
            Obx(() => Text(
              direction_z.value,
              style: TextStyle(fontSize: 26),
            )),
          ]),
        Obx(
          () => Text("x: ${dir_x.value}", style: TextStyle(fontSize: 14)),
        ),
        Obx(
          () => Text("y: ${dir_y.value}", style: TextStyle(fontSize: 14)),
        ),
        Obx(
          () => Text("z: ${dir_z.value}", style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}