import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/controls/settings_group_title.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/pages/settings_pages/appearance_settings_page.dart';
import 'package:kitx_mobile/pages/settings_pages/log_settings_page.dart';
import 'package:kitx_mobile/pages/test_pages/device_info_test.dart';
import 'package:kitx_mobile/pages/test_pages/device_sensors.dart';
import 'package:kitx_mobile/pages/test_pages/network_info_test.dart';
import 'package:kitx_mobile/utils/composer.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/handlers/tasks/delayed_task.dart';
import 'package:kitx_mobile/utils/handlers/vibration_handler.dart';

/// Settings Page
class SettingsPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/settings';

  /// Get Page
  static Widget Function() getPage() => () => const SettingsPage();

  /// Constructor
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var tileRadius = ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0));

  void showSnackBar(Widget content, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: content,
      showCloseIcon: true,
      duration: duration ?? Duration(milliseconds: 400),
    ));
  }

  void saveChanges(BuildContext context) {
    config.saveAsync().then(
          (value) => showSnackBar(Text('SettingsPage_Saved'.tr)),
        );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsPage_Title'.tr),
        actions: [
          PopupMenuButton(
            tooltip: '',
            padding: EdgeInsets.all(0),
            icon: const Icon(Icons.translate),
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('简体中文'),
                onTap: () => () {
                  instances.appInfo.languageCodeProperty = 'zh-CN';
                  saveChanges(context);
                }.delay(milliseconds: 200).execute(),
              ),
              PopupMenuItem(
                child: const Text('English (US)'),
                onTap: () => () {
                  instances.appInfo.languageCodeProperty = 'en-US';
                  saveChanges(context);
                }.delay(milliseconds: 200).execute(),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_General'),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.color_lens),
                    title: Text('SettingsPage_Appearance'.tr),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => (() => Get.toNamed(AppearanceSettingsPage.getRoute())).tryVibrate().call(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.notes),
                    title: Text('SettingsPage_Log'.tr),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => (() => Get.toNamed(LogSettingsPage.getRoute())).tryVibrate().call(),
                  ),
                ),
              ],
            ),
            const SizedBox(),
            spacer: null,
          ),
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_Test'),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.devices),
                    title: Text('Device Info'.tr),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => (() => Get.toNamed(DeviceInfoTestPage.getRoute())).tryVibrate().call(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.sensors),
                    title: Text('Device Sensors'.tr),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => (() => Get.toNamed(DeviceSensorsPage.getRoute())).tryVibrate().call(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: ListTile(
                    leading: const Icon(Icons.wifi),
                    title: Text('Network Info'.tr),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => (() => Get.toNamed(NetworkInfoTestPage.getRoute())).tryVibrate().call(),
                  ),
                ),
              ],
            ),
            const SizedBox(),
            spacer: null,
          ),
          const SizedBox(height: 300),
        ],
      ),
    );
  }
}
