import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/controls/device_status_label.dart';
import 'package:kitx_mobile/pages/controls/home_page_drawer.dart';
import 'package:kitx_mobile/pages/pages.dart';

/// HomePage
class HomePage extends StatelessWidget {
  /// Constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IndexPage_Title'.tr),
      ),
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 7 * 5,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            OrientationBuilder(
              builder: (context, _) => MediaQuery.of(context).orientation == Orientation.portrait
                  ? ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: getContent(
                        context,
                        MediaQuery.of(context).size.width - 40,
                        isLandscape: false,
                      ),
                    )
                  : Wrap(
                      children: getContent(
                        context,
                        (MediaQuery.of(context).size.width - 40) / 2,
                        isLandscape: true,
                      ),
                    ),
            ),
            const SizedBox(height: 300),
          ],
        ),
      ),
    );
  }

  /// Get Content
  List<Widget> getContent(BuildContext context, double tileWidth, {bool isLandscape = false}) {
    var tileRadius = ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0));

    const tilesPadding = 15.0;
    const pageOpenDelay = 200;

    return [
      const SizedBox(height: tilesPadding),
      SizedBox(
        width: tileWidth,
        child: ListTile(
          leading: const Icon(Icons.devices),
          title: Text('Drawer_Devices'.tr),
          subtitle: const Hero(
            tag: 'HeroTag_DevicesCount',
            child: const DeviceStatusLabel(),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right),
          shape: tileRadius,
          onTap: () => instances.taskHandler.delay(() => Get.to(() => const DevicePage()), pageOpenDelay),
          onLongPress: () {
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(100, 0, 0, 100),
              items: [
                PopupMenuItem(
                  child: Text('Option_RestartDevicesServer'.tr),
                  onTap: instances.restartDevicesServer,
                ),
                PopupMenuItem(
                  child: Text('Option_ShutdownDevicesServer'.tr),
                  onTap: instances.shutdownDevicesServer,
                ),
              ],
              elevation: 8.0,
            );
          },
        ),
      ),
      const SizedBox(height: tilesPadding),
      SizedBox(
        width: tileWidth,
        child: ListTile(
          leading: const Icon(Icons.alternate_email),
          title: Text('Drawer_Account'.tr),
          subtitle: isLandscape ? const Text('developing ...') : null,
          trailing: const Icon(Icons.keyboard_arrow_right),
          shape: tileRadius,
          onTap: () => instances.taskHandler.delay(() => Get.to(() => const AccountPage()), pageOpenDelay),
        ),
      ),
      const SizedBox(height: tilesPadding),
      SizedBox(
        width: tileWidth,
        child: ListTile(
          leading: const Icon(Icons.bug_report),
          title: Text('Drawer_Test'.tr),
          subtitle: isLandscape ? const Text('no new tests') : null,
          trailing: const Icon(Icons.keyboard_arrow_right),
          shape: tileRadius,
          onTap: () => instances.taskHandler.delay(() => Get.to(() => const TestPage()), pageOpenDelay),
        ),
      ),
      const SizedBox(height: tilesPadding),
      SizedBox(
        width: tileWidth,
        child: ListTile(
          leading: const Icon(Icons.settings),
          title: Text('Drawer_Setting'.tr),
          subtitle: isLandscape ? const Text('no notifications') : null,
          trailing: const Icon(Icons.keyboard_arrow_right),
          shape: tileRadius,
          onTap: () => instances.taskHandler.delay(() => Get.to(() => const SettingsPage()), pageOpenDelay),
        ),
      ),
      const SizedBox(height: tilesPadding),
      SizedBox(
        width: tileWidth,
        child: Obx(
          () => ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: Text('Drawer_About'.tr),
            subtitle: Text(instances.appInfo.versionString.value),
            trailing: const Icon(Icons.keyboard_arrow_right),
            shape: tileRadius,
            onTap: () => instances.taskHandler.delay(() => Get.to(() => const AboutPage()), pageOpenDelay),
          ),
        ),
      ),
      const SizedBox(height: tilesPadding),
    ];
  }
}
