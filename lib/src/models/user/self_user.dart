part of volt;

class SelfUser {
  final IVolt _client;
  // ignore: prefer_void_to_null
  final Cacheable<Null, User> user;

  Future<void> edit(UserEditBuilder builder) =>
      _client.httpEndpoints.editSelf(builder);

  SelfUser._new(this._client) : user = _CacheableSelfUser._new(_client);
}
