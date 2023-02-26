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
      serializers.serialize(object.type,
          specifiedType: const FullType(CommandTypeEnum)),
      'Sender',
      serializers.serialize(object.sender,
          specifiedType: const FullType(DeviceLocator)),
      'Target',
      serializers.serialize(object.target,
          specifiedType: const FullType(DeviceLocator)),
      'CallId',
      serializers.serialize(object.callId, specifiedType: const FullType(int)),
      'CallIdTTL',
      serializers.serialize(object.callIdTTL,
          specifiedType: const FullType(int)),
      'SendTime',
      serializers.serialize(object.sendTime,
          specifiedType: const FullType(DateTime)),
      'Request',
      serializers.serialize(object.request,
          specifiedType: const FullType(String)),
      'RequestArgs',
      serializers.serialize(object.requestArgs,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'Body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'BodyLength',
      serializers.serialize(object.bodyLength,
          specifiedType: const FullType(int)),
      'Tags',
      serializers.serialize(object.tags,
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
          result.type = serializers.deserialize(value,
                  specifiedType: const FullType(CommandTypeEnum))!
              as CommandTypeEnum;
          break;
        case 'Sender':
          result.sender.replace(serializers.deserialize(value,
              specifiedType: const FullType(DeviceLocator))! as DeviceLocator);
          break;
        case 'Target':
          result.target.replace(serializers.deserialize(value,
              specifiedType: const FullType(DeviceLocator))! as DeviceLocator);
          break;
        case 'CallId':
          result.callId = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'CallIdTTL':
          result.callIdTTL = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'SendTime':
          result.sendTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'Request':
          result.request = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'RequestArgs':
          result.requestArgs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'Body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'BodyLength':
          result.bodyLength = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'Tags':
          result.tags.replace(serializers.deserialize(value,
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
  final CommandTypeEnum type;
  @override
  final DeviceLocator sender;
  @override
  final DeviceLocator target;
  @override
  final int callId;
  @override
  final int callIdTTL;
  @override
  final DateTime sendTime;
  @override
  final String request;
  @override
  final BuiltList<String> requestArgs;
  @override
  final String body;
  @override
  final int bodyLength;
  @override
  final BuiltMap<String, String> tags;

  factory _$Command([void Function(CommandBuilder)? updates]) =>
      (new CommandBuilder()..update(updates))._build();

  _$Command._(
      {required this.type,
      required this.sender,
      required this.target,
      required this.callId,
      required this.callIdTTL,
      required this.sendTime,
      required this.request,
      required this.requestArgs,
      required this.body,
      required this.bodyLength,
      required this.tags})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, r'Command', 'type');
    BuiltValueNullFieldError.checkNotNull(sender, r'Command', 'sender');
    BuiltValueNullFieldError.checkNotNull(target, r'Command', 'target');
    BuiltValueNullFieldError.checkNotNull(callId, r'Command', 'callId');
    BuiltValueNullFieldError.checkNotNull(callIdTTL, r'Command', 'callIdTTL');
    BuiltValueNullFieldError.checkNotNull(sendTime, r'Command', 'sendTime');
    BuiltValueNullFieldError.checkNotNull(request, r'Command', 'request');
    BuiltValueNullFieldError.checkNotNull(
        requestArgs, r'Command', 'requestArgs');
    BuiltValueNullFieldError.checkNotNull(body, r'Command', 'body');
    BuiltValueNullFieldError.checkNotNull(bodyLength, r'Command', 'bodyLength');
    BuiltValueNullFieldError.checkNotNull(tags, r'Command', 'tags');
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
        type == other.type &&
        sender == other.sender &&
        target == other.target &&
        callId == other.callId &&
        callIdTTL == other.callIdTTL &&
        sendTime == other.sendTime &&
        request == other.request &&
        requestArgs == other.requestArgs &&
        body == other.body &&
        bodyLength == other.bodyLength &&
        tags == other.tags;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, sender.hashCode);
    _$hash = $jc(_$hash, target.hashCode);
    _$hash = $jc(_$hash, callId.hashCode);
    _$hash = $jc(_$hash, callIdTTL.hashCode);
    _$hash = $jc(_$hash, sendTime.hashCode);
    _$hash = $jc(_$hash, request.hashCode);
    _$hash = $jc(_$hash, requestArgs.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, bodyLength.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class CommandBuilder implements Builder<Command, CommandBuilder> {
  _$Command? _$v;

  CommandTypeEnum? _type;
  CommandTypeEnum? get type => _$this._type;
  set type(CommandTypeEnum? type) => _$this._type = type;

  DeviceLocatorBuilder? _sender;
  DeviceLocatorBuilder get sender =>
      _$this._sender ??= new DeviceLocatorBuilder();
  set sender(DeviceLocatorBuilder? sender) => _$this._sender = sender;

  DeviceLocatorBuilder? _target;
  DeviceLocatorBuilder get target =>
      _$this._target ??= new DeviceLocatorBuilder();
  set target(DeviceLocatorBuilder? target) => _$this._target = target;

  int? _callId;
  int? get callId => _$this._callId;
  set callId(int? callId) => _$this._callId = callId;

  int? _callIdTTL;
  int? get callIdTTL => _$this._callIdTTL;
  set callIdTTL(int? callIdTTL) => _$this._callIdTTL = callIdTTL;

  DateTime? _sendTime;
  DateTime? get sendTime => _$this._sendTime;
  set sendTime(DateTime? sendTime) => _$this._sendTime = sendTime;

  String? _request;
  String? get request => _$this._request;
  set request(String? request) => _$this._request = request;

  ListBuilder<String>? _requestArgs;
  ListBuilder<String> get requestArgs =>
      _$this._requestArgs ??= new ListBuilder<String>();
  set requestArgs(ListBuilder<String>? requestArgs) =>
      _$this._requestArgs = requestArgs;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  int? _bodyLength;
  int? get bodyLength => _$this._bodyLength;
  set bodyLength(int? bodyLength) => _$this._bodyLength = bodyLength;

  MapBuilder<String, String>? _tags;
  MapBuilder<String, String> get tags =>
      _$this._tags ??= new MapBuilder<String, String>();
  set tags(MapBuilder<String, String>? tags) => _$this._tags = tags;

  CommandBuilder();

  CommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _sender = $v.sender.toBuilder();
      _target = $v.target.toBuilder();
      _callId = $v.callId;
      _callIdTTL = $v.callIdTTL;
      _sendTime = $v.sendTime;
      _request = $v.request;
      _requestArgs = $v.requestArgs.toBuilder();
      _body = $v.body;
      _bodyLength = $v.bodyLength;
      _tags = $v.tags.toBuilder();
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
              type: BuiltValueNullFieldError.checkNotNull(
                  type, r'Command', 'type'),
              sender: sender.build(),
              target: target.build(),
              callId: BuiltValueNullFieldError.checkNotNull(
                  callId, r'Command', 'callId'),
              callIdTTL: BuiltValueNullFieldError.checkNotNull(
                  callIdTTL, r'Command', 'callIdTTL'),
              sendTime: BuiltValueNullFieldError.checkNotNull(
                  sendTime, r'Command', 'sendTime'),
              request: BuiltValueNullFieldError.checkNotNull(
                  request, r'Command', 'request'),
              requestArgs: requestArgs.build(),
              body: BuiltValueNullFieldError.checkNotNull(
                  body, r'Command', 'body'),
              bodyLength: BuiltValueNullFieldError.checkNotNull(
                  bodyLength, r'Command', 'bodyLength'),
              tags: tags.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sender';
        sender.build();
        _$failedField = 'target';
        target.build();

        _$failedField = 'requestArgs';
        requestArgs.build();

        _$failedField = 'tags';
        tags.build();
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
