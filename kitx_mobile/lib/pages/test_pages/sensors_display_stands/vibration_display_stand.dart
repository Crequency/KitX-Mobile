import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

/// VibrationDisplayStand
class VibrationDisplayStand extends StatefulWidget {
  @override
  VibrationDisplayStandState createState() => VibrationDisplayStandState();
}

/// VibrationDisplayStandState
class VibrationDisplayStandState extends State<VibrationDisplayStand> {
  @override
  void initState() => super.initState();

  /// Vibration duration
  var vibrateDuration = 200;

  /// Vibrate text
  var vibrateText = "Vibrate".obs;

  /// Vibrate
  Future<void> vibrate() async {
    if (await Vibration.hasCustomVibrationsSupport() ?? false) {
      Vibration.vibrate(duration: vibrateDuration);
    } else if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }
  }

  /// Cancel vibration
  void cancelVibration() => Vibration.cancel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Vibration Test', style: TextStyle(fontSize: 32)),
          TextField(
            decoration: InputDecoration(labelText: 'Vibration Duration (ms)'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'\d')),
              FilteringTextInputFormatter.digitsOnly,
            ], // Only numbers can be entered
            onChanged: (val) {
              vibrateDuration = int.tryParse(val) ?? 200;

              if (vibrateDuration == 520) {
                vibrateText.value = "zzy";
              } else if (vibrateText.value == "zzy") {
                vibrateText.value = "Vibrate";
              }
            },
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              children: [
                Expanded(
                  flex: 65,
                  child: ElevatedButton(
                    onPressed: vibrate,
                    child: Obx(() => Text(vibrateText.value)),
                  ),
                ),
                Spacer(
                  flex: 5,
                ),
                Expanded(
                  flex: 30,
                  child: OutlinedButton(
                    onPressed: cancelVibration,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
