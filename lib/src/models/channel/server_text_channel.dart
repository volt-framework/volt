part of volt;

class ServerTextChannel extends ServerChannel implements TextChannel {
  ServerTextChannel._new(IVolt client, RawApiMap raw) : super._new(client, raw);

  @override
  Future<Message> fetchMessage(Ulid id) {
    // TODO: implement fetchMessage
    throw UnimplementedError();
  }

  @override
  Stream<dynamic> fetchMessages(FetchMessagesQueryBuilder query) {
    // TODO: implement fetchMessages and replace dynamic with result object
    throw UnimplementedError();
  }

  @override
  Stream<dynamic> findMessages(SearchMessagesQueryBuilder query) {
    // TODO: implement findMessages and replace dynamic with result object
    throw UnimplementedError();
  }

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
