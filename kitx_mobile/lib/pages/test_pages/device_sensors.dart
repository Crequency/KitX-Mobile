import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

// Future<void> main() async {
//   runApp(DeviceSensorsPage());
// }

class DeviceSensorsPage extends StatefulWidget {
  @override
  _DeviceSensorsPage createState() => _DeviceSensorsPage();
}

class _DeviceSensorsPage extends State<DeviceSensorsPage> {
  double x = 0, y = 0, z = 0;
  String direction = "none";

  @override
  void initState() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // print(event);

      x = event.x;
      y = event.y;
      z = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      if (x > 0) {
        direction = "back";
      } else if (x < 0) {
        direction = "forward";
      } else if (y > 0) {
        direction = "left";
      } else if (y < 0) {
        direction = "right";
      }

      setState(() {});
    });
    super.initState();
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
          child: Column(children: [
            Text(
              direction,
              style: TextStyle(fontSize: 30),
            )
          ])),
    );
  }
}
