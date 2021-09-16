part of volt;

// TODO: implement attachments and replies
class MessageBuilder extends Builder<RawApiMap> {
  final _content = StringBuffer();

  set content(Object content) {
    _content.clear();
    _content.write(content);
  }

  MessageBuilder();

  factory MessageBuilder.content(String content) {
    return MessageBuilder()..content = content;
  }

  @override
  RawApiMap build() {
    return {
      if (_content.isNotEmpty) 'content': _content.toString(),
      'nonce': Ulid.fromTimestamp(DateTime.now()).toString(),
    };
  }
}
