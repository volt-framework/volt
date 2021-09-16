part of volt;

abstract class _IHttpEndpoints {
  Future<NodeInfo> queryNode();
  Future<Message> sendMessage(Ulid id, MessageBuilder message);
  Future<T> fetchChannel<T extends Channel>(Ulid id);
  Future<void> joinVoiceChannel(Ulid channelId);
}

class _HttpEndpoints extends _IHttpEndpoints {
  final _HttpClient _rest = _HttpClient('api.revolt.chat');
  final IVolt _client;

  _HttpEndpoints(this._client);

  @override
  Future<NodeInfo> queryNode() async {
    final res = await _rest.get('/');
    return NodeInfo._new(res.body);
  }

  @override
  Future<Message> sendMessage(Ulid id, MessageBuilder message) async {
    // TODO: abstraction layer for preparing requests
    final res = await _rest.post(
      '/channels/${id.toString()}/messages',
      body: jsonEncode(message.build()),
      headers: {
        'content-type': 'application/json',
        'x-bot-token': _client._token
      },
    );
    return Message._new(_client, res.body);
  }

  @override
  Future<T> fetchChannel<T extends Channel>(Ulid id) async {
    final res = await _rest.get(
      '/channels/${id.toString()}',
      headers: {'x-bot-token': _client._token},
    );
    return Channel._define(_client, res.body) as T;
  }

  @override
  Future<void> joinVoiceChannel(Ulid channelId) {
    return _rest.post(
      '/channels/${channelId.toString()}/join_call',
      headers: {'x-bot-token': _client._token},
    );
  }

  Future<T> fetchUser<T extends User>(Ulid id) async {
    final res = await _rest.get(
      '/users/${id.toString()}',
      headers: {'x-bot-token': _client._token},
    );
    print(id);
    return User._define(_client, res.body) as T;
  }
}
