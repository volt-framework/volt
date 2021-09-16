part of volt;

class Relationship {
  final CacheableUser user;
  final RelationshipStatus status;

  Relationship._new(IVolt client, RawApiMap raw)
      : user = CacheableUser._new(client, Ulid(raw['_id'] as String)),
        status = RelationshipStatus.from(raw['status'] as String);
}

class RelationshipStatus extends Enum<String> {
  static const blocked = RelationshipStatus._create('Blocked');
  static const blockedOther = RelationshipStatus._create('BlockedOther');
  static const friend = RelationshipStatus._create('Friend');
  static const incoming = RelationshipStatus._create('Incoming');
  static const none = RelationshipStatus._create('None');
  static const outgoing = RelationshipStatus._create('Outgoing');
  static const user = RelationshipStatus._create('User');

  RelationshipStatus.from(String value) : super(value);
  const RelationshipStatus._create(String value) : super(value);
}
