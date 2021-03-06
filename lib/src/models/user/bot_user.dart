part of volt;

class BotUser extends User {
  CacheableUser owner;

  BotUser._new(IVolt client, RawApiMap raw)
      : owner = CacheableUser._new(
          client,
          Ulid((raw['bot'] as RawApiMap)['owner'] as String),
        ),
        super._new(client, raw);
}
