import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'device_locator.g.dart';

abstract class DeviceLocator
    implements Built<DeviceLocator, DeviceLocatorBuilder> {
  String get DeviceName;

  String get IPv4;

  String get IPv6;

  String get DeviceMacAddress;

  DeviceLocator._();
  factory DeviceLocator([void Function(DeviceLocatorBuilder) updates]) =
      _$DeviceLocator;

  Object? toJson() {
    return serializers.serializeWith(DeviceLocator.serializer, this);
  }

  @override
  String toString() {
    return json
        .encode(serializers.serializeWith(DeviceLocator.serializer, this));
  }

  static DeviceLocator? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(DeviceLocator.serializer, json);
  }

  static DeviceLocator? fromString(String jsonString) {
    return serializers.deserializeWith(
        DeviceLocator.serializer, json.decode(jsonString));
  }

  static Serializer<DeviceLocator> get serializer => _$deviceLocatorSerializer;
}
