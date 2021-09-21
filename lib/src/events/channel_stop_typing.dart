part of volt;

class ChannelStopTypingEvent extends Event {
  final CacheableTextChannel channel;
  final CacheableUser user;

  ChannelStopTypingEvent._new(IVolt client, RawApiMap raw)
      : channel = CacheableTextChannel._new(client, Ulid(raw['id'] as String)),
        user = CacheableUser._new(client, Ulid(raw['user'] as String)),
        super(raw['type'] as String);
}
