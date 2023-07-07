import 'package:flutter/material.dart' hide Intent;
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/pages/home_page.dart';
import 'package:kitx_mobile/pages/routes.dart';
import 'package:kitx_mobile/themes/dark_theme.dart';
import 'package:kitx_mobile/themes/light_theme.dart';
import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/log.dart';
import 'package:kitx_mobile/utils/translation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Config.loadAsync();
  await Log.initAsync();
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
        locale: instances.appInfo.getLanguageCode ?? Localizations.localeOf(context),
        fallbackLocale: Locale('en', 'US'),
        getPages: getPages(),
        home: const HomePage(),
      ),
    );
  }
}
