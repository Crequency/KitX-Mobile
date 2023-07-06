import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/widgets.dart';

part 'device_os_type.g.dart';

class DeviceOSTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 0)
  static const DeviceOSTypeEnum Unknown = _$unknown;

  @BuiltValueEnumConst(wireNumber: 1)
  static const DeviceOSTypeEnum Android = _$android;

  @BuiltValueEnumConst(wireNumber: 2)
  static const DeviceOSTypeEnum Browser = _$browser;

  @BuiltValueEnumConst(wireNumber: 3)
  static const DeviceOSTypeEnum FreeBSD = _$freeBSD;

  @BuiltValueEnumConst(wireNumber: 4)
  static const DeviceOSTypeEnum iOS = _$iOS;

  @BuiltValueEnumConst(wireNumber: 5)
  static const DeviceOSTypeEnum Linux = _$linux;

  @BuiltValueEnumConst(wireNumber: 6)
  static const DeviceOSTypeEnum MacCatalyst = _$macCatalyst;

  @BuiltValueEnumConst(wireNumber: 7)
  static const DeviceOSTypeEnum MacOS = _$macOS;

  @BuiltValueEnumConst(wireNumber: 8)
  static const DeviceOSTypeEnum TvOS = _$tvOS;

  @BuiltValueEnumConst(wireNumber: 9)
  static const DeviceOSTypeEnum WatchOS = _$watchOS;

  @BuiltValueEnumConst(wireNumber: 10)
  static const DeviceOSTypeEnum Windows = _$windows;

  @BuiltValueEnumConst(wireNumber: 11)
  static const DeviceOSTypeEnum IoT = _$ioT;

  const DeviceOSTypeEnum._(String name) : super(name);

  static BuiltSet<DeviceOSTypeEnum> get values => _$deviceOSTypeEnumValues;
  static DeviceOSTypeEnum valueOf(String name) => _$deviceOSTypeEnumValueOf(name);

  static Serializer<DeviceOSTypeEnum> get serializer => _$deviceOSTypeEnumSerializer;
}

/// Device OS Type Enum Extensions
extension DeviceOSTypeEnumExtensions on DeviceOSTypeEnum {
  /// Convert [DeviceOSTypeEnum] to [IconData]
  IconData toIconData() {
    switch (this) {
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

  /// Convert [DeviceOSTypeEnum] to [int]
  int toInt(DeviceOSTypeEnum type) {
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
}
