import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/pages/about_page.dart';
import 'package:kitx_mobile/pages/account_page.dart';
import 'package:kitx_mobile/pages/device_page.dart';
import 'package:kitx_mobile/pages/settings_page.dart';
import 'package:kitx_mobile/pages/test_page.dart';

import 'package:kitx_mobile/utils/global.dart';

/// AppDrawer
class AppDrawer extends StatelessWidget {
  /// Delay time before open page
  final pageOpenDelay = 200;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.blue,
              image: const DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/KitX-Background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              '',
              // 'Drawer_Title'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text('Drawer_Devices'.tr),
            onTap: () => Global.delay(() {
              Get.back();
              Get.to(() => DevicePage());
            }, pageOpenDelay),
          ),
          ListTile(
            leading: Icon(Icons.alternate_email),
            title: Text('Drawer_Account'.tr),
            onTap: () => Global.delay(() {
              Get.back();
              Get.to(() => AccountPage());
            }, pageOpenDelay),
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text('Drawer_Test'.tr),
            onTap: () => Global.delay(() {
              Get.back();
              Get.to(() => TestPage());
            }, pageOpenDelay),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Drawer_Setting'.tr),
            onTap: () => Global.delay(() {
              Get.back();
              Get.to(() => SettingsPage());
            }, pageOpenDelay),
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('Drawer_About'.tr),
            onTap: () => Global.delay(() {
              Get.back();
              Get.to(() => AboutPage());
            }, pageOpenDelay),
          ),
        ],
      ),
    );
  }
}
