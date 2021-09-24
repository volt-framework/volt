part of volt;

class CacheableMember extends BaseMember implements Cacheable<Ulid, Member> {
  @override
  final IVolt _client;

  CacheableMember._new(this._client, Ulid serverId, Ulid id)
      : super._new(_client, serverId, id);

  @override
  Future<Member> download() {
    // TODO: implement download pls asap
    throw UnimplementedError();
  }

  @override
  Member? getFromCache() => server.getFromCache()?.members[id];

  @override
  FutureOr<Member> getOrDownload() async => getFromCache() ?? await download();
}
