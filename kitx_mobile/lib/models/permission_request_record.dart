import 'package:permission_handler/permission_handler.dart';

class PermissionRequestRecord {
  const PermissionRequestRecord({
    required this.permission,
    required this.requestTime,
  });

  final Permission permission;

  final DateTime requestTime;

  static PermissionRequestRecord now(Permission permission) => PermissionRequestRecord(permission: permission, requestTime: DateTime.now());
}
