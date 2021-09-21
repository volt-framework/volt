part of volt;

class ChannelEditBuilder extends Builder<RawApiMap> {
  /// Channel name (1-32).
  String? name;

  /// Channel description (0-1024).
  String? description;

  /// Autumn file ID.
  String? icon;

  /// Whether this channel is not safe for work.
  bool? isNsfw;

  /// Field to remove from channel object.
  ChannelRemoveField? remove;

  @override
  RawApiMap build() {
    return {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (isNsfw != null) 'nsfw': isNsfw,
      if (remove != null) 'remove': remove!.value,
    };
  }
}

class ChannelRemoveField extends Enum<String> {
  static const description = ChannelRemoveField._create('Description');
  static const icon = ChannelRemoveField._create('Icon');

  const ChannelRemoveField._create(String value) : super(value);
}
