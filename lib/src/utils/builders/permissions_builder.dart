part of volt;

class PermissionsBuilder extends Builder<RawApiMap> {
  ServerPermissionsBuilder server;
  ChannelPermissionsBuilder channel;

  PermissionsBuilder({required this.server, required this.channel});

  factory PermissionsBuilder.from(RolePermissions permissions) =>
      PermissionsBuilder(
        server: ServerPermissionsBuilder.from(permissions.server),
        channel: ChannelPermissionsBuilder.from(permissions.channel),
      );

  @override
  RawApiMap build() {
    return {
      'permissions': {
        'server': server.build(),
        'channel': channel.build(),
      },
    };
  }
}
