part of volt;

abstract class BaseMember extends UlidEntity {
  /// Reference to client.
  final IVolt client;

  /// Reference to server.
  final CacheableServer server;

  /// Reference to user.
  final CacheableUser user;

  /// Edit the member.
  Future<void> edit(MemberEditBuilder builder) =>
      client.httpEndpoints.editMember(server.id, id, builder);

  /// Kick the member from the server.
  Future<void> kick() => client.httpEndpoints.kickMember(server.id, id);

  /// Ban the member from the server.
  Future<void> ban(BanBuilder builder) =>
      client.httpEndpoints.banMember(server.id, id, builder);

  BaseMember._new(this.client, Ulid serverId, Ulid id)
      : user = CacheableUser._new(client, id),
        server = CacheableServer._new(client, serverId),
        super(id);
}
