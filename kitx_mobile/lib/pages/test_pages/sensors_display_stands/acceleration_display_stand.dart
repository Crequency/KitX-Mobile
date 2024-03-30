import 'dart:async';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// AccelerationDisplayStand
class AccelerationDisplayStand extends StatefulWidget {
  @override
  AccelerationDisplayStandState createState() => AccelerationDisplayStandState();
}

/// AccelerationDisplayStandState
class AccelerationDisplayStandState extends State<AccelerationDisplayStand> {
  /// Acceleration x-axis, y-axis, z-axis
  final accX = 0.0.obs, accY = 0.0.obs, accZ = 0.0.obs;

  /// Sampling Rage
  var samplingRate = 0.05.obs;

  /// User accelerometer sensor data listener
  StreamSubscription<UserAccelerometerEvent>? userAccelerometerDataListener;

  /// Is listener paused
  var listenerPaused = false.obs;

  /// Chart related data
  var minX = 0.0.obs, maxX = 0.05.obs, xCount = 10.obs;

  /// Acceleration x-axis, y-axis, z-axis values
  var xValues = <FlSpot>[], yValues = <FlSpot>[], zValues = <FlSpot>[];

  @override
  void initState() {
    userAccelerometerDataListener = userAccelerometerEventStream(
      samplingPeriod: Duration(milliseconds: (samplingRate * 1000).toInt()),
    ).listen(
      (event) {
        accX.value = event.x;
        accY.value = event.y;
        accZ.value = event.z;
        maxX.value += samplingRate.value;
        if ((maxX.value - minX.value) >= samplingRate.value * xCount.value) {
          minX.value += samplingRate.value;
        }
        xValues.add(FlSpot(maxX.value, event.x));
        yValues.add(FlSpot(maxX.value, event.y));
        zValues.add(FlSpot(maxX.value, event.z));
        if (xValues.length > xCount.value + 1) {
          xValues.removeAt(0);
          yValues.removeAt(0);
          zValues.removeAt(0);
        }
      },
      onError: (error) {
        var random = Random(114514);
        Timer.periodic(Duration(milliseconds: (samplingRate * 1000).toInt()), (timer) {
          accX.value = random.nextDouble() * 10 - 5;
          accY.value = random.nextDouble() * 10 - 5;
          accZ.value = random.nextDouble() * 10 - 5;
          maxX.value += samplingRate.value;
          if ((maxX.value - minX.value) >= samplingRate.value * xCount.value) {
            minX.value += samplingRate.value;
          }
          xValues.add(FlSpot(maxX.value, accX.value));
          yValues.add(FlSpot(maxX.value, accY.value));
          zValues.add(FlSpot(maxX.value, accZ.value));
          if (xValues.length > xCount.value + 1) {
            xValues.removeAt(0);
            yValues.removeAt(0);
            zValues.removeAt(0);
          }
        });
      },
      cancelOnError: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    userAccelerometerDataListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Acceleration Data', style: TextStyle(fontSize: 32)),
          Container(
            height: 300,
            margin: EdgeInsets.fromLTRB(0, 30, 20, 30),
            child: Obx(
              () => LineChart(
                LineChartData(
                  minX: minX.value,
                  maxX: maxX.value,
                  minY: -5,
                  maxY: 5,
                  lineBarsData: [
                    LineChartBarData(
                      spots: xValues,
                      color: Colors.redAccent,
                      isStrokeCapRound: true,
                      isStrokeJoinRound: true,
                    ),
                    LineChartBarData(
                      spots: yValues,
                      color: Colors.greenAccent,
                      isStrokeCapRound: true,
                      isStrokeJoinRound: true,
                    ),
                    LineChartBarData(
                      spots: zValues,
                      color: Colors.blueAccent,
                      isStrokeCapRound: true,
                      isStrokeJoinRound: true,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1,
                        getTitlesWidget: (a, b) => Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(a.toStringAsFixed(3).toString()),
                        ),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (a, b) => Text(a.toInt().toString()),
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: 1,
                    verticalInterval: samplingRate.value,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Colors.indigo,
                        strokeWidth: 1,
                      );
                    },
                    getDrawingVerticalLine: (value) {
                      return const FlLine(
                        color: Colors.indigo,
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.indigo),
                  ),
                ),
                duration: const Duration(milliseconds: 0),
              ),
            ),
          ),
          Obx(
            () => Text('${accX > 0 ? "⏪" : "⏩"} \tx: ${accX.value}', style: TextStyle(fontSize: 16, color: Colors.redAccent)),
          ),
          Obx(
            () => Text('${accY > 0 ? "⏬" : "⏫"} \ty: ${accY.value}', style: TextStyle(fontSize: 16, color: Colors.greenAccent)),
          ),
          Obx(
            () => Text('${accZ > 0 ? "⬇" : "⬆"} \tz: ${accZ.value}', style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
          ),
          Obx(
            () => Text('⏱ \tSampling Rate: ${samplingRate.value} s', style: TextStyle(fontSize: 16)),
          ),
          const Text('↔ \tUnit: m/s^2', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          Obx(
            () => ElevatedButton(
              onPressed: () {
                if (userAccelerometerDataListener?.isPaused ?? true) {
                  userAccelerometerDataListener?.resume();
                  listenerPaused.value = false;
                } else {
                  userAccelerometerDataListener?.pause();
                  listenerPaused.value = true;
                }
              },
              child: listenerPaused.value ? const Text('Resume') : const Text("Pause"),
            ),
          ),
        ],
      ),
    );
  }
}
