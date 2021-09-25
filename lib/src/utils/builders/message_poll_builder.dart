part of volt;

class MessagePollBuilder extends Builder<RawApiMap> {
  Iterable<Ulid> ids = [];

  MessagePollBuilder();

  factory MessagePollBuilder.fromIds(Iterable<Ulid> ids) =>
      MessagePollBuilder()..ids = ids;

  factory MessagePollBuilder.fromMessages(Iterable<Message> messages) =>
      MessagePollBuilder()..ids = messages.map((e) => e.id);

  @override
  RawApiMap build() => {'ids': ids.map((e) => e.toString()).toList()};
}
