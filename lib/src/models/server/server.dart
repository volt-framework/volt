part of volt;

/// Revolt server
class Server extends BaseServer {
  /// Nonce value, used to prevent double requests to create objects.
  final String? nonce;

  /// Server owner.
  final CacheableMember owner;

  /// Server name.
  final String name;

  /// Server description.
  final String? description;

  /// Server members cache.
  final Cache<Ulid, Member> members;

  /// List of server channels.
  final Iterable<CacheableChannel<ServerChannel>> channels;

  /// List of server categories.
  final Iterable<ServerCategory> categories;

  /// System message channels.
  final SystemMessages systemMessages;

  /// List of all server roles.
  final Iterable<Role> roles;

  /// Default server permissions for all members.
  final ServerPermissions? defaultServerPermissions;

  /// Default channel permissions for all members.
  final ChannelPermissions? defaultChannelPermissions;

  /// Server icon.
  final Attachment? icon;

  /// Server banner.
  final Attachment? banner;

  /// Whether this server is marked as not safe for work.
  final bool? isNsfw;

  /// Server flags.
  final ServerFlags flags;

  Server._new(IVolt client, RawApiMap raw)
      : nonce = raw['nonce'] as String?,
        name = raw['name'] as String,
        owner = CacheableMember._new(
            client, Ulid(raw['_id'] as String), Ulid(raw['owner'] as String)),
        description = raw['description'] as String?,
        members = Cache<Ulid, Member>(),
        channels = [
          for (final channelId in raw['channels'] as List<dynamic>)
            CacheableChannel<ServerChannel>._new(
                client, Ulid(channelId as String))
        ],
        categories = [
          for (final category in (raw['categories'] as List<dynamic>? ?? []))
            ServerCategory._new(client, category as RawApiMap)
        ],
        systemMessages = SystemMessages._new(
            client, raw['system_messages'] as RawApiMap? ?? {}),
        roles = ((raw['roles'] as RawApiMap? ?? {})
            .entries
            .map((a) => Role._raw(a.key, a.value as RawApiMap))),
        defaultServerPermissions = ServerPermissions._new(
            (raw['default_permissions'] as List<dynamic>)[0] as int),
        defaultChannelPermissions = ChannelPermissions._new(
            (raw['default_permissions'] as List<dynamic>)[1] as int),
        icon = raw['icon'] == null
            ? null
            : Attachment._new(raw['icon'] as RawApiMap),
        banner = raw['banner'] == null
            ? null
            : Attachment._new(raw['icon'] as RawApiMap),
        isNsfw = raw['nsfw'] as bool?,
        flags = ServerFlags._new(raw['flags'] as int? ?? 0),
        super._new(client, Ulid(raw['_id'] as String)) {
    if (client.options.cacheOptions.cacheServers) {
      client.servers[id] = this;
    }
  }
}
