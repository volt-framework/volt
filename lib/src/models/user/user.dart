part of volt;

class User extends BaseUser {
  final String username;
  final File? avatar;
  // TODO: does it really need for bots?
  final Iterable<Relationship> relations;
  final UserBadges badges;
  final bool? isOnline;
  final UserFlags flags;

  User._new(IVolt client, RawApiMap raw)
      : username = raw['username'] as String,
        avatar = raw['avatar'] == null
            ? null
            : File._new(raw['avatar'] as RawApiMap),
        relations = [
          if (raw['relations'] != null)
            for (final rawRelation in raw['relations'] as List<RawApiMap>)
              Relationship._new(client, rawRelation),
        ],
        badges = UserBadges._new(raw['badges'] as int? ?? 0),
        isOnline = raw['online'] as bool?,
        flags = UserFlags._new(raw['flags'] as int? ?? 0),
        super._new(client, Ulid(raw['_id'])) {
    if (client.options.cacheOptions.cacheUsers) {
      client.users[id] = this;
    }
  }

  factory User._define(IVolt client, RawApiMap raw) {
    if (raw['bot'] != null) return BotUser._new(client, raw);
    return User._new(client, raw);
  }

  @override
  Future<Message> sendMessage(MessageBuilder message) =>
      client.httpEndpoints.sendMessage(id, message);
}
