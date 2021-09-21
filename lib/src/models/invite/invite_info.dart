part of volt;

/// Resolved invite information.
class InviteInfo {
  /// Invite type.
  final InviteType type;
  final CacheableServer server;
  final String serverName;
  final File? serverIcon;
  final File? serverBanner;
  final CacheableTextChannel<ServerTextChannel> channel;
  final String channelName;
  final String? channelDescription;
  final String userName;
  final File? userAvatar;
  final int memberCount;

  InviteInfo._new(IVolt client, RawApiMap raw)
      : type = InviteType.from(raw['type']),
        server = CacheableServer._new(client, Ulid(raw['server_id'] as String)),
        serverName = raw['server_name'] as String,
        serverIcon = raw['server_icon'] == null
            ? null
            : File._new(raw['server_icon'] as RawApiMap),
        serverBanner = raw['server_banner'] == null
            ? null
            : File._new(raw['server_banner'] as RawApiMap),
        channel = CacheableTextChannel._new(
            client, Ulid(raw['channel_id'] as String)),
        channelName = raw['channel_name'] as String,
        channelDescription = raw['channel_description'] as String?,
        userName = raw['user_name'] as String,
        userAvatar = raw['user_avatar'] == null
            ? null
            : File._new(raw['user_avatar'] as RawApiMap),
        memberCount = raw['member_count'] as int;
}

/// Invite type.
class InviteType extends Enum<String> {
  static const server = InviteType._create('Server');

  InviteType.from(String value) : super(value);
  const InviteType._create(String value) : super(value);
}
