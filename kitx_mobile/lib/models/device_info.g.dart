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
      serializers.serialize(object.deviceName,
          specifiedType: const FullType(String)),
      'DeviceOSVersion',
      serializers.serialize(object.deviceOSVersion,
          specifiedType: const FullType(String)),
      'IPv4',
      serializers.serialize(object.iPv4, specifiedType: const FullType(String)),
      'IPv6',
      serializers.serialize(object.iPv6, specifiedType: const FullType(String)),
      'DeviceMacAddress',
      serializers.serialize(object.deviceMacAddress,
          specifiedType: const FullType(String)),
      'PluginServerPort',
      serializers.serialize(object.pluginServerPort,
          specifiedType: const FullType(int)),
      'PluginsCount',
      serializers.serialize(object.pluginsCount,
          specifiedType: const FullType(int)),
      'SendTime',
      serializers.serialize(object.sendTime,
          specifiedType: const FullType(DateTime)),
      'IsMainDevice',
      serializers.serialize(object.isMainDevice,
          specifiedType: const FullType(bool)),
      'DeviceServerPort',
      serializers.serialize(object.deviceServerPort,
          specifiedType: const FullType(int)),
      'DeviceServerBuildTime',
      serializers.serialize(object.deviceServerBuildTime,
          specifiedType: const FullType(DateTime)),
      'DeviceOSType',
      serializers.serialize(object.deviceOSType,
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
          result.deviceName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'DeviceOSVersion':
          result.deviceOSVersion = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'IPv4':
          result.iPv4 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'IPv6':
          result.iPv6 = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'DeviceMacAddress':
          result.deviceMacAddress = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'PluginServerPort':
          result.pluginServerPort = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'PluginsCount':
          result.pluginsCount = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'SendTime':
          result.sendTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'IsMainDevice':
          result.isMainDevice = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'DeviceServerPort':
          result.deviceServerPort = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'DeviceServerBuildTime':
          result.deviceServerBuildTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'DeviceOSType':
          result.deviceOSType = serializers.deserialize(value,
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
  final String deviceName;
  @override
  final String deviceOSVersion;
  @override
  final String iPv4;
  @override
  final String iPv6;
  @override
  final String deviceMacAddress;
  @override
  final int pluginServerPort;
  @override
  final int pluginsCount;
  @override
  final DateTime sendTime;
  @override
  final bool isMainDevice;
  @override
  final int deviceServerPort;
  @override
  final DateTime deviceServerBuildTime;
  @override
  final DeviceOSTypeEnum deviceOSType;

  factory _$DeviceInfoStruct(
          [void Function(DeviceInfoStructBuilder)? updates]) =>
      (new DeviceInfoStructBuilder()..update(updates))._build();

  _$DeviceInfoStruct._(
      {required this.deviceName,
      required this.deviceOSVersion,
      required this.iPv4,
      required this.iPv6,
      required this.deviceMacAddress,
      required this.pluginServerPort,
      required this.pluginsCount,
      required this.sendTime,
      required this.isMainDevice,
      required this.deviceServerPort,
      required this.deviceServerBuildTime,
      required this.deviceOSType})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        deviceName, r'DeviceInfoStruct', 'deviceName');
    BuiltValueNullFieldError.checkNotNull(
        deviceOSVersion, r'DeviceInfoStruct', 'deviceOSVersion');
    BuiltValueNullFieldError.checkNotNull(iPv4, r'DeviceInfoStruct', 'iPv4');
    BuiltValueNullFieldError.checkNotNull(iPv6, r'DeviceInfoStruct', 'iPv6');
    BuiltValueNullFieldError.checkNotNull(
        deviceMacAddress, r'DeviceInfoStruct', 'deviceMacAddress');
    BuiltValueNullFieldError.checkNotNull(
        pluginServerPort, r'DeviceInfoStruct', 'pluginServerPort');
    BuiltValueNullFieldError.checkNotNull(
        pluginsCount, r'DeviceInfoStruct', 'pluginsCount');
    BuiltValueNullFieldError.checkNotNull(
        sendTime, r'DeviceInfoStruct', 'sendTime');
    BuiltValueNullFieldError.checkNotNull(
        isMainDevice, r'DeviceInfoStruct', 'isMainDevice');
    BuiltValueNullFieldError.checkNotNull(
        deviceServerPort, r'DeviceInfoStruct', 'deviceServerPort');
    BuiltValueNullFieldError.checkNotNull(
        deviceServerBuildTime, r'DeviceInfoStruct', 'deviceServerBuildTime');
    BuiltValueNullFieldError.checkNotNull(
        deviceOSType, r'DeviceInfoStruct', 'deviceOSType');
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
        deviceName == other.deviceName &&
        deviceOSVersion == other.deviceOSVersion &&
        iPv4 == other.iPv4 &&
        iPv6 == other.iPv6 &&
        deviceMacAddress == other.deviceMacAddress &&
        pluginServerPort == other.pluginServerPort &&
        pluginsCount == other.pluginsCount &&
        sendTime == other.sendTime &&
        isMainDevice == other.isMainDevice &&
        deviceServerPort == other.deviceServerPort &&
        deviceServerBuildTime == other.deviceServerBuildTime &&
        deviceOSType == other.deviceOSType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceName.hashCode);
    _$hash = $jc(_$hash, deviceOSVersion.hashCode);
    _$hash = $jc(_$hash, iPv4.hashCode);
    _$hash = $jc(_$hash, iPv6.hashCode);
    _$hash = $jc(_$hash, deviceMacAddress.hashCode);
    _$hash = $jc(_$hash, pluginServerPort.hashCode);
    _$hash = $jc(_$hash, pluginsCount.hashCode);
    _$hash = $jc(_$hash, sendTime.hashCode);
    _$hash = $jc(_$hash, isMainDevice.hashCode);
    _$hash = $jc(_$hash, deviceServerPort.hashCode);
    _$hash = $jc(_$hash, deviceServerBuildTime.hashCode);
    _$hash = $jc(_$hash, deviceOSType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class DeviceInfoStructBuilder
    implements Builder<DeviceInfoStruct, DeviceInfoStructBuilder> {
  _$DeviceInfoStruct? _$v;

  String? _deviceName;
  String? get deviceName => _$this._deviceName;
  set deviceName(String? deviceName) => _$this._deviceName = deviceName;

  String? _deviceOSVersion;
  String? get deviceOSVersion => _$this._deviceOSVersion;
  set deviceOSVersion(String? deviceOSVersion) =>
      _$this._deviceOSVersion = deviceOSVersion;

  String? _iPv4;
  String? get iPv4 => _$this._iPv4;
  set iPv4(String? iPv4) => _$this._iPv4 = iPv4;

  String? _iPv6;
  String? get iPv6 => _$this._iPv6;
  set iPv6(String? iPv6) => _$this._iPv6 = iPv6;

  String? _deviceMacAddress;
  String? get deviceMacAddress => _$this._deviceMacAddress;
  set deviceMacAddress(String? deviceMacAddress) =>
      _$this._deviceMacAddress = deviceMacAddress;

  int? _pluginServerPort;
  int? get pluginServerPort => _$this._pluginServerPort;
  set pluginServerPort(int? pluginServerPort) =>
      _$this._pluginServerPort = pluginServerPort;

  int? _pluginsCount;
  int? get pluginsCount => _$this._pluginsCount;
  set pluginsCount(int? pluginsCount) => _$this._pluginsCount = pluginsCount;

  DateTime? _sendTime;
  DateTime? get sendTime => _$this._sendTime;
  set sendTime(DateTime? sendTime) => _$this._sendTime = sendTime;

  bool? _isMainDevice;
  bool? get isMainDevice => _$this._isMainDevice;
  set isMainDevice(bool? isMainDevice) => _$this._isMainDevice = isMainDevice;

  int? _deviceServerPort;
  int? get deviceServerPort => _$this._deviceServerPort;
  set deviceServerPort(int? deviceServerPort) =>
      _$this._deviceServerPort = deviceServerPort;

  DateTime? _deviceServerBuildTime;
  DateTime? get deviceServerBuildTime => _$this._deviceServerBuildTime;
  set deviceServerBuildTime(DateTime? deviceServerBuildTime) =>
      _$this._deviceServerBuildTime = deviceServerBuildTime;

  DeviceOSTypeEnum? _deviceOSType;
  DeviceOSTypeEnum? get deviceOSType => _$this._deviceOSType;
  set deviceOSType(DeviceOSTypeEnum? deviceOSType) =>
      _$this._deviceOSType = deviceOSType;

  DeviceInfoStructBuilder();

  DeviceInfoStructBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceName = $v.deviceName;
      _deviceOSVersion = $v.deviceOSVersion;
      _iPv4 = $v.iPv4;
      _iPv6 = $v.iPv6;
      _deviceMacAddress = $v.deviceMacAddress;
      _pluginServerPort = $v.pluginServerPort;
      _pluginsCount = $v.pluginsCount;
      _sendTime = $v.sendTime;
      _isMainDevice = $v.isMainDevice;
      _deviceServerPort = $v.deviceServerPort;
      _deviceServerBuildTime = $v.deviceServerBuildTime;
      _deviceOSType = $v.deviceOSType;
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
            deviceName: BuiltValueNullFieldError.checkNotNull(
                deviceName, r'DeviceInfoStruct', 'deviceName'),
            deviceOSVersion: BuiltValueNullFieldError.checkNotNull(
                deviceOSVersion, r'DeviceInfoStruct', 'deviceOSVersion'),
            iPv4: BuiltValueNullFieldError.checkNotNull(
                iPv4, r'DeviceInfoStruct', 'iPv4'),
            iPv6: BuiltValueNullFieldError.checkNotNull(
                iPv6, r'DeviceInfoStruct', 'iPv6'),
            deviceMacAddress: BuiltValueNullFieldError.checkNotNull(
                deviceMacAddress, r'DeviceInfoStruct', 'deviceMacAddress'),
            pluginServerPort: BuiltValueNullFieldError.checkNotNull(
                pluginServerPort, r'DeviceInfoStruct', 'pluginServerPort'),
            pluginsCount: BuiltValueNullFieldError.checkNotNull(
                pluginsCount, r'DeviceInfoStruct', 'pluginsCount'),
            sendTime: BuiltValueNullFieldError.checkNotNull(
                sendTime, r'DeviceInfoStruct', 'sendTime'),
            isMainDevice: BuiltValueNullFieldError.checkNotNull(isMainDevice, r'DeviceInfoStruct', 'isMainDevice'),
            deviceServerPort: BuiltValueNullFieldError.checkNotNull(deviceServerPort, r'DeviceInfoStruct', 'deviceServerPort'),
            deviceServerBuildTime: BuiltValueNullFieldError.checkNotNull(deviceServerBuildTime, r'DeviceInfoStruct', 'deviceServerBuildTime'),
            deviceOSType: BuiltValueNullFieldError.checkNotNull(deviceOSType, r'DeviceInfoStruct', 'deviceOSType'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
