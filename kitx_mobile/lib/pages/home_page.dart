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
class HomePage extends StatefulWidget {
  // ignore: public_member_api_docs
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageOpenDelay = 200;

  @override
  Widget build(BuildContext context) {
    // imageCache.clear(); // 清除图片缓存
    var tileRadius = ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0));
    var tilesPadding = 15.0;

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
                SizedBox(height: tilesPadding),
                Obx(
                  () => ListTile(
                    leading: Icon(Icons.devices),
                    title: Text('Drawer_Devices'.tr),
                    subtitle: Text('${Global.device.length.obs} ${'HomePage_DevicesCount'.tr}'),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    // tileColor: Colors.indigo,
                    // textColor: Colors.white,
                    // iconColor: Colors.white,
                    onTap: () => Global.delay(() => Get.to(() => DevicePage()), pageOpenDelay),
                  ),
                ),
                SizedBox(height: tilesPadding),
                ListTile(
                  leading: Icon(Icons.alternate_email),
                  title: Text('Drawer_Account'.tr),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Global.delay(() => Get.to(() => AccountPage()), pageOpenDelay),
                ),
                SizedBox(height: tilesPadding),
                ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text('Drawer_Test'.tr),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Global.delay(() => Get.to(() => TestPage()), pageOpenDelay),
                ),
                SizedBox(height: tilesPadding),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Drawer_Setting'.tr),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Global.delay(() => Get.to(() => SettingsPage()), pageOpenDelay),
                ),
                SizedBox(height: tilesPadding),
                Obx(
                  () => ListTile(
                    leading: Icon(Icons.info_outline_rounded),
                    title: Text('Drawer_About'.tr),
                    subtitle: Text(Global.versionString.value),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => Global.delay(() => Get.to(() => AboutPage()), pageOpenDelay),
                  ),
                ),
                SizedBox(height: tilesPadding),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
