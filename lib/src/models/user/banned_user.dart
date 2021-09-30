part of volt;

class BannedMember extends UlidEntity {
  /// [Cacheable] reference to [Member].
  final CacheableMember member;

  /// [User] nickname.
  final String nickname;

  /// [User] avatar.
  final File? avatar;

  BannedMember._new(IVolt client, String rawServerId, RawApiMap raw)
      : member = CacheableMember._new(
          client,
          Ulid(rawServerId),
          Ulid(raw['_id'] as String),
        ),
        nickname = raw['nickname'] as String,
        avatar = raw['avatar'] == null
            ? null
            : File._new(raw['avatar'] as RawApiMap),
        super(Ulid(raw['_id'] as String));
}
