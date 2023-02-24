import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'device_page.dart';
import 'account_page.dart';
import 'test_page.dart';
import 'settings_page.dart';
import 'about_page.dart';

import '../utils/global.dart' as global;

import "controls/devices_status.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final version = "getting ...".obs;

  @override
  Widget build(BuildContext context) {
    var packageInfo = PackageInfo.fromPlatform();
    packageInfo.then((value) => version.value = value.version);

    // imageCache.clear(); // 清除图片缓存
    var tileRadius = ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0));
    var tilesPadding = 15.0;

    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: MediaQuery.of(context).size.width / 2 + 50,
      appBar: AppBar(
        title: Text("IndexPage_Title".tr),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                // color: Colors.blue,
                image: const DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage("assets/KitX-Background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                "",
                // "Drawer_Title".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.devices),
              title: Text("Drawer_Devices".tr),
              onTap: () {
                Get.back();
                Get.to(() => DevicePage());
              },
            ),
            ListTile(
              leading: Icon(Icons.alternate_email),
              title: Text("Drawer_Account".tr),
              onTap: () {
                Get.back();
                Get.to(() => AccountPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.bug_report),
              title: Text("Drawer_Test".tr),
              onTap: () {
                Get.back();
                Get.to(() => TestPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Drawer_Setting".tr),
              onTap: () {
                Get.back();
                Get.to(() => SettingsPage());
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline_rounded),
              title: Text("Drawer_About".tr),
              onTap: () {
                Get.back();
                Get.to(() => AboutPage());
              },
            ),
          ],
        ),
      ),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Obx(
                  () => ListTile(
                    leading: Icon(Icons.devices),
                    title: Text("Drawer_Devices".tr),
                    subtitle: Text("${global.devices.length.obs} " + "HomePage_DevicesCount".tr),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => Get.to(() => DevicePage()),
                  ),
                ),
                Container(height: tilesPadding),
                ListTile(
                  leading: Icon(Icons.alternate_email),
                  title: Text("Drawer_Account".tr),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Get.to(() => AccountPage()),
                ),
                Container(height: tilesPadding),
                ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text("Drawer_Test".tr),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Get.to(() => TestPage()),
                ),
                Container(height: tilesPadding),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Drawer_Setting".tr),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  shape: tileRadius,
                  onTap: () => Get.to(() => SettingsPage()),
                ),
                Container(height: tilesPadding),
                Obx(
                  () => ListTile(
                    leading: Icon(Icons.info_outline_rounded),
                    title: Text("Drawer_About".tr),
                    subtitle: Text(version.value),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    shape: tileRadius,
                    onTap: () => Get.to(() => AboutPage()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
