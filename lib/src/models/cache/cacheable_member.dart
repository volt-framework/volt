part of volt;

class CacheableMember extends BaseMember implements Cacheable<Ulid, Member> {
  @override
  final IVolt _client;

  CacheableMember._new(this._client, Ulid serverId, Ulid id)
      : super._new(_client, serverId, id);

  @override
  Future<Member> download() => _client.httpEndpoints.fetchMember(server.id, id);

  @override
  Member? getFromCache() => server.getFromCache()?.members[id];

  @override
  FutureOr<Member> getOrDownload() async => getFromCache() ?? await download();
}
