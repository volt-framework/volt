part of volt;

abstract class TextChannel extends BaseTextChannel {
  /// Messages cache.
  Cache<Ulid, Message> get messages;
}
