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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
