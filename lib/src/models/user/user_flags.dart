part of volt;

class UserFlags {
  final bool suspended;
  final bool deleted;
  final bool banned;

  UserFlags._new(int raw)
      : suspended = FlagsUtils.isApplied(raw, 1 << 0),
        deleted = FlagsUtils.isApplied(raw, 1 << 1),
        banned = FlagsUtils.isApplied(raw, 1 << 2);
}
