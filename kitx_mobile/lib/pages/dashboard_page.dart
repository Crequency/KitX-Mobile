import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "drawer.dashboard")),
      ),
      body: const Center(
        child: Text(
          'DashBoardPage',
          style: TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
