part of volt;

// ignore: prefer_void_to_null
class _CacheableSelfUser extends Cacheable<Null, BotUser> {
  BotUser? _cached;

  _CacheableSelfUser._new(IVolt client) : super._new(client, null);

  @override
  Future<BotUser> download() async =>
      _cached = await _client.httpEndpoints.fetchSelf();

  @override
  BotUser? getFromCache() => _cached;
}
