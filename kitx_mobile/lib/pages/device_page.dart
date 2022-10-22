import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';

import 'package:get/get.dart';

import '../rules/device_info_struct.dart';

import '../utils/global.dart' as global;
import '../utils/datetime_format.dart' show datetimeToShortString;

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {

  // void _onPressed() {}
  // Widget _cardBuilder(BuildContext context, int index) {
  //   return createDeviceCard(global)
  // }

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    return Scaffold(
      appBar: AppBar(
        title: Text("DevicePage_Title".tr),
      ),
      body: Obx(() => ListView.builder(
        itemCount: global.devices.length,
        itemBuilder: (_, int index) {return createDeviceCard(global.devices.deviceInfoList[index]);},
      )),
      // ),
    );
  }
}

Widget createDeviceCard(DeviceInfo info) {
  Icon _icon = Icon(Icons.help);
  switch (info.deviceOSType) {
    case 0:
      _icon = Icon(Icons.android);
      break;
    case 1:
      _icon = Icon(CommunityMaterialIcons.microsoft_edge);
      break;
    case 2:
      _icon = Icon(CommunityMaterialIcons.freebsd);
      break;
    case 3:
      _icon = Icon(CommunityMaterialIcons.apple_ios);
      break;
    case 4:
      _icon = Icon(CommunityMaterialIcons.linux);
      break;
    case 5:
      _icon = Icon(CommunityMaterialIcons.apple_finder);
      break;
    case 6:
      _icon = Icon(CommunityMaterialIcons.apple);
      break;
    case 7:
      _icon = Icon(CommunityMaterialIcons.apple);
      break;
    case 8:
      _icon = Icon(CommunityMaterialIcons.apple);
      break;
    case 9:
      _icon = Icon(CommunityMaterialIcons.microsoft_windows);
      break;
    default:
      _icon = Icon(Icons.help);
  }
  return Padding(
    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
    child: Row(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Card(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.max,
                // children: <Widget>[
                //   Column(
                children: <Widget>[
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _icon,
                      Column(
                        children: <Widget>[
                          Text(info.deviceName),
                          Text(info.deviceOSVersion),
                        ],
                      ),
                    ],
                  ),
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // children: [
                  Text(
                    datetimeToShortString(DateTime.parse(info.sendTime)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "DevicePage_PluginsCountText".tr + info.pluginsCount.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    info.iPv4,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    info.iPv6,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
  );
}
