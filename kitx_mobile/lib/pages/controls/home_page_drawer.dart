import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/pages/plugins_page.dart';
import 'package:kitx_mobile/utils/handlers/tasks/delayed_task.dart';

/// [HomePageDrawer] class
class HomePageDrawer extends StatelessWidget {
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
            onTap: () {
              Get.back();
              Get.toNamed(DevicesPage.getRoute());
            }.delay(milliseconds: pageOpenDelay).execute,
          ),
          ListTile(
            leading: const Icon(Icons.layers),
            title: Text('Drawer_Plugins'.tr),
            onTap: () {
              Get.back();
              Get.toNamed(PluginsPage.getRoute());
            }.delay(milliseconds: pageOpenDelay).execute,
          ),
          ListTile(
            leading: const Icon(Icons.alternate_email),
            title: Text('Drawer_Account'.tr),
            onTap: () {
              Get.back();
              Get.toNamed(AccountPage.getRoute());
            }.delay(milliseconds: pageOpenDelay).execute,
          ),
          const Divider(),
          Row(
            children: [
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(SettingsPage.getRoute());
                }.delay(milliseconds: pageOpenDelay).execute,
                icon: const Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(AboutPage.getRoute());
                }.delay(milliseconds: pageOpenDelay).execute,
                icon: const Icon(Icons.info_outline_rounded),
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(TestPage.getRoute());
                }.delay(milliseconds: pageOpenDelay).execute,
                icon: const Icon(Icons.bug_report),
              ),
            ],
          )
        ],
      ),
    );
  }
}
