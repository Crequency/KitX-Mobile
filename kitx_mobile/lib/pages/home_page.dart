import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/controls/device_status_label.dart';
import 'package:kitx_mobile/pages/controls/home_page_drawer.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/pages/plugins_page.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/handlers/tasks/delayed_task.dart';
import 'package:kitx_mobile/utils/handlers/vibration_handler.dart';

/// HomePage
class HomePage extends StatelessWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/';

  /// Get Page
  static Widget Function() getPage() => () => const HomePage();

  /// Constructor
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IndexPage_Title'.tr),
      ),
      drawer: HomePageDrawer(),
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
                      physics: const NeverScrollableScrollPhysics(),
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

    const tileEnterDelay = Duration(milliseconds: 350);
    const tileEnterCurve = Curves.easeInOutCubic;

    const maxTilesCount = 5;

    var enteringTileIndex = 0.obs;

    var tileEnterPad = 300.0;
    var tileEnterPadFuture = 40.0;

    if (instances.appInfo.animationEnabled.value) {
      Future.doWhile(() async {
        await Future.delayed(Duration(milliseconds: tileEnterPad.round()));
        enteringTileIndex.value++;
        tileEnterPad -= enteringTileIndex.value * tileEnterPadFuture;
        tileEnterPadFuture -= enteringTileIndex.value * 7.5;
        return enteringTileIndex.value <= maxTilesCount;
      });
    } else {
      enteringTileIndex.value = maxTilesCount;
    }

    return [
      Obx(
        () => AnimatedContainer(
          duration: tileEnterDelay,
          curve: tileEnterCurve,
          height: enteringTileIndex.value >= 1 ? tilesPadding : 400,
          width: 0,
        ),
      ),
      SizedBox(
        width: tileWidth,
        child: Obx(
          () => AnimatedOpacity(
            opacity: enteringTileIndex.value >= 1 ? 1.0 : 0.0,
            duration: tileEnterDelay,
            curve: tileEnterCurve,
            child: ListTile(
              leading: const Icon(Icons.devices),
              title: Text('Drawer_Devices'.tr),
              subtitle: const Hero(
                tag: 'HeroTag_DevicesCount',
                child: const DeviceStatusLabel(),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right),
              shape: tileRadius,
              onTap: () => (() => Get.toNamed(DevicesPage.getRoute())).tryVibrate().delay(milliseconds: config.delayOpenPageInHomePage.value ? pageOpenDelay : 0).execute(),
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
        ),
      ),
      Obx(
        () => AnimatedContainer(
          duration: tileEnterDelay,
          curve: tileEnterCurve,
          height: enteringTileIndex.value >= 2 ? tilesPadding : 200,
          width: 0,
        ),
      ),
      SizedBox(
        width: tileWidth,
        child: Obx(
          () => AnimatedOpacity(
            opacity: enteringTileIndex.value >= 2 ? 1.0 : 0.0,
            duration: tileEnterDelay,
            curve: tileEnterCurve,
            child: ListTile(
              leading: const Icon(Icons.layers),
              title: Text('Drawer_Plugins'.tr),
              subtitle: isLandscape ? const Text('developing ...') : null,
              trailing: const Icon(Icons.keyboard_arrow_right),
              shape: tileRadius,
              onTap: () => (() => Get.toNamed(PluginsPage.getRoute())).tryVibrate().delay(milliseconds: config.delayOpenPageInHomePage.value ? pageOpenDelay : 0).execute(),
            ),
          ),
        ),
      ),
      Obx(
        () => AnimatedContainer(
          duration: tileEnterDelay,
          curve: tileEnterCurve,
          height: enteringTileIndex.value >= 1 ? tilesPadding : 100,
          width: 0,
        ),
      ),
      SizedBox(
        width: tileWidth,
        child: Obx(
          () => AnimatedOpacity(
            opacity: enteringTileIndex.value >= 3 ? 1.0 : 0.0,
            duration: tileEnterDelay,
            curve: tileEnterCurve,
            child: ListTile(
              leading: const Icon(Icons.alternate_email),
              title: Text('Drawer_Account'.tr),
              subtitle: isLandscape ? const Text('developing ...') : null,
              trailing: const Icon(Icons.keyboard_arrow_right),
              shape: tileRadius,
              onTap: () => (() => Get.toNamed(AccountPage.getRoute())).tryVibrate().delay(milliseconds: config.delayOpenPageInHomePage.value ? pageOpenDelay : 0).execute(),
            ),
          ),
        ),
      ),
      Obx(
        () => AnimatedContainer(
          duration: tileEnterDelay,
          curve: tileEnterCurve,
          height: enteringTileIndex.value >= 1 ? tilesPadding : 60,
          width: 0,
        ),
      ),
      SizedBox(
        width: tileWidth,
        child: Obx(
          () => AnimatedOpacity(
            opacity: enteringTileIndex.value >= 4 ? 1.0 : 0.0,
            duration: tileEnterDelay,
            curve: tileEnterCurve,
            child: ListTile(
              leading: const Icon(Icons.settings),
              title: Text('Drawer_Setting'.tr),
              subtitle: isLandscape ? const Text('no notifications') : null,
              trailing: const Icon(Icons.keyboard_arrow_right),
              shape: tileRadius,
              onTap: () => (() => Get.toNamed(SettingsPage.getRoute())).tryVibrate().delay(milliseconds: config.delayOpenPageInHomePage.value ? pageOpenDelay : 0).execute(),
            ),
          ),
        ),
      ),
      Obx(
        () => AnimatedContainer(
          duration: tileEnterDelay,
          curve: tileEnterCurve,
          height: enteringTileIndex.value >= 1 ? tilesPadding : 30,
          width: 0,
        ),
      ),
      SizedBox(
        width: tileWidth,
        child: Obx(
          () => AnimatedOpacity(
            opacity: enteringTileIndex.value >= 5 ? 1.0 : 0.0,
            duration: tileEnterDelay,
            curve: tileEnterCurve,
            child: ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: Text('Drawer_About'.tr),
              subtitle: Text(instances.appInfo.versionString.value),
              trailing: const Icon(Icons.keyboard_arrow_right),
              shape: tileRadius,
              onTap: () => (() => Get.toNamed(AboutPage.getRoute())).tryVibrate().delay(milliseconds: config.delayOpenPageInHomePage.value ? pageOpenDelay : 0).execute(),
            ),
          ),
        ),
      ),
      const SizedBox(height: tilesPadding),
    ];
  }
}
