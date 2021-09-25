part of volt;

class DeletedMessage extends UlidEntity {
  final IVolt client;
  final CacheableTextChannel channel;

  DeletedMessage._new(this.client, this.channel, Ulid id) : super(id);
  // TODO: implement this pls
  Message? get cached => null;
}
