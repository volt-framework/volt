part of volt;

class DmChannel extends Channel implements TextChannel {
  final bool isActive;
  final Iterable<CacheableUser> recipients;
  // TODO: replace with cacheable message??
  final Ulid? lastMessageId;

  /// Messages cache.
  @override
  final Cache<Ulid, Message> messages;

  DmChannel._new(IVolt client, RawApiMap raw)
      : isActive = raw['active'] as bool,
        recipients = [
          for (final userId in raw['recipients'] as List<String>)
            CacheableUser._new(client, Ulid(userId))
        ],
        lastMessageId = raw['last_message_id'] == null
            ? null
            : Ulid(raw['last_message_id'] as String),
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

  @override
  String get mention => '<#${id.toString()}>';

  @override
  Future<Message> sendMessage(MessageBuilder message) =>
      client.httpEndpoints.sendMessage(id, message);
}
