part of volt;

class ServerTextChannel extends ServerChannel implements TextChannel {
  ServerTextChannel._new(IVolt client, RawApiMap raw)
      : messages = Cache<Ulid, Message>(),
        super._new(client, raw);

  /// Messages cache.
  @override
  final Cache<Ulid, Message> messages;

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

  Future<Invite> createInvite() => client.httpEndpoints.createInvite(id);

  @override
  Future<Message> sendMessage(MessageBuilder message) =>
      client.httpEndpoints.sendMessage(id, message);
}
