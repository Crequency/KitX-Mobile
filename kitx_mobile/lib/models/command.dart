import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';
import 'device_locator.dart';

import 'enums/command_type.dart';

part 'command.g.dart';

abstract class Command implements Built<Command, CommandBuilder> {
  
  CommandTypeEnum get Type;

  DeviceLocator get Sender;

  DeviceLocator get Target;

  int get CallId;

  int get CallIdTTL;

  DateTime get SendTime;

  String get Request;

  BuiltList<String> get RequestArgs;

  String get Body;

  int get BodyLength;

  BuiltMap<String, String> get Tags;

  Command._();
  factory Command([void Function(CommandBuilder) updates]) = _$Command;

  Object? toJson() {
    return serializers.serializeWith(Command.serializer, this);
  }

  @override
  String toString() {
    return json.encode(serializers.serializeWith(Command.serializer, this));
  }

  static Command? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Command.serializer, json);
  }

  static Command? fromString(String jsonString) {
    return serializers.deserializeWith(Command.serializer, json.decode(jsonString));
  }

  static Serializer<Command> get serializer => _$commandSerializer;
}