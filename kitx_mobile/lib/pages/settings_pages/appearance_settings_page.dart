import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/controls/settings_group_divider.dart';
import 'package:kitx_mobile/pages/controls/settings_group_title.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/utils/composer.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/themes/light_theme.dart';

/// Exterior Settings Page
class AppearanceSettingsPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/settings/exterior';

  /// Get Page
  static Widget Function() getPage() => () => const AppearanceSettingsPage();

  /// Constructor
  const AppearanceSettingsPage({Key? key}) : super(key: key);

  @override
  State<AppearanceSettingsPage> createState() => _AppearanceSettingsPageState();
}

class _AppearanceSettingsPageState extends State<AppearanceSettingsPage> {
  var selectedModes = <ThemeMode>{instances.appInfo.themeMode};
  var useMaterial3 = lightThemeData.value.useMaterial3.obs;

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
        title: Text('SettingsPage_Appearance'.tr),
      ),
      body: ListView(
        children: [
          group(
            SettingsGroupTitle(titleKey: 'SettingsPage_Appearance_Theme'),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: SegmentedButton<ThemeMode>(
                    emptySelectionAllowed: false,
                    multiSelectionEnabled: false,
                    segments: <ButtonSegment<ThemeMode>>[
                      ButtonSegment<ThemeMode>(
                        value: ThemeMode.light,
                        label: Text('SettingsPage_Appearance_Theme_Light'.tr),
                        icon: Icon(Icons.light_mode),
                      ),
                      ButtonSegment<ThemeMode>(
                        value: ThemeMode.dark,
                        label: Text('SettingsPage_Appearance_Theme_Dark'.tr),
                        icon: Icon(Icons.dark_mode),
                      ),
                      ButtonSegment<ThemeMode>(
                        value: ThemeMode.system,
                        label: Text('SettingsPage_Appearance_Theme_FollowSystem'.tr),
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
                      instances.appInfo.themeModeProperty = newSelection.first,
                      // Global.themeMode = newSelection.first,
                      // Get.changeThemeMode(newSelection.first),
                      saveChanges(context),
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${'Public_Enable'.tr} Material 3'),
                      Obx(
                        () => Switch.adaptive(
                          value: useMaterial3.value,
                          onChanged: (selection) {
                            instances.appInfo.updateTheme(useMaterial3: selection);
                            useMaterial3.value = selection;
                            saveChanges(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SettingsGroupDivider(),
          ),
          group(
            SettingsGroupTitle(titleKey: 'Public_Animation'),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${'Public_Enable'.tr} ${'SettingsPage_Appearance_Animation_Additional'.tr}'),
                      Obx(
                        () => Switch.adaptive(
                          value: instances.appInfo.animationEnabled.value,
                          onChanged: (selection) {
                            instances.appInfo.animationEnabled.value = selection;
                            saveChanges(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${'Public_Enable'.tr} ${'SettingsPage_Appearance_Animation_OpenPageDelay'.tr}'),
                      Obx(
                        () => Switch.adaptive(
                          value: config.delayOpenPageInHomePage.value,
                          onChanged: (selection) {
                            config.delayOpenPageInHomePage.value = selection;
                            saveChanges(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SettingsGroupDivider(),
            spacer: null,
          ),
          const SizedBox(height: 300),
        ],
      ),
    );
  }
}
