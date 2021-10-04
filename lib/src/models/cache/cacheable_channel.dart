part of volt;

class CacheableChannel<T extends Channel> extends Cacheable<Ulid, T> {
  CacheableChannel._new(IVolt client, Ulid id) : super._new(client, id);

  @override
  Future<T> download() {
    return _client.httpEndpoints.fetchChannel<T>(id);
  }

  @override
  T? getFromCache() {
    return _client.channels[id] as T?;
  }
}

// TODO: add server and group channels which extends this
class CacheableTextChannel<T extends TextChannel> extends Channel
    implements Sendible, BaseTextChannel, CacheableChannel<T> {
  @override
  final IVolt _client;

  CacheableTextChannel._new(
    this._client,
    Ulid id, [
    ChannelType type = ChannelType.text,
  ]) : super._raw(_client, id, type);

  @override
  Future<T> download() => client.httpEndpoints.fetchChannel<T>(id);

  @override
  T? getFromCache() => client.channels[id] as T?;

  @override
  FutureOr<T> getOrDownload() async => getFromCache() ?? await download();

  @override
  DateTime get createdAt => throw UnimplementedError();

  @override
  Future<Message> sendMessage(MessageBuilder message) =>
      client.httpEndpoints.sendMessage(id, message);

  @override
  bool operator ==(dynamic other) {
    if (other is CacheableChannel) return id == other.id;
    if (other is UlidEntity) return this == other;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

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
}
