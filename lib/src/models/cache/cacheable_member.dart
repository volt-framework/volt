part of volt;

class CacheableMember extends BaseMember implements Cacheable<Ulid, Member> {
  final Cacheable<Ulid, Server> _server;
  @override
  final IVolt _client;

  CacheableMember._new(this._client, this._server, Ulid id)
      : super._new(_client, _server.id, id);

  @override
  Future<Member> download() {
    // TODO: implement download pls asap
    throw UnimplementedError();
  }

  @override
  Member? getFromCache() => _server.getFromCache()?.members[id];

  @override
  FutureOr<Member> getOrDownload() async => getFromCache() ?? await download();
}
