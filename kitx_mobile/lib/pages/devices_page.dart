import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "drawer.devices")),
      ),
      body: const Center(
        child: Text(
          'DevicesPage',
          style: TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
