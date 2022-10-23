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
            itemBuilder: (_, int index) {
              return createDeviceCard(global.devices.deviceInfoList[index]);
            },
          )),
    );
  }
}

Widget createDeviceCard(DeviceInfo info) {
  IconData _iconStyle;
  switch (info.deviceOSType) {
    case 0:
      _iconStyle = Icons.android;
      break;
    case 1:
      _iconStyle = CommunityMaterialIcons.microsoft_edge;
      break;
    case 2:
      _iconStyle = CommunityMaterialIcons.freebsd;
      break;
    case 3:
      _iconStyle = CommunityMaterialIcons.apple_ios;
      break;
    case 4:
      _iconStyle = CommunityMaterialIcons.linux;
      break;
    case 5:
      _iconStyle = CommunityMaterialIcons.apple_finder;
      break;
    case 6:
      _iconStyle = CommunityMaterialIcons.apple;
      break;
    case 7:
      _iconStyle = CommunityMaterialIcons.apple;
      break;
    case 8:
      _iconStyle = CommunityMaterialIcons.apple;
      break;
    case 9:
      _iconStyle = CommunityMaterialIcons.microsoft_windows;
      break;
    default:
      _iconStyle = Icons.help;
  }
  Icon _icon = Icon(
    _iconStyle,
    size: 36,
  );
  return FractionallySizedBox(
    widthFactor: 0.9,
    child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Card(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 2, 0, 2),
                      child: _icon,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 3, 0, 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(info.deviceName),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(info.deviceOSVersion),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // crossAxisAlignment: CrossAxisAlignment.center,
                // children: [
                Text(
                  datetimeToShortString(DateTime.parse(info.sendTime)),
                  // textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Text(
                  "DevicePage_PluginsCountText".tr +
                      info.pluginsCount.toString(),
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      info.iPv4,
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      info.iPv6,
                      // textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        // ]),
        ),
  );
}
