import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/controls/settings_group_title.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/utils/composer.dart';
import 'package:kitx_mobile/utils/converters/size_converter.dart';

/// Log Settings Page
class LogSettingsPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/settings/log';

  /// Get Page
  static Widget Function() getPage() => () => const LogSettingsPage();

  /// Constructor
  const LogSettingsPage({Key? key}) : super(key: key);

  @override
  State<LogSettingsPage> createState() => _LogSettingsPageState();
}

class _LogSettingsPageState extends State<LogSettingsPage> {
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
      duration: duration ?? Duration(milliseconds: 400),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsPage_Log'.tr),
      ),
      body: ListView(
        children: [
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_Log'),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('SettingsPage_Log_Clean'.tr),
                  ),
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
                //             child: Text('SettingsPage_Log_Clean'.tr),
                //           ),
                //         ),
                //         const SizedBox(height: 30),
                //         ElevatedButton(onPressed: () {}, child: const Text('...')),
                //       ],
                //     ),
                //     const SettingsGroupDivider(),
                //     spacer: null,
                //   ),
              ],
            ),
            const SizedBox(),
          ),
        ],
      ),
    );
  }
}
