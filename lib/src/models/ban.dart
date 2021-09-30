part of volt;

class Ban {
  BannedMember member;
  String? reason;

  Ban._new(IVolt client, RawApiMap raw, RawApiMap userRaw)
      : member = BannedMember._new(
          client,
          raw['_id']['server'] as String,
          userRaw,
        ),
        reason = raw['reason'] as String?;
}
