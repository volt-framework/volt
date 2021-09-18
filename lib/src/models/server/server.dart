part of volt;

/// Revolt server
class Server extends UlidEntity {
  /// Reference to [Volt] instance
  final IVolt client;

  /// Nonce value, used to prevent double requests to create objects.
  final String? nonce;

  // TODO: maybe member?
  /// Server owner.
  final CacheableUser owner;

  /// Server name.
  final String name;

  /// Server description.
  final String? description;

  /// List of server channels.
  final Iterable<CacheableChannel<ServerChannel>> channels;

  /// List of server categories.
  final Iterable<ServerCategory> categories;

  /// System message channels.
  final SystemMessages systemMessages;

  // TODO: maybe cache? (but we cant just fetch a role)
  /// Server roles.
  final Map<String, Role> roles;

  /// Default server permissions for all members.
  final ServerPermissions? defaultServerPermissions;

  /// Default channel permissions for all members.
  final ChannelPermissions? defaultChannelPermissions;

  /// Server icon.
  final File? icon;

  /// Server banner.
  final File? banner;

  /// Whether this server is marked as not safe for work.
  final bool? isNsfw;

  /// Server flags.
  final ServerFlags flags;

  Server._new(this.client, RawApiMap raw)
      : nonce = raw['nonce'] as String?,
        owner = CacheableUser._new(client, Ulid(raw['owner'] as String)),
        name = raw['name'] as String,
        description = raw['description'] as String?,
        channels = [
          for (final channelId in raw['channels'] as List<String>)
            CacheableChannel<ServerChannel>._new(client, Ulid(channelId))
        ],
        categories = [
          for (final category
              in (raw['categories'] as List<RawApiMap>? ?? <RawApiMap>[]))
            ServerCategory._new(client, category)
        ],
        systemMessages = SystemMessages._new(
            client, raw['system_messages'] as RawApiMap? ?? {}),
        roles = (raw['roles'] as Map<String, RawApiMap>? ?? {})
            .map((key, value) => MapEntry(key, Role._new(value))),
        defaultServerPermissions = ServerPermissions._new(
            (raw['default_permissions'] as List<int>)[0]),
        defaultChannelPermissions = ChannelPermissions._new(
            (raw['default_permissions'] as List<int>)[1]),
        icon = raw['icon'] == null ? null : File._new(raw['icon'] as RawApiMap),
        banner =
            raw['banner'] == null ? null : File._new(raw['icon'] as RawApiMap),
        isNsfw = raw['nsfw'] as bool?,
        flags = ServerFlags._new(raw['flags'] as int? ?? 0),
        super(Ulid(raw['_id'] as String));
}
