import 'dart:math';

/// PI
const double pi = 3.1415926535897938324626433832795028841971;

/// [Doubles3D] class
class Doubles3D {
  /// x, y, z
  var x = 0.0, y = 0.0, z = 0.0;

  /// Constructor of [Doubles3D]
  Doubles3D(this.x, this.y, this.z);
}

/// [Point] class
class Point extends Doubles3D {
  /// Constructor of [Point]
  Point(super.x, super.y, super.z);
}

/// [Vector3D] class
class Vector3D extends Doubles3D {
  /// Constructor of [Vector3D]
  Vector3D(super.x, super.y, super.z);
}

/// Rotate
Point rotate(Point p, Doubles3D angles) => rotateAll(p, angles.x, angles.y, angles.z);

/// Rotate all
Point rotateAll(Point p, double yaw, double pitch, double roll) => rotateX(
      rotateY(
        rotateZ(p, yaw),
        pitch,
      ),
      roll,
    );

/// Rotate X
Point rotateX(Point p, double alpha) {
  alpha *= pi / 180;
  return Point(cos(alpha) * p.x + sin(alpha) * p.z, p.y, -sin(alpha) * p.x + cos(alpha) * p.z);
}

/// Rotate Y
Point rotateY(Point p, double beta) {
  beta *= pi / 180;
  return Point(p.x, cos(beta) * p.y - sin(beta) * p.z, sin(beta) * p.y + cos(beta) * p.z);
}

/// Rotate Z
Point rotateZ(Point p, double gamma) {
  gamma *= pi / 180;
  return Point(cos(gamma) * p.x - sin(gamma) * p.y, sin(gamma) * p.x + cos(gamma) * p.y, p.z);
}

/// Get direction
Vector3D getDirection(Point p1, Point p2) => Vector3D(p2.x - p1.x, p2.y - p1.y, p2.z - p1.z);

/// Get cross point
Point? getCrossPoint(Point p, Point camera, Point? n, Vector3D? plane) {
  var vL = getDirection(p, camera);
  var vP = plane ?? Vector3D(0, 0, 1);

  var vp1 = vP.x, vp2 = vP.y, vp3 = vP.z;
  var v1 = vL.x, v2 = vL.y, v3 = vL.z;

  var tBase = vp1 * v1 + vp2 * v2 + vp3 * v3;
  if (tBase - 0 <= 0.00001) {
    return null;
  } else {
    n ??= Point(0, 0, 0);

    var n1 = n.x, n2 = n.y, n3 = n.z;
    var p1 = p.x, p2 = p.y, p3 = p.z;

    var tDivide = (n1 - p1) * vp1 + (n2 - p2) * vp2 + (n3 - p3) * vp3;
    var t = tDivide / tBase;

    var x = p1 + v1 * t;
    var y = p2 + v2 * t;
    var z = p3 + v3 * t;

    return Point(x, y, z);
  }
}
