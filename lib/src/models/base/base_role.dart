part of volt;

abstract class BaseRole extends UlidEntity {
  /// Overrides permissions for specific channel.
  Future<void> overridePermissions(
          ServerChannel channel, RoleChannelPermissionsBuilder builder) =>
      channel.client.httpEndpoints
          .setRoleChannelPermissions(channel.id, id, builder);

  BaseRole._new(Ulid id) : super(id);
}
