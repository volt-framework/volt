part of volt;

abstract class Sendible {
  Future<Message> sendMessage(MessageBuilder message);
}
