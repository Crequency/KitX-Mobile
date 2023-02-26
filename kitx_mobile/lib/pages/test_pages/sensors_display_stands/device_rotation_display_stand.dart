import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

import 'package:kitx_mobile/utils/acceleration_emulator.dart';
import 'package:kitx_mobile/utils/rotation_emulator.dart';

class DeviceRotationDisplayStand extends StatefulWidget {
  @override
  DeviceRotationDisplayStandState createState() => DeviceRotationDisplayStandState();
}

class DeviceRotationDisplayStandState extends State<DeviceRotationDisplayStand> {
  static double canvas_width = 400;
  static double canvas_height = 300;
  static bool firstEnterPage = true;

  @override
  void initState() {
    if (firstEnterPage) {
      gyroscopeEvents.listen((event) {
        DeviceRotationHost.RotateWithAcceleration(event.x, event.y, event.z, 0.2);
      });
      firstEnterPage = false;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    canvas_width = size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
            child: CustomPaint(
              isComplex: true,
              size: new Size(canvas_width - 60, canvas_height),
              willChange: true,
              painter: Painter(),
            ),
            onTap: () => DeviceRotationHost.Restore(),
          ),
        )
      ],
    );
  }
}

class Painter extends CustomPainter {
  var object_width = 135, object_height = 240;

  var Camera = Point(0, 0, 800);

  double abs(double num) => num >= 0 ? num : -num;

  //  yaw - pitch - roll
  Doubles3D GetRotationAngles() => DeviceRotationHost.GetRotationAngles();

  Point? GetLeftBarPoint() => GetCrossPoint(
      Rotate(Point(-object_width / 2 + object_width / 4, -object_height / 2 + object_height / 24, 0),
          GetRotationAngles()),
      Camera,
      null,
      null);
  Point? GetRightBarPoint() => GetCrossPoint(
      Rotate(Point(object_width / 2 - object_width / 4, -object_height / 2 + object_height / 24, 0),
          GetRotationAngles()),
      Camera,
      null,
      null);

  Point? GetLeftTopPoint() => GetCrossPoint(
      Rotate(Point(-object_width / 2, object_height / 2, 0), GetRotationAngles()), Camera, null, null);
  Point? GetRightTopPoint() => GetCrossPoint(
      Rotate(Point(object_width / 2, object_height / 2, 0), GetRotationAngles()), Camera, null, null);
  Point? GetRightBottomPoint() => GetCrossPoint(
      Rotate(Point(object_width / 2, -object_height / 2, 0), GetRotationAngles()), Camera, null, null);
  Point? GetLeftBottomPoint() => GetCrossPoint(
      Rotate(Point(-object_width / 2, -object_height / 2, 0), GetRotationAngles()), Camera, null, null);

  Offset ToOffset(Point p) => Offset(p.x, p.y);
  Offset ToCenter(Offset p, double width, double height) => Offset(
      p.dx > 0 ? width / 2 + p.dx : width / 2 - abs(p.dx),
      p.dy > 0 ? height / 2 - p.dy : height / 2 + abs(p.dy));
  Offset ToScreen(Point p, Size size) => ToCenter(ToOffset(p), size.width, size.height);

  @override
  void paint(Canvas canvas, Size size) {
    var angles = GetRotationAngles();
    var isBack = abs(angles.y) > 90 || abs(angles.z) > 90;
    var paint = Paint()
      ..color = isBack ? Colors.blue : Colors.red
      ..strokeWidth = 1.0;

    var a = GetLeftTopPoint();
    var b = GetRightTopPoint();
    var c = GetRightBottomPoint();
    var d = GetLeftBottomPoint();
    var e = GetLeftBarPoint();
    var f = GetRightBarPoint();

    if (a != null && b != null) canvas.drawLine(ToScreen(a, size), ToScreen(b, size), paint);
    if (b != null && c != null) canvas.drawLine(ToScreen(b, size), ToScreen(c, size), paint);
    if (c != null && d != null) canvas.drawLine(ToScreen(c, size), ToScreen(d, size), paint);
    if (d != null && a != null) canvas.drawLine(ToScreen(d, size), ToScreen(a, size), paint);

    if (e != null && f != null) canvas.drawLine(ToScreen(e, size), ToScreen(f, size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
