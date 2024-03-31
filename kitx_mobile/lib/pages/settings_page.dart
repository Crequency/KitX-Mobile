import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/pages/settings_pages/exterior_settings_page.dart';
import 'package:kitx_mobile/pages/test_pages/device_info_test.dart';
import 'package:kitx_mobile/pages/test_pages/device_sensors.dart';
import 'package:kitx_mobile/pages/test_pages/network_info_test.dart';
import 'package:kitx_mobile/utils/composer.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/converters/size_converter.dart';
import 'package:kitx_mobile/utils/handlers/tasks/delayed_task.dart';
import 'package:kitx_mobile/utils/handlers/vibration_handler.dart';

/// Settings Group Title
class SettingsGroupTitle extends StatelessWidget {
  /// Constructor
  const SettingsGroupTitle({required this.titleKey, super.key});

  /// Title Key
  final String titleKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            titleKey.tr,
            style: TextStyle(fontSize: 28),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

/// Settings Group Divider
class SettingsGroupDivider extends StatelessWidget {
  /// Constructor
  const SettingsGroupDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        Divider(),
      ],
    );
  }
}

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

  var logFilePath = '/data/data/com.crequency.kitx.mobile/app_flutter/flog.db';

  var logFileSizeString = 'getting ...'.obs;
  var logFileExists = false.obs;

  void updateLogFileSizeString() {
    var file = File(logFilePath);
    if (file.existsSync()) {
      logFileSizeString.value = convert2string(file.lengthSync());
      logFileExists.value = true;
    } else {
      logFileSizeString.value = 'File $logFilePath don\'t exists';
      logFileExists.value = false;
    }
  }

  void showSnackBar(Widget content, {Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: content,
      showCloseIcon: true,
      duration: duration ?? Duration(milliseconds: 1200),
    ));
  }

  void saveChanges(BuildContext context) {
    config.saveAsync().then(
          (value) => showSnackBar(Text('SettingsPage_Saved'.tr)),
        );
  }

  @override
  void initState() {
    updateLogFileSizeString();

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
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.color_lens),
              title: Text('SettingsPage_Theme'.tr),
              trailing: const Icon(Icons.keyboard_arrow_right),
              shape: tileRadius,
              onTap: () => (() => Get.toNamed(ExteriorSettingsPage.getRoute())).tryVibrate().call(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.notes),
              title: Text('Public_Log'.tr),
              trailing: const Icon(Icons.keyboard_arrow_right),
              shape: tileRadius,
              onTap: () => (() => {}).tryVibrate().call(),
            ),
          ),
          group(
            SettingsGroupTitle(titleKey: 'Drawer_Test'.tr),
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
          //   group(
          //     SettingsGroupTitle(titleKey: 'Public_Log'),
          //     Column(
          //       children: [
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Obx(
          //               () => AnimatedContainer(
          //                 duration: Duration(milliseconds: 700),
          //                 curve: Curves.easeInOutCubic,
          //                 width: logFileExists.value ? null : MediaQuery.of(context).size.width / 3 * 2,
          //                 child: Text(logFileSizeString.value),
          //               ),
          //             ),
          //             const SizedBox(width: 10),
          //             IconButton(
          //               onPressed: updateLogFileSizeString,
          //               icon: Icon(Icons.refresh),
          //             )
          //           ],
          //         ),
          //         const SizedBox(height: 30),
          //         Container(
          //           alignment: Alignment.center,
          //           child: ElevatedButton(
          //             onPressed: () async {
          //               var beforeSize = 0;
          //               var beforeSizeString = convert2string(beforeSize);
          //               var nowSize = 0;
          //               var nowSizeString = convert2string(nowSize);

          //               var file = File(logFilePath);

          //               if (file.existsSync()) {
          //                 logFileExists.value = true;

          //                 beforeSize = file.lengthSync();
          //                 beforeSizeString = convert2string(beforeSize);
          //               }

          //               if (logFileExists.value) {
          //                 await FLog.clearLogs();
          //               } else {
          //                 FLog.clearLogs();
          //               }

          //               file = File(logFilePath);

          //               if (logFileExists.value) {
          //                 nowSize = file.lengthSync();
          //                 nowSizeString = convert2string(nowSize);
          //               }

          //               updateLogFileSizeString();

          //               if (logFileExists.value) {
          //                 showSnackBar(Text('$beforeSizeString -> $nowSizeString'));
          //               } else {
          //                 showSnackBar(Text('Log file clean action requested.'));
          //               }
          //             }.delay(milliseconds: 200).execute,
          //             child: Text('SettingsPage_CleanLog'.tr),
          //           ),
          //         ),
          //         const SizedBox(height: 30),
          //         ElevatedButton(onPressed: () {}, child: const Text('...')),
          //       ],
          //     ),
          //     const SettingsGroupDivider(),
          //     spacer: null,
          //   ),
          const SizedBox(height: 300),
        ],
      ),
    );
  }
}
