import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/about_page.dart';
import 'package:kitx_mobile/pages/account_page.dart';
import 'package:kitx_mobile/pages/device_page.dart';
import 'package:kitx_mobile/pages/settings_page.dart';
import 'package:kitx_mobile/pages/test_page.dart';

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
          const DrawerHeader(
            decoration: const BoxDecoration(
              // color: Colors.blue,
              image: const DecorationImage(
                alignment: Alignment.topCenter,
                image: const AssetImage('assets/KitX-Background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: const Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: Text('Drawer_Devices'.tr),
            onTap: () => instances.taskHandler.delay(() {
              Get.back();
              Get.to(() => const DevicePage());
            }, pageOpenDelay),
          ),
          ListTile(
            leading: const Icon(Icons.alternate_email),
            title: Text('Drawer_Account'.tr),
            onTap: () => instances.taskHandler.delay(() {
              Get.back();
              Get.to(() => const AccountPage());
            }, pageOpenDelay),
          ),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: Text('Drawer_Test'.tr),
            onTap: () => instances.taskHandler.delay(() {
              Get.back();
              Get.to(() => const TestPage());
            }, pageOpenDelay),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text('Drawer_Setting'.tr),
            onTap: () => instances.taskHandler.delay(() {
              Get.back();
              Get.to(() => const SettingsPage());
            }, pageOpenDelay),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: Text('Drawer_About'.tr),
            onTap: () => instances.taskHandler.delay(() {
              Get.back();
              Get.to(() => const AboutPage());
            }, pageOpenDelay),
          ),
        ],
      ),
    );
  }
}
