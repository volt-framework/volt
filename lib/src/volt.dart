part of volt;

typedef RawApiMap = Map<String, dynamic>;

abstract class IVolt {
  String get _token;
  ClientOptions get options;
  _IHttpEndpoints get httpEndpoints;
  SelfUser get self;

  Cache<Ulid, Server> get servers;
  Cache<Ulid, Channel> get channels;
  Cache<Ulid, User> get users;

  Future<NodeInfo> queryNodes();
  Future<Server> fetchServer(Ulid id);
  Future<T> fetchChannel<T extends Channel>(Ulid id);
  Future<T> fetchUser<T extends User>(Ulid id);
}

class VoltRest extends IVolt {
  final _logger = Logger('Volt');

  @override
  final String _token;

  @override
  late final ClientOptions options;

  @override
  late final SelfUser self;

  @override
  late final _HttpEndpoints httpEndpoints;

  @override
  final Cache<Ulid, Server> servers;

  @override
  final Cache<Ulid, Channel> channels;

  @override
  final Cache<Ulid, User> users;

  VoltRest(this._token, {ClientOptions? options})
      : servers = Cache<Ulid, Server>(),
        channels = Cache<Ulid, Channel>(),
        users = Cache<Ulid, User>() {
    this.options = options ?? ClientOptions();

    httpEndpoints = _HttpEndpoints(this);
    self = SelfUser._new(this);

    if (this.options.enableLogging) {
      Logger.root.onRecord.listen((LogRecord rec) {
        print(
          "[${rec.time}] [${rec.level.name}] [${rec.loggerName}] ${rec.message}",
        );
      });
    }

    if (this.options.ignoreExceptions) {
      Isolate.current.setErrorsFatal(false);
      final port = ReceivePort();
      port.listen((error) {
        final trace = error[1] != null ? '. Stacktrace: \n${error[1]}' : '';
        _logger.shout('Error: Message: [${error[0]}]$trace');
      });
      Isolate.current.addErrorListener(port.sendPort);
    }
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

  @override
  Future<Server> fetchServer(Ulid id) {
    return httpEndpoints.fetchServer(id);
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

  Volt(String token, {ClientOptions? options})
      : super(token, options: options) {
    _controller = _EventController(this);
    _handler = _EventHandler(_controller);
  }
}
