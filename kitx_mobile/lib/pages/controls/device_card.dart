import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kitx_mobile/converters/os_type_2_icon.dart';
import 'package:kitx_mobile/models/device_info.dart';
import 'package:kitx_mobile/models/enums/device_os_type.dart';
import 'package:kitx_mobile/utils/datetime_format.dart' show datetimeToShortString;
import 'package:kitx_mobile/utils/global.dart';

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

class _DeviceCard extends State<DeviceCard> with TickerProviderStateMixin {
  final DeviceInfoStruct? info;
  final int index;
  final double? width;

  _DeviceCard(this.info, this.index, {this.width});

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutCubicEmphasized,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // To check if this had been disposed.
    if (context.mounted) {
      _animationController.dispose();
    }

    super.dispose();
  }

  String getDeviceDisplayName(DeviceInfoStruct info) {
    var result = info.deviceName;

    if (info.deviceName == Global.deviceName) result += ' ${'DevicePage_LocalDevice'.tr}';
    if (info.isMainDevice) result += ' ${'DevicePage_MainDevice'.tr}';

    return result;
  }

  Color getDeviceCardColor(BuildContext context, DeviceInfoStruct info) {
    var result = context.theme.cardColor;

    if (info.deviceName == Global.deviceName) {
      result = context.isDarkMode ? Colors.indigo : Colors.limeAccent;
    }
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

    return ScaleTransition(
      scale: _animation,
      child: SizedBox(
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
      ),
    );
  }
}
