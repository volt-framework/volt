part of volt;

class BaseServer extends UlidEntity {
  /// Reference to [IVolt] instance.
  final IVolt client;

  // TODO: implement methods

  /// Fetch server member by their ID.
  Future<Member> fetchMember(Ulid id) =>
      client.httpEndpoints.fetchMember(this.id, id);

  /// Fetch all server members.
  Future<Iterable<Member>> fetchMembers() =>
      client.httpEndpoints.fetchMembers(id);

  /// Fetch all server bans.
  Future<Iterable<Ban>> fetchBans() => client.httpEndpoints.fetchBans(id);

  BaseServer._new(this.client, Ulid id) : super(id);
}
