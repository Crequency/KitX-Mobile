// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CommandTypeEnum _$call = const CommandTypeEnum._('Call');
const CommandTypeEnum _$callBack = const CommandTypeEnum._('CallBack');

CommandTypeEnum _$commandTypeEnumValueOf(String name) {
  switch (name) {
    case 'Call':
      return _$call;
    case 'CallBack':
      return _$callBack;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<CommandTypeEnum> _$commandTypeEnumValues =
    new BuiltSet<CommandTypeEnum>(const <CommandTypeEnum>[
  _$call,
  _$callBack,
]);

Serializer<CommandTypeEnum> _$commandTypeEnumSerializer =
    new _$CommandTypeEnumSerializer();

class _$CommandTypeEnumSerializer
    implements PrimitiveSerializer<CommandTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'Call': 0,
    'CallBack': 1,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    0: 'Call',
    1: 'CallBack',
  };

  @override
  final Iterable<Type> types = const <Type>[CommandTypeEnum];
  @override
  final String wireName = 'CommandTypeEnum';

  @override
  Object serialize(Serializers serializers, CommandTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CommandTypeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CommandTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
