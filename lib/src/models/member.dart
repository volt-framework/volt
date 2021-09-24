part of volt;

class Member extends BaseMember {
  /// Reference to client.
  final IVolt client;

  /// Reference to server.
  final CacheableServer server;

  /// Custom member nickname.
  final String? nickname;

  /// Custom member avatar.
  final File? avatar;

  /// List of member roles.
  final Iterable<CacheableRole> roles;

  Member._new(this.client, RawApiMap raw)
      : server =
            CacheableServer._new(client, Ulid(raw['_id']['server'] as String)),
        nickname = raw['nickname'] as String?,
        avatar = raw['avatar'] == null
            ? null
            : File._new(raw['avatar'] as RawApiMap),
        roles = [
          for (final role in raw['roles'] as List<dynamic>)
            CacheableRole._new(
              client,
              CacheableServer._new(
                  client, Ulid(raw['_id']['server'] as String)),
              Ulid(role as String),
            ),
        ],
        super._new(Ulid(raw['_id']['user'] as String));
}
