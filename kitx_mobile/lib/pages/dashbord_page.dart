import 'package:flutter/material.dart';

class DashBordPage extends StatefulWidget {
  @override
  _DashBordPageState createState() => new _DashBordPageState();
}

class _DashBordPageState extends State<DashBordPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("DashBord"),
      ),
      body: new Center(
        child: new Text(
          'DashBordPage',
          style: new TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
