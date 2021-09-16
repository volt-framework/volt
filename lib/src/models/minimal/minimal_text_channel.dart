part of volt;

abstract class MinimalTextChannel implements Channel, Sendible, Mentionable {
  // TODO: implement methods
  Future<Message> fetchMessage(Ulid id);

  // TODO: replace dynamic with https://developers.revolt.chat/api/#tag/Messaging/paths/~1channels~1:channel~1messages~1search/post
  Stream<dynamic> fetchMessages(FetchMessagesQueryBuilder query);
  Stream<dynamic> findMessages(SearchMessagesQueryBuilder query);

  @override
  Future<Message> sendMessage(MessageBuilder message);

  @override
  String get mention => '<#${id.toString()}>';
}
