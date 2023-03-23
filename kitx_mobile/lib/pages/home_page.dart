import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/pages/about_page.dart';
import 'package:kitx_mobile/pages/account_page.dart';
import 'package:kitx_mobile/pages/controls/drawer.dart';
import 'package:kitx_mobile/pages/device_page.dart';
import 'package:kitx_mobile/pages/settings_page.dart';
import 'package:kitx_mobile/pages/test_page.dart';

import 'package:kitx_mobile/utils/global.dart';

/// HomePage
class HomePage extends StatelessWidget {
  /// Constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // imageCache.clear(); // 清除图片缓存
    var tileRadius = ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0));
    const tilesPadding = 15.0;
    const pageOpenDelay = 200;

    return Scaffold(
      appBar: AppBar(
        title: Text('IndexPage_Title'.tr),
      ),
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 7 * 5,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: tilesPadding),
                Obx(
                  () => ListTile(
                    leading: const Icon(Icons.devices),
                    title: Text('Drawer_Devices'.tr),
                    subtitle: Text('${Global.deviceService.length.obs} ${'HomePage_DevicesCount'.tr}'),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => Global.delay(() => Get.to(() => DevicePage()), pageOpenDelay),
                    onLongPress: () {
                      showMenu(
                        context: context,
                        position: RelativeRect.fromLTRB(100, 100, 0, 0),
                        items: [
                          PopupMenuItem(
                            child: Text('Option_RestartDevicesServer'.tr),
                            onTap: Global.restartDevicesServer,
                          ),
                          PopupMenuItem(
                            child: Text('Option_ShutdownDevicesServer'.tr),
                            onTap: Global.shutdownDevicesServer,
                          ),
                        ],
                        elevation: 8.0,
                      );
                    },
                  ),
                ),
                const SizedBox(height: tilesPadding),
                ListTile(
                  leading: const Icon(Icons.alternate_email),
                  title: Text('Drawer_Account'.tr),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Global.delay(() => Get.to(() => AccountPage()), pageOpenDelay),
                ),
                const SizedBox(height: tilesPadding),
                ListTile(
                  leading: const Icon(Icons.bug_report),
                  title: Text('Drawer_Test'.tr),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Global.delay(() => Get.to(() => TestPage()), pageOpenDelay),
                ),
                const SizedBox(height: tilesPadding),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text('Drawer_Setting'.tr),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Global.delay(() => Get.to(() => SettingsPage()), pageOpenDelay),
                ),
                const SizedBox(height: tilesPadding),
                Obx(
                  () => ListTile(
                    leading: const Icon(Icons.info_outline_rounded),
                    title: Text('Drawer_About'.tr),
                    subtitle: Text(Global.versionString.value),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => Global.delay(() => Get.to(() => AboutPage()), pageOpenDelay),
                  ),
                ),
                const SizedBox(height: tilesPadding),
                const SizedBox(height: 300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
