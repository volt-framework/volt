part of volt;

abstract class MinimalUser extends UlidEntity implements Sendible, Mentionable {
  final IVolt client;

  // TODO: replace with cacheable dm channel ??????
  final CacheableTextChannel channel;

  // TODO: add user methods
  MinimalUser._new(this.client, Ulid id)
      : channel = CacheableTextChannel._new(client, id),
        super(id);

  @override
  String get mention => '<@${id.toString()}>';
}
