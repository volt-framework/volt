part of volt;

class ServerPermissions extends Permissions
    implements Convertable<ServerPermissionsBuilder> {
  final bool viewServer;
  final bool manageRoles;
  final bool manageChannels;
  final bool manageServer;
  final bool kickMembers;
  final bool banMembers;
  final bool changeNickname;
  final bool manageNicknames;
  final bool changeAvatar;
  final bool manageAvatars;

  ServerPermissions._new(int raw)
      : viewServer = FlagsUtils.isApplied(raw, 1 << 0),
        manageRoles = FlagsUtils.isApplied(raw, 1 << 1),
        manageChannels = FlagsUtils.isApplied(raw, 1 << 2),
        manageServer = FlagsUtils.isApplied(raw, 1 << 3),
        kickMembers = FlagsUtils.isApplied(raw, 1 << 4),
        banMembers = FlagsUtils.isApplied(raw, 1 << 5),
        changeNickname = FlagsUtils.isApplied(raw, 1 << 12),
        manageNicknames = FlagsUtils.isApplied(raw, 1 << 13),
        changeAvatar = FlagsUtils.isApplied(raw, 1 << 14),
        manageAvatars = FlagsUtils.isApplied(raw, 1 << 15);

  @override
  ServerPermissionsBuilder toBuilder() => ServerPermissionsBuilder.from(this);
}
