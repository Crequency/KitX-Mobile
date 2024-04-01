import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/controls/settings_group_divider.dart';
import 'package:kitx_mobile/pages/controls/settings_group_title.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/utils/composer.dart';
import 'package:logger/logger.dart';

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
  var logLevel = Logger.level.obs;

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
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SettingsPage_Log_SelectLevel'.tr),
                      Obx(
                        () => DropdownButton<String>(
                          value: logLevel.value.name,
                          onChanged: (newLevel) {
                            // TODO: If new version of log lib removed deprecated member use, change this line
                            // ignore: deprecated_member_use
                            if (newLevel == Level.nothing.name || newLevel == Level.wtf.name || newLevel == Level.verbose.name) {
                              Get.snackbar(
                                'Public_Error'.tr,
                                'SettingsPage_Log_NotSupportedLevel'.trParams({'level': newLevel ?? 'null'}),
                                snackPosition: SnackPosition.BOTTOM,
                                margin: EdgeInsets.all(20),
                                icon: const Icon(Icons.error_outline_rounded, color: Colors.redAccent),
                                duration: const Duration(milliseconds: 1200),
                                animationDuration: const Duration(milliseconds: 300),
                              );
                              return;
                            }

                            Logger.level = Level.values.firstWhere((element) => element.name == newLevel);
                            logLevel.value = Logger.level;

                            SettingsPage.saveChanges();
                          },
                          items: Level.values.map<DropdownMenuItem<String>>((Level value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
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
