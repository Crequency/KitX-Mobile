import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/utils/emulators/rotation_emulator.dart';
import 'package:kitx_mobile/utils/handlers/vibration_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

/// GyroscopeDisplayStand
class GyroscopeDisplayStand extends StatefulWidget {
  /// Constructor
  const GyroscopeDisplayStand({super.key});

  @override
  GyroscopeDisplayStandState createState() => GyroscopeDisplayStandState();
}

/// GyroscopeDisplayStandState
class GyroscopeDisplayStandState extends State<GyroscopeDisplayStand> {
  /// Gyroscope x-axis, y-axis, z-axis
  final dirX = 0.0.obs, dirY = 0.0.obs, dirZ = 0.0.obs;

  /// Drawing canvas size
  static double canvasWidth = 400, canvasHeight = 300;

  /// Is drawing paused
  /// Is listener errored
  var rotationPaused = false.obs, listenerErrored = false.obs;

  /// Sampling Rage
  var samplingRate = 0.05.obs;

  /// 当前朝向读数（法向量与正/背面判定结果）
  var facingReadout = ''.obs;

  /// Gyroscope sensor data listener
  StreamSubscription<GyroscopeEvent>? gyroscopeDataListener;

  /// Painter
  Painter painter = Painter();

  /// Random sensor data timer
  Timer? randomSensorDataTimer;

  /// 推进姿态并刷新读数
  void advance(double gyroX, double gyroY, double gyroZ) {
    DeviceRotationHost.rotateWithGyroscope(gyroX, gyroY, gyroZ, samplingRate.value);

    dirX.value = gyroX;
    dirY.value = gyroY;
    dirZ.value = gyroZ;

    var n = DeviceRotationHost.normal;
    facingReadout.value = 'n = (${n.x.toStringAsFixed(2)}, ${n.y.toStringAsFixed(2)}, ${n.z.toStringAsFixed(2)})'
        ' → ${DeviceRotationHost.isBackFacing ? 'BACK' : 'FRONT'}';
  }

  @override
  void initState() {
    painter.initialize();

    gyroscopeDataListener = gyroscopeEventStream(
      samplingPeriod: Duration(milliseconds: (samplingRate.value * 1000).toInt()),
    ).listen(
      (event) {
        advance(event.x, event.y, event.z);
      },
      onError: (error) {
        listenerErrored.value = true;

        var random = Random(114514);

        randomSensorDataTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
          var rad = 0.5 + random.nextDouble() / 10;

          advance(dirX.value, rad, dirZ.value);
        });
      },
      cancelOnError: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    gyroscopeDataListener?.cancel();
    randomSensorDataTimer?.cancel();
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
                            VibrationHandler.tryVibrate();
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
            () => Text('${dirX >= 0 ? '⏬' : '⏫'} \tx: ${dirX.value}', style: TextStyle(fontSize: 16)),
          ),
          Obx(
            () => Text('${dirY >= 0 ? '⤵' : '⤴'} \ty: ${dirY.value}', style: TextStyle(fontSize: 16)),
          ),
          Obx(
            () => Text('${dirZ >= 0 ? '⏪' : '⏩'} \tz: ${dirZ.value}', style: TextStyle(fontSize: 16)),
          ),
          Obx(
            () => Text('⏱ \tSampling Rate: ${samplingRate.value} s', style: TextStyle(fontSize: 16)),
          ),
          Obx(
            () => Text('🧭 \t$facingReadout', style: TextStyle(fontSize: 16)),
          ),
          const Text('↔ \tUnit: rad/s', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          Obx(() => listenerErrored.value ? const Text('No sensor data, you are seeing random data.') : const SizedBox())
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

  /// 正面朝向摄像机时的描边颜色
  static const frontColor = Colors.blue;

  /// 背面朝向摄像机时的描边颜色
  static const backColor = Colors.orange;

  /// Return absolute value
  double abs(double num) => num >= 0 ? num : -num;

  /// 初始化物体坐标系点集（机身轮廓四点 + 腰线两点）
  void initialize() {
    DeviceRotationHost.setPoints([
      vector_math.Vector3(-objectWidth / 2, objectHeight / 2, 0),
      vector_math.Vector3(objectWidth / 2, objectHeight / 2, 0),
      vector_math.Vector3(objectWidth / 2, -objectHeight / 2, 0),
      vector_math.Vector3(-objectWidth / 2, -objectHeight / 2, 0),
      vector_math.Vector3(-objectWidth / 2 + objectWidth / 4, -objectHeight / 2 + objectHeight / 24, 0),
      vector_math.Vector3(objectWidth / 2 - objectWidth / 4, -objectHeight / 2 + objectHeight / 24, 0),
    ]);
  }

  /// 把点集从物体坐标系变换到世界坐标系并做透视投影
  ///
  /// 落在摄像机背面（或与投影平面平行）的顶点返回 null，绘制时整条线段都会被丢弃。
  List<vector_math.Vector3?> projectPoints() => DeviceRotationHost.points
      .map((point) => getCrossPoint(DeviceRotationHost.transform(point), camera, null, null))
      .toList();

  /// Convert [vector_math.Vector3] to [Offset]
  Offset toOffset(vector_math.Vector3 p) => Offset(p.x, p.y);

  /// Trans [Offset] to center position
  Offset toCenter(Offset p, double width, double height) =>
      Offset(p.dx > 0 ? width / 2 + p.dx : width / 2 - abs(p.dx), p.dy > 0 ? height / 2 - p.dy : height / 2 + abs(p.dy));

  /// Convert [vector_math.Vector3] to [Offset] for screen display
  Offset toScreen(vector_math.Vector3 p, Size size) => toCenter(toOffset(p), size.width, size.height);

  @override
  void paint(Canvas canvas, Size size) {
    var points = projectPoints();

    // 由变换后的面法向量判定正/背面：n.z < 0 表示机身背面朝向摄像机。
    // 旧实现用 |pitch| > 90 || |roll| > 90 近似，两个角同时越过 ±90° 时会误判。
    var paint = Paint()
      ..color = DeviceRotationHost.isBackFacing ? backColor : frontColor
      ..strokeWidth = 1.0;

    void connect(int from, int to) {
      var a = points[from];
      var b = points[to];

      if (a == null || b == null) return;

      canvas.drawLine(toScreen(a, size), toScreen(b, size), paint);
    }

    connect(0, 1);
    connect(1, 2);
    connect(2, 3);
    connect(3, 0);
    connect(4, 5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
