// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'function.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PluginFunction> _$pluginFunctionSerializer =
    new _$PluginFunctionSerializer();

class _$PluginFunctionSerializer
    implements StructuredSerializer<PluginFunction> {
  @override
  final Iterable<Type> types = const [PluginFunction, _$PluginFunction];
  @override
  final String wireName = 'PluginFunction';

  @override
  Iterable<Object?> serialize(Serializers serializers, PluginFunction object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'Name',
      serializers.serialize(object.Name, specifiedType: const FullType(String)),
      'DisplayNames',
      serializers.serialize(object.displayNames,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'Parameters',
      serializers.serialize(object.parameters,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(
                Map, const [const FullType(String), const FullType(String)])
          ])),
      'ParametersType',
      serializers.serialize(object.parametersType,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'HasAppendParameters',
      serializers.serialize(object.hasAppendParameters,
          specifiedType: const FullType(bool)),
      'ReturnValueType',
      serializers.serialize(object.returnValueType,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  PluginFunction deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PluginFunctionBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'Name':
          result.Name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'DisplayNames':
          result.displayNames.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'Parameters':
          result.parameters.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(
                    Map, const [const FullType(String), const FullType(String)])
              ]))!);
          break;
        case 'ParametersType':
          result.parametersType.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'HasAppendParameters':
          result.hasAppendParameters = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'ReturnValueType':
          result.returnValueType = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PluginFunction extends PluginFunction {
  @override
  final String Name;
  @override
  final BuiltMap<String, String> displayNames;
  @override
  final BuiltMap<String, Map<String, String>> parameters;
  @override
  final BuiltList<String> parametersType;
  @override
  final bool hasAppendParameters;
  @override
  final String returnValueType;

  factory _$PluginFunction([void Function(PluginFunctionBuilder)? updates]) =>
      (new PluginFunctionBuilder()..update(updates))._build();

  _$PluginFunction._(
      {required this.Name,
      required this.displayNames,
      required this.parameters,
      required this.parametersType,
      required this.hasAppendParameters,
      required this.returnValueType})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(Name, r'PluginFunction', 'Name');
    BuiltValueNullFieldError.checkNotNull(
        displayNames, r'PluginFunction', 'displayNames');
    BuiltValueNullFieldError.checkNotNull(
        parameters, r'PluginFunction', 'parameters');
    BuiltValueNullFieldError.checkNotNull(
        parametersType, r'PluginFunction', 'parametersType');
    BuiltValueNullFieldError.checkNotNull(
        hasAppendParameters, r'PluginFunction', 'hasAppendParameters');
    BuiltValueNullFieldError.checkNotNull(
        returnValueType, r'PluginFunction', 'returnValueType');
  }

  @override
  PluginFunction rebuild(void Function(PluginFunctionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PluginFunctionBuilder toBuilder() =>
      new PluginFunctionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PluginFunction &&
        Name == other.Name &&
        displayNames == other.displayNames &&
        parameters == other.parameters &&
        parametersType == other.parametersType &&
        hasAppendParameters == other.hasAppendParameters &&
        returnValueType == other.returnValueType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, Name.hashCode);
    _$hash = $jc(_$hash, displayNames.hashCode);
    _$hash = $jc(_$hash, parameters.hashCode);
    _$hash = $jc(_$hash, parametersType.hashCode);
    _$hash = $jc(_$hash, hasAppendParameters.hashCode);
    _$hash = $jc(_$hash, returnValueType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class PluginFunctionBuilder
    implements Builder<PluginFunction, PluginFunctionBuilder> {
  _$PluginFunction? _$v;

  String? _Name;
  String? get Name => _$this._Name;
  set Name(String? Name) => _$this._Name = Name;

  MapBuilder<String, String>? _displayNames;
  MapBuilder<String, String> get displayNames =>
      _$this._displayNames ??= new MapBuilder<String, String>();
  set displayNames(MapBuilder<String, String>? displayNames) =>
      _$this._displayNames = displayNames;

  MapBuilder<String, Map<String, String>>? _parameters;
  MapBuilder<String, Map<String, String>> get parameters =>
      _$this._parameters ??= new MapBuilder<String, Map<String, String>>();
  set parameters(MapBuilder<String, Map<String, String>>? parameters) =>
      _$this._parameters = parameters;

  ListBuilder<String>? _parametersType;
  ListBuilder<String> get parametersType =>
      _$this._parametersType ??= new ListBuilder<String>();
  set parametersType(ListBuilder<String>? parametersType) =>
      _$this._parametersType = parametersType;

  bool? _hasAppendParameters;
  bool? get hasAppendParameters => _$this._hasAppendParameters;
  set hasAppendParameters(bool? hasAppendParameters) =>
      _$this._hasAppendParameters = hasAppendParameters;

  String? _returnValueType;
  String? get returnValueType => _$this._returnValueType;
  set returnValueType(String? returnValueType) =>
      _$this._returnValueType = returnValueType;

  PluginFunctionBuilder();

  PluginFunctionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _Name = $v.Name;
      _displayNames = $v.displayNames.toBuilder();
      _parameters = $v.parameters.toBuilder();
      _parametersType = $v.parametersType.toBuilder();
      _hasAppendParameters = $v.hasAppendParameters;
      _returnValueType = $v.returnValueType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PluginFunction other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$PluginFunction;
  }

  @override
  void update(void Function(PluginFunctionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PluginFunction build() => _build();

  _$PluginFunction _build() {
    _$PluginFunction _$result;
    try {
      _$result = _$v ??
          new _$PluginFunction._(
              Name: BuiltValueNullFieldError.checkNotNull(
                  Name, r'PluginFunction', 'Name'),
              displayNames: displayNames.build(),
              parameters: parameters.build(),
              parametersType: parametersType.build(),
              hasAppendParameters: BuiltValueNullFieldError.checkNotNull(
                  hasAppendParameters,
                  r'PluginFunction',
                  'hasAppendParameters'),
              returnValueType: BuiltValueNullFieldError.checkNotNull(
                  returnValueType, r'PluginFunction', 'returnValueType'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'displayNames';
        displayNames.build();
        _$failedField = 'parameters';
        parameters.build();
        _$failedField = 'parametersType';
        parametersType.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'PluginFunction', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
