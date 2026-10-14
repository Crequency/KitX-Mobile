import 'package:sound_mode_advanced/sound_mode_advanced.dart';
import 'package:vibration/vibration.dart';

/// [VibrationHandler]
class VibrationHandler {
  /// [tryVibrate]
  static void tryVibrate({int milliseconds = 50}) {
    SoundMode.ringerModeStatus.then((ringer) {
      if (ringer == RingerModeStatus.silent) {
        return;
      }

      Vibration.hasVibrator().then((value) {
        Vibration.hasCustomVibrationsSupport().then(
          (value) {
            if (value) {
              Vibration.vibrate(duration: milliseconds);
            } else {
              Vibration.hasVibrator().then(
                (value) {
                  if (value) Vibration.vibrate();
                },
              );
            }
          },
        );
      });
    });
  }
}

/// [VibrationHandlerExtensions]
extension VibrationHandlerExtensions on Function {
  /// [tryVibrate]
  Function tryVibrate({int milliseconds = 50}) {
    VibrationHandler.tryVibrate(milliseconds: milliseconds);
    return this;
  }
}
