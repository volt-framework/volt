part of volt;

class Invite {
  final IVolt _client;

  /// Invite code
  final String code;

  // TODO: implement resolve
  Future<InviteInfo> resolve() => throw UnimplementedError();

  Invite._new(this._client, RawApiMap raw) : code = raw['code'] as String;
}
