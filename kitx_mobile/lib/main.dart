// import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide Intent;

// import 'package:receive_intent/receive_intent.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/themes/dark_theme.dart';
import 'package:kitx_mobile/themes/light_theme.dart';
import 'package:kitx_mobile/utils/log.dart';

import 'pages/get_pages.dart';
import 'pages/home_page.dart';

import 'services/web_service.dart';
// import 'services/sms_server.dart';

import 'utils/translation.dart';
import 'utils/config.dart';
import 'utils/global.dart';

/// 程序入口
Future<void> main() async {
  // 提前初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 WebService
  WebService webService = WebService(Config.WebService_UdpPortReceive,
      Config.WebService_UdpPortSend, Config.WebService_UdpBroadcastAddress);
  webService.initService();

  // 初始化 log
  InitLogger();

  // 初始化 Devices
  Global.devices.init();

  // 初始化 SmsServer
  // SmsServer smsServer = SmsServer();
  // smsServer.initServer();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
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

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: Global.themeNotifier,
      builder: (_, mode, __) => GetMaterialApp(
        title: "KitX Mobile",
        themeMode: mode,
        theme: GetLightThemeData(),
        darkTheme: GetDarkThemeData(),
        highContrastTheme: ThemeData(),
        highContrastDarkTheme: ThemeData(),
        translations: Translation(), // 定义翻译 使用: "Text".tr
        locale: ui.window.locale, // 定义当前语言
        fallbackLocale: Locale('en', 'US'), // 定义默认语言
        // supportedLocales: const [ // 定义支持的语言
        //   Locale("en", "US"),
        //   Locale("zh", "CN"),
        // ],
        getPages: GetPages(),
        home: const HomePage(),
      ),
    );
  }
}
