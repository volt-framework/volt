part of volt;

class CacheableRole extends MinimalRole implements Cacheable<Ulid, Role> {
  @override
  final IVolt _client;
  final MinimalServer server;

  CacheableRole._new(this._client, this.server, Ulid id) : super._new(id);

  @override
  Future<Role> download() async =>
      // we cannot get only role, so we need to fetch the server first
      (await _client.fetchServer(server.id))
          .roles
          .firstWhere((r) => r.id == id);

  @override
  Role? getFromCache() {
    final server = _client.servers.findOne((item) =>
        _IterUtils.findOne<Role>(item.roles, (role) => role.id == id) != null);
    return server?.roles.firstWhere((r) => r.id == id);
  }

  @override
  FutureOr<Role> getOrDownload() async => getFromCache() ?? await download();
}
