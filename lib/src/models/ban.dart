part of volt;

class Ban {
  /// Reference to [BannedMember].
  BannedMember member;

  /// Ban reason.
  String? reason;

  Ban._new(IVolt client, RawApiMap raw, RawApiMap userRaw)
      : member = BannedMember._new(
          client,
          raw['_id']['server'] as String,
          userRaw,
        ),
        reason = raw['reason'] as String?;
}
