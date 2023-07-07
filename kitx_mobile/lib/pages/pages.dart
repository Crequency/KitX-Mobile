﻿import 'package:get/get.dart';
import 'package:kitx_mobile/pages/about_page.dart';
import 'package:kitx_mobile/pages/account_page.dart';
import 'package:kitx_mobile/pages/device_page.dart';
import 'package:kitx_mobile/pages/home_page.dart';
import 'package:kitx_mobile/pages/settings_page.dart';
import 'package:kitx_mobile/pages/test_page.dart';

export 'about_page.dart';
export 'account_page.dart';
export 'device_page.dart';
export 'home_page.dart';
export 'settings_page.dart';
export 'test_page.dart';

/// Get Pages
List<GetPage<dynamic>> getPages() => [
      GetPage(name: '/', page: () => HomePage()),
      GetPage(name: '/DevicePage/', page: () => DevicePage()),
      GetPage(name: '/AccountPage/', page: () => AccountPage()),
      GetPage(name: '/TestPage/', page: () => TestPage()),
      GetPage(name: '/SettingsPage/', page: () => SettingsPage()),
      GetPage(name: '/AboutPage/', page: () => AboutPage()),
    ];