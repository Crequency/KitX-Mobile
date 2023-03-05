import 'package:get/get.dart';

import 'package:kitx_mobile/pages/home_page.dart';
import 'package:kitx_mobile/pages/device_page.dart';
import 'package:kitx_mobile/pages/account_page.dart';
import 'package:kitx_mobile/pages/test_page.dart';
import 'package:kitx_mobile/pages/settings_page.dart';
import 'package:kitx_mobile/pages/about_page.dart';

List<GetPage<dynamic>> GetPages() => [
      // 定义路由
      GetPage(
        name: '/',
        page: () => HomePage(),
      ),
      GetPage(
        name: '/DevicePage/',
        page: () => DevicePage(),
      ),
      GetPage(
        name: '/AccountPage/',
        page: () => AccountPage(),
      ),
      GetPage(
        name: '/TestPage/',
        page: () => TestPage(),
      ),
      GetPage(
        name: '/SettingsPage/',
        page: () => SettingsPage(),
      ),
      GetPage(
        name: '/AboutPage/',
        page: () => AboutPage(),
      ),
    ];
