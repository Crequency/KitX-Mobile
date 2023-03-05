﻿// ignore_for_file: public_member_api_docs, non_constant_identifier_names

import 'dart:math';

const double pi = 3.1415926535897938324626433832795028841971;

class Doubles3D {
  var x = 0.0, y = 0.0, z = 0.0;
  Doubles3D(this.x, this.y, this.z);
}

class Point extends Doubles3D {
  Point(super.x, super.y, super.z);
}

class Vector3D extends Doubles3D {
  Vector3D(super.x, super.y, super.z);
}

Point Rotate(Point p, Doubles3D angles) => AllRotate(p, angles.x, angles.y, angles.z);

Point AllRotate(Point p, double yaw, double pitch, double roll) =>
    X_Rotate(Y_Rotate(Z_Rotate(p, yaw), pitch), roll);

Point X_Rotate(Point p, double alpha) {
  alpha *= pi / 180;
  return Point(cos(alpha) * p.x + sin(alpha) * p.z, p.y, -sin(alpha) * p.x + cos(alpha) * p.z);
}

Point Y_Rotate(Point p, double beta) {
  beta *= pi / 180;
  return Point(p.x, cos(beta) * p.y - sin(beta) * p.z, sin(beta) * p.y + cos(beta) * p.z);
}

Point Z_Rotate(Point p, double gamma) {
  gamma *= pi / 180;
  return Point(cos(gamma) * p.x - sin(gamma) * p.y, sin(gamma) * p.x + cos(gamma) * p.y, p.z);
}

Vector3D GetDirection(Point p1, Point p2) => Vector3D(p2.x - p1.x, p2.y - p1.y, p2.z - p1.z);

Point? GetCrossPoint(Point p, Point camera, Point? n, Vector3D? plane) {
  var VL = GetDirection(p, camera);
  var VP = plane ?? Vector3D(0, 0, 1);

  var vp1 = VP.x, vp2 = VP.y, vp3 = VP.z;
  var v1 = VL.x, v2 = VL.y, v3 = VL.z;

  var t_base = vp1 * v1 + vp2 * v2 + vp3 * v3;
  if (t_base - 0 <= 0.00001) {
    return null;
  } else {
    n ??= Point(0, 0, 0);

    var n1 = n.x, n2 = n.y, n3 = n.z;
    var p1 = p.x, p2 = p.y, p3 = p.z;

    var t_devide = (n1 - p1) * vp1 + (n2 - p2) * vp2 + (n3 - p3) * vp3;
    var t = t_devide / t_base;

    var x = p1 + v1 * t;
    var y = p2 + v2 * t;
    var z = p3 + v3 * t;

    return Point(x, y, z);
  }
}
