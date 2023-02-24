import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    // imageCache.clear(); // 清除图片缓存
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
                      onTap: () => Get.to(() => DevicePage()),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.alternate_email),
                    title: Text("Drawer_Account".tr),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => Get.to(() => AccountPage()),
                  ),
                  ListTile(
                    leading: Icon(Icons.bug_report),
                    title: Text("Drawer_Test".tr),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => Get.to(() => TestPage()),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Drawer_Setting".tr),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => Get.to(() => SettingsPage()),
                  ),
                  ListTile(
                    leading: Icon(Icons.info_outline_rounded),
                    title: Text("Drawer_About".tr),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () => Get.to(() => AboutPage()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
