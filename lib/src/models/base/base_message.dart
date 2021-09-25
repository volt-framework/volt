part of volt;

abstract class BaseMessage extends UlidEntity {
  /// Reference to client.
  final IVolt client;

  /// Reference to channel.
  final CacheableTextChannel channel;

  /// Delete the message.
  Future<void> delete() => client.httpEndpoints.deleteMessage(channel.id, id);

  /// Edit the message.
  Future<void> edit(MessageEditBuilder builder) =>
      client.httpEndpoints.editMessage(channel.id, id, builder);

  BaseMessage._new(this.client, Ulid channelId, Ulid id)
      : channel = CacheableTextChannel._new(client, channelId),
        super(id);
}
