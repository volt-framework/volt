part of volt;

abstract class _IHttpEndpoints {
  // Core
  Future<NodeInfo> queryNode();

  // User Information
  Future<T> fetchUser<T extends User>(Ulid id);
  Future<BotUser> fetchSelf();
  Future<void> editSelf(UserEditBuilder builder);
  Future<UserProfile> fetchUserProfile(Ulid id);
  Uri fetchDefaultAvatar(Ulid id);

  // Direct Messaging
  Future<Iterable<TextChannel>> fetchDmChannels();
  Future<DmChannel> openDm(Ulid userId);

  // Channel Information
  Future<T> fetchChannel<T extends Channel>(Ulid id);
  Future<void> editChannel(Ulid id, ChannelEditBuilder builder);
  Future<void> closeChannel(Ulid id);

  // Messaging
  Future<Message> sendMessage(Ulid id, MessageBuilder message);

  // Voice
  Future<void> joinVoiceChannel(Ulid channelId);

  // Server Information
  Future<Server> fetchServer(Ulid id);
}

class _HttpEndpoints extends _IHttpEndpoints {
  final _HttpHandler _handler;
  final IVolt _client;

  _HttpEndpoints(this._client)
      : _handler = _HttpHandler(_client, _client.options.httpBaseUrl);

  @override
  Future<NodeInfo> queryNode() async {
    final res = await BasicRequest._new(_handler, '/').execute();
    return NodeInfo._new(res.body);
  }

  @override
  Future<Message> sendMessage(Ulid id, MessageBuilder message) async {
    final res = await BasicRequest._new(_handler, '/channels/$id/messages',
            method: 'POST', body: message.build())
        .execute();
    return Message._new(_client, res.body);
  }

  @override
  Future<T> fetchChannel<T extends Channel>(Ulid id) async {
    final res = await BasicRequest._new(_handler, '/channels/$id').execute();
    return Channel._define(_client, res.body) as T;
  }

  /// Edit a channel object.
  @override
  Future<void> editChannel(Ulid id, ChannelEditBuilder builder) =>
      BasicRequest._new(_handler, '/channels/$id',
              method: 'PATCH', body: builder.build())
          .execute();

  /// Deletes a server channel, leaves a group or closes a DM.
  @override
  Future<void> closeChannel(Ulid id) =>
      BasicRequest._new(_handler, '/channels/$id', method: 'DELETE').execute();

  @override
  Future<void> joinVoiceChannel(Ulid channelId) =>
      BasicRequest._new(_handler, '/channels/$channelId/join_call',
              method: 'POST')
          .execute();

  @override
  Future<T> fetchUser<T extends User>(Ulid id) async {
    final res = await BasicRequest._new(_handler, '/users/$id').execute();
    return User._define(_client, res.body) as T;
  }

  @override
  Future<Server> fetchServer(Ulid id) async {
    final res = await BasicRequest._new(_handler, '/servers/$id').execute();
    return Server._new(_client, res.body);
  }

  @override
  Future<void> editSelf(UserEditBuilder builder) =>
      BasicRequest._new(_handler, '/users/@me',
              method: 'PATCH', body: builder.build())
          .execute();

  @override
  Uri fetchDefaultAvatar(Ulid id) =>
      Uri.https(_handler.baseUrl, '/$id/default_avatar');

  @override
  Future<BotUser> fetchSelf() async {
    final res = await BasicRequest._new(_handler, '/users/@me').execute();
    return BotUser._new(_client, res.body);
  }

  @override
  Future<UserProfile> fetchUserProfile(Ulid id) async {
    final res =
        await BasicRequest._new(_handler, '/users/$id/profile').execute();
    return UserProfile._new(res.body);
  }

  @override
  Future<Iterable<TextChannel>> fetchDmChannels() async {
    final res = await BasicRequest._new(_handler, '/users/dms').execute();
    return (res.body as List)
        .map((e) => Channel._define(_client, e as RawApiMap) as TextChannel);
  }

  @override
  Future<DmChannel> openDm(Ulid userId) async {
    final res =
        await BasicRequest._new(_handler, '/users/$userId/dm').execute();
    return DmChannel._new(_client, res.body);
  }
}
