import 'package:flutter/material.dart';

class DevicesPage extends StatefulWidget {
  @override
  _DevicesPageState createState() => new _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Devices"),
      ),
      body: new Center(
        child: new Text(
          'DevicesPage',
          style: new TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
