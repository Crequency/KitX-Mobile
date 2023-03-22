import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide Intent;
import 'package:get/get.dart';

import 'package:kitx_mobile/pages/home_page.dart';
import 'package:kitx_mobile/pages/routes.dart';

import 'package:kitx_mobile/services/web_service.dart';

import 'package:kitx_mobile/themes/dark_theme.dart';
import 'package:kitx_mobile/themes/light_theme.dart';

import 'package:kitx_mobile/utils/config.dart';
import 'package:kitx_mobile/utils/global.dart';
import 'package:kitx_mobile/utils/log.dart';
import 'package:kitx_mobile/utils/translation.dart';

/// 程序入口
Future<void> main() async {
  // 提前初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 读取配置
  await Config.loadAsync();

  // 初始化 WebService
  var webService = WebService()
    ..udpPortSend = Config.WebService_UdpPortSend
    ..udpPortReceive = Config.WebService_UdpPortReceive
    ..udpBroadcastAddress = Config.WebService_UdpBroadcastAddress;
  webService.initService();

  //  初始化 log
  initLogger();

  //  初始化 Global
  await Global.init();

  //  初始化 Devices
  Global.device.initService();

  runApp(MainApp());
}

/// MainApp
class MainApp extends StatelessWidget {
  // ignore: public_member_api_docs
  MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'KitX Mobile',
    //   themeMode: ThemeMode.system,
    //   locale: ui.window.locale,
    //   home: const HomePage(),
    //   showPerformanceOverlay: true,
    // );

    // return GetCupertinoApp(
    //   title: 'KitX Mobile',
    //   home: CupertinoPageScaffold(
    //       child: CupertinoSlider(value: 0.4, onChanged: (_) => print('a')),
    //   ),
    // );

    return Obx(
      () => GetMaterialApp(
        title: 'KitX Mobile',
        themeMode: Global.themeMode,
        theme: lightThemeData.value,
        darkTheme: darkThemeData.value,
        highContrastTheme: ThemeData(),
        highContrastDarkTheme: ThemeData(),
        translations: Translation(),
        // 定义翻译 使用: 'Text'.tr
        locale: ui.window.locale,
        // 定义当前语言
        fallbackLocale: Locale('en', 'US'),
        // 定义默认语言
        // supportedLocales: const [ // 定义支持的语言
        //   Locale('en', 'US'),
        //   Locale('zh', 'CN'),
        // ],
        getPages: GetPages(),
        home: const HomePage(),
      ),
    );
  }
}
