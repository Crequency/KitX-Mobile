import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "drawer.setting")),
      ),
      body: const Center(
        child: Text(
          'SettingPage',
          style: TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
