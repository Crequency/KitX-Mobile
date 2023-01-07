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
      serializers.serialize(object.DisplayNames,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
      'Parameters',
      serializers.serialize(object.Parameters,
          specifiedType: const FullType(BuiltMap, const [
            const FullType(String),
            const FullType(
                Map, const [const FullType(String), const FullType(String)])
          ])),
      'ParametersType',
      serializers.serialize(object.ParametersType,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'HasAppendParameters',
      serializers.serialize(object.HasAppendParameters,
          specifiedType: const FullType(bool)),
      'ReturnValueType',
      serializers.serialize(object.ReturnValueType,
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
          result.DisplayNames.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
          break;
        case 'Parameters':
          result.Parameters.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(
                    Map, const [const FullType(String), const FullType(String)])
              ]))!);
          break;
        case 'ParametersType':
          result.ParametersType.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'HasAppendParameters':
          result.HasAppendParameters = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'ReturnValueType':
          result.ReturnValueType = serializers.deserialize(value,
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
  final BuiltMap<String, String> DisplayNames;
  @override
  final BuiltMap<String, Map<String, String>> Parameters;
  @override
  final BuiltList<String> ParametersType;
  @override
  final bool HasAppendParameters;
  @override
  final String ReturnValueType;

  factory _$PluginFunction([void Function(PluginFunctionBuilder)? updates]) =>
      (new PluginFunctionBuilder()..update(updates))._build();

  _$PluginFunction._(
      {required this.Name,
      required this.DisplayNames,
      required this.Parameters,
      required this.ParametersType,
      required this.HasAppendParameters,
      required this.ReturnValueType})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(Name, r'PluginFunction', 'Name');
    BuiltValueNullFieldError.checkNotNull(
        DisplayNames, r'PluginFunction', 'DisplayNames');
    BuiltValueNullFieldError.checkNotNull(
        Parameters, r'PluginFunction', 'Parameters');
    BuiltValueNullFieldError.checkNotNull(
        ParametersType, r'PluginFunction', 'ParametersType');
    BuiltValueNullFieldError.checkNotNull(
        HasAppendParameters, r'PluginFunction', 'HasAppendParameters');
    BuiltValueNullFieldError.checkNotNull(
        ReturnValueType, r'PluginFunction', 'ReturnValueType');
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
        DisplayNames == other.DisplayNames &&
        Parameters == other.Parameters &&
        ParametersType == other.ParametersType &&
        HasAppendParameters == other.HasAppendParameters &&
        ReturnValueType == other.ReturnValueType;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, Name.hashCode), DisplayNames.hashCode),
                    Parameters.hashCode),
                ParametersType.hashCode),
            HasAppendParameters.hashCode),
        ReturnValueType.hashCode));
  }
}

class PluginFunctionBuilder
    implements Builder<PluginFunction, PluginFunctionBuilder> {
  _$PluginFunction? _$v;

  String? _Name;
  String? get Name => _$this._Name;
  set Name(String? Name) => _$this._Name = Name;

  MapBuilder<String, String>? _DisplayNames;
  MapBuilder<String, String> get DisplayNames =>
      _$this._DisplayNames ??= new MapBuilder<String, String>();
  set DisplayNames(MapBuilder<String, String>? DisplayNames) =>
      _$this._DisplayNames = DisplayNames;

  MapBuilder<String, Map<String, String>>? _Parameters;
  MapBuilder<String, Map<String, String>> get Parameters =>
      _$this._Parameters ??= new MapBuilder<String, Map<String, String>>();
  set Parameters(MapBuilder<String, Map<String, String>>? Parameters) =>
      _$this._Parameters = Parameters;

  ListBuilder<String>? _ParametersType;
  ListBuilder<String> get ParametersType =>
      _$this._ParametersType ??= new ListBuilder<String>();
  set ParametersType(ListBuilder<String>? ParametersType) =>
      _$this._ParametersType = ParametersType;

  bool? _HasAppendParameters;
  bool? get HasAppendParameters => _$this._HasAppendParameters;
  set HasAppendParameters(bool? HasAppendParameters) =>
      _$this._HasAppendParameters = HasAppendParameters;

  String? _ReturnValueType;
  String? get ReturnValueType => _$this._ReturnValueType;
  set ReturnValueType(String? ReturnValueType) =>
      _$this._ReturnValueType = ReturnValueType;

  PluginFunctionBuilder();

  PluginFunctionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _Name = $v.Name;
      _DisplayNames = $v.DisplayNames.toBuilder();
      _Parameters = $v.Parameters.toBuilder();
      _ParametersType = $v.ParametersType.toBuilder();
      _HasAppendParameters = $v.HasAppendParameters;
      _ReturnValueType = $v.ReturnValueType;
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
              DisplayNames: DisplayNames.build(),
              Parameters: Parameters.build(),
              ParametersType: ParametersType.build(),
              HasAppendParameters: BuiltValueNullFieldError.checkNotNull(
                  HasAppendParameters,
                  r'PluginFunction',
                  'HasAppendParameters'),
              ReturnValueType: BuiltValueNullFieldError.checkNotNull(
                  ReturnValueType, r'PluginFunction', 'ReturnValueType'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'DisplayNames';
        DisplayNames.build();
        _$failedField = 'Parameters';
        Parameters.build();
        _$failedField = 'ParametersType';
        ParametersType.build();
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
