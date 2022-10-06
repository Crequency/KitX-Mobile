import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => new _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Setting"),
      ),
      body: new Center(
        child: new Text(
          'SettingPage',
          style: new TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
