import 'package:flutter/foundation.dart';
import 'package:kitx_shared_dart/kitx_shared_dart.dart';

/// Device Info Extensions
extension DeviceInfoExtensions on DeviceInfo {
  /// Get Value Key
  ValueKey getValueKey() {
    return ValueKey('${device.deviceName} (${device.macAddress})');
  }
}
