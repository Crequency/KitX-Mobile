import 'package:get/get.dart';
import 'package:kitx_mobile/pages/about_page.dart';
import 'package:kitx_mobile/pages/account_page.dart';
import 'package:kitx_mobile/pages/devices_page.dart';
import 'package:kitx_mobile/pages/home_page.dart';
import 'package:kitx_mobile/pages/settings_page.dart';
import 'package:kitx_mobile/pages/test_page.dart';

export 'about_page.dart';
export 'account_page.dart';
export 'devices_page.dart';
export 'home_page.dart';
export 'settings_page.dart';
export 'test_page.dart';

/// Get Pages
List<GetPage<dynamic>> getPages() => [
      GetPage(name: '/', page: () => const HomePage()),
      GetPage(name: '/DevicesPage/', page: () => const DevicesPage()),
      GetPage(name: '/AccountPage/', page: () => const AccountPage()),
      GetPage(name: '/TestPage/', page: () => const TestPage()),
      GetPage(name: '/SettingsPage/', page: () => const SettingsPage()),
      GetPage(name: '/AboutPage/', page: () => const AboutPage()),
    ];
