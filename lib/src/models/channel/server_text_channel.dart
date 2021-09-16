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
  Future<Message> sendMessage(MessageBuilder message) =>
      client.httpEndpoints.sendMessage(id, message);
}
