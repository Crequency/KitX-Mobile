import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

class DeviceSensorsPage extends StatefulWidget {
  @override
  _DeviceSensorsPage createState() => _DeviceSensorsPage();
}

class _DeviceSensorsPage extends State<DeviceSensorsPage> {
  final dir_x = 0.0.obs, dir_y = 0.0.obs, dir_z = 0.0.obs;
  final acc_x = 0.0.obs, acc_y = 0.0.obs, acc_z = 0.0.obs;
  final direction_x = "none".obs;
  final direction_y = "none".obs;
  final direction_z = "none".obs;

  @override
  void initState() {
    gyroscopeEvents.listen((event) {
      print(event);

      dir_x.value = event.x;
      dir_y.value = event.y;
      dir_z.value = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      if (dir_x >= 0)
        direction_x.value = "back";
      else
        direction_x.value = "forward";

      if (dir_y >= 0)
        direction_y.value = "right";
      else
        direction_y.value = "left";

      if (dir_z >= 0)
        direction_z.value = "👈";
      else
        direction_z.value = "👉";
    });

    userAccelerometerEvents.listen((event) {
      print(event);

      acc_x.value = event.x;
      acc_y.value = event.y;
      acc_z.value = event.z;
    });

    super.initState();
  }

  int vibrate_duration = 200;

  Future<void> vibrate() async {
    if (await Vibration.hasCustomVibrationsSupport() ?? false) {
      Vibration.vibrate(duration: vibrate_duration);
    } else if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }
  }

  void vibrate_cancel() {
    Vibration.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text("Device Sensors Info"),
      // ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: ListView(children: [
            Text("Gyroscope Data", style: TextStyle(fontSize: 32)),
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
            Text("Vibration Test", style: TextStyle(fontSize: 32)),
            TextField(
              decoration:
                  new InputDecoration(labelText: "Vibration Duration (ms)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                FilteringTextInputFormatter.digitsOnly,
              ], // Only numbers can be entered
              onChanged: (val) {
                vibrate_duration = int.parse(val);
              },
            ),
            OutlinedButton(onPressed: vibrate, child: Text("Vibrate")),
            OutlinedButton(onPressed: vibrate_cancel, child: Text("Cancel")),
          ])),
    );
  }
}
