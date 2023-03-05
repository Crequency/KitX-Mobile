import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import 'package:kitx_mobile/models/enums/device_os_type.dart';

IconData Convert(DeviceOSTypeEnum os_type) {
  switch (os_type) {
    case DeviceOSTypeEnum.Unknown:
      return Icons.help;
    case DeviceOSTypeEnum.Android:
      return Icons.android;
    case DeviceOSTypeEnum.Browser:
      return CommunityMaterialIcons.microsoft_edge;
    case DeviceOSTypeEnum.FreeBSD:
      return CommunityMaterialIcons.freebsd;
    case DeviceOSTypeEnum.iOS:
      return CommunityMaterialIcons.apple_ios;
    case DeviceOSTypeEnum.Linux:
      return CommunityMaterialIcons.linux;
    case DeviceOSTypeEnum.MacCatalyst:
      return CommunityMaterialIcons.apple;
    case DeviceOSTypeEnum.MacOS:
      return CommunityMaterialIcons.apple_keyboard_command;
    case DeviceOSTypeEnum.TvOS:
      return CommunityMaterialIcons.apple;
    case DeviceOSTypeEnum.WatchOS:
      return CommunityMaterialIcons.apple;
    case DeviceOSTypeEnum.Windows:
      return CommunityMaterialIcons.microsoft_windows;
    case DeviceOSTypeEnum.IoT:
      return CommunityMaterialIcons.chip;
    default:
      return Icons.help;
  }
}
