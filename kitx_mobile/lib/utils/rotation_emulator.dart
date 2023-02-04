import 'dart:math';

const double pi = 3.1415926535897938324626433832795028841971;

class Doubles3D {
  double x = 0, y = 0, z = 0;
  Doubles3D(this.x, this.y, this.z);
}

class Point extends Doubles3D {
  Point(super.x, super.y, super.z);
}

class Vector3D extends Doubles3D {
  Vector3D(super.x, super.y, super.z);
}

Point Rotate(Point p, Doubles3D angles) =>
    AllRotate(p, angles.x, angles.y, angles.z);

Point AllRotate(Point p, double yaw, double pitch, double roll) =>
    X_Rotate(Y_Rotate(Z_Rotate(p, yaw), pitch), roll);

Point X_Rotate(Point p, double alpha) {
  alpha *= pi / 180;
  return new Point(cos(alpha) * p.x + sin(alpha) * p.z, p.y,
      -sin(alpha) * p.x + cos(alpha) * p.z);
}

Point Y_Rotate(Point p, double beta) {
  beta *= pi / 180;
  return new Point(p.x, cos(beta) * p.y - sin(beta) * p.z,
      sin(beta) * p.y + cos(beta) * p.z);
}

Point Z_Rotate(Point p, double gamma) {
  gamma *= pi / 180;
  return new Point(cos(gamma) * p.x - sin(gamma) * p.y,
      sin(gamma) * p.x + cos(gamma) * p.y, p.z);
}

Vector3D GetDirection(Point p1, Point p2) =>
    new Vector3D(p2.x - p1.x, p2.y - p1.y, p2.z - p1.z);

Point? GetCrossPoint(Point p, Point camera, Point? n, Vector3D? plane) {
  Vector3D VL = GetDirection(p, camera);
  Vector3D VP = plane ?? new Vector3D(0, 0, 1);

  double vp1 = VP.x, vp2 = VP.y, vp3 = VP.z;
  double v1 = VL.x, v2 = VL.y, v3 = VL.z;

  var t_base = vp1 * v1 + vp2 * v2 + vp3 * v3;
  if (t_base - 0 <= 0.00001)
    return null;
  else {
    n ??= new Point(0, 0, 0);

    double n1 = n.x, n2 = n.y, n3 = n.z;
    double p1 = p.x, p2 = p.y, p3 = p.z;

    double t_devide = (n1 - p1) * vp1 + (n2 - p2) * vp2 + (n3 - p3) * vp3;
    double t = t_devide / t_base;

    double x = p1 + v1 * t;
    double y = p2 + v2 * t;
    double z = p3 + v3 * t;

    return new Point(x, y, z);
  }
}
