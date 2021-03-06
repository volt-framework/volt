part of volt;

class Member extends BaseMember implements Convertable<MemberEditBuilder> {
  /// Custom member nickname.
  final String? nickname;

  /// Custom member avatar.
  final Attachment? avatar;

  /// List of member roles.
  final Iterable<CacheableRole> roles;

  Member._new(IVolt client, RawApiMap raw)
      : nickname = raw['nickname'] as String?,
        avatar = raw['avatar'] == null
            ? null
            : Attachment._new(raw['avatar'] as RawApiMap),
        roles = [
          for (final role in raw['roles'] as List<dynamic>)
            CacheableRole._new(
              client,
              CacheableServer._new(
                client,
                Ulid(raw['_id']['server'] as String),
              ),
              Ulid(role as String),
            ),
        ],
        super._new(client, Ulid(raw['_id']['server']),
            Ulid(raw['_id']['user'] as String)) {
    if (client.options.cacheOptions.cacheMembers) {
      server.getFromCache()?.members.add(id, this);
    }
  }

  @override
  MemberEditBuilder toBuilder() => MemberEditBuilder.from(this);
}
