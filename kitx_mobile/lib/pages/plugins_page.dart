import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kitx_mobile_internal_plugins/kitx_mobile_internal_plugins.dart';

/// Plugins Page
class PluginsPage extends StatefulWidget {
  /// Constructor
  const PluginsPage({Key? key}) : super(key: key);

  @override
  State<PluginsPage> createState() => _PluginsPageState();
}

class _PluginsPageState extends State<PluginsPage> {
  var tileRadius = ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10.0));

  @override
  Widget build(BuildContext context) {
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
            ListView(
              shrinkWrap: true,
              children: InternalPluginsManager.instance().getList(shape: tileRadius),
            ),
            const SizedBox(height: 50),
            Text(
              'PluginsPage_ConnectedPlugins'.tr,
              style: const TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              children: [],
            ),
            const SizedBox(height: 300),
          ],
        ),
      ),
    );
  }
}
