import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:kitx_mobile/pages/pages.dart';
import 'package:kitx_mobile/utils/handlers/vibration_handler.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';

/// Plugins Page
class PluginsPage extends StatefulWidget implements ConstantPage {
  /// Get Route
  static String getRoute() => '/plugins';

  /// Get Page
  static Widget Function() getPage() => () => const PluginsPage();

  /// Constructor
  const PluginsPage({super.key});

  @override
  State<PluginsPage> createState() => _PluginsPageState();
}

class _PluginsPageState extends State<PluginsPage> {
  var tileRadius = ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0));

  @override
  Widget build(BuildContext context) {
    InternalPluginsManager.instance().onPluginAbilityChanged(
      (ability) => VibrationHandler.tryVibrate(
        milliseconds: ability ? 50 : 100,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('PluginsPage_Title'.tr),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Text(
              'PluginsPage_BuiltInPlugins'.tr,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Column(
              children: InternalPluginsManager.instance().getList(
                shape: tileRadius,
                vibrator: () => VibrationHandler.tryVibrate(),
              ),
            ),
            const SizedBox(height: 50),
            Text(
              'PluginsPage_ConnectedPlugins'.tr,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Column(
              children: [
                const ListTile(
                  title: Text('Nothing here yet!'),
                  subtitle: Text('Developing ...'),
                ),
              ],
            ),
            const SizedBox(height: 300),
          ],
        ),
      ),
    );
  }
}
