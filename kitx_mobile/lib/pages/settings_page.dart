import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../utils/global.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var selectedModes = <ThemeMode>{Global.themeMode};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SettingsPage_Title".tr),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: SegmentedButton<ThemeMode>(
              emptySelectionAllowed: false,
              multiSelectionEnabled: false,
              segments: <ButtonSegment<ThemeMode>>[
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text("SettingsPage_Light".tr),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text("SettingsPage_Dark".tr),
                  icon: Icon(Icons.dark_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text("SettingsPage_FollowSystem".tr),
                  icon: Icon(Icons.settings),
                ),
              ],
              selected: selectedModes,
              // selectedIcon: Icon(Icons.check),
              showSelectedIcon: false,
              onSelectionChanged: (Set<ThemeMode> newSelection) => {
                print(newSelection),
                setState(() {
                  selectedModes = newSelection;
                }),
                Global.themeMode = newSelection.first,
                Global.themeNotifier.value = Global.themeMode,
              },
            ),
          ),
        ],
      ),
    );
  }
}
