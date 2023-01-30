import 'package:get/get.dart';

import 'home_page.dart';
import 'device_page.dart';
import 'account_page.dart';
import 'test_page.dart';
import 'settings_page.dart';
import 'about_page.dart';

List<GetPage<dynamic>> GetPages() => [
  // 定义路由
  GetPage(
    name: "/",
    page: () => HomePage(),
  ),
  GetPage(
    name: "/DevicePage/",
    page: () => DevicePage(),
  ),
  GetPage(
      name: "/AccountPage/",
      page: () => AccountPage()
  ),
  GetPage(
      name: "/TestPage/",
      page: () => TestPage()
  ),
  GetPage(
      name: "/SettingsPage/",
      page: () => SettingsPage()
  ),
  GetPage(
      name: "/AboutPage/",
      page: () => AboutPage()
  ),
];