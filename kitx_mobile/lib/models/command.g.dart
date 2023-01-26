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
      'Sender',
      serializers.serialize(object.Sender,
          specifiedType: const FullType(DeviceLocator)),
      'Target',
      serializers.serialize(object.Target,
          specifiedType: const FullType(DeviceLocator)),
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
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'Body',
      serializers.serialize(object.Body, specifiedType: const FullType(String)),
      'BodyLength',
      serializers.serialize(object.BodyLength,
          specifiedType: const FullType(int)),
      'Tags',
      serializers.serialize(object.Tags,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(String)])),
    ];

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
          result.RequestArgs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'Body':
          result.Body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'BodyLength':
          result.BodyLength = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'Tags':
          result.Tags.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)]))!);
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
  final DeviceLocator Sender;
  @override
  final DeviceLocator Target;
  @override
  final int CallId;
  @override
  final int CallIdTTL;
  @override
  final DateTime SendTime;
  @override
  final String Request;
  @override
  final BuiltList<String> RequestArgs;
  @override
  final String Body;
  @override
  final int BodyLength;
  @override
  final BuiltMap<String, String> Tags;

  factory _$Command([void Function(CommandBuilder)? updates]) =>
      (new CommandBuilder()..update(updates))._build();

  _$Command._(
      {required this.Type,
      required this.Sender,
      required this.Target,
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
    BuiltValueNullFieldError.checkNotNull(Sender, r'Command', 'Sender');
    BuiltValueNullFieldError.checkNotNull(Target, r'Command', 'Target');
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
    var _$hash = 0;
    _$hash = $jc(_$hash, Type.hashCode);
    _$hash = $jc(_$hash, Sender.hashCode);
    _$hash = $jc(_$hash, Target.hashCode);
    _$hash = $jc(_$hash, CallId.hashCode);
    _$hash = $jc(_$hash, CallIdTTL.hashCode);
    _$hash = $jc(_$hash, SendTime.hashCode);
    _$hash = $jc(_$hash, Request.hashCode);
    _$hash = $jc(_$hash, RequestArgs.hashCode);
    _$hash = $jc(_$hash, Body.hashCode);
    _$hash = $jc(_$hash, BodyLength.hashCode);
    _$hash = $jc(_$hash, Tags.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
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

  ListBuilder<String>? _RequestArgs;
  ListBuilder<String> get RequestArgs =>
      _$this._RequestArgs ??= new ListBuilder<String>();
  set RequestArgs(ListBuilder<String>? RequestArgs) =>
      _$this._RequestArgs = RequestArgs;

  String? _Body;
  String? get Body => _$this._Body;
  set Body(String? Body) => _$this._Body = Body;

  int? _BodyLength;
  int? get BodyLength => _$this._BodyLength;
  set BodyLength(int? BodyLength) => _$this._BodyLength = BodyLength;

  MapBuilder<String, String>? _Tags;
  MapBuilder<String, String> get Tags =>
      _$this._Tags ??= new MapBuilder<String, String>();
  set Tags(MapBuilder<String, String>? Tags) => _$this._Tags = Tags;

  CommandBuilder();

  CommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _Type = $v.Type;
      _Sender = $v.Sender.toBuilder();
      _Target = $v.Target.toBuilder();
      _CallId = $v.CallId;
      _CallIdTTL = $v.CallIdTTL;
      _SendTime = $v.SendTime;
      _Request = $v.Request;
      _RequestArgs = $v.RequestArgs.toBuilder();
      _Body = $v.Body;
      _BodyLength = $v.BodyLength;
      _Tags = $v.Tags.toBuilder();
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
              Sender: Sender.build(),
              Target: Target.build(),
              CallId: BuiltValueNullFieldError.checkNotNull(
                  CallId, r'Command', 'CallId'),
              CallIdTTL: BuiltValueNullFieldError.checkNotNull(
                  CallIdTTL, r'Command', 'CallIdTTL'),
              SendTime: BuiltValueNullFieldError.checkNotNull(
                  SendTime, r'Command', 'SendTime'),
              Request: BuiltValueNullFieldError.checkNotNull(
                  Request, r'Command', 'Request'),
              RequestArgs: RequestArgs.build(),
              Body: BuiltValueNullFieldError.checkNotNull(
                  Body, r'Command', 'Body'),
              BodyLength: BuiltValueNullFieldError.checkNotNull(
                  BodyLength, r'Command', 'BodyLength'),
              Tags: Tags.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'Sender';
        Sender.build();
        _$failedField = 'Target';
        Target.build();

        _$failedField = 'RequestArgs';
        RequestArgs.build();

        _$failedField = 'Tags';
        Tags.build();
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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
