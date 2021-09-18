part of volt;

/// System message channels.
class SystemMessages {
  /// Channel where user join events should be sent.
  final CacheableTextChannel<ServerTextChannel>? userJoined;

  /// Channel where user leave events should be sent.
  final CacheableTextChannel<ServerTextChannel>? userLeft;

  /// Channel where user kick events should be sent.
  final CacheableTextChannel<ServerTextChannel>? userKicked;

  /// Channel where user ban events should be sent.
  final CacheableTextChannel<ServerTextChannel>? userBanned;

  SystemMessages._new(IVolt client, RawApiMap raw)
      : userJoined = raw['user_joined'] == null
            ? null
            : CacheableTextChannel._new(
                client,
                Ulid(raw['user_joined'] as String),
              ),
        userLeft = raw['user_left'] == null
            ? null
            : CacheableTextChannel._new(
                client, Ulid(raw['user_left'] as String)),
        userKicked = raw['user_kicked'] == null
            ? null
            : CacheableTextChannel._new(
                client,
                Ulid(raw['user_kicked'] as String),
              ),
        userBanned = raw['user_banned'] == null
            ? null
            : CacheableTextChannel._new(
                client,
                Ulid(raw['user_banned'] as String),
              );
}
