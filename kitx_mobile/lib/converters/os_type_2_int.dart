// ignore_for_file: non_constant_identifier_names

import 'package:kitx_mobile/models/enums/device_os_type.dart';

/// Convert [DeviceOSTypeEnum] to [int]
int Convert(DeviceOSTypeEnum type) {
  switch (type) {
    case DeviceOSTypeEnum.Unknown:
      return 0;
    case DeviceOSTypeEnum.Android:
      return 1;
    case DeviceOSTypeEnum.Browser:
      return 2;
    case DeviceOSTypeEnum.FreeBSD:
      return 3;
    case DeviceOSTypeEnum.iOS:
      return 4;
    case DeviceOSTypeEnum.Linux:
      return 5;
    case DeviceOSTypeEnum.MacCatalyst:
      return 6;
    case DeviceOSTypeEnum.MacOS:
      return 7;
    case DeviceOSTypeEnum.TvOS:
      return 8;
    case DeviceOSTypeEnum.WatchOS:
      return 9;
    case DeviceOSTypeEnum.Windows:
      return 10;
    case DeviceOSTypeEnum.IoT:
      return 11;
    default:
      return 0;
  }
}

/// Convert [int] to [DeviceOSTypeEnum]
DeviceOSTypeEnum ConvertBack(int type) {
  switch (type) {
    case 0:
      return DeviceOSTypeEnum.Unknown;
    case 1:
      return DeviceOSTypeEnum.Android;
    case 2:
      return DeviceOSTypeEnum.Browser;
    case 3:
      return DeviceOSTypeEnum.FreeBSD;
    case 4:
      return DeviceOSTypeEnum.iOS;
    case 5:
      return DeviceOSTypeEnum.Linux;
    case 6:
      return DeviceOSTypeEnum.MacCatalyst;
    case 7:
      return DeviceOSTypeEnum.MacOS;
    case 8:
      return DeviceOSTypeEnum.TvOS;
    case 9:
      return DeviceOSTypeEnum.WatchOS;
    case 10:
      return DeviceOSTypeEnum.Windows;
    case 11:
      return DeviceOSTypeEnum.IoT;
    default:
      return DeviceOSTypeEnum.Unknown;
  }
}
