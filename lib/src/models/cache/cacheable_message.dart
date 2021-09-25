part of volt;

class CacheableMessage extends BaseMessage implements Cacheable<Ulid, Message> {
  @override
  final IVolt _client;

  CacheableMessage._new(this._client, Ulid channelId, Ulid id)
      : super._new(_client, channelId, id);

  @override
  Future<Message> download() => channel.fetchMessage(id);

  @override
  Message? getFromCache() => channel.getFromCache()?.messages[id];

  @override
  FutureOr<Message> getOrDownload() async => getFromCache() ?? await download();
}
