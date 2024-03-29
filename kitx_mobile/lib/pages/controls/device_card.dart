﻿import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kitx_mobile/instances.dart';
import 'package:kitx_mobile/utils/datetime_format.dart' show datetimeToShortString;
import 'package:kitx_mobile/utils/extensions/operating_systems_to_icon.dart';
import 'package:kitx_mobile/utils/handlers/tasks/delayed_task.dart';
import 'package:kitx_shared_dart/kitx_shared_dart.dart';

/// Device Card
class DeviceCard extends StatefulWidget {
  /// Constructor
  const DeviceCard(
    this.info,
    this.index, {
    super.key,
    this.width,
    this.shouldDelay,
    this.shouldScaleIn,
    this.onScale,
    this.onScaleEnd,
    this.onTap,
    this.onLongPress,
  });

  /// Device Info Struct
  final DeviceInfo? info;

  /// Index in ListView
  final int index;

  /// If width specified
  final double? width;

  /// Should delay for appear
  final bool? shouldDelay;

  /// Should scale in
  final bool? shouldScaleIn;

  /// On scale function
  final Function? onScale;

  /// On scale end function
  final Function? onScaleEnd;

  /// On widget tapped
  final VoidCallback? onTap;

  /// On widget long pressed
  final VoidCallback? onLongPress;

  @override
  State<DeviceCard> createState() => _DeviceCard();
}

class _DeviceCard extends State<DeviceCard> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 700),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOutCubicEmphasized,
  );

  @override
  void initState() {
    var onScale = widget.onScale;
    var onScaleEnd = widget.onScaleEnd;
    var shouldScaleIn = widget.shouldScaleIn;
    var shouldDelay = widget.shouldDelay;
    var index = widget.index;

    onScale?.call();

    if (shouldScaleIn ?? true) {
      if (shouldDelay ?? true) {
        (() => _animationController.forward().then((value) => onScaleEnd?.call())).delay(milliseconds: 150 * index).execute();
      } else {
        _animationController.forward().then((value) => onScaleEnd?.call());
      }
    } else {
      _animationController
        ..duration = const Duration(milliseconds: 0)
        ..forward().then((value) => onScaleEnd?.call());
    }

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

  String getDeviceDisplayName(DeviceInfo info) {
    var result = info.device.deviceName;

    if (info.device.deviceName == instances.deviceInfo.deviceName) {
      result += ' ${'DevicesPage_LocalDevice'.tr}';
    }
    if (info.isMainDevice) result += ' ${'DevicesPage_MainDevice'.tr}';

    return result;
  }

  Color getDeviceCardColor(BuildContext context, DeviceInfo info) {
    var result = context.theme.cardColor;

    if (info.device.deviceName == instances.deviceInfo.deviceName) {
      result = context.isDarkMode ? Colors.indigo : Colors.limeAccent;
    }
    if (info.isMainDevice) result = context.isDarkMode ? Colors.deepPurple : Colors.tealAccent;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var info = widget.info;
    var width = widget.width;

    if (info == null) return SizedBox(height: 300, width: widget.width, key: Key('spacer'));

    var _iconStyle = info.deviceOSType.toIconData();
    var _icon = Icon(_iconStyle, size: 36);

    var cardColor = getDeviceCardColor(context, info);
    var deviceName = getDeviceDisplayName(info);

    return ScaleTransition(
      scale: _animation,
      child: SizedBox(
        width: width,
        child: FractionallySizedBox(
          widthFactor: width == null ? 0.9 : 0.98,
          child: Padding(
            padding: EdgeInsets.only(bottom: width == null ? 20 : 8),
            child: badges.Badge(
              badgeContent: Text(
                'DevicesPage_PluginsCountText'.tr.replaceAll('%count%', (info.pluginsCount).toString()),
                style: const TextStyle(color: Colors.white),
              ),
              position: badges.BadgePosition.topEnd(top: 70, end: 15),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.square,
                badgeColor: Get.isDarkMode ? Colors.white12 : Colors.black87,
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                borderRadius: BorderRadius.circular(45),
                elevation: 0,
              ),
              child: Card(
                color: cardColor,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: context.iconColor?.withOpacity(0.3),
                  onTap: widget.onTap,
                  onLongPress: widget.onLongPress,
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
                                      child: Text(info.deviceOSVersion),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(datetimeToShortString(info.sendTime)),
                        Text(info.device.macAddress),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${info.device.iPv4}:${info.pluginsServerPort}',
                              style: const TextStyle(fontSize: 12),
                            ),
                            const SizedBox(width: 30),
                            Flexible(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  info.device.iPv6,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 12),
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
      ),
    );
  }
}
