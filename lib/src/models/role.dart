part of volt;

/// Server role.
class Role {
  /// Role name.
  String name;

  /// Server permissions.
  ServerPermissions serverPermissions;

  /// Channel permissions.
  ChannelPermissions channelPermissions;

  /// Valid HTML color.
  String? color;

  /// Whether to display this role separately on the members list.
  bool? isHoist;

  /// Role ranking. A role with a smaller number will have permissions over roles with larger numbers.
  int? rank;

  Role._new(RawApiMap raw)
      : name = raw['name'] as String,
        serverPermissions =
            ServerPermissions._new(raw['permissions'][0] as int),
        channelPermissions =
            ChannelPermissions._new(raw['permissions'][1] as int),
        color = raw['colour'] as String?,
        isHoist = raw['hoist'] as bool?,
        rank = raw['rank'] as int?;
}
