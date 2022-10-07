import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "drawer.account")),
      ),
      body: const Center(
        child: Text(
          'AccountPage',
          style: TextStyle(fontSize: 35.0),
        ),
      ),
    );
  }
}
