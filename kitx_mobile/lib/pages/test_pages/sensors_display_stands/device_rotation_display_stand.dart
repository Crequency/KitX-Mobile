import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/utils/emulators/acceleration_emulator.dart';
import 'package:kitx_mobile/utils/emulators/rotation_emulator.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// DeviceRotationDisplayStand
class DeviceRotationDisplayStand extends StatefulWidget {
  @override
  DeviceRotationDisplayStandState createState() => DeviceRotationDisplayStandState();
}

/// DeviceRotationDisplayStandState
class DeviceRotationDisplayStandState extends State<DeviceRotationDisplayStand> {
  /// Drawing canvas width
  static double canvasWidth = 400;

  /// Drawing canvas height
  static double canvasHeight = 300;

  /// Is drawing paused
  var rotationPaused = false.obs;

  /// Gyroscope sensor data listener
  StreamSubscription<GyroscopeEvent>? gyroscopeDataListener;

  /// Begin listen gyroscope sensor's datas
  void beginListenGyroscopeData() {
    gyroscopeEventStream(samplingPeriod: Duration(milliseconds: 20)).listen((event) {
      DeviceRotationHost.rotateWithAcceleration(event.x, event.y, event.z, 0.2);
    });
  }

  @override
  void initState() {
    beginListenGyroscopeData();

    super.initState();
  }

  @override
  void dispose() {
    gyroscopeDataListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    canvasWidth = size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Obx(
              () => AnimatedOpacity(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic,
                opacity: rotationPaused.value ? 1 : 0,
                child: const Icon(Icons.pause, size: 40),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                child: CustomPaint(
                  isComplex: true,
                  size: Size(canvasWidth - 60, canvasHeight),
                  willChange: true,
                  painter: Painter(),
                ),
                onTap: () {
                  if (gyroscopeDataListener != null) {
                    if (gyroscopeDataListener?.isPaused ?? true) {
                      gyroscopeDataListener?.resume();
                    } else {
                      gyroscopeDataListener?.pause();
                    }
                    rotationPaused.value = gyroscopeDataListener?.isPaused ?? true;
                  } else {
                    beginListenGyroscopeData();
                  }
                },
                onLongPress: () => DeviceRotationHost.restore(),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 20),
      ],
    );
  }
}

/// The painter class implements the CustomPainter class
class Painter extends CustomPainter {
  /// The object's size
  var objectWidth = 135, objectHeight = 240;

  /// The camera's position
  var camera = Point(0, 0, 800);

  /// Return absolute value
  double abs(double num) => num >= 0 ? num : -num;

  /// Yaw - Pitch - Roll
  Doubles3D getRotationAngles() => DeviceRotationHost.getRotationAngles();

  /// Get left bar point
  Point? getLeftBarPoint() => getCrossPoint(
        rotate(
          Point(
            -objectWidth / 2 + objectWidth / 4,
            -objectHeight / 2 + objectHeight / 24,
            0,
          ),
          getRotationAngles(),
        ),
        camera,
        null,
        null,
      );

  /// Get right bar point
  Point? getRightBarPoint() => getCrossPoint(
        rotate(
          Point(
            objectWidth / 2 - objectWidth / 4,
            -objectHeight / 2 + objectHeight / 24,
            0,
          ),
          getRotationAngles(),
        ),
        camera,
        null,
        null,
      );

  /// Get left top point
  Point? getLeftTopPoint() => getCrossPoint(
        rotate(
          Point(
            -objectWidth / 2,
            objectHeight / 2,
            0,
          ),
          getRotationAngles(),
        ),
        camera,
        null,
        null,
      );

  /// Get right top point
  Point? getRightTopPoint() => getCrossPoint(
        rotate(
          Point(
            objectWidth / 2,
            objectHeight / 2,
            0,
          ),
          getRotationAngles(),
        ),
        camera,
        null,
        null,
      );

  /// Get right bottom point
  Point? getRightBottomPoint() => getCrossPoint(
        rotate(
          Point(
            objectWidth / 2,
            -objectHeight / 2,
            0,
          ),
          getRotationAngles(),
        ),
        camera,
        null,
        null,
      );

  /// Get left bottom point
  Point? getLeftBottomPoint() => getCrossPoint(
        rotate(
          Point(
            -objectWidth / 2,
            -objectHeight / 2,
            0,
          ),
          getRotationAngles(),
        ),
        camera,
        null,
        null,
      );

  /// Convert [Point] to [Offset]
  Offset toOffset(Point p) => Offset(p.x, p.y);

  /// Trans [Offset] to center position
  Offset toCenter(Offset p, double width, double height) => Offset(p.dx > 0 ? width / 2 + p.dx : width / 2 - abs(p.dx), p.dy > 0 ? height / 2 - p.dy : height / 2 + abs(p.dy));

  /// Convert [Point] to [Offset] for screen display
  Offset toScreen(Point p, Size size) => toCenter(toOffset(p), size.width, size.height);

  @override
  void paint(Canvas canvas, Size size) {
    var angles = getRotationAngles();
    var isBack = abs(angles.y) > 90 || abs(angles.z) > 90;
    var paint = Paint()
      ..color = isBack ? Colors.blue : Colors.red
      ..strokeWidth = 1.0;

    var a = getLeftTopPoint();
    var b = getRightTopPoint();
    var c = getRightBottomPoint();
    var d = getLeftBottomPoint();
    var e = getLeftBarPoint();
    var f = getRightBarPoint();

    if (a != null && b != null) canvas.drawLine(toScreen(a, size), toScreen(b, size), paint);
    if (b != null && c != null) canvas.drawLine(toScreen(b, size), toScreen(c, size), paint);
    if (c != null && d != null) canvas.drawLine(toScreen(c, size), toScreen(d, size), paint);
    if (d != null && a != null) canvas.drawLine(toScreen(d, size), toScreen(a, size), paint);

    if (e != null && f != null) canvas.drawLine(toScreen(e, size), toScreen(f, size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
