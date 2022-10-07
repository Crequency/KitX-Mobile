import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'account_page.dart';
import 'dashboard_page.dart';
import 'devices_page.dart';
import 'setting_page.dart';

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
              title: Text(FlutterI18n.translate(context, "drawer.dashboard")),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const DashBoardPage();
                }));
              }),
          ListTile(
              leading: Icon(Icons.devices),
              title: Text(FlutterI18n.translate(context, "drawer.devices")),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const DevicesPage();
                }));
              }),
          ListTile(
              leading: Icon(Icons.alternate_email),
              title: Text(FlutterI18n.translate(context, "drawer.account")),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const AccountPage();
                }));
              }),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text(FlutterI18n.translate(context, "drawer.setting")),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const SettingPage();
                }));
              }),
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
