part of volt;

// TODO: message edit date and replies list
class Message extends UlidEntity {
  final IVolt client;

  // TODO: replace with content object
  final String content;

  final CacheableTextChannel channel;
  // TODO: replace with member, not user
  final CacheableUser author;

  final Ulid? nonce;

  final List<File> attachments;

  // TODO: replace with member
  final List<CacheableUser> mentions;

  bool get isSystem => author.id.toString() == '0' * 26;

  Future<Message> reply(MessageBuilder builder, {bool shouldMention = false}) {
    builder.replies.add(MessageReplyBuilder(id, shouldMention: shouldMention));
    return client.httpEndpoints.sendMessage(channel.id, builder);
  }

  Message._new(this.client, RawApiMap raw)
      : channel = CacheableTextChannel._new(
          client,
          Ulid(raw['channel'] as String),
        ),
        author = CacheableUser._new(client, Ulid(raw['author'])),
        nonce = raw['nonce'] == null ? null : Ulid(raw['nonce'] as String),
        content = raw['content'] as String,
        attachments = [
          if (raw['attachments'] != null)
            for (final attachment in raw['attachments'] as List<RawApiMap>)
              File._new(attachment),
        ],
        mentions = [
          if (raw['mentions'] != null)
            for (final mention in raw['mentions'] as List<dynamic>)
              CacheableUser._new(client, Ulid(mention))
        ],
        super(Ulid(raw['_id'])) {
    if (client.options.cacheOptions.cacheMessages) {
      channel.getFromCache()?.messages[id] = this;
    }
  }
}
