part of volt;

class ServerCategory extends UlidEntity {
  final String title;
  final Iterable<CacheableChannel<ServerChannel>> channels;

  ServerCategory._new(IVolt client, RawApiMap raw)
      : title = raw['title'] as String,
        channels = [
          for (final channelId in raw['channels'] as List<dynamic>)
            CacheableChannel<ServerChannel>._new(
                client, Ulid(raw[channelId as String]))
        ],
        super(Ulid(raw['id'] as String));
}
