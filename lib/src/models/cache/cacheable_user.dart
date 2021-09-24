part of volt;

class CacheableUser<T extends User> extends BaseUser
    implements Cacheable<Ulid, T> {
  @override
  final IVolt _client;

  CacheableUser._new(this._client, Ulid id) : super._new(_client, id);

  @override
  Future<T> download() => _client.httpEndpoints.fetchUser<T>(id);

  @override
  T? getFromCache() => _client.users[id] as T?;

  @override
  FutureOr<T> getOrDownload() async => getFromCache() ?? await download();

  @override
  Future<Message> sendMessage(MessageBuilder message) =>
      _client.httpEndpoints.sendMessage(id, message);
}
