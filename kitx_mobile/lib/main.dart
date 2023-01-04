// import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart' hide Intent;

import 'package:flutter_logs/flutter_logs.dart';

// import 'package:receive_intent/receive_intent.dart';
import 'package:get/get.dart';

import 'pages/device_page.dart';
import 'pages/account_page.dart';
import 'pages/test_page.dart';
import 'pages/setting_page.dart';
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
      Config.WebService_UdpPortSend, Config.WebService_UdpBroadcastAddress);
  webService.initService();

  // 初始化 log
  await FlutterLogs.initLogs(
    logLevelsEnabled: Config.Log_LogLevelsEnabled,
    // Log 等级
    timeStampFormat: Config.Log_TimeStampFormat,
    // 时间戳格式
    directoryStructure: Config.Log_DirectoryStructure,
    // 日志目录结构
    logTypesEnabled: Config.Log_LogTypesEnabled,
    // 日志类型
    logFileExtension: Config.Log_LogFileExtension,
    // 日志文件扩展名
    logsWriteDirectoryName: Config.Log_LogsWriteDirectoryName,
    // 日志写入目录名
    logsExportDirectoryName: Config.Log_LogsExportDirectoryName,
    // 日志导出目录名
    debugFileOperations: Config.Log_DebugFileOperations,
    // 调试文件操作
    isDebuggable: Config.Log_IsDebuggable, // 是否调试
  );

  // 初始化 Devices
  global.devices.init();

  // 初始化 SmsServer
  // SmsServer smsServer = SmsServer();
  // smsServer.initServer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KitX Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      translations: Translation(),
      // 定义翻译 使用: "Text".tr
      locale: ui.window.locale,
      // 定义当前语言
      fallbackLocale: Locale('en', 'US'),
      // 定义默认语言
      // supportedLocales: const [ // 定义支持的语言
      //     Locale("en", "US"),
      //     Locale("zh", "CN"),
      // ],
      getPages: [
        // 定义路由
        GetPage(
          name: "/",
          page: () => AboutPage(),
        ),
        GetPage(
          name: "/DevicePage/",
          page: () => DevicePage(),
        ),
      ],
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // imageCache.clear(); // 清除图片缓存
    return Scaffold(
      appBar: AppBar(
        title: Text("IndexPage_Title".tr),
      ),
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              // color: Colors.blue,
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/KitX-Background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              "Drawer_Title".tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text("Drawer_Devices".tr),
            onTap: () {
              Get.back();
              Get.to(() => DevicePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.alternate_email),
            title: Text("Drawer_Account".tr),
            onTap: () {
              Get.back();
              Get.to(() => AccountPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text("Drawer_Test".tr),
            onTap: () {
              Get.back();
              Get.to(() => TestPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Drawer_Setting".tr),
            onTap: () {
              Get.back();
              Get.to(() => SettingPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text("Drawer_About".tr),
            onTap: () {
              Get.back();
              Get.to(() => AboutPage());
            },
          ),
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "欢迎来到 KitX",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
