import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => new _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Account"),
      ),
      body: new Center(
        child: new Text(
          'AccountPage',
          style: new TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
