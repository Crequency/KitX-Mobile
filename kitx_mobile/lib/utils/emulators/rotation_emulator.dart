import 'dart:math';

import 'package:vector_math/vector_math.dart';

/// 直线与平面视为平行时的分母阈值
const double parallelEpsilon = 1e-5;

/// 判定陀螺仪处于静止的角速度阈值（rad/s）
const double gyroStationaryThreshold = 0.02;

/// 零偏估计的时间常数（s）
const double gyroBiasTimeConstant = 2.0;

/// 从 [p1] 指向 [p2] 的方向向量
Vector3 getDirection(Vector3 p1, Vector3 p2) => Vector3(p2.x - p1.x, p2.y - p1.y, p2.z - p1.z);

/// 求直线与平面的交点
///
/// 本项目的透视投影就是它：从被摄点朝摄像机连线，与 z = 0 平面求交。
/// [p] 为直线上一点，[camera] 为直线上另一点（摄像机位置），
/// [n] 为平面上一点（默认原点），[plane] 为平面法向量（默认 (0, 0, 1)）。
///
/// 分母为 0 表示直线与平面平行；分母为负表示交点落在摄像机背面（被摄点已越过
/// 摄像机所在平面），两种情况都无法成像，因此返回 null，由调用方决定线段取舍。
Vector3? getCrossPoint(Vector3 p, Vector3 camera, Vector3? n, Vector3? plane) {
  final vL = getDirection(p, camera);
  final vP = plane ?? Vector3(0, 0, 1);

  final denominator = vP.x * vL.x + vP.y * vL.y + vP.z * vL.z;

  if (denominator <= parallelEpsilon) return null;

  final origin = n ?? Vector3(0, 0, 0);
  final numerator = (origin.x - p.x) * vP.x + (origin.y - p.y) * vP.y + (origin.z - p.z) * vP.z;
  final t = numerator / denominator;

  return Vector3(p.x + vL.x * t, p.y + vL.y * t, p.z + vL.z * t);
}

/// 用单位四元数 [q] 旋转向量 [v]，即 `v' = q · v · q⁻¹`
///
/// 采用展开后的等价形式 `v + 2w(q_vec × v) + 2(q_vec × (q_vec × v))`，
/// 全程只用叉乘与数乘，不构造矩阵。
///
/// 注意不能直接用 vector_math 的 [Quaternion.rotate]：它按 `q⁻¹ · v · q` 计算，
/// 方向与这里采用的标准约定正好相反。
Vector3 rotateVector(Quaternion q, Vector3 v) {
  final axis = Vector3(q.x, q.y, q.z);
  final t = axis.cross(v)..scale(2.0);

  return v + t * q.w + axis.cross(t);
}

/// 机身姿态宿主
///
/// 维护一个姿态四元数（物体坐标系 → 世界坐标系），每帧由陀螺仪读数推进，
/// 再把固定的物体坐标系点集映射到世界坐标系。
///
/// 关键点是「姿态」与「点集」分离：点始终保存在物体坐标系，每帧都从原始位置
/// 重新变换一次，而不是把增量反复累乘到点上。这样既不会累积浮点误差，也不存在
/// 逐轴顺序叠加带来的路径依赖。
class DeviceRotationHost {
  /// 当前姿态（单位四元数）
  static Quaternion _orientation = Quaternion.identity();

  /// 陀螺仪零偏估计（rad/s）
  static Vector3 _gyroBias = Vector3(0, 0, 0);

  /// 物体坐标系下的点集
  static List<Vector3> points = [];

  /// 当前姿态
  static Quaternion get orientation => _orientation.clone();

  /// 当前陀螺仪零偏估计（rad/s）
  static Vector3 get gyroBias => _gyroBias.clone();

  /// 机身所在平面的法向量（世界坐标系）
  ///
  /// 初始为 (0, 0, 1)，即正面朝向摄像机。
  static Vector3 get normal => rotateVector(_orientation, Vector3(0, 0, 1));

  /// 机身是否背面朝向摄像机
  ///
  /// 摄像机位于 (0, 0, z) 且 z > 0、物体中心在原点，于是
  /// `n · (摄像机 − 物体中心) = n.z · z`，符号与 n.z 完全一致，判据即 `n.z < 0`。
  ///
  /// 旧实现用 `|pitch| > 90 || |roll| > 90` 近似判断，在两个角同时越过 ±90° 时会误判。
  static bool get isBackFacing => normal.z < 0;

  /// 由一帧陀螺仪读数构造增量旋转四元数（机体坐标系）
  ///
  /// [gyroX]、[gyroY]、[gyroZ] 为角速度，单位 rad/s；[samplingRate] 为采样周期，单位 s。
  /// 三个轴向的增量合成**一次**旋转，而不是逐轴依次施加。
  static Quaternion deltaFromGyroscope(double gyroX, double gyroY, double gyroZ, double samplingRate) {
    final qx = Quaternion.axisAngle(Vector3(1, 0, 0), gyroX * samplingRate);
    final qy = Quaternion.axisAngle(Vector3(0, 1, 0), gyroY * samplingRate);
    final qz = Quaternion.axisAngle(Vector3(0, 0, 1), gyroZ * samplingRate);

    return qy * qx * qz;
  }

  /// 用一帧陀螺仪读数推进姿态
  ///
  /// 增量四元数**右乘**到当前姿态上，表示绕**机体轴**旋转（陀螺仪输出的正是机体
  /// 坐标系角速度）；随后归一化以抑制浮点漂移。
  static void rotateWithGyroscope(double gyroX, double gyroY, double gyroZ, double samplingRate) {
    // 注意全程用 double 计算：vector_math 的 Vector3 是 float32，
    // 若把角速度先塞进 Vector3 再取出来，积分精度会明显下降。
    final magnitude = sqrt(gyroX * gyroX + gyroY * gyroY + gyroZ * gyroZ);

    // MEMS 陀螺仪静止时输出并不为 0，直接积分会让姿态缓慢漂移。
    // 读数低于静止阈值时，按时间常数缓慢把零偏估计拉向当前读数。
    if (magnitude < gyroStationaryThreshold) {
      final adapt = 1 - exp(-samplingRate / gyroBiasTimeConstant);
      _gyroBias = Vector3(
        _gyroBias.x * (1 - adapt) + gyroX * adapt,
        _gyroBias.y * (1 - adapt) + gyroY * adapt,
        _gyroBias.z * (1 - adapt) + gyroZ * adapt,
      );
    }

    final delta = deltaFromGyroscope(
      gyroX - _gyroBias.x,
      gyroY - _gyroBias.y,
      gyroZ - _gyroBias.z,
      samplingRate,
    );

    _orientation = (_orientation * delta).normalized();
  }

  /// 把物体坐标系下的点（或向量）映射到世界坐标系
  static Vector3 transform(Vector3 value) => rotateVector(_orientation, value);

  /// 设置物体坐标系点集
  static void setPoints(List<Vector3> newPoints) {
    points = newPoints.map((e) => e.clone()).toList();
  }

  /// 复位姿态与零偏估计
  ///
  /// 对应界面上的长按操作：把机身朝向恢复到正对摄像机，并重新开始零偏收敛。
  static void restore() {
    _orientation = Quaternion.identity();
    _gyroBias = Vector3(0, 0, 0);
  }
}
