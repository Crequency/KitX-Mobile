import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/device_info.dart';

import '../converters/os_type_2_icon.dart';

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
            itemCount: global.devices.length + 1,
            itemBuilder: (_, int index) {
              return createDeviceCard(context,
                  index >= global.devices.length ? null : global.devices.deviceInfoList[index], index);
            },
          )),

      // body: Obx(() => AnimatedList(
      //       initialItemCount: global.devices.length,
      //       itemBuilder: (context, index, animation) => createDeviceCard(
      //           context, global.devices.deviceInfoList[index], index),
      //     ))
    );
  }
}

Widget createDeviceCard(BuildContext context, DeviceInfoStruct? info, int index) {
  if (info == null) return Container(height: 300);

  IconData _iconStyle = Convert(info.DeviceOSType);
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
              onTap: () => print(info.DeviceName + " card tapped."),
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
                      "DevicePage_PluginsCountText".tr + info.PluginsCount.toString(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${info.IPv4}:${info.PluginServerPort}",
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
            ))),
  );
}
