part of volt;

class Group extends Channel implements TextChannel {
  final Iterable<CacheableUser> recipients;
  // TODO: replace with cacheable message??
  final String name;
  final CacheableUser owner;
  final String? description;
  final Ulid? lastMessageId;
  final File? icon;
  final ChannelPermissions? permissions;
  final bool? isNsfw;

  Group._new(IVolt client, RawApiMap raw)
      : recipients = [
          for (final userId in raw['recipients'] as List)
            CacheableUser._new(client, Ulid(userId))
        ],
        name = raw['name'] as String,
        owner = CacheableUser._new(client, Ulid(raw['owner'] as String)),
        description = raw['description'] as String?,
        lastMessageId = raw['last_message_id'] == null
            ? null
            : Ulid(raw['last_message_id'] as String),
        icon = raw['icon'] == null ? null : File._new(raw['icon'] as RawApiMap),
        permissions = raw['permissions'] == null
            ? null
            : ChannelPermissions._new(raw['permissions']),
        isNsfw = raw['nsfw'] as bool?,
        super._new(client, raw);

  @override
  Future<Message> fetchMessage(Ulid id) {
    // TODO: implement fetchMessage
    throw UnimplementedError();
  }

  @override
  Stream fetchMessages(FetchMessagesQueryBuilder query) {
    // TODO: implement fetchMessages
    throw UnimplementedError();
  }

  @override
  Stream findMessages(SearchMessagesQueryBuilder query) {
    // TODO: implement findMessages
    throw UnimplementedError();
  }

  @override
  String get mention => '<#${id.toString()}>';

  @override
  Future<Message> sendMessage(MessageBuilder message) =>
      client.httpEndpoints.sendMessage(id, message);
}
