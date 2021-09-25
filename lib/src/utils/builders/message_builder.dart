part of volt;

// TODO: implement attachments
class MessageBuilder extends Builder<RawApiMap> {
  final _content = StringBuffer();
  List<MessageReplyBuilder> replies = [];

  set content(Object content) {
    _content.clear();
    _content.write(content);
  }

  MessageBuilder();

  factory MessageBuilder.content(String content) {
    return MessageBuilder()..content = content;
  }

  // TODO: maybe messages, not its ids?
  factory MessageBuilder.reply(
    String content, {
    required List<MessageReplyBuilder> replies,
  }) {
    return MessageBuilder()..replies = replies;
  }

  @override
  RawApiMap build() {
    return {
      if (_content.isNotEmpty) 'content': _content.toString(),
      'nonce': Ulid.fromTimestamp(DateTime.now()).toString(),
      if (replies.isNotEmpty) 'replies': replies.map((r) => r.build()).toList()
    };
  }
}

class MessageReplyBuilder extends Builder<RawApiMap> {
  Ulid messageId;
  bool shouldMention;

  MessageReplyBuilder(this.messageId, {this.shouldMention = false});

  @override
  RawApiMap build() {
    return {
      'id': messageId.toString(),
      'mention': shouldMention,
    };
  }
}
