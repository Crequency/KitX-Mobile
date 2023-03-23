﻿import 'dart:io';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:kitx_mobile/converters/size_converter.dart';

import 'package:kitx_mobile/themes/light_theme.dart';

import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/global.dart';

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
  Widget build(BuildContext context){
    return Column(
      children: [
        SizedBox(height: 30),
        Divider(),
      ],
    );
  }
}

/// Settings Page
class SettingsPage extends StatefulWidget {
  // ignore: public_member_api_docs
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var selectedModes = <ThemeMode>{Global.themeMode};
  var logFilePath = '/data/data/com.crequency.kitx.mobile/app_flutter/flog.db';

  var useMaterial3 = lightThemeData.value.useMaterial3.obs;
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
    Config.saveAsync();

    showSnackBar(Text('SettingsPage_Saved'.tr));

    // var snackBar = SnackBar(
    //   content: Text('SettingsPage_Saved'.tr),
    //   // margin: EdgeInsets.all(30),
    //   // behavior: SnackBarBehavior.floating,
    //   showCloseIcon: true,
    //   duration: Duration(milliseconds: 1200),
    //   // animation: Animation,
    // );
    //
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                onTap: () => Global.delay(() => Get.updateLocale(Locale('zh', 'CN')), 200),
              ),
              PopupMenuItem(
                child: const Text('English (US)'),
                onTap: () => Global.delay(() => Get.updateLocale(Locale('en', 'US')), 200),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 60 * 3),
          SettingsGroupTitle(titleKey: 'SettingsPage_Theme'),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SegmentedButton<ThemeMode>(
              emptySelectionAllowed: false,
              multiSelectionEnabled: false,
              segments: <ButtonSegment<ThemeMode>>[
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text('SettingsPage_Light'.tr),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text('SettingsPage_Dark'.tr),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text('SettingsPage_FollowSystem'.tr),
                  icon: Icon(Icons.settings),
                ),
              ],
              selected: selectedModes,
              // selectedIcon: Icon(Icons.check),
              showSelectedIcon: false,
              onSelectionChanged: (Set<ThemeMode> newSelection) => {
                setState(() {
                  selectedModes = newSelection;
                }),
                Global.themeModeProperty = newSelection.first,
                // Global.themeMode = newSelection.first,
                // Get.changeThemeMode(newSelection.first),
                saveChanges(context),
              },
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${'Public_Enable'.tr} Material 3'),
              Obx(
                () => Checkbox(
                  value: useMaterial3.value,
                  onChanged: (selection) {
                    if (selection != null) {
                      // Get.changeTheme(Get.theme.copyWith(useMaterial3: selection));
                      Global.updateTheme(useMaterial3: selection);
                      useMaterial3.value = selection;
                      saveChanges(context);
                    }
                  },
                ),
              ),
            ],
          ),
          const SettingsGroupDivider(),
          SettingsGroupTitle(titleKey: 'Public_Animation'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${'Public_Enable'.tr} ${'Public_Additional'.tr} ${'Public_Animation'.tr}'),
              Obx(
                () => Checkbox(
                  value: Global.animationEnabled.value,
                  onChanged: (selection) {
                    if (selection != null) {
                      Global.animationEnabled.value = selection;
                      saveChanges(context);
                    }
                  },
                ),
              ),
            ],
          ),
          const SettingsGroupDivider(),
          SettingsGroupTitle(titleKey: 'Public_Log'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  curve: Curves.easeInOutCubic,
                  width: logFileExists.value ? null : MediaQuery.of(context).size.width / 3 * 2,
                  child: Text(logFileSizeString.value),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: updateLogFileSizeString,
                icon: Icon(Icons.refresh),
              )
            ],
          ),
          const SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () => Global.delay(() async {
                var beforeSize = 0;
                var beforeSizeString = convert2string(beforeSize);
                var nowSize = 0;
                var nowSizeString = convert2string(nowSize);

                var file = File(logFilePath);

                if (file.existsSync()) {
                  logFileExists.value = true;

                  beforeSize = file.lengthSync();
                  beforeSizeString = convert2string(beforeSize);
                }

                if (logFileExists.value) {
                  await FLog.clearLogs();
                } else {
                  FLog.clearLogs();
                }

                file = File(logFilePath);

                if (logFileExists.value) {
                  nowSize = file.lengthSync();
                  nowSizeString = convert2string(nowSize);
                }

                updateLogFileSizeString();

                if (logFileExists.value) {
                  showSnackBar(Text('$beforeSizeString -> $nowSizeString'));
                } else {
                  showSnackBar(Text('Log file clean action requested.'));
                }
              }, 200),
              child: Text('SettingsPage_CleanLog'.tr),
            ),
          ),
          const SettingsGroupDivider(),
          const SizedBox(height: 300),
        ],
      ),
    );
  }
}
