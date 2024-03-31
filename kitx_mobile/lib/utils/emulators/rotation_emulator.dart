import 'dart:math';

import 'package:vector_math/vector_math.dart';

/// PI
const double pi = 3.1415926535897938324626433832795028841971;

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

/// Rotate
Vector3 rotate(Vector3 p, Vector3 angles) => rotateAll(p, angles.x, angles.y, angles.z);

/// Rotate all
Vector3 rotateAll(Vector3 p, double yaw, double pitch, double roll) => rotateX(
      rotateY(
        rotateZ(p, yaw),
        pitch,
      ),
      roll,
    );

/// Rotate X
Vector3 rotateX(Vector3 p, double alpha) {
  alpha *= pi / 180;
  return Vector3(
    cos(alpha) * p.x + sin(alpha) * p.z,
    p.y,
    -sin(alpha) * p.x + cos(alpha) * p.z,
  );
}

/// Rotate Y
Vector3 rotateY(Vector3 p, double beta) {
  beta *= pi / 180;
  return Vector3(
    p.x,
    cos(beta) * p.y - sin(beta) * p.z,
    sin(beta) * p.y + cos(beta) * p.z,
  );
}

/// Rotate Z
Vector3 rotateZ(Vector3 p, double gamma) {
  gamma *= pi / 180;
  return Vector3(
    cos(gamma) * p.x - sin(gamma) * p.y,
    sin(gamma) * p.x + cos(gamma) * p.y,
    p.z,
  );
}

/// DeviceRotationHost
class DeviceRotationHost {
  /// Per rad equals 57.29 degrees
  static double perRadToDegrees = 57.29577951308232;

  /// Rotation degrees
  static double yaw = 0, pitch = 0, roll = 0;

  /// Get rotation angles
  static Vector3 getRotationAngles() => Vector3(yaw, pitch, roll);

  /// Default axis, ayis, azis
  static Vector3 axis = Vector3(1, 0, 0), ayis = Vector3(0, 1, 0), azis = Vector3(0, 0, 1);

  /// Points to rotate
  static List<Vector3> points = [], originPoints = [];

  /// 显式调用此方法来计算加速度之后的四元数
  /// [gyroX], [gyroY], [gyroZ] 单位: rad/s, [samplingRate] 单位: s
  /// yaw -> z
  /// pitch -> y
  /// roll -> x
  static void rotateWithAcceleration(double gyroX, double gyroY, double gyroZ, double samplingRate) {
    yaw += gyroZ * samplingRate * perRadToDegrees;
    pitch += gyroX * samplingRate * perRadToDegrees;
    roll += gyroY * samplingRate * perRadToDegrees;

    var qx = Quaternion.axisAngle(axis, -gyroX * samplingRate);
    var qy = Quaternion.axisAngle(ayis, -gyroY * samplingRate);
    var qz = Quaternion.axisAngle(azis, -gyroZ * samplingRate);

    var q = qx * qy * qz;

    q.normalize();

    for (int i = 0; i < points.length; ++i) {
      qz.rotate(points[i]);
      qy.rotate(points[i]);
      qx.rotate(points[i]);
    }
  }

  /// Set points
  static void setPoints(List<Vector3> newPoints) {
    for (int i = 0; i < newPoints.length; ++i) {
      points.add(newPoints[i].clone());
      originPoints.add(newPoints[i].clone());
    }
  }

  /// Restore quaternion
  static void restore() {
    yaw = 0;
    pitch = 0;
    roll = 0;

    for (int i = 0; i < points.length; ++i) {
      points[i] = originPoints[i].clone();
    }
  }
}
