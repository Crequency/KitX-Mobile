import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kitx_mobile/pages/pages.dart';

/// Account Page
class AccountPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/account';

  /// Get Page
  static Widget Function() getPage() => () => const AccountPage();

  /// Constructor
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AccountPage_Title'.tr),
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Developing ...',
            ),
          ],
        ),
      ),
    );
  }
}
