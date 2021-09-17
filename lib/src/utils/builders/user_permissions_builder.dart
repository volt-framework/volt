part of volt;

class UserPermissionsBuilder extends Builder<int> {
  // yeah that's a bad practice but i dont care
  int _raw = 0;

  bool? access;
  bool? viewProfile;
  bool? sendMessages;
  bool? inviteUsers;

  UserPermissionsBuilder();

  UserPermissionsBuilder.from(UserPermissions permissions)
      : access = permissions.access,
        viewProfile = permissions.viewProfile,
        sendMessages = permissions.sendMessages,
        inviteUsers = permissions.inviteUsers;

  void _apply(bool? applies, int shift) =>
      _raw = FlagsUtils.apply(_raw, applies, shift);

  @override
  int build() {
    _raw = 0;

    _apply(access, 1 << 0);
    _apply(viewProfile, 1 << 1);
    _apply(sendMessages, 1 << 2);
    _apply(inviteUsers, 1 << 3);

    return _raw;
  }
}
