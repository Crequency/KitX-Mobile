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
  double dir_x = 0, dir_y = 0, dir_z = 0;
  double acc_x = 0, acc_y = 0, acc_z = 0;
  String direction_x = "none";
  String direction_y = "none";
  String direction_z = "none";

  @override
  void initState() {
    gyroscopeEvents.listen((event) {
      print(event);

      dir_x = event.x;
      dir_y = event.y;
      dir_z = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      if (dir_x >= 0)
        direction_x = "back";
      else
        direction_x = "forward";
      if (dir_y >= 0)
        direction_y = "right";
      else
        direction_y = "left";
      if (dir_z >= 0)
        direction_z = "👈";
      else
        direction_z = "👉";

      setState(() {});
    });

    userAccelerometerEvents.listen((event) {
      print(event);

      acc_x = event.x;
      acc_y = event.y;
      acc_z = event.z;
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
            Text("Gyroscope Data", style: TextStyle(fontSize: 32)),
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(direction_x, style: TextStyle(fontSize: 26),),
                  Text(direction_y, style: TextStyle(fontSize: 26),),
                  Text(direction_z, style: TextStyle(fontSize: 26),),
                ]),
            Text("x: $dir_x", style: TextStyle(fontSize: 14)),
            Text("y: $dir_y", style: TextStyle(fontSize: 14)),
            Text("z: $dir_z", style: TextStyle(fontSize: 14)),
            Text("Acceleration Data", style: TextStyle(fontSize: 32)),
            Text("x: $acc_x", style: TextStyle(fontSize: 14)),
            Text("y: $acc_y", style: TextStyle(fontSize: 14)),
            Text("z: $acc_z", style: TextStyle(fontSize: 14)),
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
