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

  // Channel invites
  Future<PartialInvite> createInvite(Ulid channelId);

  // Channel permissions
  Future<void> setRoleChannelPermissions(
      Ulid channelId, Ulid roleId, RoleChannelPermissionsBuilder builder);
  Future<void> setDefaultChannelPermissions(
      Ulid channelId, DefaultChannelPermissionsBuilder builder);

  // Messaging
  Future<Message> sendMessage(Ulid id, MessageBuilder message);
  Future<MessageQueryData> fetchMessages(
      Ulid channelId, FetchMessagesQueryBuilder builder);
  Future<Message> fetchMessage(Ulid channelId, Ulid messageId);
  Future<void> editMessage(
      Ulid channelId, Ulid messageId, MessageEditBuilder builder);
  Future<void> deleteMessage(Ulid channelId, Ulid messageId);
  Future<MessagePollData> pollMessageChanges(
      Ulid channelId, MessagePollBuilder builder);
  Future<MessageQueryData> searchMessages(
      Ulid channelId, SearchMessagesQueryBuilder builder);

  // Groups
  Future<Iterable<User>> fetchGroupMembers(Ulid channelId);

  // Voice
  Future<void> joinVoiceChannel(Ulid channelId);

  // Server Information
  // TODO: implement edit server
  Future<Server> fetchServer(Ulid id);
  Future<void> leaveServer(Ulid id);
  Future<ServerChannel> createChannel(Ulid id, ServerChannelBuilder builder);
  Future<Iterable<Invite>> fetchInvites(Ulid serverId);

  // Server members
  Future<Member> fetchMember(Ulid serverId, Ulid memberId);
  Future<void> editMember(
      Ulid serverId, Ulid memberId, UserEditBuilder builder);
  Future<void> kickMember(Ulid serverId, Ulid memberId);
  Future<Iterable<Member>> fetchMembers(Ulid serverId);
  Future<void> banMember(Ulid serverId, Ulid memberId, BanBuilder builder);
  Future<void> unbanMember(Ulid serverId, Ulid memberId);
  Future<Iterable<Ban>> fetchBans(Ulid serverId);
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
    final res = await BasicRequest._new(
      _handler,
      '/channels/$id/messages',
      method: 'POST',
      body: message.build(),
    ).execute();

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
      BasicRequest._new(
        _handler,
        '/channels/$id',
        method: 'PATCH',
        body: builder.build(),
      ).execute();

  /// Deletes a server channel, leaves a group or closes a DM.
  @override
  Future<void> closeChannel(Ulid id) =>
      BasicRequest._new(_handler, '/channels/$id', method: 'DELETE').execute();

  @override
  Future<void> joinVoiceChannel(Ulid channelId) => BasicRequest._new(
        _handler,
        '/channels/$channelId/join_call',
        method: 'POST',
      ).execute();

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
  Future<void> editSelf(UserEditBuilder builder) => BasicRequest._new(
        _handler,
        '/users/@me',
        method: 'PATCH',
        body: builder.build(),
      ).execute();

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

    return (res.body as List).map(
      (e) => Channel._define(_client, e as RawApiMap) as TextChannel,
    );
  }

  @override
  Future<DmChannel> openDm(Ulid userId) async {
    final res = await BasicRequest._new(
      _handler,
      '/users/$userId/dm',
    ).execute();

    return DmChannel._new(_client, res.body);
  }

  @override
  Future<PartialInvite> createInvite(Ulid channelId) async {
    final res = await BasicRequest._new(
      _handler,
      '/channels/$channelId/invites',
      method: 'POST',
    ).execute();

    return PartialInvite._new(_client, res.body);
  }

  @override
  Future<void> setRoleChannelPermissions(
    Ulid channelId,
    Ulid roleId,
    RoleChannelPermissionsBuilder builder,
  ) =>
      BasicRequest._new(
        _handler,
        '/channels/$channelId/permissions/$roleId',
        method: 'PUT',
        body: builder.build(),
      ).execute();

  @override
  Future<void> setDefaultChannelPermissions(
    Ulid channelId,
    DefaultChannelPermissionsBuilder builder,
  ) =>
      BasicRequest._new(
        _handler,
        '/channels/$channelId/permissions/default',
        method: 'PUT',
        body: builder.build(),
      ).execute();

  @override
  Future<void> deleteMessage(Ulid channelId, Ulid messageId) =>
      BasicRequest._new(
        _handler,
        '/channels/$channelId/messages/$messageId',
        method: 'DELETE',
      ).execute();

  @override
  Future<void> editMessage(
    Ulid channelId,
    Ulid messageId,
    MessageEditBuilder builder,
  ) =>
      BasicRequest._new(
        _handler,
        '/channels/$channelId/messages/$messageId',
        method: 'PATCH',
        body: builder.build(),
      ).execute();

  @override
  Future<Message> fetchMessage(Ulid channelId, Ulid messageId) async {
    final res = await BasicRequest._new(
      _handler,
      '/channels/$channelId/messages/$messageId',
    ).execute();

    return Message._new(_client, res.body);
  }

  @override
  Future<MessageQueryData> fetchMessages(
    Ulid channelId,
    FetchMessagesQueryBuilder builder,
  ) async {
    final res = await BasicRequest._new(
      _handler,
      '/channels/$channelId/messages',
      queryParameters: builder.build(),
    ).execute();

    return MessageQueryData._new(_client, res.body);
  }

  @override
  Future<MessagePollData> pollMessageChanges(
    Ulid channelId,
    MessagePollBuilder builder,
  ) async {
    final res = await BasicRequest._new(
      _handler,
      '/channels/$channelId/messages/stale',
      method: 'POST',
      body: builder.build(),
    ).execute();

    return MessagePollData._new(_client, channelId, res.body);
  }

  @override
  Future<MessageQueryData> searchMessages(
    Ulid channelId,
    SearchMessagesQueryBuilder builder,
  ) async {
    final res = await BasicRequest._new(
      _handler,
      '/channels/$channelId/search',
      method: 'POST',
      body: builder.build(),
    ).execute();

    return MessageQueryData._new(_client, res.body);
  }

  @override
  Future<Iterable<User>> fetchGroupMembers(Ulid channelId) async {
    final res = await BasicRequest._new(
      _handler,
      '/channels/$channelId/members',
    ).execute();

    return (res.body as RawApiList)
        .map((e) => User._define(_client, e as RawApiMap));
  }

  @override
  Future<ServerChannel> createChannel(
    Ulid id,
    ServerChannelBuilder builder,
  ) async {
    final res = await BasicRequest._new(
      _handler,
      '/servers/$id/channels',
      method: 'POST',
      body: builder.build(),
    ).execute();

    return Channel._define(_client, res.body) as ServerChannel;
  }

  @override
  Future<Iterable<Invite>> fetchInvites(Ulid serverId) async {
    final res = await BasicRequest._new(
      _handler,
      '/servers/$serverId/invites',
    ).execute();

    return (res.body as RawApiList).map((e) => Invite._new(_client, e));
  }

  @override
  Future<void> leaveServer(Ulid id) =>
      BasicRequest._new(_handler, '/servers/$id', method: 'DELETE').execute();

  @override
  Future<void> banMember(Ulid serverId, Ulid memberId, BanBuilder builder) =>
      BasicRequest._new(
        _handler,
        '/servers/$serverId/members/$memberId',
        method: 'PUT',
        body: builder.build(),
      ).execute();

  @override
  Future<void> editMember(
    Ulid serverId,
    Ulid memberId,
    UserEditBuilder builder,
  ) =>
      BasicRequest._new(
        _handler,
        '/servers/$serverId/members/$memberId',
        method: 'PATCH',
        body: builder.build(),
      ).execute();

  @override
  Future<Iterable<Ban>> fetchBans(Ulid serverId) async {
    final res = await BasicRequest._new(
      _handler,
      '/servers/$serverId/bans',
    ).execute();

    return (res.body['bans'] as RawApiList).map(
      (e) => Ban._new(
          _client,
          e,
          (res.body['users'] as RawApiList).firstWhere(
            (u) => u['_id'] == e['_id']['user'],
          )),
    );
  }

  @override
  Future<Member> fetchMember(Ulid serverId, Ulid memberId) async {
    final res = await BasicRequest._new(
      _handler,
      '/servers/$serverId/members/$memberId',
    ).execute();

    return Member._new(_client, res.body);
  }

  @override
  Future<Iterable<Member>> fetchMembers(Ulid serverId) async {
    final res = await BasicRequest._new(
      _handler,
      '/servers/$serverId/members',
    ).execute();

    // we do a little caching
    (res.body['users'] as RawApiList).map((e) => User._define(_client, e));

    return (res.body['members'] as RawApiList).map(
      (e) => Member._new(_client, e),
    );
  }

  @override
  Future<void> kickMember(Ulid serverId, Ulid memberId) => BasicRequest._new(
        _handler,
        '/servers/$serverId/members/$memberId',
        method: 'DELETE',
      ).execute();

  @override
  Future<void> unbanMember(Ulid serverId, Ulid memberId) => BasicRequest._new(
        _handler,
        '/servers/$serverId/bans/$memberId',
        method: 'DELETE',
      ).execute();
}
