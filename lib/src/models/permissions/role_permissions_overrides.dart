part of volt;

class RolePermissionsOverride {
  final CacheableRole role;
  final ChannelPermissions permissions;

  RolePermissionsOverride._new(
      IVolt client, MinimalServer server, String roleId, int permissions)
      : role = CacheableRole._new(client, server, Ulid(roleId)),
        permissions = ChannelPermissions._new(permissions);
}
