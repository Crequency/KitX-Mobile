import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './setting_page.dart';
import './dashbord_page.dart';
import './devices_page.dart';
import './account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).homePage_title),
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
                image: AssetImage('Assets/KitX-Icon-Background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Text(
              'KitX Mobile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('仪表板'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return DashBordPage();
              }));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.devices),
            title: Text('设备管理'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return DevicesPage();
              }));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.alternate_email),
            title: Text('账户'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return AccountPage();
              }));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return SettingPage();
              }));
            },
          ),
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).homePage_text,
            ),
            Text(
              AppLocalizations.of(context).helloWorld,
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
