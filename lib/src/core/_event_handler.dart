part of volt;

/// The early version of shard =)
class _EventHandler implements Disposable {
  final _WsClient _ws;
  final _EventController _controller;

  late final StreamSubscription _subscription;
  late final Timer _heartbeat;

  _EventHandler(this._controller)
      : _ws = _WsClient(Uri.parse('wss://ws.revolt.chat')) {
    _subscription = _ws.stream.listen(_handle);

    _sendAuth();

    _heartbeat = Timer.periodic(Duration(seconds: 10), (timer) {
      _sendHeartbeat();
    });
  }

  Future<void> _sendAuth() {
    return _ws.send(jsonEncode(
      {'type': 'Authenticate', 'token': _controller._client._token},
    ));
  }

  Future<void> _sendHeartbeat() {
    return _ws.send(jsonEncode(
      {'type': 'Ping', 'data': DateTime.now().millisecondsSinceEpoch},
    ));
  }

  Future<void> beginTyping(Ulid id) async {
    return _ws.send(jsonEncode(
      {'type': 'BeginTyping', 'channel': id.toString()},
    ));
  }

  Future<void> endTyping(Ulid id) async {
    return _ws.send(jsonEncode(
      {'type': 'EndTyping', 'channel': id.toString()},
    ));
  }

  void _handle(dynamic data) {
    print(data);
    final raw = jsonDecode(data) as RawApiMap;
    _controller.onRawEvent.add(raw);

    switch (raw['type']) {
      // TODO: parse ready event and add data to cache
      case 'Pong':
        break;
      case 'Authenticated':
        break;

      case 'Message':
        _controller.onMessageReceived.add(
          MessageReceivedEvent._new(_controller._client, raw),
        );
        break;

      case 'ChannelStartTyping':
        _controller.onChannelStartTyping.add(ChannelStartTypingEvent._new(raw));
        break;

      case 'ChannelStopTyping':
        _controller.onChannelStopTyping.add(ChannelStopTypingEvent._new(raw));
        break;

      default:
        print('RECEIVED UNKNOWN DATA: $raw');
    }
  }

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    await _ws.close();
    _heartbeat.cancel();
  }
}
