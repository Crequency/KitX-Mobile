
import 'package:community_material_icon/community_material_icon.dart';
import '../models/enums/device_os_type.dart';
import 'package:flutter/material.dart';

IconData Convert(DeviceOSTypeEnum os_type){
  var icon_type;
  switch (os_type) {
    case DeviceOSTypeEnum.Unknown:
      icon_type = Icons.help;
      break;
    case DeviceOSTypeEnum.Android:
      icon_type = Icons.android;
      break;
    case DeviceOSTypeEnum.Browser:
      icon_type = CommunityMaterialIcons.microsoft_edge;
      break;
    case DeviceOSTypeEnum.FreeBSD:
      icon_type = CommunityMaterialIcons.freebsd;
      break;
    case DeviceOSTypeEnum.iOS:
      icon_type = CommunityMaterialIcons.apple_ios;
      break;
    case DeviceOSTypeEnum.Linux:
      icon_type = CommunityMaterialIcons.linux;
      break;
    case DeviceOSTypeEnum.MacCatalyst:
      icon_type = CommunityMaterialIcons.apple;
      break;
    case DeviceOSTypeEnum.MacOS:
      icon_type = CommunityMaterialIcons.apple_keyboard_command;
      break;
    case DeviceOSTypeEnum.TvOS:
      icon_type = CommunityMaterialIcons.apple;
      break;
    case DeviceOSTypeEnum.WatchOS:
      icon_type = CommunityMaterialIcons.apple;
      break;
    case DeviceOSTypeEnum.Windows:
      icon_type = CommunityMaterialIcons.microsoft_windows;
      break;
    case DeviceOSTypeEnum.IoT:
      icon_type = CommunityMaterialIcons.chip;
      break;
    default:
      icon_type = Icons.help;
  }
  return icon_type;
}