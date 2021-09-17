part of volt;

class UserPermissions extends Permissions
    implements Convertable<UserPermissionsBuilder> {
  final bool access;
  final bool viewProfile;
  final bool sendMessages;
  final bool inviteUsers;

  UserPermissions._new(int raw)
      : access = FlagsUtils.isApplied(raw, 1 << 0),
        viewProfile = FlagsUtils.isApplied(raw, 1 << 1),
        sendMessages = FlagsUtils.isApplied(raw, 1 << 2),
        inviteUsers = FlagsUtils.isApplied(raw, 1 << 3);

  @override
  UserPermissionsBuilder toBuilder() => UserPermissionsBuilder.from(this);
}
