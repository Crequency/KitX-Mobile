import 'package:flutter/material.dart';

import '../../../utils/rotation_emulator.dart';

class DeviceRotationDisplayStand extends StatefulWidget{
  @override
  DeviceRotationDisplayStandState createState() => DeviceRotationDisplayStandState();
}

class DeviceRotationDisplayStandState extends State<DeviceRotationDisplayStand>{
  static double canvas_width = 400;
  static double canvas_height = 300;

  @override
  void initState() => super.initState();

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    canvas_width = size.width;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomPaint(
            isComplex: true,
            size: new Size(canvas_width - 60, canvas_height),
            willChange: true,
            painter: Painter(),
          )
        ],
    );
  }
}

class Painter extends CustomPainter {

  double object_width = 135, object_height = 240;

  Point Camera = new Point(0, 0, 800);

  double abs(double num) => num >= 0 ? num : -num;

  //  yaw - pitch - roll
  Doubles3D GetRotationAngles() => new Doubles3D(0, 0, 0);

  Point GetLeftBarPoint() => Rotate(new Point(
      -object_width / 2 + object_width / 4,
      -object_height / 2 + object_height / 24,
      0
  ), GetRotationAngles());
  Point GetRightBarPoint() => Rotate(new Point(
      object_width / 2 - object_width / 4,
      -object_height / 2 + object_height / 24,
      0
  ), GetRotationAngles());

  Point GetLeftTopPoint() => Rotate(
      new Point(-object_width / 2, object_height / 2, 0), GetRotationAngles()
  );
  Point GetRightTopPoint() => Rotate(
      new Point(object_width / 2, object_height / 2, 0), GetRotationAngles()
  );
  Point GetRightBottomPoint() => Rotate(
      new Point(object_width / 2, -object_height / 2, 0), GetRotationAngles()
  );
  Point GetLeftBottomPoint() => Rotate(
      new Point(-object_width / 2, -object_height / 2, 0), GetRotationAngles()
  );

  Offset ToOffset(Point p) => new Offset(p.x, p.y);
  Offset ToCenter(Offset p, double width, double height)
    => new Offset(
      p.dx > 0 ? width / 2 + p.dx : width / 2 - abs(p.dx),
      p.dy > 0 ? height / 2 - p.dy : height / 2 + abs(p.dy)
    );
  Offset ToScreen(Point p, Size size) => ToCenter(ToOffset(p), size.width, size.height);

  @override
  void paint(Canvas canvas, Size size) {
    var angles = GetRotationAngles();
    bool isBack = abs(angles.y) > 90 || abs(angles.z) > 90;
    var paint = Paint()
      ..color = isBack
          ?
          Color(0x8000FF00)
          :
          Color(0x80F53010)
      ..strokeWidth = 4.0
    ;
    canvas.drawLine(
        ToScreen(GetLeftTopPoint(), size),
        ToScreen(GetRightTopPoint(), size),
        paint
    );
    canvas.drawLine(
        ToScreen(GetRightTopPoint(), size),
        ToScreen(GetRightBottomPoint(), size),
        paint
    );
    canvas.drawLine(
        ToScreen(GetRightBottomPoint(), size),
        ToScreen(GetLeftBottomPoint(), size),
        paint
    );
    canvas.drawLine(
        ToScreen(GetLeftBottomPoint(), size),
        ToScreen(GetLeftTopPoint(), size),
        paint
    );

    canvas.drawLine(
        ToScreen(GetLeftBarPoint(), size),
        ToScreen(GetRightBarPoint(), size),
        paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}