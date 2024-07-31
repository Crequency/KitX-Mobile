import 'package:cherrilog/cherrilog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/controls/settings_group_divider.dart';
import 'package:kitx_mobile/pages/controls/settings_group_title.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/utils/composer.dart';
import 'package:kitx_mobile/utils/handlers/vibration_handler.dart';

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
  var logLevelRange = CherriLog.instance!.options.logLevelRange.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SettingsPage_Log'.tr),
        forceMaterialTransparency: true,
      ),
      body: ListView(
        children: [
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_Log'),
            Column(
              children: [
                Text('SettingsPage_Log_SelectLevelRange'.tr),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                        () => DropdownButton<CherriLogLevel>(
                          value: logLevelRange.value.$1,
                          onTap: () => VibrationHandler.tryVibrate(),
                          onChanged: (newLevel) {
                            VibrationHandler.tryVibrate();
                            CherriLog.instance = CherriLog.instance!
                              ..withOptions(
                                CherriLog.instance!.options..logLevelRange = (newLevel!, logLevelRange.value.$2),
                              )
                              ..logTo(CherriLog.instance!.logger);
                            logLevelRange.value = CherriLog.instance!.options.logLevelRange;
                            SettingsPage.saveChanges();
                          },
                          items: CherriLogLevel.order
                              .where((e) => e.name != CherriLogLevel.nether.name && e.name != CherriLogLevel.upperBond.name)
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text("SettingsPage_Log_Level_${e.name}".tr),
                                  value: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: const Icon(Icons.compare_arrows)),
                      Obx(
                        () => DropdownButton<CherriLogLevel>(
                          value: logLevelRange.value.$2,
                          onTap: () => VibrationHandler.tryVibrate(),
                          onChanged: (newLevel) {
                            VibrationHandler.tryVibrate();
                            CherriLog.instance = CherriLog.instance!
                              ..withOptions(
                                CherriLog.instance!.options..logLevelRange = (logLevelRange.value.$1, newLevel!),
                              )
                              ..logTo(CherriLog.instance!.logger);
                            logLevelRange.value = CherriLog.instance!.options.logLevelRange;
                            SettingsPage.saveChanges();
                          },
                          items: CherriLogLevel.order
                              .where((e) => e.name != CherriLogLevel.nether.name && e.name != CherriLogLevel.upperBond.name)
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Text("SettingsPage_Log_Level_${e.name}".tr),
                                  value: e,
                                ),
                              )
                              .toList(),
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
