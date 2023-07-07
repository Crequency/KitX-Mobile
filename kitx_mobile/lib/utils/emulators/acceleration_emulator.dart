import 'package:kitx_mobile/utils/emulators/rotation_emulator.dart';

/// DeviceRotationHost
class DeviceRotationHost {
  /// Rotation degrees
  static double yaw = 0, pitch = 0, roll = 0;

  /// Per rad equals 57.29 degrees
  static double perRadToDegrees = 57.29577951308232;

  ///  显式调用此方法来计算加速度之后的旋转角
  ///  x, y, z 单位: rad/s, time 单位: s
  ///  yaw -> z
  ///  pitch -> y
  ///  roll -> x
  static void rotateWithAcceleration(double x, double y, double z, double time) {
    yaw += z * time * perRadToDegrees;
    pitch += x * time * perRadToDegrees;
    roll += y * time * perRadToDegrees;
  }

  /// Restore rotation
  static void restore() {
    yaw = 0;
    pitch = 0;
    roll = 0;
  }

  /// Get rotation angles
  static Doubles3D getRotationAngles() => Doubles3D(yaw, pitch, roll);
}
