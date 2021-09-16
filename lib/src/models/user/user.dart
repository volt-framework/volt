part of volt;

class User extends MinimalUser {
  final String username;
  final File? avatar;
  // TODO: does it really need for bots?
  final Iterable<Relationship> relations;
  // TODO: cast to badges object
  // 1: Developer, 2: Translator, 4: Supporter, 8: Responsible Disclosure, 16: Revolt Team 256: Early Adopter
  final int? badges;
  final bool? isOnline;
  // TODO: cast to flags object
  // 1: Account is suspended, 2: Account was deleted, 4: Account is banned
  final int? flags;

  User._new(IVolt client, RawApiMap raw)
      : username = raw['username'] as String,
        avatar = raw['avatar'] == null
            ? null
            : File._define(raw['avatar'] as RawApiMap),
        relations = [
          if (raw['relations'] != null)
            for (final rawRelation in raw['relations'] as List<RawApiMap>)
              Relationship._new(client, rawRelation),
        ],
        badges = raw['badges'] as int?,
        isOnline = raw['online'] as bool?,
        flags = raw['flags'] as int?,
        super._new(client, Ulid(raw['_id']));

  factory User._define(IVolt client, RawApiMap raw) {
    if (raw['bot'] != null) return BotUser._new(client, raw);
    return User._new(client, raw);
  }

  @override
  Future<Message> sendMessage(MessageBuilder message) =>
      client.httpEndpoints.sendMessage(id, message);
}
