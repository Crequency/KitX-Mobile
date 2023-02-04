import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'device_page.dart';
import 'account_page.dart';
import 'test_page.dart';
import 'settings_page.dart';
import 'about_page.dart';

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
      appBar: AppBar(
        title: Text("IndexPage_Title".tr),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.blue,
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/KitX-Background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              "Drawer_Title".tr,
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
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DevicesStatus(),
            Text(
              "欢迎来到 KitX",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
