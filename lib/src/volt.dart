part of volt;

typedef RawApiMap = Map<String, dynamic>;

abstract class IVolt {
  String get _token;
  _HttpEndpoints get httpEndpoints;

  Cache<Ulid, Channel> get channels;
  Cache<Ulid, User> get users;

  Future<NodeInfo> queryNodes();
  Future<T> fetchChannel<T extends Channel>(Ulid id);
  Future<T> fetchUser<T extends User>(Ulid id);
}

class VoltRest extends IVolt {
  @override
  final String _token;

  @override
  late final _HttpEndpoints httpEndpoints;

  @override
  final Cache<Ulid, Channel> channels;

  @override
  final Cache<Ulid, User> users;

  VoltRest(this._token)
      : channels = Cache<Ulid, Channel>(),
        users = Cache<Ulid, User>() {
    httpEndpoints = _HttpEndpoints(this);
  }

  @override
  Future<NodeInfo> queryNodes() {
    return httpEndpoints.queryNode();
  }

  @override
  Future<T> fetchChannel<T extends Channel>(Ulid id) {
    return httpEndpoints.fetchChannel(id);
  }

  @override
  Future<T> fetchUser<T extends User>(Ulid id) {
    return httpEndpoints.fetchUser(id);
  }
}

class Volt extends VoltRest {
  late final Stream<dynamic> onRawEvent;
  late final Stream<MessageReceivedEvent> onMessageReceived;
  late final Stream<ChannelStartTypingEvent> onChannelStartTyping;
  late final Stream<ChannelStopTypingEvent> onChannelStopTyping;

  late final _EventController _controller;
  // ignore: unused_field
  late final _EventHandler _handler;

  Volt(String token) : super(token) {
    _controller = _EventController(this);
    _handler = _EventHandler(_controller);
  }
}
