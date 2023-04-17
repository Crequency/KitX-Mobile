import 'package:permission_handler/permission_handler.dart';

/// Request Permission
Future<bool> requestPermission(Permission target) async {
  var status = await Permission.location.status;
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
  ]);

  if (result.every((element) => element)) {
    return true;
  } else {
    return false;
  }
}
