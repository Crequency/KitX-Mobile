import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'enums/device_os_type.dart';

import 'serializers.dart';

part 'device_info.g.dart';

abstract class DeviceInfoStruct implements Built<DeviceInfoStruct, DeviceInfoStructBuilder> {
  @BuiltValueField(wireName: 'DeviceName')
  String get deviceName;

  @BuiltValueField(wireName: 'DeviceOSVersion')
  String get deviceOSVersion;

  @BuiltValueField(wireName: 'IPv4')
  String get iPv4;

  @BuiltValueField(wireName: 'IPv6')
  String get iPv6;

  @BuiltValueField(wireName: 'DeviceMacAddress')
  String get deviceMacAddress;

  @BuiltValueField(wireName: 'PluginServerPort')
  int get pluginServerPort;

  @BuiltValueField(wireName: 'PluginsCount')
  int get pluginsCount;

  @BuiltValueField(wireName: 'SendTime')
  DateTime get sendTime;

  @BuiltValueField(wireName: 'IsMainDevice')
  bool get isMainDevice;

  @BuiltValueField(wireName: 'DeviceServerPort')
  int get deviceServerPort;

  @BuiltValueField(wireName: 'DeviceServerBuildTime')
  DateTime get deviceServerBuildTime;

  @BuiltValueField(wireName: 'DeviceOSType')
  DeviceOSTypeEnum get deviceOSType;

  DeviceInfoStruct._();
  factory DeviceInfoStruct([void Function(DeviceInfoStructBuilder) updates]) = _$DeviceInfoStruct;

  Object? toJson() {
    return serializers.serializeWith(DeviceInfoStruct.serializer, this);
  }

  @override
  String toString() {
    return json.encode(serializers.serializeWith(DeviceInfoStruct.serializer, this));
  }

  static DeviceInfoStruct? fromString(String jsonString) {
    DeviceInfoStruct? result =
        serializers.deserializeWith(DeviceInfoStruct.serializer, json.decode(jsonString));
    return result;
  }

  static DeviceInfoStruct? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(DeviceInfoStruct.serializer, json);
  }

  static Serializer<DeviceInfoStruct> get serializer => _$deviceInfoStructSerializer;
}
