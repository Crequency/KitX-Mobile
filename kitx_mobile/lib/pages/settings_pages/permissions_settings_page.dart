import 'package:cherrilog/cherrilog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kitx_mobile/models/permission_request_record.dart';
import 'package:kitx_mobile/pages/controls/settings_group_divider.dart';
import 'package:kitx_mobile/pages/controls/settings_group_title.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/utils/composer.dart';
import 'package:kitx_mobile/utils/handlers/permissions_handlers.dart';
import 'package:kitx_mobile/utils/handlers/vibration_handler.dart';
import 'package:permission_handler/permission_handler.dart';

/// Log Settings Page
class PermissionsSettingsPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/settings/permissions';

  /// Get Page
  static Widget Function() getPage() => () => const PermissionsSettingsPage();

  /// Constructor
  const PermissionsSettingsPage({Key? key}) : super(key: key);

  @override
  State<PermissionsSettingsPage> createState() => _PermissionsSettingsPageState();
}

class _PermissionsSettingsPageState extends State<PermissionsSettingsPage> {
  var logLevelRange = CherriLog.instance!.options.logLevelRange.obs;

  Widget getPermissionRequester(Permission permission) {
    Rx<Color?> statusColor = Rx(null);

    var fetchPermissionStatus = () {
      permission.status.then((value) {
        if (value.isGranted) {
          statusColor.value = Colors.greenAccent;
        } else if (value.isRestricted) {
          statusColor.value = Colors.orange;
        } else if (value.isDenied) {
          statusColor.value = Colors.redAccent;
        }
      });
    };

    fetchPermissionStatus();

    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: ListTile(
        title: Obx(() => Text(permission.toString(), style: TextStyle(color: statusColor.value))),
        trailing: IconButton.outlined(
          onPressed: () {
            VibrationHandler.tryVibrate();

            requestPermission(permission).then(
              (result) {
                Get.snackbar(
                  "SettingsPage_Permissions_List_ReRequest".tr,
                  result.toString(),
                  snackPosition: SnackPosition.BOTTOM,
                  margin: EdgeInsets.all(20),
                  icon: Icon(Icons.task_alt_rounded, color: result ? Colors.greenAccent : Colors.redAccent),
                  duration: const Duration(milliseconds: 600),
                  animationDuration: const Duration(milliseconds: 300),
                );

                fetchPermissionStatus();
              },
            );
          },
          icon: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  Widget getPermissionRequestRecordDisplayStand(PermissionRequestRecord record) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Text(
              record.permission.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 10),
            child: Row(
              children: [
                Expanded(child: const SizedBox()),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(record.requestTime),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsPage_Permissions'.tr),
        forceMaterialTransparency: true,
      ),
      body: ListView(
        children: [
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_Permissions_List'),
            Column(
              children: [
                for (var bundle in permissionsMap)
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            bundle.descriptionKey.tr,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        for (var permission in bundle.permissions)
                          Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: getPermissionRequester(permission),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            const SettingsGroupDivider(),
          ),
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_Permissions_RequestLog'),
            Column(
              children: [
                for (var record in requestedPermissions.take(3)) getPermissionRequestRecordDisplayStand(record),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    VibrationHandler.tryVibrate();

                    Get.to(
                      Scaffold(
                        appBar: AppBar(
                          title: Text('SettingsPage_Permissions_RequestLog'.tr),
                          forceMaterialTransparency: true,
                        ),
                        body: ListView(
                          children: [
                            const SizedBox(height: 20),
                            for (var record in requestedPermissions) getPermissionRequestRecordDisplayStand(record),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.open_in_new_rounded),
                  label: Text("Public_More".tr),
                ),
              ],
            ),
            const SettingsGroupDivider(),
          ),
        ],
      ),
    );
  }
}
