import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'command_type.g.dart';

class CommandTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireNumber: 0)
  static const CommandTypeEnum Call = _$call;

  @BuiltValueEnumConst(wireNumber: 1)
  static const CommandTypeEnum CallBack = _$callBack;

  const CommandTypeEnum._(String name) : super(name);

  static BuiltSet<CommandTypeEnum> get values => _$commandTypeEnumValues;
  static CommandTypeEnum valueOf(String name) => _$commandTypeEnumValueOf(name);

  static Serializer<CommandTypeEnum> get serializer => _$commandTypeEnumSerializer;
}
