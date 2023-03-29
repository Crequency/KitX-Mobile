import 'package:kitx_mobile/utils/log.dart';
import 'package:permission_handler/permission_handler.dart';

/// Request Location Permissions
Future<bool> requestLocationPermissions() async {
  Log.info('Checking Location permissions');

  var status = await Permission.location.status;

  // Blocked?
  if (status.isDenied || status.isRestricted) {
    // Ask the user to unblock
    if (await Permission.location.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      Log.info('Location permissions granted');
      return true;
    } else {
      Log.info('Location permissions not granted');
      return false;
    }
  } else {
    Log.info('Permission already granted (previous execution?)');
    return true;
  }
}
