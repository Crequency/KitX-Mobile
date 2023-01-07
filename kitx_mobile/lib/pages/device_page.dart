import 'package:flutter/material.dart';

import 'package:community_material_icon/community_material_icon.dart';

import 'package:get/get.dart';

import '../models/device_info.dart';
import '../models/enums/device_os_type.dart';

import '../utils/global.dart' as global;
import '../utils/datetime_format.dart' show datetimeToShortString;

class DevicePage extends StatefulWidget {
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {
  @override
  Widget build(BuildContext context) {
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

Widget createDeviceCard(DeviceInfoStruct info) {
    IconData _iconStyle;
    switch (info.DeviceOSType) {
        case DeviceOSTypeEnum.Unknown:
            _iconStyle = Icons.help;
            break;
        case DeviceOSTypeEnum.Android:
            _iconStyle = Icons.android;
            break;
        case DeviceOSTypeEnum.Browser:
            _iconStyle = CommunityMaterialIcons.microsoft_edge;
            break;
        case DeviceOSTypeEnum.FreeBSD:
            _iconStyle = CommunityMaterialIcons.freebsd;
            break;
        case DeviceOSTypeEnum.iOS:
            _iconStyle = CommunityMaterialIcons.apple_ios;
            break;
        case DeviceOSTypeEnum.Linux:
            _iconStyle = CommunityMaterialIcons.linux;
            break;
        case DeviceOSTypeEnum.MacCatalyst:
            _iconStyle = CommunityMaterialIcons.apple_finder;
            break;
        case DeviceOSTypeEnum.MacOS:
            _iconStyle = CommunityMaterialIcons.apple;
            break;
        case DeviceOSTypeEnum.TvOS:
            _iconStyle = CommunityMaterialIcons.apple;
            break;
        case DeviceOSTypeEnum.WatchOS:
            _iconStyle = CommunityMaterialIcons.apple;
            break;
        case DeviceOSTypeEnum.Windows:
            _iconStyle = CommunityMaterialIcons.microsoft_windows;
            break;
        case DeviceOSTypeEnum.IoT:
            _iconStyle = CommunityMaterialIcons.chip;
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
                                                            child: Text(info.DeviceName == global.DeviceName
                                                                    ? info.DeviceName + " " + "DevicePage_LocalDevice".tr
                                                                    : info.DeviceName),
                                                        ),
                                                        SingleChildScrollView(
                                                            scrollDirection: Axis.horizontal,
                                                            child: Text(info.DeviceOSVersion),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                                Text(
                                    datetimeToShortString(info.SendTime),
                                    style: TextStyle(
                                        fontSize: 14,
                                    ),
                                ),
                                Text(
                                    "DevicePage_PluginsCountText".tr +
                                            info.PluginsCount.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                    ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Text(
                                            info.IPv4,
                                            style: TextStyle(
                                                fontSize: 10,
                                            ),
                                        ),
                                        Flexible(
                                            child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                    info.IPv6,
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ],
                                ),
                            ],
                        ),
                    ),
                )
                ),
    );
}
