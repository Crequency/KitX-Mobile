import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/converters/os_type_2_icon.dart';
import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/utils/datetime_format.dart' show datetimeToShortString;
import 'package:kitx_mobile/utils/global.dart';

/// Device Page
class DevicePage extends StatefulWidget {
  // ignore: public_member_api_docs
  const DevicePage({Key? key}) : super(key: key);

  @override
  State<DevicePage> createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DevicePage_Title'.tr),
        actions: [
          PopupMenuButton(
            tooltip: '',
            padding: EdgeInsets.all(0),
            icon: const Icon(CommunityMaterialIcons.refresh),
            position: PopupMenuPosition.under,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text('Option_RestartDevicesServer'.tr),
                onTap: Global.restartDevicesServer,
              ),
              PopupMenuItem(
                child: Text('Option_ShutdownDevicesServer'.tr),
                onTap: Global.shutdownDevicesServer,
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          Obx(
            () => Container(
              margin: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Text('${Global.deviceService.length.obs} ${'HomePage_DevicesCount'.tr}'),
            ),
          ),
          Obx(
            () => ReorderableListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Global.deviceService.length + 1,
              itemBuilder: (_, index) {
                var list = Global.deviceService.deviceInfoList;
                var info = index >= Global.deviceService.length ? null : list[index];
                return createDeviceCard(context, info, index);
              },
              onReorder: (int oldIndex, int newIndex) {
                var list = Global.deviceService.deviceInfoList;
                var moveBack = newIndex > oldIndex;
                list.insert(moveBack ? newIndex - 1 : newIndex, list.removeAt(oldIndex));
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Get device display name
  String getDeviceDisplayName(DeviceInfoStruct info) {
    var result = info.deviceName;

    if (info.deviceName == Global.deviceName) result += ' ${'DevicePage_LocalDevice'.tr}';
    if (info.isMainDevice) result += ' ${'DevicePage_MainDevice'.tr}';

    return result;
  }

  /// Get device card color
  Color getDeviceCardColor(BuildContext context, DeviceInfoStruct info) {
    var result = context.theme.cardColor;

    if (info.deviceName == Global.deviceName) result = context.isDarkMode ? Colors.indigo : Colors.limeAccent;
    if (info.isMainDevice) result = context.isDarkMode ? Colors.deepPurple : Colors.tealAccent;

    return result;
  }

  var mainDeviceUpdatedSignal = false.obs;

  Widget createDeviceCard(BuildContext context, DeviceInfoStruct? info, int index) {
    if (info == null) return Container(height: 300, key: Key('spacer'));

    var _iconStyle = Convert(info.deviceOSType);
    var _icon = Icon(
      _iconStyle,
      size: 36,
    );

    var cardColor = getDeviceCardColor(context, info);
    var deviceName = getDeviceDisplayName(info);

    return FractionallySizedBox(
      key: Key('${info.deviceName}${info.iPv4}'),
      widthFactor: 0.9,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, index == 0 ? 25 : 0, 0, 20),
        child: Card(
          color: cardColor,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            splashColor: context.iconColor?.withOpacity(0.3),
            onTap: () {},
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
                                  deviceName,
                                  style: TextStyle(fontSize: 18),
                                ),
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
                    'DevicePage_PluginsCountText'.tr + info.pluginsCount.toString(),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${info.iPv4}:${info.pluginServerPort}',
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
          ),
        ),
      ),
    );
  }
}
