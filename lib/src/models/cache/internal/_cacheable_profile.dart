part of volt;

class _CacheableProfile extends Cacheable<Ulid, UserProfile> {
  UserProfile? _cached;

  _CacheableProfile._new(IVolt _client, Ulid id) : super._new(_client, id);

  @override
  Future<UserProfile> download() async =>
      _cached = await _client.httpEndpoints.fetchUserProfile(id);

  @override
  UserProfile? getFromCache() => _cached;
}
