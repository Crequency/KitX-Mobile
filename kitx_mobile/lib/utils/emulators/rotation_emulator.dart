import 'dart:math';

import 'package:vector_math/vector_math.dart';

/// PI
const double pi = 3.1415926535897938324626433832795028841971;

/// Per rad equals 57.29 degrees
const double perRadToDegrees = 57.29577951308232;

/// Get direction
Vector3 getDirection(Vector3 p1, Vector3 p2) => Vector3(p2.x - p1.x, p2.y - p1.y, p2.z - p1.z);

/// Get cross point
Vector3? getCrossPoint(Vector3 p, Vector3 camera, Vector3? n, Vector3? plane) {
  var vL = getDirection(p, camera);
  var vP = plane ?? Vector3(0, 0, 1);

  var vp1 = vP.x, vp2 = vP.y, vp3 = vP.z;
  var v1 = vL.x, v2 = vL.y, v3 = vL.z;

  var tBase = vp1 * v1 + vp2 * v2 + vp3 * v3;
  if (tBase - 0 <= 0.00001) {
    return null;
  } else {
    n ??= Vector3(0, 0, 0);

    var n1 = n.x, n2 = n.y, n3 = n.z;
    var p1 = p.x, p2 = p.y, p3 = p.z;

    var tDivide = (n1 - p1) * vp1 + (n2 - p2) * vp2 + (n3 - p3) * vp3;
    var t = tDivide / tBase;

    var x = p1 + v1 * t;
    var y = p2 + v2 * t;
    var z = p3 + v3 * t;

    return Vector3(x, y, z);
  }
}

/// DeviceRotationHost
class DeviceRotationHost {
  /// Directions
  static Quaternion xDir = Quaternion(1, 0, 0, 0), yDir = Quaternion(0, 1, 0, 0), zDir = Quaternion(0, 0, 1, 0);

  /// The last time's directions rotation
  static Quaternion lastXDirR = Quaternion(1, 0, 0, 0), lastYDirR = Quaternion(0, 1, 0, 0), lastZDirR = Quaternion(0, 0, 1, 0);

  /// Points to rotate
  static List<Quaternion> points = [], originPoints = [];

  /// 显式调用此方法来计算加速度之后的四元数
  /// [gyroX], [gyroY], [gyroZ] 单位: rad/s, [samplingRate] 单位: s
  static void rotateWithAcceleration(double gyroX, double gyroY, double gyroZ, double samplingRate) {
    var radX = gyroX * samplingRate, radY = gyroY * samplingRate, radZ = gyroZ * samplingRate;

    var xDirR = xDir.ewNormalize().wpRotate(radX);
    var yDirR = yDir.ewNormalize().wpRotate(radY);
    var zDirR = zDir.ewNormalize().wpRotate(radZ);

    var xDirRInv = xDirR.clone().conjugated();
    var yDirRInv = yDirR.clone().conjugated();
    var zDirRInv = zDirR.clone().conjugated();

    for (int i = 0; i < points.length; ++i) {
      var np = points[i].clone();
      np = xDirR * np * xDirRInv;
      np = yDirR * np * yDirRInv;
      np = zDirR * np * zDirRInv;
      points[i] = np;
    }
  }

  /// Set points
  static void setPoints(List<Quaternion> newPoints) {
    originPoints.clear();
    points.clear();

    for (int i = 0; i < newPoints.length; ++i) {
      points.add(newPoints[i].clone());
      originPoints.add(newPoints[i].clone());
    }
  }

  /// Restore quaternion
  static void restore() {
    for (int i = 0; i < points.length; ++i) {
      points[i] = originPoints[i].clone();
    }
  }
}

/// Quaternion extension
extension QuaternionExtension on Quaternion {
  /// To [Vector3]
  Vector3 toPoint() => Vector3(x, y, z);

  /// Normalize except w
  Quaternion ewNormalize() {
    var norm = sqrt(x * x + y * y + z * z);
    return Quaternion(x / norm, y / norm, z / norm, 0);
  }

  /// Rotate with rad for point
  Quaternion wpRotate(double rad) {
    var r = rad / 2, w = cos(r), k = sin(r);
    return Quaternion(k * x, k * y, k * z, w);
  }

  /// Get text to display
  String getText() {
    return 'x: $x, y: $y, z: $z, w: $w';
  }
}
