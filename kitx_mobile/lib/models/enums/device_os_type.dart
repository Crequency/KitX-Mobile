import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

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
