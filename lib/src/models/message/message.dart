part of volt;

class Message extends BaseMessage {
  // TODO: parse system messages
  final String? content;

  final CacheableMember author;

  final Ulid? nonce;

  final Iterable<Attachment> attachments;

  final Iterable<CacheableMember> mentions;

  final Iterable<CacheableMember> replies;

  final DateTime? editedAt;

  bool get isSystem => author.id.toString() == '0' * 26;

  Future<Message> reply(MessageBuilder builder, {bool shouldMention = false}) {
    builder.replies.add(MessageReplyBuilder(id, shouldMention: shouldMention));
    return client.httpEndpoints.sendMessage(channel.id, builder);
  }

  Message._new(IVolt client, RawApiMap raw)
      : author = CacheableMember._new(
            client, Ulid(raw['channel'] as String), Ulid(raw['author'])),
        nonce = raw['nonce'] == null ? null : Ulid(raw['nonce'] as String),
        content = raw['content'] is String ? raw['content'] as String : null,
        attachments = [
          if (raw['attachments'] != null)
            for (final attachment in raw['attachments'] as List<RawApiMap>)
              Attachment._new(attachment),
        ],
        mentions = [
          if (raw['mentions'] != null)
            for (final mention in raw['mentions'] as List<dynamic>)
              CacheableMember._new(
                  client, Ulid(raw['channel'] as String), Ulid(mention))
        ],
        replies = [
          if (raw['replies'] != null)
            for (final reply in raw['replies'] as List<dynamic>)
              CacheableMember._new(
                  client, Ulid(raw['channel'] as String), Ulid(reply))
        ],
        editedAt = raw['edited'] == null
            ? null
            : DateTime.parse(raw['edited']['\$date'] as String),
        super._new(client, Ulid(raw['channel'] as String), Ulid(raw['_id'])) {
    if (client.options.cacheOptions.cacheMessages) {
      channel.getFromCache()?.messages[id] = this;
    }
  }
}
