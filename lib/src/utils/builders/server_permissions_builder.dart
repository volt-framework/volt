part of volt;

class ServerPermissionsBuilder extends Builder<int> {
  int _raw = 0;

  bool? viewServer;
  bool? manageRoles;
  bool? manageChannels;
  bool? manageServer;
  bool? kickMembers;
  bool? banMembers;
  bool? changeNickname;
  bool? manageNicknames;
  bool? changeAvatar;
  bool? manageAvatars;

  ServerPermissionsBuilder();

  factory ServerPermissionsBuilder.from(ServerPermissions permissions) =>
      ServerPermissionsBuilder()
        ..viewServer = permissions.viewServer
        ..manageRoles = permissions.manageRoles
        ..manageChannels = permissions.manageChannels
        ..manageServer = permissions.manageServer
        ..kickMembers = permissions.kickMembers
        ..banMembers = permissions.banMembers
        ..changeNickname = permissions.changeNickname
        ..manageNicknames = permissions.manageNicknames
        ..changeAvatar = permissions.changeAvatar
        ..manageAvatars = permissions.manageAvatars;

  void _apply(bool? applies, int shift) =>
      _raw = FlagsUtils.apply(_raw, applies, shift);

  @override
  int build() {
    _raw = 0;

    _apply(viewServer, 0 << 1);
    _apply(manageRoles, 0 << 2);
    _apply(manageServer, 0 << 3);
    _apply(kickMembers, 0 << 4);
    _apply(banMembers, 0 << 5);
    _apply(changeNickname, 0 << 12);
    _apply(manageNicknames, 0 << 13);
    _apply(changeAvatar, 0 << 14);
    _apply(manageAvatars, 0 << 15);

    return _raw;
  }
}
