import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/about_page.dart';
import 'package:kitx_mobile/pages/account_page.dart';
import 'package:kitx_mobile/pages/devices_page.dart';
import 'package:kitx_mobile/pages/home_page.dart';
import 'package:kitx_mobile/pages/not_found_page.dart';
import 'package:kitx_mobile/pages/plugins_page.dart';
import 'package:kitx_mobile/pages/settings_page.dart';
import 'package:kitx_mobile/pages/settings_pages/appearance_settings_page.dart';
import 'package:kitx_mobile/pages/settings_pages/log_settings_page.dart';
import 'package:kitx_mobile/pages/sub_pages/device_chat_page.dart';
import 'package:kitx_mobile/pages/test_page.dart';
import 'package:kitx_mobile/pages/test_pages/device_info_test.dart';
import 'package:kitx_mobile/pages/test_pages/device_sensors.dart';
import 'package:kitx_mobile/pages/test_pages/network_info_test.dart';

export 'about_page.dart';
export 'account_page.dart';
export 'devices_page.dart';
export 'home_page.dart';
export 'settings_page.dart';
export 'test_page.dart';

/// Get Pages
List<GetPage<dynamic>> getPages() => [
      GetPage(name: HomePage.getRoute(), page: HomePage.getPage()),
      GetPage(name: DevicesPage.getRoute(), page: DevicesPage.getPage()),
      GetPage(name: PluginsPage.getRoute(), page: PluginsPage.getPage()),
      GetPage(name: AccountPage.getRoute(), page: AccountPage.getPage()),
      GetPage(name: TestPage.getRoute(), page: TestPage.getPage()),
      GetPage(name: SettingsPage.getRoute(), page: SettingsPage.getPage()),
      GetPage(name: AboutPage.getRoute(), page: AboutPage.getPage()),
      GetPage(name: DeviceChatPage.getRoute(), page: DeviceChatPage.getPage()),
      GetPage(name: DeviceInfoTestPage.getRoute(), page: DeviceInfoTestPage.getPage()),
      GetPage(name: DeviceSensorsPage.getRoute(), page: DeviceSensorsPage.getPage()),
      GetPage(name: NetworkInfoTestPage.getRoute(), page: NetworkInfoTestPage.getPage()),
      GetPage(name: AppearanceSettingsPage.getRoute(), page: AppearanceSettingsPage.getPage()),
      GetPage(name: LogSettingsPage.getRoute(), page: LogSettingsPage.getPage()),
    ];

/// Constant Page
abstract class ConstantPage {
  /// Get Route
  static String getRoute() {
    return '/404';
  }

  /// Get Page
  static Widget Function() getPage() => () => const NotFoundPage();
}
