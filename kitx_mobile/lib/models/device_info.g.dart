// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DeviceInfoStruct> _$deviceInfoStructSerializer =
    new _$DeviceInfoStructSerializer();

class _$DeviceInfoStructSerializer
    implements StructuredSerializer<DeviceInfoStruct> {
  @override
  final Iterable<Type> types = const [DeviceInfoStruct, _$DeviceInfoStruct];
  @override
  final String wireName = 'DeviceInfoStruct';

  @override
  Iterable<Object?> serialize(Serializers serializers, DeviceInfoStruct object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'DeviceName',
      serializers.serialize(object.DeviceName,
          specifiedType: const FullType(String)),
      'DeviceOSVersion',
      serializers.serialize(object.DeviceOSVersion,
          specifiedType: const FullType(String)),
      'IPv4',
      serializers.serialize(object.IPv4, specifiedType: const FullType(String)),
      'IPv6',
      serializers.serialize(object.IPv6, specifiedType: const FullType(String)),
      'DeviceMacAddress',
      serializers.serialize(object.DeviceMacAddress,
          specifiedType: const FullType(String)),
      'PluginServerPort',
      serializers.serialize(object.PluginServerPort,
          specifiedType: const FullType(int)),
      'PluginsCount',
      serializers.serialize(object.PluginsCount,
          specifiedType: const FullType(int)),
      'SendTime',
      serializers.serialize(object.SendTime,
          specifiedType: const FullType(DateTime)),
      'IsMainDevice',
      serializers.serialize(object.IsMainDevice,
          specifiedType: const FullType(bool)),
      'DeviceServerPort',
      serializers.serialize(object.DeviceServerPort,
          specifiedType: const FullType(int)),
      'DeviceServerBuildTime',
      serializers.serialize(object.DeviceServerBuildTime,
          specifiedType: const FullType(DateTime)),
      'DeviceOSType',
      serializers.serialize(object.DeviceOSType,
          specifiedType: const FullType(DeviceOSTypeEnum)),
    ];

    return result;
  }

  @override
  DeviceInfoStruct deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DeviceInfoStructBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'DeviceName':
          result.DeviceName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'DeviceOSVersion':
          result.DeviceOSVersion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'IPv4':
          result.IPv4 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'IPv6':
          result.IPv6 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'DeviceMacAddress':
          result.DeviceMacAddress = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'PluginServerPort':
          result.PluginServerPort = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'PluginsCount':
          result.PluginsCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'SendTime':
          result.SendTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'IsMainDevice':
          result.IsMainDevice = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'DeviceServerPort':
          result.DeviceServerPort = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'DeviceServerBuildTime':
          result.DeviceServerBuildTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'DeviceOSType':
          result.DeviceOSType = serializers.deserialize(value,
                  specifiedType: const FullType(DeviceOSTypeEnum))!
              as DeviceOSTypeEnum;
          break;
      }
    }

    return result.build();
  }
}

class _$DeviceInfoStruct extends DeviceInfoStruct {
  @override
  final String DeviceName;
  @override
  final String DeviceOSVersion;
  @override
  final String IPv4;
  @override
  final String IPv6;
  @override
  final String DeviceMacAddress;
  @override
  final int PluginServerPort;
  @override
  final int PluginsCount;
  @override
  final DateTime SendTime;
  @override
  final bool IsMainDevice;
  @override
  final int DeviceServerPort;
  @override
  final DateTime DeviceServerBuildTime;
  @override
  final DeviceOSTypeEnum DeviceOSType;

  factory _$DeviceInfoStruct(
          [void Function(DeviceInfoStructBuilder)? updates]) =>
      (new DeviceInfoStructBuilder()..update(updates))._build();

  _$DeviceInfoStruct._(
      {required this.DeviceName,
      required this.DeviceOSVersion,
      required this.IPv4,
      required this.IPv6,
      required this.DeviceMacAddress,
      required this.PluginServerPort,
      required this.PluginsCount,
      required this.SendTime,
      required this.IsMainDevice,
      required this.DeviceServerPort,
      required this.DeviceServerBuildTime,
      required this.DeviceOSType})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        DeviceName, r'DeviceInfoStruct', 'DeviceName');
    BuiltValueNullFieldError.checkNotNull(
        DeviceOSVersion, r'DeviceInfoStruct', 'DeviceOSVersion');
    BuiltValueNullFieldError.checkNotNull(IPv4, r'DeviceInfoStruct', 'IPv4');
    BuiltValueNullFieldError.checkNotNull(IPv6, r'DeviceInfoStruct', 'IPv6');
    BuiltValueNullFieldError.checkNotNull(
        DeviceMacAddress, r'DeviceInfoStruct', 'DeviceMacAddress');
    BuiltValueNullFieldError.checkNotNull(
        PluginServerPort, r'DeviceInfoStruct', 'PluginServerPort');
    BuiltValueNullFieldError.checkNotNull(
        PluginsCount, r'DeviceInfoStruct', 'PluginsCount');
    BuiltValueNullFieldError.checkNotNull(
        SendTime, r'DeviceInfoStruct', 'SendTime');
    BuiltValueNullFieldError.checkNotNull(
        IsMainDevice, r'DeviceInfoStruct', 'IsMainDevice');
    BuiltValueNullFieldError.checkNotNull(
        DeviceServerPort, r'DeviceInfoStruct', 'DeviceServerPort');
    BuiltValueNullFieldError.checkNotNull(
        DeviceServerBuildTime, r'DeviceInfoStruct', 'DeviceServerBuildTime');
    BuiltValueNullFieldError.checkNotNull(
        DeviceOSType, r'DeviceInfoStruct', 'DeviceOSType');
  }

  @override
  DeviceInfoStruct rebuild(void Function(DeviceInfoStructBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeviceInfoStructBuilder toBuilder() =>
      new DeviceInfoStructBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeviceInfoStruct &&
        DeviceName == other.DeviceName &&
        DeviceOSVersion == other.DeviceOSVersion &&
        IPv4 == other.IPv4 &&
        IPv6 == other.IPv6 &&
        DeviceMacAddress == other.DeviceMacAddress &&
        PluginServerPort == other.PluginServerPort &&
        PluginsCount == other.PluginsCount &&
        SendTime == other.SendTime &&
        IsMainDevice == other.IsMainDevice &&
        DeviceServerPort == other.DeviceServerPort &&
        DeviceServerBuildTime == other.DeviceServerBuildTime &&
        DeviceOSType == other.DeviceOSType;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, DeviceName.hashCode),
                                                DeviceOSVersion.hashCode),
                                            IPv4.hashCode),
                                        IPv6.hashCode),
                                    DeviceMacAddress.hashCode),
                                PluginServerPort.hashCode),
                            PluginsCount.hashCode),
                        SendTime.hashCode),
                    IsMainDevice.hashCode),
                DeviceServerPort.hashCode),
            DeviceServerBuildTime.hashCode),
        DeviceOSType.hashCode));
  }
}

class DeviceInfoStructBuilder
    implements Builder<DeviceInfoStruct, DeviceInfoStructBuilder> {
  _$DeviceInfoStruct? _$v;

  String? _DeviceName;
  String? get DeviceName => _$this._DeviceName;
  set DeviceName(String? DeviceName) => _$this._DeviceName = DeviceName;

  String? _DeviceOSVersion;
  String? get DeviceOSVersion => _$this._DeviceOSVersion;
  set DeviceOSVersion(String? DeviceOSVersion) =>
      _$this._DeviceOSVersion = DeviceOSVersion;

  String? _IPv4;
  String? get IPv4 => _$this._IPv4;
  set IPv4(String? IPv4) => _$this._IPv4 = IPv4;

  String? _IPv6;
  String? get IPv6 => _$this._IPv6;
  set IPv6(String? IPv6) => _$this._IPv6 = IPv6;

  String? _DeviceMacAddress;
  String? get DeviceMacAddress => _$this._DeviceMacAddress;
  set DeviceMacAddress(String? DeviceMacAddress) =>
      _$this._DeviceMacAddress = DeviceMacAddress;

  int? _PluginServerPort;
  int? get PluginServerPort => _$this._PluginServerPort;
  set PluginServerPort(int? PluginServerPort) =>
      _$this._PluginServerPort = PluginServerPort;

  int? _PluginsCount;
  int? get PluginsCount => _$this._PluginsCount;
  set PluginsCount(int? PluginsCount) => _$this._PluginsCount = PluginsCount;

  DateTime? _SendTime;
  DateTime? get SendTime => _$this._SendTime;
  set SendTime(DateTime? SendTime) => _$this._SendTime = SendTime;

  bool? _IsMainDevice;
  bool? get IsMainDevice => _$this._IsMainDevice;
  set IsMainDevice(bool? IsMainDevice) => _$this._IsMainDevice = IsMainDevice;

  int? _DeviceServerPort;
  int? get DeviceServerPort => _$this._DeviceServerPort;
  set DeviceServerPort(int? DeviceServerPort) =>
      _$this._DeviceServerPort = DeviceServerPort;

  DateTime? _DeviceServerBuildTime;
  DateTime? get DeviceServerBuildTime => _$this._DeviceServerBuildTime;
  set DeviceServerBuildTime(DateTime? DeviceServerBuildTime) =>
      _$this._DeviceServerBuildTime = DeviceServerBuildTime;

  DeviceOSTypeEnum? _DeviceOSType;
  DeviceOSTypeEnum? get DeviceOSType => _$this._DeviceOSType;
  set DeviceOSType(DeviceOSTypeEnum? DeviceOSType) =>
      _$this._DeviceOSType = DeviceOSType;

  DeviceInfoStructBuilder();

  DeviceInfoStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _DeviceName = $v.DeviceName;
      _DeviceOSVersion = $v.DeviceOSVersion;
      _IPv4 = $v.IPv4;
      _IPv6 = $v.IPv6;
      _DeviceMacAddress = $v.DeviceMacAddress;
      _PluginServerPort = $v.PluginServerPort;
      _PluginsCount = $v.PluginsCount;
      _SendTime = $v.SendTime;
      _IsMainDevice = $v.IsMainDevice;
      _DeviceServerPort = $v.DeviceServerPort;
      _DeviceServerBuildTime = $v.DeviceServerBuildTime;
      _DeviceOSType = $v.DeviceOSType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeviceInfoStruct other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeviceInfoStruct;
  }

  @override
  void update(void Function(DeviceInfoStructBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeviceInfoStruct build() => _build();

  _$DeviceInfoStruct _build() {
    final _$result = _$v ??
        new _$DeviceInfoStruct._(
            DeviceName: BuiltValueNullFieldError.checkNotNull(
                DeviceName, r'DeviceInfoStruct', 'DeviceName'),
            DeviceOSVersion: BuiltValueNullFieldError.checkNotNull(
                DeviceOSVersion, r'DeviceInfoStruct', 'DeviceOSVersion'),
            IPv4: BuiltValueNullFieldError.checkNotNull(
                IPv4, r'DeviceInfoStruct', 'IPv4'),
            IPv6: BuiltValueNullFieldError.checkNotNull(
                IPv6, r'DeviceInfoStruct', 'IPv6'),
            DeviceMacAddress: BuiltValueNullFieldError.checkNotNull(
                DeviceMacAddress, r'DeviceInfoStruct', 'DeviceMacAddress'),
            PluginServerPort: BuiltValueNullFieldError.checkNotNull(
                PluginServerPort, r'DeviceInfoStruct', 'PluginServerPort'),
            PluginsCount: BuiltValueNullFieldError.checkNotNull(
                PluginsCount, r'DeviceInfoStruct', 'PluginsCount'),
            SendTime: BuiltValueNullFieldError.checkNotNull(
                SendTime, r'DeviceInfoStruct', 'SendTime'),
            IsMainDevice: BuiltValueNullFieldError.checkNotNull(IsMainDevice, r'DeviceInfoStruct', 'IsMainDevice'),
            DeviceServerPort: BuiltValueNullFieldError.checkNotNull(DeviceServerPort, r'DeviceInfoStruct', 'DeviceServerPort'),
            DeviceServerBuildTime: BuiltValueNullFieldError.checkNotNull(DeviceServerBuildTime, r'DeviceInfoStruct', 'DeviceServerBuildTime'),
            DeviceOSType: BuiltValueNullFieldError.checkNotNull(DeviceOSType, r'DeviceInfoStruct', 'DeviceOSType'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
