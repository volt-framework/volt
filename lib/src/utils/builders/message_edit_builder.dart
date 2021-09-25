part of volt;

class MessageEditBuilder extends Builder<RawApiMap> {
  String? content;

  MessageEditBuilder();

  factory MessageEditBuilder.content(String content) =>
      MessageEditBuilder()..content = content;

  @override
  RawApiMap build() {
    if (content == null) {
      throw ArgumentError.notNull('content');
    }
    return {'content': content!};
  }
}
