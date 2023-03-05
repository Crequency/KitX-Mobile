import 'rotation_emulator.dart';

class DeviceRotationHost {
  static double yaw = 0, pitch = 0, roll = 0;

  static double perRadToDegrees = 57.29577951308232;

  //  显式调用此方法来计算加速度之后的旋转角
  //  x, y, z 单位: rad/s, time 单位: s
  //  yaw -> z
  //  pitch -> y
  //  roll -> x
  static void RotateWithAcceleration(double x, double y, double z, double time) {
    yaw += z * time * perRadToDegrees;
    pitch += x * time * perRadToDegrees;
    roll += y * time * perRadToDegrees;

    // print('yaw: $yaw, pitch: $pitch, roll: $roll');
  }

  static void Restore() {
    yaw = 0;
    pitch = 0;
    roll = 0;
  }

  static Doubles3D GetRotationAngles() => Doubles3D(yaw, pitch, roll);
}
