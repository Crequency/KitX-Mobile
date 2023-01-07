// JSON 序列化器 如果需要添加新的模型, 需要在这里添加

library serializers;

import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'device_info.dart';
import 'enums/device_os_type.dart';

part 'serializers.g.dart';

@SerializersFor([
    // TODO: add the built values that require serialization
    // TODO: 添加需要序列化的 built value
    DeviceInfoStruct,
    // DeviceOSType,
])

/// Can add additional plugins that will serialize types like [DateTime]
///   - It is also possible to write your own Serializer plugins for type that
///     are not supported by default.
///   - For Example: https://github.com/google/built_value.dart/issues/543
///     implements [SerializerPlugin] and writes a serializer for Firebase
///     Datetime that converts TimeStamp or DateTime to integers.
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..add(Iso8601DateTimeSerializer()))
    .build();
