import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:kitx_mobile/utils/emulators/rotation_emulator.dart';
import 'package:vector_math/vector_math.dart';

void main() {
  group('rotateVector', () {
    test('rotates about Z following the standard q·v·q⁻¹ convention', () {
      final q = Quaternion.axisAngle(Vector3(0, 0, 1), pi / 2);
      final result = rotateVector(q, Vector3(1, 0, 0));

      expect(result.x, closeTo(0, 1e-6));
      expect(result.y, closeTo(1, 1e-6));
      expect(result.z, closeTo(0, 1e-6));
    });

    test('leaves the rotation axis itself untouched', () {
      final q = Quaternion.axisAngle(Vector3(1, 0, 0), pi / 3);
      final result = rotateVector(q, Vector3(1, 0, 0));

      expect(result.x, closeTo(1, 1e-6));
      expect(result.y, closeTo(0, 1e-6));
      expect(result.z, closeTo(0, 1e-6));
    });

    test('is opposite to vector_math built-in rotate, which computes q⁻¹·v·q', () {
      final q = Quaternion.axisAngle(Vector3(0, 0, 1), pi / 2);

      expect(rotateVector(q, Vector3(1, 0, 0)).y, closeTo(1, 1e-6));
      expect(q.rotated(Vector3(1, 0, 0)).y, closeTo(-1, 1e-6));
    });
  });

  group('DeviceRotationHost', () {
    setUp(DeviceRotationHost.restore);

    test('starts facing the camera', () {
      final n = DeviceRotationHost.normal;

      expect(n.x, closeTo(0, 1e-6));
      expect(n.y, closeTo(0, 1e-6));
      expect(n.z, closeTo(1, 1e-6));
      expect(DeviceRotationHost.isBackFacing, isFalse);
    });

    test('becomes back facing after integrating 180° about X', () {
      // π rad/s × 0.01 s × 100 帧 = π rad = 180°
      for (var i = 0; i < 100; i++) {
        DeviceRotationHost.rotateWithGyroscope(pi, 0, 0, 0.01);
      }

      expect(DeviceRotationHost.normal.z, closeTo(-1, 1e-6));
      expect(DeviceRotationHost.isBackFacing, isTrue);
    });

    test('normal is perpendicular to the camera after integrating 90° about X', () {
      for (var i = 0; i < 50; i++) {
        DeviceRotationHost.rotateWithGyroscope(pi, 0, 0, 0.01);
      }

      expect(DeviceRotationHost.normal.z, closeTo(0, 1e-6));
    });

    test('stays front facing when rotating about Z (screen normal is the Z axis)', () {
      for (var i = 0; i < 50; i++) {
        DeviceRotationHost.rotateWithGyroscope(0, 0, pi, 0.01);
      }

      expect(DeviceRotationHost.normal.z, closeTo(1, 1e-6));
      expect(DeviceRotationHost.isBackFacing, isFalse);
    });

    test('keeps the orientation a unit quaternion under sustained input', () {
      for (var i = 0; i < 500; i++) {
        DeviceRotationHost.rotateWithGyroscope(1.7, -2.3, 0.9, 0.01);
      }

      expect(DeviceRotationHost.orientation.length, closeTo(1, 1e-6));
    });

    test('restore resets the orientation', () {
      // π rad/s × 1 s = π rad = 180°，足以让机身翻到背面
      DeviceRotationHost.rotateWithGyroscope(pi, 0, 0, 1.0);
      expect(DeviceRotationHost.isBackFacing, isTrue);

      DeviceRotationHost.restore();

      expect(DeviceRotationHost.isBackFacing, isFalse);
      expect(DeviceRotationHost.normal.z, closeTo(1, 1e-6));
    });

    test('a full turn about Z brings a point back without drift', () {
      DeviceRotationHost.setPoints([Vector3(0, 10, 0)]);
      final start = DeviceRotationHost.transform(Vector3(0, 10, 0));

      // 2π rad/s × 0.01 s × 100 帧 = 2π rad = 一整圈
      for (var i = 0; i < 100; i++) {
        DeviceRotationHost.rotateWithGyroscope(0, 0, 2 * pi, 0.01);
      }

      final end = DeviceRotationHost.transform(Vector3(0, 10, 0));

      expect(end.x, closeTo(start.x, 1e-6));
      expect(end.y, closeTo(start.y, 1e-6));
      expect(end.z, closeTo(start.z, 1e-6));
    });

    test('absorbs a constant gyro bias while stationary', () {
      // 模拟静止时持续存在的零偏（0.005 rad/s，低于静止阈值 0.02）
      for (var i = 0; i < 400; i++) {
        DeviceRotationHost.rotateWithGyroscope(0.005, 0, 0, 0.05);
      }

      expect(DeviceRotationHost.gyroBias.x, closeTo(0.005, 1e-4));
      // 零偏被扣除后姿态不应明显漂移
      expect(DeviceRotationHost.normal.z, closeTo(1, 0.01));
    });

    test('does not treat real motion as bias', () {
      // 0.5 rad/s 远高于静止阈值，不应被当成零偏吸收
      for (var i = 0; i < 100; i++) {
        DeviceRotationHost.rotateWithGyroscope(0.5, 0, 0, 0.05);
      }

      expect(DeviceRotationHost.gyroBias.length, closeTo(0, 1e-6));
    });

    test('setPoints keeps the given object-space coordinates', () {
      DeviceRotationHost.setPoints([Vector3(1, 2, 3)]);

      expect(DeviceRotationHost.points.single.x, 1);
      expect(DeviceRotationHost.points.single.y, 2);
      expect(DeviceRotationHost.points.single.z, 3);
    });
  });

  group('getCrossPoint', () {
    test('projects a point lying on the z = 0 plane onto itself', () {
      final result = getCrossPoint(Vector3(67.5, 120, 0), Vector3(0, 0, 800), null, null);

      expect(result, isNotNull);
      expect(result!.x, closeTo(67.5, 1e-6));
      expect(result.y, closeTo(120, 1e-6));
      expect(result.z, closeTo(0, 1e-6));
    });

    test('drops a point behind the camera plane', () {
      expect(getCrossPoint(Vector3(0, 0, 900), Vector3(0, 0, 800), null, null), isNull);
    });
  });
}
