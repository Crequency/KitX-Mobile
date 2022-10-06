import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KitX Mobile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: [
        FlutterI18nDelegate(
          translationLoader: FileTranslationLoader(
            basePath: "assets/i18n",
            // fallbackFile: "en_US",
            useCountryCode: true,
            // forcedLocale: Locale("zh", "CN"),
          ),
          missingTranslationHandler: (key, locale) {
            print("--- Missing Key: $key, languageCode: ${locale?.languageCode}, countryCode: ${locale?.countryCode}");
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
        title: Text(FlutterI18n.translate(context, "homePage.title")),
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
              FlutterI18n.translate(context, "homePage.title"),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(FlutterI18n.translate(context, "drawer.home")),
          ),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text(FlutterI18n.translate(context, "drawer.devices")),
          ),
          ListTile(
            leading: Icon(Icons.alternate_email),
            title: Text(FlutterI18n.translate(context, "drawer.account")),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(FlutterI18n.translate(context, "drawer.setting")),
          ),
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              FlutterI18n.translate(context, "homePage.hello"),
            ),
            Text(
              FlutterI18n.translate(context, "homePage.text"),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
