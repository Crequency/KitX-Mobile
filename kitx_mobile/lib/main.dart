// import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide Intent;
import 'package:flutter_logs/flutter_logs.dart';

// import 'package:receive_intent/receive_intent.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/pages/home_page.dart';

import 'pages/device_page.dart';
import 'pages/account_page.dart';
import 'pages/test_page.dart';
import 'pages/settings_page.dart';
import 'pages/about_page.dart';

import 'services/web_service.dart';
// import 'services/sms_server.dart';

import 'utils/translation.dart';
import 'utils/config.dart';
import 'utils/global.dart' as global;

/// 程序入口
Future<void> main() async {
  // 提前初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 WebService
  WebService webService = WebService(Config.WebService_UdpPortReceive,
      Config.WebService_UdpPortSend, Config.WebService_UdpBroadcastAddress);  webService.initService();
  // 初始化 log
  await FlutterLogs.initLogs(
    logLevelsEnabled: Config.Log_LogLevelsEnabled, // Log 等级
    timeStampFormat: Config.Log_TimeStampFormat, // 时间戳格式
    directoryStructure: Config.Log_DirectoryStructure, // 日志目录结构
    logTypesEnabled: Config.Log_LogTypesEnabled, // 日志类型
    logFileExtension: Config.Log_LogFileExtension, // 日志文件扩展名
    logsWriteDirectoryName: Config.Log_LogsWriteDirectoryName, // 日志写入目录名
    logsExportDirectoryName: Config.Log_LogsExportDirectoryName, // 日志导出目录名
    debugFileOperations: Config.Log_DebugFileOperations, // 调试文件操作
    isDebuggable: Config.Log_IsDebuggable, // 是否调试
  );

  // 初始化 Devices
  global.devices.init();

  // 初始化 SmsServer
  // SmsServer smsServer = SmsServer();
  // smsServer.initServer();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'KitX Mobile',
    //   themeMode: ThemeMode.system,
    //   locale: ui.window.locale,
    //   home: const HomePage(),
    //   showPerformanceOverlay: true,
    // );
    return GetMaterialApp(
      title: 'KitX Mobile',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.dark,
      ),
      highContrastTheme: ThemeData(),
      highContrastDarkTheme: ThemeData(),
      translations: Translation(), // 定义翻译 使用: "Text".tr
      locale: ui.window.locale, // 定义当前语言
      fallbackLocale: Locale('en', 'US'), // 定义默认语言
      // supportedLocales: const [ // 定义支持的语言
      //   Locale("en", "US"),
      //   Locale("zh", "CN"),
      // ],
      getPages: [
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
      ],
      home: const HomePage(),
    );
  }
}
