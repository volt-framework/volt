part of volt;

abstract class _IHttpEndpoints {
  Future<NodeInfo> queryNode();
  Future<Message> sendMessage(Ulid id, MessageBuilder message);
  Future<T> fetchChannel<T extends Channel>(Ulid id);
  Future<void> joinVoiceChannel(Ulid channelId);
}

class _HttpEndpoints extends _IHttpEndpoints {
  final _HttpHandler _handler;
  final IVolt _client;

  _HttpEndpoints(this._client)
      : _handler = _HttpHandler(_client, 'api.revolt.chat');

  @override
  Future<NodeInfo> queryNode() async {
    final res = await _handler.get('/');
    return NodeInfo._new(res.body);
  }

  @override
  Future<Message> sendMessage(Ulid id, MessageBuilder message) async {
    final res = await _handler.post(
      '/channels/${id.toString()}/messages',
      body: message.build(),
    );
    return Message._new(_client, res.body);
  }

  @override
  Future<T> fetchChannel<T extends Channel>(Ulid id) async {
    final res = await _handler.get('/channels/${id.toString()}');
    return Channel._define(_client, res.body) as T;
  }

  @override
  Future<void> joinVoiceChannel(Ulid channelId) {
    return _handler.post('/channels/${channelId.toString()}/join_call');
  }

  Future<T> fetchUser<T extends User>(Ulid id) async {
    final res = await _handler.get('/users/${id.toString()}');
    return User._define(_client, res.body) as T;
  }
}
