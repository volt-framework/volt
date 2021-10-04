part of volt;

/// Role permissions.
class RolePermissions implements Convertable<PermissionsBuilder> {
  final ServerPermissions server;
  final ChannelPermissions channel;

  RolePermissions._new(List<dynamic> raw)
      : server = ServerPermissions._new(raw[0] as int),
        channel = ChannelPermissions._new(raw[1] as int);

  @override
  PermissionsBuilder toBuilder() => PermissionsBuilder.from(this);
}
