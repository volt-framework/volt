part of volt;

class DmChannel extends Channel implements TextChannel {
  final bool isActive;
  final Iterable<CacheableUser> recipients;
  // TODO: replace with cacheable message??
  final Ulid? lastMessageId;

  DmChannel._new(IVolt client, RawApiMap raw)
      : isActive = raw['active'] as bool,
        recipients = [
          for (final userId in raw['recipients'] as List<String>)
            CacheableUser._new(client, Ulid(userId))
        ],
        lastMessageId = raw['last_message_id'] == null
            ? null
            : Ulid(raw['last_message_id'] as String),
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
