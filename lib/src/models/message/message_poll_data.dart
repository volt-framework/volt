part of volt;

class MessagePollData {
  Iterable<Message> updated;
  Iterable<DeletedMessage> deleted;

  MessagePollData._new(IVolt client, Ulid channelId, RawApiMap raw)
      : updated = [
          for (final message in raw['updated'] as RawApiList)
            Message._new(client, message),
        ],
        deleted = [
          for (final message in raw['deleted'] as RawApiList)
            DeletedMessage._new(
                client,
                CacheableTextChannel._new(client, channelId),
                Ulid(message as String)),
        ];
}
