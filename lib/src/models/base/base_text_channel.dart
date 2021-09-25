part of volt;

abstract class BaseTextChannel implements Channel, Sendible, Mentionable {
  Future<Message> fetchMessage(Ulid id);
  Future<MessageQueryData> fetchMessages(FetchMessagesQueryBuilder query);
  Future<MessageQueryData> searchMessages(SearchMessagesQueryBuilder query);

  Future<void> startTyping();
  Future<void> stopTyping();

  @override
  Future<Message> sendMessage(MessageBuilder message);

  @override
  String get mention => '<#${id.toString()}>';
}
