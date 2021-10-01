part of volt;

class Group extends Channel implements TextChannel {
  final Iterable<CacheableUser> recipients;
  final String name;
  final CacheableUser owner;
  final String? description;
  final CacheableMessage? lastMessage;
  final Attachment? icon;
  final ChannelPermissions? permissions;
  final bool? isNsfw;

  /// Messages cache.
  @override
  final Cache<Ulid, Message> messages;

  Group._new(IVolt client, RawApiMap raw)
      : recipients = [
          for (final userId in raw['recipients'] as List)
            CacheableUser._new(client, Ulid(userId))
        ],
        name = raw['name'] as String,
        owner = CacheableUser._new(client, Ulid(raw['owner'] as String)),
        description = raw['description'] as String?,
        lastMessage = raw['last_message_id'] == null
            ? null
            : CacheableMessage._new(
                client,
                Ulid(raw['_id'] as String),
                Ulid(raw['last_message_id'] as String),
              ),
        icon = raw['icon'] == null
            ? null
            : Attachment._new(raw['icon'] as RawApiMap),
        permissions = raw['permissions'] == null
            ? null
            : ChannelPermissions._new(raw['permissions']),
        isNsfw = raw['nsfw'] as bool?,
        messages = Cache<Ulid, Message>(),
        super._new(client, raw);

  /// Fetch a message by ID.
  @override
  Future<Message> fetchMessage(Ulid messageId) =>
      client.httpEndpoints.fetchMessage(id, messageId);

  /// Fetch multiple messages.
  @override
  Future<MessageQueryData> fetchMessages(FetchMessagesQueryBuilder query) =>
      client.httpEndpoints.fetchMessages(id, query);

  /// Search for messages within the given parameters.
  @override
  Future<MessageQueryData> searchMessages(SearchMessagesQueryBuilder query) =>
      client.httpEndpoints.searchMessages(id, query);

  /// Retrieve users who are part of this group.
  Future<Iterable<User>> fetchMembers() =>
      client.httpEndpoints.fetchGroupMembers(id);

  @override
  Future<void> startTyping() {
    if (client is Volt) {
      return (client as Volt)._handler.beginTyping(id);
    } else {
      throw UnsupportedError('Cannot use startTyping() with VoltRest');
    }
  }

  @override
  Future<void> stopTyping() {
    if (client is Volt) {
      return (client as Volt)._handler.endTyping(id);
    } else {
      throw UnsupportedError('Cannot use startTyping() with VoltRest');
    }
  }

  /// Sets default role permissions overrides.
  Future<void> setDefaultPermissionsOverrides(
          DefaultChannelPermissionsBuilder builder) =>
      client.httpEndpoints.setDefaultChannelPermissions(id, builder);

  @override
  String get mention => '<#${id.toString()}>';

  @override
  Future<Message> sendMessage(MessageBuilder message) =>
      client.httpEndpoints.sendMessage(id, message);
}
