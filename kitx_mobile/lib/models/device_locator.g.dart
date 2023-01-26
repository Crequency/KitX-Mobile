// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_locator.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<DeviceLocator> _$deviceLocatorSerializer =
    new _$DeviceLocatorSerializer();

class _$DeviceLocatorSerializer implements StructuredSerializer<DeviceLocator> {
  @override
  final Iterable<Type> types = const [DeviceLocator, _$DeviceLocator];
  @override
  final String wireName = 'DeviceLocator';

  @override
  Iterable<Object?> serialize(Serializers serializers, DeviceLocator object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'DeviceName',
      serializers.serialize(object.DeviceName,
          specifiedType: const FullType(String)),
      'IPv4',
      serializers.serialize(object.IPv4, specifiedType: const FullType(String)),
      'IPv6',
      serializers.serialize(object.IPv6, specifiedType: const FullType(String)),
      'DeviceMacAddress',
      serializers.serialize(object.DeviceMacAddress,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  DeviceLocator deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new DeviceLocatorBuilder();

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
      }
    }

    return result.build();
  }
}

class _$DeviceLocator extends DeviceLocator {
  @override
  final String DeviceName;
  @override
  final String IPv4;
  @override
  final String IPv6;
  @override
  final String DeviceMacAddress;

  factory _$DeviceLocator([void Function(DeviceLocatorBuilder)? updates]) =>
      (new DeviceLocatorBuilder()..update(updates))._build();

  _$DeviceLocator._(
      {required this.DeviceName,
      required this.IPv4,
      required this.IPv6,
      required this.DeviceMacAddress})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        DeviceName, r'DeviceLocator', 'DeviceName');
    BuiltValueNullFieldError.checkNotNull(IPv4, r'DeviceLocator', 'IPv4');
    BuiltValueNullFieldError.checkNotNull(IPv6, r'DeviceLocator', 'IPv6');
    BuiltValueNullFieldError.checkNotNull(
        DeviceMacAddress, r'DeviceLocator', 'DeviceMacAddress');
  }

  @override
  DeviceLocator rebuild(void Function(DeviceLocatorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeviceLocatorBuilder toBuilder() => new DeviceLocatorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeviceLocator &&
        DeviceName == other.DeviceName &&
        IPv4 == other.IPv4 &&
        IPv6 == other.IPv6 &&
        DeviceMacAddress == other.DeviceMacAddress;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, DeviceName.hashCode);
    _$hash = $jc(_$hash, IPv4.hashCode);
    _$hash = $jc(_$hash, IPv6.hashCode);
    _$hash = $jc(_$hash, DeviceMacAddress.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class DeviceLocatorBuilder
    implements Builder<DeviceLocator, DeviceLocatorBuilder> {
  _$DeviceLocator? _$v;

  String? _DeviceName;
  String? get DeviceName => _$this._DeviceName;
  set DeviceName(String? DeviceName) => _$this._DeviceName = DeviceName;

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

  DeviceLocatorBuilder();

  DeviceLocatorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _DeviceName = $v.DeviceName;
      _IPv4 = $v.IPv4;
      _IPv6 = $v.IPv6;
      _DeviceMacAddress = $v.DeviceMacAddress;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeviceLocator other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DeviceLocator;
  }

  @override
  void update(void Function(DeviceLocatorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeviceLocator build() => _build();

  _$DeviceLocator _build() {
    final _$result = _$v ??
        new _$DeviceLocator._(
            DeviceName: BuiltValueNullFieldError.checkNotNull(
                DeviceName, r'DeviceLocator', 'DeviceName'),
            IPv4: BuiltValueNullFieldError.checkNotNull(
                IPv4, r'DeviceLocator', 'IPv4'),
            IPv6: BuiltValueNullFieldError.checkNotNull(
                IPv6, r'DeviceLocator', 'IPv6'),
            DeviceMacAddress: BuiltValueNullFieldError.checkNotNull(
                DeviceMacAddress, r'DeviceLocator', 'DeviceMacAddress'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
