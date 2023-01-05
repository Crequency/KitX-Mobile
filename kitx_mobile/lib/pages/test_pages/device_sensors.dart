import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vibration/vibration.dart';

// import 'package:model_viewer/model_viewer.dart';
// import 'package:flutter_cube/flutter_cube.dart';

class DeviceSensorsPage extends StatefulWidget {
  @override
  _DeviceSensorsPage createState() => _DeviceSensorsPage();
}

class _DeviceSensorsPage extends State<DeviceSensorsPage> {
  double x = 0, y = 0, z = 0;
  String direction_x = "none";
  String direction_y = "none";
  String direction_z = "none";

  @override
  void initState() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);

      x = event.x;
      y = event.y;
      z = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      if (x >= 0)
        direction_x = "back";
      else
        direction_x = "forward";
      if (y >= 0)
        direction_y = "right";
      else
        direction_y = "left";
      if (z >= 0)
        direction_z = "👈";
      else
        direction_z = "👉";

      setState(() {});
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Device Sensors Info"),
      ),
      body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: ListView(children: [
            Text("Gyroscope Data", style: TextStyle(fontSize: 42)),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    direction_x,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    direction_y,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    direction_z,
                    style: TextStyle(fontSize: 30),
                  ),
                ]),
            Text("x: $x", style: TextStyle(fontSize: 14)),
            Text("y: $y", style: TextStyle(fontSize: 14)),
            Text("z: $z", style: TextStyle(fontSize: 14)),
            // Cube(
            //   onSceneCreated: (Scene scene) {
            //     scene.world.add(Object(fileName: 'assets/cube/KitX-Icon-1.obj'));
            //   },
            // ),
            Text("Vibration Test", style: TextStyle(fontSize: 42)),
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
