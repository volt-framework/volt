part of volt;

class Invite extends PartialInvite {
  /// Invite type.
  final InviteType type;

  /// Server on which the invite was created.
  final CacheableServer server;

  /// Invite creator.
  final CacheableMember creator;

  /// Channel on which the invite was created.
  final CacheableChannel channel;

  Invite._new(IVolt client, RawApiMap raw)
      : type = InviteType.from(raw['type'] as String),
        server = CacheableServer._new(client, Ulid(raw['server'] as String)),
        creator = CacheableMember._new(client, Ulid(raw['server'] as String),
            Ulid(raw['creator'] as String)),
        channel = CacheableChannel._new(client, Ulid(raw['channel'] as String)),
        super._raw(client, raw['_id'] as String);
}

/// Invite type.
class InviteType extends Enum<String> {
  static const server = InviteType._create('Server');

  InviteType.from(String value) : super(value);
  const InviteType._create(String value) : super(value);
}
