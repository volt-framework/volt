part of volt;

class ServerFlags {
  final bool officialRevoltServer;
  final bool verifiedCommunityServer;

  ServerFlags._new(int raw)
      : officialRevoltServer = FlagsUtils.isApplied(raw, 1 << 0),
        verifiedCommunityServer = FlagsUtils.isApplied(raw, 1 << 1);
}
