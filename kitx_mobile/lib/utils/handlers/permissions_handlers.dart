import 'package:kitx_mobile/models/permission_request_record.dart';
import 'package:permission_handler/permission_handler.dart';

/// Requested Permissions List
final requestedPermissions = <PermissionRequestRecord>[];

/// Request Permission
Future<bool> requestPermission(Permission target) async {
  requestedPermissions.add(PermissionRequestRecord.now(target)); // To record the requested permission

  var status = await target.status;
  if (status.isDenied || status.isRestricted) {
    return target.request().isGranted;
  } else {
    return true;
  }
}

/// Request Permissions
Future<List<bool>> requestPermissions(List<Permission> targets) async {
  var rst = <bool>[];
  for (var element in targets) {
    rst.add(await requestPermission(element));
  }
  return rst;
}

/// Request Network Related Permissions
Future<bool> requestNetworkRelatedPermissions() async {
  var result = await requestPermissions([
    Permission.location,
    Permission.bluetooth,
    Permission.bluetoothConnect,
  ]);

  if (result.every((element) => element)) {
    return true;
  } else {
    return false;
  }
}

/// Request Notification Permission
Future<bool> requestNotificationPermission() async {
  var result = await requestPermission(Permission.notification);

  return result;
}
