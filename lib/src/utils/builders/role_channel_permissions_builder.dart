part of volt;

class RoleChannelPermissionsBuilder extends Builder<RawApiMap> {
  ChannelPermissionsBuilder? permissions;

  @override
  RawApiMap build() {
    if (permissions == null) {
      throw ArgumentError.notNull('permissions');
    }

    return {'permissions': permissions!.build()};
  }
}
