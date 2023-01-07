import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'enums/device_os_type.dart';

import 'serializers.dart';

part 'device_info.g.dart';

abstract class DeviceInfoStruct implements Built<DeviceInfoStruct, DeviceInfoStructBuilder> {
    String get DeviceName;

    String get DeviceOSVersion;

    String get IPv4;

    String get IPv6;

    String get DeviceMacAddress;

    int get PluginServerPort;

    int get PluginsCount;

    DateTime get SendTime;

    bool get IsMainDevice;

    int get DeviceServerPort;

    DateTime get DeviceServerBuildTime;
    
    DeviceOSTypeEnum get DeviceOSType;

    DeviceInfoStruct._();
    factory DeviceInfoStruct([void Function(DeviceInfoStructBuilder) updates]) = _$DeviceInfoStruct;

    Object? toJson() {
        return serializers.serializeWith(DeviceInfoStruct.serializer, this);
    }

    String toString() {
        return json.encode(serializers.serializeWith(DeviceInfoStruct.serializer, this));
    }

    static DeviceInfoStruct? fromString(String jsonString) {
        DeviceInfoStruct? result = serializers.deserializeWith(DeviceInfoStruct.serializer, json.decode(jsonString));
        return result;
    }

    static DeviceInfoStruct? fromJson(Map<String, dynamic> json) {
        return serializers.deserializeWith(DeviceInfoStruct.serializer, json);
    }

    static Serializer<DeviceInfoStruct> get serializer => _$deviceInfoStructSerializer;
}
