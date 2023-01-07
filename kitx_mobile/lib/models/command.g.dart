// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Command> _$commandSerializer = new _$CommandSerializer();

class _$CommandSerializer implements StructuredSerializer<Command> {
  @override
  final Iterable<Type> types = const [Command, _$Command];
  @override
  final String wireName = 'Command';

  @override
  Iterable<Object?> serialize(Serializers serializers, Command object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'Type',
      serializers.serialize(object.Type,
          specifiedType: const FullType(CommandTypeEnum)),
      'CallId',
      serializers.serialize(object.CallId, specifiedType: const FullType(int)),
      'CallIdTTL',
      serializers.serialize(object.CallIdTTL,
          specifiedType: const FullType(int)),
      'SendTime',
      serializers.serialize(object.SendTime,
          specifiedType: const FullType(DateTime)),
      'Request',
      serializers.serialize(object.Request,
          specifiedType: const FullType(String)),
      'RequestArgs',
      serializers.serialize(object.RequestArgs,
          specifiedType: const FullType(List, const [const FullType(String)])),
      'Body',
      serializers.serialize(object.Body,
          specifiedType: const FullType(Uint8List)),
      'BodyLength',
      serializers.serialize(object.BodyLength,
          specifiedType: const FullType(int)),
      'Tags',
      serializers.serialize(object.Tags,
          specifiedType: const FullType(
              Map, const [const FullType(String), const FullType(String)])),
    ];
    Object? value;
    value = object.Sender;
    if (value != null) {
      result
        ..add('Sender')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DeviceLocator)));
    }
    value = object.Target;
    if (value != null) {
      result
        ..add('Target')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DeviceLocator)));
    }
    return result;
  }

  @override
  Command deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommandBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'Type':
          result.Type = serializers.deserialize(value,
                  specifiedType: const FullType(CommandTypeEnum))!
              as CommandTypeEnum;
          break;
        case 'Sender':
          result.Sender.replace(serializers.deserialize(value,
              specifiedType: const FullType(DeviceLocator))! as DeviceLocator);
          break;
        case 'Target':
          result.Target.replace(serializers.deserialize(value,
              specifiedType: const FullType(DeviceLocator))! as DeviceLocator);
          break;
        case 'CallId':
          result.CallId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'CallIdTTL':
          result.CallIdTTL = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'SendTime':
          result.SendTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'Request':
          result.Request = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'RequestArgs':
          result.RequestArgs = serializers.deserialize(value,
                  specifiedType:
                      const FullType(List, const [const FullType(String)]))!
              as List<String>;
          break;
        case 'Body':
          result.Body = serializers.deserialize(value,
              specifiedType: const FullType(Uint8List))! as Uint8List;
          break;
        case 'BodyLength':
          result.BodyLength = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'Tags':
          result.Tags = serializers.deserialize(value,
              specifiedType: const FullType(Map, const [
                const FullType(String),
                const FullType(String)
              ]))! as Map<String, String>;
          break;
      }
    }

    return result.build();
  }
}

class _$Command extends Command {
  @override
  final CommandTypeEnum Type;
  @override
  final DeviceLocator? Sender;
  @override
  final DeviceLocator? Target;
  @override
  final int CallId;
  @override
  final int CallIdTTL;
  @override
  final DateTime SendTime;
  @override
  final String Request;
  @override
  final List<String> RequestArgs;
  @override
  final Uint8List Body;
  @override
  final int BodyLength;
  @override
  final Map<String, String> Tags;

  factory _$Command([void Function(CommandBuilder)? updates]) =>
      (new CommandBuilder()..update(updates))._build();

  _$Command._(
      {required this.Type,
      this.Sender,
      this.Target,
      required this.CallId,
      required this.CallIdTTL,
      required this.SendTime,
      required this.Request,
      required this.RequestArgs,
      required this.Body,
      required this.BodyLength,
      required this.Tags})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(Type, r'Command', 'Type');
    BuiltValueNullFieldError.checkNotNull(CallId, r'Command', 'CallId');
    BuiltValueNullFieldError.checkNotNull(CallIdTTL, r'Command', 'CallIdTTL');
    BuiltValueNullFieldError.checkNotNull(SendTime, r'Command', 'SendTime');
    BuiltValueNullFieldError.checkNotNull(Request, r'Command', 'Request');
    BuiltValueNullFieldError.checkNotNull(
        RequestArgs, r'Command', 'RequestArgs');
    BuiltValueNullFieldError.checkNotNull(Body, r'Command', 'Body');
    BuiltValueNullFieldError.checkNotNull(BodyLength, r'Command', 'BodyLength');
    BuiltValueNullFieldError.checkNotNull(Tags, r'Command', 'Tags');
  }

  @override
  Command rebuild(void Function(CommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommandBuilder toBuilder() => new CommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Command &&
        Type == other.Type &&
        Sender == other.Sender &&
        Target == other.Target &&
        CallId == other.CallId &&
        CallIdTTL == other.CallIdTTL &&
        SendTime == other.SendTime &&
        Request == other.Request &&
        RequestArgs == other.RequestArgs &&
        Body == other.Body &&
        BodyLength == other.BodyLength &&
        Tags == other.Tags;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc($jc(0, Type.hashCode),
                                            Sender.hashCode),
                                        Target.hashCode),
                                    CallId.hashCode),
                                CallIdTTL.hashCode),
                            SendTime.hashCode),
                        Request.hashCode),
                    RequestArgs.hashCode),
                Body.hashCode),
            BodyLength.hashCode),
        Tags.hashCode));
  }
}

class CommandBuilder implements Builder<Command, CommandBuilder> {
  _$Command? _$v;

  CommandTypeEnum? _Type;
  CommandTypeEnum? get Type => _$this._Type;
  set Type(CommandTypeEnum? Type) => _$this._Type = Type;

  DeviceLocatorBuilder? _Sender;
  DeviceLocatorBuilder get Sender =>
      _$this._Sender ??= new DeviceLocatorBuilder();
  set Sender(DeviceLocatorBuilder? Sender) => _$this._Sender = Sender;

  DeviceLocatorBuilder? _Target;
  DeviceLocatorBuilder get Target =>
      _$this._Target ??= new DeviceLocatorBuilder();
  set Target(DeviceLocatorBuilder? Target) => _$this._Target = Target;

  int? _CallId;
  int? get CallId => _$this._CallId;
  set CallId(int? CallId) => _$this._CallId = CallId;

  int? _CallIdTTL;
  int? get CallIdTTL => _$this._CallIdTTL;
  set CallIdTTL(int? CallIdTTL) => _$this._CallIdTTL = CallIdTTL;

  DateTime? _SendTime;
  DateTime? get SendTime => _$this._SendTime;
  set SendTime(DateTime? SendTime) => _$this._SendTime = SendTime;

  String? _Request;
  String? get Request => _$this._Request;
  set Request(String? Request) => _$this._Request = Request;

  List<String>? _RequestArgs;
  List<String>? get RequestArgs => _$this._RequestArgs;
  set RequestArgs(List<String>? RequestArgs) =>
      _$this._RequestArgs = RequestArgs;

  Uint8List? _Body;
  Uint8List? get Body => _$this._Body;
  set Body(Uint8List? Body) => _$this._Body = Body;

  int? _BodyLength;
  int? get BodyLength => _$this._BodyLength;
  set BodyLength(int? BodyLength) => _$this._BodyLength = BodyLength;

  Map<String, String>? _Tags;
  Map<String, String>? get Tags => _$this._Tags;
  set Tags(Map<String, String>? Tags) => _$this._Tags = Tags;

  CommandBuilder();

  CommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _Type = $v.Type;
      _Sender = $v.Sender?.toBuilder();
      _Target = $v.Target?.toBuilder();
      _CallId = $v.CallId;
      _CallIdTTL = $v.CallIdTTL;
      _SendTime = $v.SendTime;
      _Request = $v.Request;
      _RequestArgs = $v.RequestArgs;
      _Body = $v.Body;
      _BodyLength = $v.BodyLength;
      _Tags = $v.Tags;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Command other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Command;
  }

  @override
  void update(void Function(CommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Command build() => _build();

  _$Command _build() {
    _$Command _$result;
    try {
      _$result = _$v ??
          new _$Command._(
              Type: BuiltValueNullFieldError.checkNotNull(
                  Type, r'Command', 'Type'),
              Sender: _Sender?.build(),
              Target: _Target?.build(),
              CallId: BuiltValueNullFieldError.checkNotNull(
                  CallId, r'Command', 'CallId'),
              CallIdTTL: BuiltValueNullFieldError.checkNotNull(
                  CallIdTTL, r'Command', 'CallIdTTL'),
              SendTime: BuiltValueNullFieldError.checkNotNull(
                  SendTime, r'Command', 'SendTime'),
              Request: BuiltValueNullFieldError.checkNotNull(
                  Request, r'Command', 'Request'),
              RequestArgs: BuiltValueNullFieldError.checkNotNull(
                  RequestArgs, r'Command', 'RequestArgs'),
              Body: BuiltValueNullFieldError.checkNotNull(
                  Body, r'Command', 'Body'),
              BodyLength: BuiltValueNullFieldError.checkNotNull(
                  BodyLength, r'Command', 'BodyLength'),
              Tags: BuiltValueNullFieldError.checkNotNull(
                  Tags, r'Command', 'Tags'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'Sender';
        _Sender?.build();
        _$failedField = 'Target';
        _Target?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Command', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
