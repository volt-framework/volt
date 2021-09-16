part of volt;

class ChannelStartTypingEvent extends Event {
  // TODO: replace with cacheable
  final UlidEntity channel;
  final UlidEntity user;

  ChannelStartTypingEvent._new(RawApiMap raw)
      : channel = UlidEntity(Ulid(raw['id'] as String)),
        user = UlidEntity(Ulid(raw['user'] as String)),
        super(raw['type'] as String);
}
