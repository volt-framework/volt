part of volt;

// TODO: message cache here?
abstract class TextChannel extends BaseTextChannel {
  /// Messages cache.
  Cache<Ulid, Message> get messages;
}
