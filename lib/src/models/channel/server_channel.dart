part of volt;

class ServerChannel extends Channel implements Mentionable {
  /// Reference to server.
  final CacheableServer server;

  /// Channel name.
  final String name;

  /// Channel description.
  final String? description;

  /// Channel icon.
  final File? icon;

  /// Default role permissions overrides.
  final ChannelPermissions? defaultPermissionsOverrides;

  /// Role permissions overrides.
  final Iterable<RolePermissionsOverride> rolePermissionsOverrides;

  /// Whether is this channel is marked as Not Safe For Work.
  final bool? isNsfw;

  // TODO: replace with cacheable message??
  /// Last message.
  final UlidEntity? lastMessage;

  /// Overrides default permissions.
  Future<void> overrideDefaultPermissions(
          DefaultChannelPermissionsBuilder builder) =>
      client.httpEndpoints.setDefaultChannelPermissions(id, builder);

  /// Overrides permissions of the [role].
  Future<void> overrideRolePermissions(
          MinimalRole role, RoleChannelPermissionsBuilder builder) =>
      role.overridePermissions(this, builder);

  ServerChannel._new(IVolt client, RawApiMap raw)
      : server = CacheableServer._new(client, Ulid(raw['server'] as String)),
        name = raw['name'] as String,
        description = raw['description'] as String?,
        icon = raw['icon'] == null ? null : File._new(raw['icon'] as RawApiMap),
        defaultPermissionsOverrides = raw['default_permissions'] == null
            ? null
            : ChannelPermissions._new(raw['default_permissions'] as int),
        rolePermissionsOverrides =
            ((raw['role_permissions'] as RawApiMap? ?? {}).entries.map(
                  (a) => RolePermissionsOverride._new(
                    client,
                    CacheableServer._new(client, Ulid(raw['server'] as String)),
                    a.key,
                    a.value as int,
                  ),
                )),
        isNsfw = raw['nsfw'] as bool?,
        lastMessage = raw['last_message_id'] == null
            ? null
            : UlidEntity(Ulid(raw['last_message_id'])),
        super._new(client, raw);

  @override
  String get mention => '<#${id.toString()}>';
}
