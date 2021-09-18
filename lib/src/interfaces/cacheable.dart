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
