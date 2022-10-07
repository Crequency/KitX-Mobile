import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
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
