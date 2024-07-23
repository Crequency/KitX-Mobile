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

  Widget getPermissionRequestRecordDisplayStand(PermissionRequestRecord record) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
      ),
      body: ListView(
        children: [
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_Permissions_List'),
            const SizedBox(),
            const SettingsGroupDivider(),
          ),
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_Permissions_RequestLog'),
            Column(
              children: [
                for (var record in requestedPermissions.take(3)) getPermissionRequestRecordDisplayStand(record),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => Get.to(
                    Scaffold(
                      appBar: AppBar(
                        title: Text('SettingsPage_Permissions_RequestLog'.tr),
                      ),
                      body: ListView(
                        children: [
                          const SizedBox(height: 20),
                          for (var record in requestedPermissions) getPermissionRequestRecordDisplayStand(record),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
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
