// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_os_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeviceOSTypeEnum _$unknown = const DeviceOSTypeEnum._('Unknown');
const DeviceOSTypeEnum _$android = const DeviceOSTypeEnum._('Android');
const DeviceOSTypeEnum _$browser = const DeviceOSTypeEnum._('Browser');
const DeviceOSTypeEnum _$freeBSD = const DeviceOSTypeEnum._('FreeBSD');
const DeviceOSTypeEnum _$iOS = const DeviceOSTypeEnum._('iOS');
const DeviceOSTypeEnum _$linux = const DeviceOSTypeEnum._('Linux');
const DeviceOSTypeEnum _$macCatalyst = const DeviceOSTypeEnum._('MacCatalyst');
const DeviceOSTypeEnum _$macOS = const DeviceOSTypeEnum._('MacOS');
const DeviceOSTypeEnum _$tvOS = const DeviceOSTypeEnum._('TvOS');
const DeviceOSTypeEnum _$watchOS = const DeviceOSTypeEnum._('WatchOS');
const DeviceOSTypeEnum _$windows = const DeviceOSTypeEnum._('Windows');
const DeviceOSTypeEnum _$ioT = const DeviceOSTypeEnum._('IoT');

DeviceOSTypeEnum _$deviceOSTypeEnumValueOf(String name) {
  switch (name) {
    case 'Unknown':
      return _$unknown;
    case 'Android':
      return _$android;
    case 'Browser':
      return _$browser;
    case 'FreeBSD':
      return _$freeBSD;
    case 'iOS':
      return _$iOS;
    case 'Linux':
      return _$linux;
    case 'MacCatalyst':
      return _$macCatalyst;
    case 'MacOS':
      return _$macOS;
    case 'TvOS':
      return _$tvOS;
    case 'WatchOS':
      return _$watchOS;
    case 'Windows':
      return _$windows;
    case 'IoT':
      return _$ioT;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DeviceOSTypeEnum> _$deviceOSTypeEnumValues =
    new BuiltSet<DeviceOSTypeEnum>(const <DeviceOSTypeEnum>[
  _$unknown,
  _$android,
  _$browser,
  _$freeBSD,
  _$iOS,
  _$linux,
  _$macCatalyst,
  _$macOS,
  _$tvOS,
  _$watchOS,
  _$windows,
  _$ioT,
]);

Serializer<DeviceOSTypeEnum> _$deviceOSTypeEnumSerializer =
    new _$DeviceOSTypeEnumSerializer();

class _$DeviceOSTypeEnumSerializer
    implements PrimitiveSerializer<DeviceOSTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'Unknown': 0,
    'Android': 1,
    'Browser': 2,
    'FreeBSD': 3,
    'iOS': 4,
    'Linux': 5,
    'MacCatalyst': 6,
    'MacOS': 7,
    'TvOS': 8,
    'WatchOS': 9,
    'Windows': 10,
    'IoT': 11,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'Unknown',
    1: 'Android',
    2: 'Browser',
    3: 'FreeBSD',
    4: 'iOS',
    5: 'Linux',
    6: 'MacCatalyst',
    7: 'MacOS',
    8: 'TvOS',
    9: 'WatchOS',
    10: 'Windows',
    11: 'IoT',
  };

  @override
  final Iterable<Type> types = const <Type>[DeviceOSTypeEnum];
  @override
  final String wireName = 'DeviceOSTypeEnum';

  @override
  Object serialize(Serializers serializers, DeviceOSTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DeviceOSTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DeviceOSTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
