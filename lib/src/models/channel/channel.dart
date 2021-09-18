part of volt;

/*
{
  "channel_type": "TextChannel",
  "_id": "01FFD0K6658VPGKAB4MVE8NZZV",
  "server": "01FFD0K665YX0RS2TKNGBF5K2G",
  "nonce": "01FFD0HSXTXSMSJQJPQ669ZAKJ",
  "name": "general",
  "last_message": "01FFJ49MSAA5PYHER0QK8J2189",
  "default_permissions": 251
}
*/
class Channel extends UlidEntity {
  final ChannelType type;
  final IVolt client;
  final Ulid? nonce;

  Channel._new(this.client, RawApiMap raw)
      : type = ChannelType.from(raw['channel_type'] as String),
        nonce = raw['none'] == null ? null : Ulid(raw['none']),
        super(Ulid(raw['_id'])) {
    print('data: $raw');
  }

  Channel._raw(this.client, Ulid id,
      [this.type = ChannelType.unknown, this.nonce])
      : super(id);

  factory Channel._define(IVolt client, RawApiMap raw) {
    final type = raw['channel_type'] as String;

    switch (type) {
      case 'TextChannel':
        return ServerTextChannel._new(client, raw);
      case 'VoiceChannel':
        return ServerVoiceChannel._new(client, raw);
      case 'DirectMessage':
        return DmChannel._new(client, raw);
      case 'Group':
        return Group._new(client, raw);
      default:
        return UndefinedChannel._new(client, raw);
    }
  }

  // TODO
  Future<void> delete() => throw UnimplementedError();
}

class ChannelType extends Enum<String> {
  static const ChannelType text = ChannelType._new('TextChannel');
  static const ChannelType voice = ChannelType._new('VoiceChannel');
  static const ChannelType unknown = ChannelType._new('idk lol');

  ChannelType.from(String value) : super(value);
  const ChannelType._new(String value) : super(value);
}
