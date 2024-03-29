import 'package:flutter/material.dart' hide Intent;
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/log.dart';
import 'package:kitx_mobile/utils/themes/themes.dart';
import 'package:kitx_mobile/utils/translation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await config.loadAsync();
  await log.initAsync();
  await instances.initAsync();

  runApp(MainApp());
}

/// [MainApp] Class
class MainApp extends StatelessWidget {
  /// Constructor for [MainApp]
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'KitX Mobile',
        themeMode: instances.appInfo.themeMode,
        theme: lightThemeData.value,
        darkTheme: darkThemeData.value,
        highContrastTheme: ThemeData(),
        highContrastDarkTheme: ThemeData(),
        translations: Translation(),
        locale: instances.appInfo.getLanguageCode ?? Get.deviceLocale,
        fallbackLocale: Locale('en', 'US'),
        getPages: getPages(),
        home: const HomePage(),
      ),
    );
  }
}
