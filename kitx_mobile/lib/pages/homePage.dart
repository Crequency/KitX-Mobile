import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   int _counter = 0;
//
//   void _incrementCounter() {
//       _counter++;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       // title: 'KitX Mobile',
//       // localizationsDelegates: [
//       //   FlutterI18nDelegate(
//       //     translationLoader: FileTranslationLoader(
//       //       basePath: "assets/i18n",
//       //       // fallbackFile: "en_US",
//       //       useCountryCode: true,
//       //       // forcedLocale: Locale("zh", "CN"),
//       //     ),
//       //     missingTranslationHandler: (key, locale) {
//       //       print("--- Missing Key: $key, languageCode: ${locale?.languageCode}, countryCode: ${locale?.countryCode}");
//       //     },
//       //   ),
//       //   GlobalMaterialLocalizations.delegate,
//       //   GlobalWidgetsLocalizations.delegate
//       // ],
//       // builder: FlutterI18n.rootAppBuilder(),
//       // supportedLocales: const [
//       //   Locale("en", "US"), // 美国英语
//       //   Locale("zh", "CN"), // 中文简体
//       // ],
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               FlutterI18n.translate(context, "homePage.hello"),
//             ),
//             Text(
//               FlutterI18n.translate(context, "homePage.text"),
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             TextButton(
//               onPressed: _incrementCounter,
//               child: Text("Click Me!"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// /*
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<HomePage> {
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
        // leading: Builder(
        //   builder: (BuildContext context) {
        //     return IconButton(
        //       icon: const Icon(Icons.back),
        //       onPressed: () { Scaffold.of(context).openDrawer(); },
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // )
      ),
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
// */
