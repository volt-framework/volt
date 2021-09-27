part of volt;

class PartialInvite {
  /// Reference to client.
  final IVolt client;

  /// Invite code.
  final String code;

  // TODO: implement fetchInfo
  /// Fetch invite metadata.
  Future<InviteInfo> fetchInfo() => throw UnimplementedError();

  PartialInvite._new(this.client, RawApiMap raw) : code = raw['code'] as String;
  PartialInvite._raw(this.client, this.code);
}
