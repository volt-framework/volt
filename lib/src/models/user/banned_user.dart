part of volt;

class BannedMember extends UlidEntity {
  /// Reference to [IVolt].
  final IVolt client;

  /// [Cacheable] reference to [Member].
  final CacheableMember member;

  /// [User] nickname.
  final String nickname;

  /// [User] avatar.
  final Attachment? avatar;

  /// Unban member.
  Future<void> unban() =>
      client.httpEndpoints.unbanMember(member.server.id, id);

  BannedMember._new(this.client, String rawServerId, RawApiMap raw)
      : member = CacheableMember._new(
          client,
          Ulid(rawServerId),
          Ulid(raw['_id'] as String),
        ),
        nickname = raw['nickname'] as String,
        avatar = raw['avatar'] == null
            ? null
            : Attachment._new(raw['avatar'] as RawApiMap),
        super(Ulid(raw['_id'] as String));
}
