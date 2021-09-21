part of volt;

class ChannelStartTypingEvent extends Event {
  final CacheableTextChannel channel;
  final CacheableUser user;

  ChannelStartTypingEvent._new(IVolt client, RawApiMap raw)
      : channel = CacheableTextChannel._new(client, Ulid(raw['id'] as String)),
        user = CacheableUser._new(client, Ulid(raw['user'] as String)),
        super._new(raw['type'] as String);
}
