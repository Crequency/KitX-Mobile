import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class VibrationDisplayStand extends StatefulWidget {
  @override
  VibrationDisplayStandState createState() => VibrationDisplayStandState();
}

class VibrationDisplayStandState extends State<VibrationDisplayStand> {
  @override
  void initState() => super.initState();

  int vibrate_duration = 200;

  Future<void> vibrate() async {
    if (await Vibration.hasCustomVibrationsSupport() ?? false) {
      Vibration.vibrate(duration: vibrate_duration);
    } else if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }
  }

  void vibrate_cancel() => Vibration.cancel();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vibration Test", style: TextStyle(fontSize: 32)),
            TextField(
              decoration: new InputDecoration(labelText: "Vibration Duration (ms)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'\d')),
                FilteringTextInputFormatter.digitsOnly,
              ], // Only numbers can be entered
              onChanged: (val) {
                vibrate_duration = int.parse(val);
              },
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: [
                    Expanded(flex: 65, child: ElevatedButton(onPressed: vibrate, child: Text("Vibrate"))),
                    Spacer(
                      flex: 5,
                    ),
                    Expanded(
                        flex: 30, child: OutlinedButton(onPressed: vibrate_cancel, child: Text("Cancel"))),
                  ],
                )),
          ],
        ));
  }
}
