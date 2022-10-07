import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wifi_iot/wifi_iot.dart';

import 'pages/home_page.dart';

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
            basePath: "i18n",
            // fallbackFile: "en_US",
            useCountryCode: true,
            // forcedLocale: Locale("zh", "CN"),
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
      home: const MyHomePage(title: 'KitX Mobile'),
    );
  }
}
