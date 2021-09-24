part of volt;

abstract class BaseMember extends UlidEntity {
  /// Reference to client.
  final IVolt client;

  /// Reference to server.
  final CacheableServer server;

  /// Reference to user.
  final CacheableUser user;

  // TODO: implement member related methods, such as edit, ban, kick etc
  BaseMember._new(this.client, Ulid serverId, Ulid id)
      : user = CacheableUser._new(client, id),
        server = CacheableServer._new(client, serverId),
        super(id);
}
