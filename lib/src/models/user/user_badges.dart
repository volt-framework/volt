part of volt;

class UserBadges {
  final bool developer;
  final bool translator;
  final bool supporter;
  final bool responsibleDisclosure;
  final bool revoltTeam;
  final bool earlyAdopter;

  UserBadges._new(int raw)
      : developer = FlagsUtils.isApplied(raw, 1 << 0),
        translator = FlagsUtils.isApplied(raw, 1 << 1),
        supporter = FlagsUtils.isApplied(raw, 1 << 2),
        responsibleDisclosure = FlagsUtils.isApplied(raw, 1 << 3),
        revoltTeam = FlagsUtils.isApplied(raw, 1 << 4),
        earlyAdopter = FlagsUtils.isApplied(raw, 1 << 8);
}
