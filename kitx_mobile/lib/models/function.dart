import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'function.g.dart';

abstract class PluginFunction implements Built<PluginFunction, PluginFunctionBuilder> {

  String get Name;

  BuiltMap<String, String> get DisplayNames;

  BuiltMap<String, Map<String, String>> get Parameters;

  BuiltList<String> get ParametersType;

  bool get HasAppendParameters;

  String get ReturnValueType;

  PluginFunction._();
  factory PluginFunction([void Function(PluginFunctionBuilder) updates]) = _$PluginFunction;

  Object? toJson() {
    return serializers.serializeWith(PluginFunction.serializer, this);
  }

  @override
  String toString() {
    return json.encode(serializers.serializeWith(PluginFunction.serializer, this));
  }

  static PluginFunction? fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(PluginFunction.serializer, json);
  }

  static PluginFunction? fromString(String jsonString) {
    return serializers.deserializeWith(PluginFunction.serializer, json.decode(jsonString));
  }

  static Serializer<PluginFunction> get serializer => _$pluginFunctionSerializer;
}