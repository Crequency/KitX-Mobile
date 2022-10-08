import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:get/get.dart';
import 'pages/homePage.dart';
import 'pages/devicePage.dart';
import 'pages/testPage.dart';
import 'services/webServer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WebServer server = WebServer(24040, 23404);
  server.initServer();
  await FlutterLogs.initLogs(
    logLevelsEnabled: [
      LogLevel.INFO,
      LogLevel.WARNING,
      LogLevel.ERROR,
      LogLevel.SEVERE,
    ],
    timeStampFormat: TimeStampFormat.TIME_FORMAT_FULL_2,
    directoryStructure: DirectoryStructure.FOR_DATE,
    logTypesEnabled: ["network", "info", "errors",],
    logFileExtension: LogFileExtension.LOG,
    logsWriteDirectoryName: "Logs",
    logsExportDirectoryName: "Logs/Exported",
    debugFileOperations: true,
    isDebuggable: true,
  );
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
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            // fallbackFile: "en_US",
            basePath: "assets/i18n",
            useCountryCode: true,
            useScriptCode: false,
            // forcedLocale: Locale("zh", "CN"),
            decodeStrategies: [JsonDecodeStrategy()],
          ),
          missingTranslationHandler: (key, locale) {
            print(
                "--- Missing Key: $key, languageCode: ${locale?.languageCode}, countryCode: ${locale?.countryCode}");
          },
        ),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      builder: FlutterI18n.rootAppBuilder(),
      supportedLocales: const [
        Locale("en", "US"), // 美国英语
        Locale("zh", "CN"), // 中文简体
      ],
      getPages: [
        GetPage(
          name: "/",
          page: () => HomePage(),
        ),
        GetPage(
          name: "/DevicePage/",
          page: () => DevicePage(),
        ),
      ],
      home: const MyHomePage(title: 'KitX Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final PageController _controller = PageController(
    initialPage: 0,
  );

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "indexPage.title")),
      ),
      drawer: Drawer(
          child: ListView(
        // padding: EdgeInsets.zero,
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
              FlutterI18n.translate(context, "drawer.title"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(FlutterI18n.translate(context, "drawer.home")),
            onTap: () {
              Get.back();
              Get.to(() => HomePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text(FlutterI18n.translate(context, "drawer.devices")),
            onTap: () {
              Get.back();
              Get.to(() => DevicePage());
            },
          ),
          ListTile(
            leading: Icon(Icons.alternate_email),
            title: Text(FlutterI18n.translate(context, "drawer.account")),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text("TestPage"),
            onTap: () {
              Get.back();
              Get.to(() => TestPage());
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(FlutterI18n.translate(context, "drawer.setting")),
            onTap: () {
              Get.back();
            },
          ),
        ],
      )),
      // body: PageView(
      //   controller: _controller,
      //   children: <Widget>[
      //     HomePage(),
      //   ],
      // ),
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
