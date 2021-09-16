part of volt;

abstract class Cacheable<T extends Ulid, S extends UlidEntity> {
  final IVolt _client;
  final T id;

  Cacheable._new(this._client, this.id);

  S? getFromCache();
  Future<S> download();

  FutureOr<S> getOrDownload() async => getFromCache() ?? await download();

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Cacheable && other.id == id;
}

class _ChannelCacheable<T extends Channel> extends Cacheable<Ulid, T> {
  _ChannelCacheable(IVolt client, Ulid id) : super._new(client, id);

  @override
  Future<T> download() {
    return _client.httpEndpoints.fetchChannel<T>(id);
  }

  @override
  T? getFromCache() {
    return _client.channels[id] as T;
  }
}
