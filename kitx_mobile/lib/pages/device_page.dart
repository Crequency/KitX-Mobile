import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/converters/os_type_2_icon.dart';
import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/models/enums/device_os_type.dart';
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
  var _scrollController = ScrollController();

  var deviceCardHorizontalScale = 0.5;
  var back2topButtonVisibility = false.obs;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >= MediaQuery.of(super.context).size.height * 0.3) {
        back2topButtonVisibility.value = true;
      } else {
        back2topButtonVisibility.value = false;
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DevicePage_Title'.tr),
        actions: [
          OrientationBuilder(
            builder: (context, _) => MediaQuery.of(context).orientation == Orientation.landscape
                ? PopupMenuButton(
                    tooltip: '',
                    padding: EdgeInsets.all(0),
                    icon: const Icon(Icons.view_column_outlined),
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text('2'),
                        onTap: () => deviceCardHorizontalScale = 0.5,
                      ),
                      PopupMenuItem(
                        child: const Text('3'),
                        onTap: () => deviceCardHorizontalScale = 1.0 / 3,
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
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
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: Obx(
        () => AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubicEmphasized,
          opacity: back2topButtonVisibility.value ? 1 : 0,
          child: FloatingActionButton(
            onPressed: () => _scrollController.animateTo(
              0.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubicEmphasized,
            ),
            child: const Icon(Icons.arrow_upward),
          ),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      body: ListView(
        controller: _scrollController,
        children: [
          Obx(
            () => Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Text('${Global.deviceService.length.obs} ${'HomePage_DevicesCount'.tr}'),
            ),
          ),
          const SizedBox(height: 25),
          OrientationBuilder(
            builder: (context, _) => MediaQuery.of(context).orientation == Orientation.portrait
                ? Obx(
                    () => ReorderableListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Global.deviceService.length + 1,
                      itemBuilder: (_, index) {
                        var list = Global.deviceService.deviceInfoList;
                        var info = index >= Global.deviceService.length ? null : list[index];
                        return DeviceCard(
                          info,
                          index,
                          key: Key('${info?.deviceName ?? ''}${info?.iPv4 ?? ''}'),
                        );
                      },
                      onReorder: (int oldIndex, int newIndex) {
                        var list = Global.deviceService.deviceInfoList;
                        var moveBack = newIndex > oldIndex;
                        list.insert(moveBack ? newIndex - 1 : newIndex, list.removeAt(oldIndex));
                      },
                    ),
                  )
                : Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Wrap(
                        spacing: 0.0,
                        runSpacing: 0.0,
                        children: [
                          for (var i = 0; i < Global.deviceService.length; ++i)
                            DeviceCard(
                              Global.deviceService.deviceInfoList[i],
                              i,
                              width: (MediaQuery.of(context).size.width - 20) * deviceCardHorizontalScale,
                              key: Key('${Global.deviceService.deviceInfoList[i].deviceName}'
                                  '${Global.deviceService.deviceInfoList[i].iPv4}'),
                            )
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

/// Device Card
class DeviceCard extends StatefulWidget {
  /// Constructor
  const DeviceCard(this.info, this.index, {super.key, this.width});

  /// Device Info Struct
  final DeviceInfoStruct? info;

  /// Index in ListView
  final int index;

  /// If width specified
  final double? width;

  @override
  State<DeviceCard> createState() => _DeviceCard(info, index, width: width);
}

class _DeviceCard extends State<DeviceCard> {
  final DeviceInfoStruct? info;
  final int index;
  final double? width;

  _DeviceCard(this.info, this.index, {this.width});

  @override
  void initState() {
    super.initState();
  }

  String getDeviceDisplayName(DeviceInfoStruct info) {
    var result = info.deviceName;

    if (info.deviceName == Global.deviceName) result += ' ${'DevicePage_LocalDevice'.tr}';
    if (info.isMainDevice) result += ' ${'DevicePage_MainDevice'.tr}';

    return result;
  }

  Color getDeviceCardColor(BuildContext context, DeviceInfoStruct info) {
    var result = context.theme.cardColor;

    if (info.deviceName == Global.deviceName) result = context.isDarkMode ? Colors.indigo : Colors.limeAccent;
    if (info.isMainDevice) result = context.isDarkMode ? Colors.deepPurple : Colors.tealAccent;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (info == null) return SizedBox(height: 300, width: width, key: Key('spacer'));

    var _iconStyle = Convert(info?.deviceOSType ?? DeviceOSTypeEnum.Unknown);
    var _icon = Icon(_iconStyle, size: 36);

    var cardColor = getDeviceCardColor(context, info ?? DeviceInfoStruct());
    var deviceName = getDeviceDisplayName(info ?? DeviceInfoStruct());

    return SizedBox(
      key: Key('${info?.deviceName ?? ''}${info?.iPv4 ?? ''}'),
      width: width,
      child: FractionallySizedBox(
        widthFactor: width == null ? 0.9 : 0.98,
        child: Padding(
          padding: EdgeInsets.only(bottom: width == null ? 20 : 8),
          child: Card(
            color: cardColor,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: context.iconColor?.withOpacity(0.3),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 2, 0, 2),
                          child: _icon,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(deviceName, style: const TextStyle(fontSize: 18)),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(info?.deviceOSVersion ?? ''),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(datetimeToShortString(info?.sendTime ?? DateTime.now()),
                        style: const TextStyle(fontSize: 14)),
                    Text(
                      'DevicePage_PluginsCountText'.tr + (info?.pluginsCount ?? 0).toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${info?.iPv4 ?? ''}:${info?.pluginServerPort ?? ''}',
                          style: const TextStyle(fontSize: 10),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              info?.iPv6 ?? '',
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 10),
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
      ),
    );
  }
}
