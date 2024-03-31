import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/utils/emulators/rotation_emulator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

/// GyroscopeDisplayStand
class GyroscopeDisplayStand extends StatefulWidget {
  @override
  GyroscopeDisplayStandState createState() => GyroscopeDisplayStandState();
}

/// GyroscopeDisplayStandState
class GyroscopeDisplayStandState extends State<GyroscopeDisplayStand> {
  /// Gyroscope x-axis, y-axis, z-axis
  final dirX = 0.0.obs, dirY = 0.0.obs, dirZ = 0.0.obs;

  /// Gyroscope direction x, y, z
  final directionX = 'none'.obs, directionY = 'none'.obs, directionZ = 'none'.obs;

  /// Drawing canvas width
  static double canvasWidth = 400;

  /// Drawing canvas height
  static double canvasHeight = 300;

  /// Is drawing paused
  var rotationPaused = false.obs;

  /// Gyroscope sensor data listener
  StreamSubscription<GyroscopeEvent>? gyroscopeDataListener;

  /// Painter
  Painter painter = Painter();

  @override
  void initState() {
    painter.initialize();

    gyroscopeDataListener = gyroscopeEventStream(samplingPeriod: Duration(milliseconds: 50)).listen((event) {
      DeviceRotationHost.rotateWithAcceleration(event.x, event.y, event.z, 0.05);

      dirX.value = event.x;
      dirY.value = event.y;
      dirZ.value = event.z;

      directionX.value = dirX >= 0 ? '⇊' : '⇈';
      directionY.value = dirY >= 0 ? '↻' : '↺';
      directionZ.value = dirZ >= 0 ? '↶' : '↷';
    });

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

    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gyroscope Data', style: TextStyle(fontSize: 32)),
          Column(
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
                    child: Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                          child: CustomPaint(
                            isComplex: true,
                            size: Size(canvasWidth - 60, canvasHeight),
                            willChange: true,
                            painter: painter,
                          ),
                          onTap: () {
                            if (gyroscopeDataListener != null) {
                              if (gyroscopeDataListener?.isPaused ?? true) {
                                gyroscopeDataListener?.resume();
                              } else {
                                gyroscopeDataListener?.pause();
                              }
                              rotationPaused.value = gyroscopeDataListener?.isPaused ?? true;
                            }
                          },
                          onLongPress: () => DeviceRotationHost.restore(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Obx(
            () => Text('${directionX.value} x: ${dirX.value}', style: TextStyle(fontSize: 16)),
          ),
          Obx(
            () => Text('${directionY.value} y: ${dirY.value}', style: TextStyle(fontSize: 16)),
          ),
          Obx(
            () => Text('${directionZ.value} z: ${dirZ.value}', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}

/// The painter class implements the CustomPainter class
class Painter extends CustomPainter {
  /// The object's size
  var objectWidth = 135.0, objectHeight = 240.0;

  /// The camera's position
  var camera = vector_math.Vector3(0, 0, 800);

  /// Return absolute value
  double abs(double num) => num >= 0 ? num : -num;

  /// Yaw - Pitch - Roll
  vector_math.Vector3 getRotationAngles() => DeviceRotationHost.getRotationAngles();

  /// Initialize
  void initialize() {
    DeviceRotationHost.axis = vector_math.Vector3(objectWidth / 2, 0, 0);
    DeviceRotationHost.ayis = vector_math.Vector3(0, objectHeight / 2, 0);
    DeviceRotationHost.azis = vector_math.Vector3(0, 0, 1);

    DeviceRotationHost.setPoints([
      vector_math.Vector3(-objectWidth / 2, objectHeight / 2, 0),
      vector_math.Vector3(objectWidth / 2, objectHeight / 2, 0),
      vector_math.Vector3(objectWidth / 2, -objectHeight / 2, 0),
      vector_math.Vector3(-objectWidth / 2, -objectHeight / 2, 0),
      vector_math.Vector3(-objectWidth / 2 + objectWidth / 4, -objectHeight / 2 + objectHeight / 24, 0),
      vector_math.Vector3(objectWidth / 2 - objectWidth / 4, -objectHeight / 2 + objectHeight / 24, 0),
    ]);
  }

  /// Get Points
  List<vector_math.Vector3> getPoints() {
    var rotatedPoints = DeviceRotationHost.points;

    List<vector_math.Vector3> displayPoints = [];

    for (int i = 0; i < rotatedPoints.length; ++i) {
      displayPoints.add(getCrossPoint(rotatedPoints[i], camera, null, null) ?? vector_math.Vector3(0, 0, 0));
    }

    return displayPoints;
  }

  /// Convert [vector_math.Vector3] to [Offset]
  Offset toOffset(vector_math.Vector3 p) => Offset(p.x, p.y);

  /// Trans [Offset] to center position
  Offset toCenter(Offset p, double width, double height) => Offset(p.dx > 0 ? width / 2 + p.dx : width / 2 - abs(p.dx), p.dy > 0 ? height / 2 - p.dy : height / 2 + abs(p.dy));

  /// Convert [vector_math.Vector3] to [Offset] for screen display
  Offset toScreen(vector_math.Vector3 p, Size size) => toCenter(toOffset(p), size.width, size.height);

  @override
  void paint(Canvas canvas, Size size) {
    var angles = getRotationAngles();
    var points = getPoints();
    var isBack = abs(angles.y) > 90 || abs(angles.z) > 90;
    var paint = Paint()
      ..color = isBack ? Colors.blue : Colors.red
      ..strokeWidth = 1.0;

    var a = points[0];
    var b = points[1];
    var c = points[2];
    var d = points[3];
    var e = points[4];
    var f = points[5];

    canvas.drawLine(toScreen(a, size), toScreen(b, size), paint);
    canvas.drawLine(toScreen(b, size), toScreen(c, size), paint);
    canvas.drawLine(toScreen(c, size), toScreen(d, size), paint);
    canvas.drawLine(toScreen(d, size), toScreen(a, size), paint);

    canvas.drawLine(toScreen(e, size), toScreen(f, size), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
