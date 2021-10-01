part of volt;

class DeletedMessage extends UlidEntity {
  /// Reference to client.
  final IVolt client;

  /// Reference to cacheable [TextChannel].
  final CacheableTextChannel channel;

  DeletedMessage._new(this.client, this.channel, Ulid id) : super(id);

  /// Cached message.
  Message? get cached => channel.getFromCache()?.messages[id];
}
