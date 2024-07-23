import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kitx_mobile/pages/pages.dart';

/// Account Page
class NotFoundPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/404';

  /// Get Page
  static Widget Function() getPage() => () => const NotFoundPage();

  /// Constructor
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotFoundPage_Title'.tr),
        forceMaterialTransparency: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '404',
            ),
          ],
        ),
      ),
    );
  }
}
