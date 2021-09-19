part of volt;

abstract class _IHttpEndpoints {
  Future<NodeInfo> queryNode();
  Future<Message> sendMessage(Ulid id, MessageBuilder message);
  Future<T> fetchChannel<T extends Channel>(Ulid id);
  Future<void> joinVoiceChannel(Ulid channelId);
  Future<T> fetchUser<T extends User>(Ulid id);
  Future<BotUser> fetchSelf();
  Future<void> editSelf(UserEditBuilder builder);
  Future<UserProfile> fetchUserProfile(Ulid id);
  Uri fetchDefaultAvatar(Ulid id);
  Future<Server> fetchServer(Ulid id);
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

  @override
  Future<T> fetchUser<T extends User>(Ulid id) async {
    final res = await _handler.get('/users/${id.toString()}');
    return User._define(_client, res.body) as T;
  }

  @override
  Future<Server> fetchServer(Ulid id) async {
    final res = await _handler.get('/servers/${id.toString()}');
    return Server._new(_client, res.body);
  }

  @override
  Future<void> editSelf(UserEditBuilder builder) {
    return _handler.patch('/users/@me', body: builder.build());
  }

  @override
  Uri fetchDefaultAvatar(Ulid id) {
    return Uri.https(_handler.baseUrl, '/${id.toString()}/default_avatar');
  }

  @override
  Future<BotUser> fetchSelf() async {
    final res = await _handler.get('/users/@me');
    return BotUser._new(_client, res.body);
  }

  @override
  Future<UserProfile> fetchUserProfile(Ulid id) async {
    final res = await _handler.get('/users/${id.toString()}/profile');
    return UserProfile._new(res.body);
  }
}
