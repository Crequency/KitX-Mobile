import 'package:permission_handler/permission_handler.dart';

/// A record of a single permission request and the moment it happened.
class PermissionRequestRecord {
  /// Constructor
  const PermissionRequestRecord({
    required this.permission,
    required this.requestTime,
  });

  /// The permission that was requested.
  final Permission permission;

  /// When the permission was requested.
  final DateTime requestTime;

  /// Create a record for [permission] timestamped with the current time.
  static PermissionRequestRecord now(Permission permission) => PermissionRequestRecord(permission: permission, requestTime: DateTime.now());
}
