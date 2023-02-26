import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/device_info.dart';

import '../converters/os_type_2_icon.dart';

import '../utils/global.dart';
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
      body: ListView(
        children: [
          Obx(
            () => Container(
              margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Text(
                  "${Global.devices.length.obs} " + "HomePage_DevicesCount".tr),
            ),
          ),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Global.devices.length + 1,
              itemBuilder: (_, int index) {
                return createDeviceCard(
                    context,
                    index >= Global.devices.length
                        ? null
                        : Global.devices.deviceInfoList[index],
                    index);
              },
            ),
          ),
        ],
      ),

      // body: Obx(() => AnimatedList(
      //       initialItemCount: Global.devices.length,
      //       itemBuilder: (context, index, animation) => createDeviceCard(
      //           context, Global.devices.deviceInfoList[index], index),
      //     ))
    );
  }
}

Widget createDeviceCard(
    BuildContext context, DeviceInfoStruct? info, int index) {
  if (info == null) return Container(height: 300);

  IconData _iconStyle = Convert(info.deviceOSType);
  Icon _icon = Icon(
    _iconStyle,
    size: 36,
  );
  return FractionallySizedBox(
    widthFactor: 0.9,
    child: Padding(
        padding: EdgeInsets.fromLTRB(0, index == 0 ? 25 : 0, 0, 20),
        child: Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: context.iconColor?.withOpacity(0.3),
              onTap: () => print(info.deviceName + " card tapped."),
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
                                  child: Text(
                                      info.deviceName == Global.deviceName
                                          ? info.deviceName +
                                              " " +
                                              "DevicePage_LocalDevice".tr
                                          : info.deviceName),
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
                    Text(
                      datetimeToShortString(info.sendTime),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "DevicePage_PluginsCountText".tr +
                          info.pluginsCount.toString(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${info.iPv4}:${info.pluginServerPort}",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              info.iPv6,
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
            ))),
  );
}
