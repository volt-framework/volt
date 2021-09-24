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
    implements Sendible, BaseTextChannel, Cacheable<Ulid, T> {
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

  @override
  Future<Message> fetchMessage(Ulid id) {
    // TODO: implement fetchMessage
    throw UnimplementedError();
  }

  @override
  Stream<Message> fetchMessages(FetchMessagesQueryBuilder query) {
    // TODO: implement fetchMessages
    throw UnimplementedError();
  }

  @override
  Stream findMessages(SearchMessagesQueryBuilder query) {
    // TODO: implement findMessages
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

  @override
  String get mention => '<#${id.toString()}>';
}
