part of volt;

abstract class BaseUser extends UlidEntity implements Sendible, Mentionable {
  final IVolt client;

  // TODO: replace with cacheable dm channel ??????
  final CacheableTextChannel<DmChannel> channel;

  final Cacheable<Ulid, UserProfile> profile;

  Uri get defaultAvatar => client.httpEndpoints.fetchDefaultAvatar(id);

  BaseUser._new(this.client, Ulid id)
      : channel = CacheableTextChannel._new(client, id),
        profile = _CacheableProfile._new(client, id),
        super(id);

  @override
  String get mention => '<@${id.toString()}>';
}
