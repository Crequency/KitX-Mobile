import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';
import 'device_locator.dart';

import 'enums/command_type.dart';

part 'command.g.dart';

abstract class Command implements Built<Command, CommandBuilder> {
  @BuiltValueField(wireName: 'Type')
  CommandTypeEnum get type;

  @BuiltValueField(wireName: 'Sender')
  DeviceLocator get sender;

  @BuiltValueField(wireName: 'Target')
  DeviceLocator get target;

  @BuiltValueField(wireName: 'CallId')
  int get callId;

  @BuiltValueField(wireName: 'CallIdTTL')
  int get callIdTTL;

  @BuiltValueField(wireName: 'SendTime')
  DateTime get sendTime;

  @BuiltValueField(wireName: 'Request')
  String get request;

  @BuiltValueField(wireName: 'RequestArgs')
  BuiltList<String> get requestArgs;

  @BuiltValueField(wireName: 'Body')
  String get body;

  @BuiltValueField(wireName: 'BodyLength')
  int get bodyLength;

  @BuiltValueField(wireName: 'Tags')
  BuiltMap<String, String> get tags;

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
