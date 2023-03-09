import 'dart:io';

import 'package:f_logs/f_logs.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:kitx_mobile/converters/size_converter.dart';

import 'package:kitx_mobile/themes/light_theme.dart';

import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/global.dart';

/// Settings Page
class SettingsPage extends StatefulWidget {
  // ignore: public_member_api_docs
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var selectedModes = <ThemeMode>{Global.themeModeNotifier.value};
  var logFilePath = '/data/data/com.crequency.kitx.kitx_mobile/app_flutter/flog.db';

  var useMaterial3 = lightThemeData.value.useMaterial3.obs;
  var logFileSizeString = 'getting ...'.obs;

  void updateLogFileSizeString() {
    var file = File(logFilePath);
    if (file.existsSync()) {
      logFileSizeString.value = convert2string(file.lengthSync());
    } else {
      logFileSizeString.value = 'File $logFilePath don\'t exists';
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
      ),
      body: ListView(
        children: [
          SizedBox(height: 60 * 3),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              'SettingsPage_Theme'.tr,
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 30),
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
                Global.themeModeNotifier.value = newSelection.first,
                saveChanges(context),
              },
            ),
          ),
          SizedBox(height: 30),
          Divider(),
          SizedBox(height: 60),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: const Text(
              'Material Design',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${'Public_Enable'.tr} Material 3'),
              Obx(
                () => Checkbox(
                  value: useMaterial3.value,
                  onChanged: (selection) {
                    if (selection != null) {
                      Global.updateTheme(useMaterial3: selection);
                      useMaterial3.value = selection;
                      saveChanges(context);
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Divider(),
          SizedBox(height: 60),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              'Public_Animation'.tr,
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 30),
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
          SizedBox(height: 30),
          Divider(),
          SizedBox(height: 60),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              'Public_Log'.tr,
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3 * 2,
                child: Obx(() => Text(logFileSizeString.value)),
              ),
              SizedBox(width: 10),
              IconButton(
                onPressed: updateLogFileSizeString,
                icon: Icon(Icons.refresh),
              )
            ],
          ),
          SizedBox(height: 30),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                Global.delay(() async {
                  var file = File(logFilePath);
                  var beforeSize = file.lengthSync();
                  var beforeSizeString = convert2string(beforeSize);

                  await FLog.clearLogs();

                  file = File(logFilePath);
                  var nowSize = file.lengthSync();
                  var nowSizeString = convert2string(nowSize);

                  updateLogFileSizeString();
                  showSnackBar(Text('$beforeSizeString -> $nowSizeString'));
                }, 200);
              },
              child: Text('SettingsPage_CleanLog'.tr),
            ),
          ),
          SizedBox(height: 30),
          Divider(),
          SizedBox(height: 60),
          SizedBox(height: 300),
        ],
      ),
    );
  }
}
